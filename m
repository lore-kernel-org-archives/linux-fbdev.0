From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 29 Mar 2011 03:35:56 +0000
Subject: [RFC][PATCH 1/3] sh_mobile_meram: MERAM framework for LCDC
Message-Id: <1301369758-18394-2-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Based on the patch by Takanari Hayama <taki@igel.co.jp>

Adds support framework necessary to use Media RAM (MERAM)
caching functionality with the LCDC.  The MERAM is accessed
through up to 4 Interconnect Buffers (ICBs).

ICB numbers and MERAM address ranges to use are specified in
by filling in the .meram_cfg member of the LCDC platform data

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/Kconfig            |   12 +
 drivers/video/Makefile           |    1 +
 drivers/video/sh_mobile_lcdcfb.c |  100 +++++++-
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 drivers/video/sh_mobile_meram.c  |  553 ++++++++++++++++++++++++++++++++++=
++++
 drivers/video/sh_mobile_meram.h  |   41 +++
 include/video/sh_mobile_lcdc.h   |    2 +
 include/video/sh_mobile_meram.h  |   68 +++++
 8 files changed, 769 insertions(+), 9 deletions(-)
 create mode 100644 drivers/video/sh_mobile_meram.c
 create mode 100644 drivers/video/sh_mobile_meram.h
 create mode 100644 include/video/sh_mobile_meram.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e6a8d8c..b3f3990 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1975,6 +1975,18 @@ config FB_SH_MOBILE_HDMI
 	---help---
 	  Driver for the on-chip SH-Mobile HDMI controller.
=20
+config FB_SH_MOBILE_MERAM
+	tristate "SuperH Mobile MERAM read ahead support for LCDC"
+	depends on FB_SH_MOBILE_LCDC
+	default y
+	---help---
+	  Enable MERAM support for the SH-Mobile LCD controller.
+
+	  This will allow for caching of the framebuffer to provide more
+	  reliable access under heavy main memory bus traffic situations.
+	  Up to 4 memory channels can be configured, allowing 4 RGB or
+	  2 YCbCr framebuffers to be configured.
+
 config FB_TMIO
 	tristate "Toshiba Mobile IO FrameBuffer support"
 	depends on FB && MFD_CORE
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 2ea44b6..8b83129 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_FB_UDL)		  +=3D udlfb.o
 obj-$(CONFIG_FB_XILINX)           +=3D xilinxfb.o
 obj-$(CONFIG_SH_MIPI_DSI)	  +=3D sh_mipi_dsi.o
 obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  +=3D sh_mobile_hdmi.o
+obj-$(CONFIG_FB_SH_MOBILE_MERAM)  +=3D sh_mobile_meram.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  +=3D sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             +=3D omap/
 obj-y                             +=3D omap2/
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcd=
cfb.c
index 757665b..92366bd 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -27,6 +27,7 @@
 #include <asm/atomic.h>
=20
 #include "sh_mobile_lcdcfb.h"
+#include "sh_mobile_meram.h"
=20
 #define SIDE_B_OFFSET 0x1000
 #define MIRROR_OFFSET 0x2000
@@ -564,6 +565,9 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_p=
riv *priv)
 	}
=20
 	for (k =3D 0; k < ARRAY_SIZE(priv->ch); k++) {
+		unsigned long base_addr_y;
+		unsigned long base_addr_c =3D 0;
+		int pitch;
 		ch =3D &priv->ch[k];
=20
 		if (!priv->ch[k].enabled)
@@ -598,16 +602,63 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc=
_priv *priv)
 		}
 		lcdc_write_chan(ch, LDDFR, tmp);
=20
+		base_addr_y =3D ch->info->fix.smem_start;
+		base_addr_c =3D base_addr_y +
+				ch->info->var.xres *
+				ch->info->var.yres_virtual;
+		pitch =3D ch->info->fix.line_length;
+
+		/* test if we can enable meram */
+		if (ch->cfg.meram_cfg) {
+			struct sh_mobile_meram_cfg *cfg;
+			struct sh_mobile_meram_info *mdev;
+			unsigned long icb_addr_y, icb_addr_c;
+			int icb_pitch;
+			int pf;
+
+			cfg =3D ch->cfg.meram_cfg;
+			mdev =3D cfg->meram_dev;
+			/* we need to de-init configured ICBs before we
+			 * we can re-initialize them.
+			 */
+			if (ch->meram_enabled)
+				mdev->ops->meram_unregister(mdev, cfg);
+
+			ch->meram_enabled =3D 0;
+
+			if (ch->info->var.nonstd)
+				pf =3D SH_MOBILE_MERAM_PF_NV;
+			else
+				pf =3D SH_MOBILE_MERAM_PF_RGB;
+
+			ret =3D mdev->ops->meram_register(mdev, cfg, pitch,
+						ch->info->var.yres,
+						pf,
+						base_addr_y,
+						base_addr_c,
+						&icb_addr_y,
+						&icb_addr_c,
+						&icb_pitch);
+			if (!ret)  {
+				/* set LDSA1R value */
+				base_addr_y =3D icb_addr_y;
+				pitch =3D icb_pitch;
+
+				/* set LDSA2R value if required */
+				if (base_addr_c)
+					base_addr_c =3D icb_addr_c;
+
+				ch->meram_enabled =3D 1;
+			}
+		}
+
 		/* point out our frame buffer */
-		lcdc_write_chan(ch, LDSA1R, ch->info->fix.smem_start);
+		lcdc_write_chan(ch, LDSA1R, base_addr_y);
 		if (ch->info->var.nonstd)
-			lcdc_write_chan(ch, LDSA2R,
-				ch->info->fix.smem_start +
-				ch->info->var.xres *
-				ch->info->var.yres_virtual);
+			lcdc_write_chan(ch, LDSA2R, base_addr_c);
=20
 		/* set line size */
-		lcdc_write_chan(ch, LDMLSR, ch->info->fix.line_length);
+		lcdc_write_chan(ch, LDMLSR, pitch);
=20
 		/* setup deferred io if SYS bus */
 		tmp =3D ch->cfg.sys_bus_cfg.deferred_io_msec;
@@ -692,6 +743,17 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_=
priv *priv)
 			board_cfg->display_off(board_cfg->board_data);
 			module_put(board_cfg->owner);
 		}
+
+		/* disable the meram */
+		if (ch->meram_enabled) {
+			struct sh_mobile_meram_cfg *cfg;
+			struct sh_mobile_meram_info *mdev;
+			cfg =3D ch->cfg.meram_cfg;
+			mdev =3D cfg->meram_dev;
+			mdev->ops->meram_unregister(mdev, cfg);
+			ch->meram_enabled =3D 0;
+		}
+
 	}
=20
 	/* stop the lcdc */
@@ -875,9 +937,29 @@ static int sh_mobile_fb_pan_display(struct fb_var_scre=
eninfo *var,
 	} else
 		base_addr_c =3D 0;
=20
-	lcdc_write_chan_mirror(ch, LDSA1R, base_addr_y);
-	if (base_addr_c)
-		lcdc_write_chan_mirror(ch, LDSA2R, base_addr_c);
+	if (!ch->meram_enabled) {
+		lcdc_write_chan_mirror(ch, LDSA1R, base_addr_y);
+		if (base_addr_c)
+			lcdc_write_chan_mirror(ch, LDSA2R, base_addr_c);
+	} else {
+		struct sh_mobile_meram_cfg *cfg;
+		struct sh_mobile_meram_info *mdev;
+		unsigned long icb_addr_y, icb_addr_c;
+		int ret;
+
+		cfg =3D ch->cfg.meram_cfg;
+		mdev =3D cfg->meram_dev;
+		ret =3D mdev->ops->meram_update(mdev, cfg,
+					base_addr_y, base_addr_c,
+					&icb_addr_y, &icb_addr_c);
+		if (ret)
+			return ret;
+
+		lcdc_write_chan_mirror(ch, LDSA1R, icb_addr_y);
+		if (icb_addr_c)
+			lcdc_write_chan_mirror(ch, LDSA2R, icb_addr_c);
+
+	}
=20
 	if (lcdc_chan_is_sublcd(ch))
 		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcd=
cfb.h
index 4635eed..d6d9f37 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -38,6 +38,7 @@ struct sh_mobile_lcdc_chan {
 	struct fb_var_screeninfo display_var;
 	int use_count;
 	struct mutex open_lock;		/* protects the use counter */
+	int meram_enabled;
 };
=20
 #endif
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_mera=
m.c
new file mode 100644
index 0000000..bd68f3d
--- /dev/null
+++ b/drivers/video/sh_mobile_meram.c
@@ -0,0 +1,553 @@
+/*
+ * SuperH Mobile MERAM Driver for SuperH Mobile LCDC Driver
+ *
+ * Copyright (c) 2011	Damian Hobson-Garcia <dhobsong@igel.co.jp>
+ *                      Takanari Hayama <taki@igel.co.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include "sh_mobile_meram.h"
+
+/* meram registers */
+#define MExxCTL 0x0
+#define MExxBSIZE 0x4
+#define MExxMNCF 0x8
+#define MExxSARA 0x10
+#define MExxSARB 0x14
+#define MExxSBSIZE 0x18
+
+#define MERAM_MExxCTL_VAL(ctl, next_icb, addr)	\
+	((ctl) | (((next_icb) & 0x1f) << 11) | (((addr) & 0x7ff) << 16))
+#define	MERAM_MExxBSIZE_VAL(a, b, c) \
+	(((a) << 28) | ((b) << 16) | (c))
+
+#define MEVCR1 0x4
+#define MEACTS 0x10
+#define MEQSEL1 0x40
+#define MEQSEL2 0x44
+
+/* settings */
+#define MERAM_SEC_LINE 15
+#define MERAM_LINE_WIDTH 2048
+
+/*
+ * MERAM/ICB access functions
+ */
+
+#define MERAM_ICB_OFFSET(base, idx, off)	\
+	((base) + (0x400 + ((idx) * 0x20) + (off)))
+
+static inline void meram_write_icb(void __iomem *base, int idx, int off,
+	unsigned long val)
+{
+	iowrite32(val, MERAM_ICB_OFFSET(base, idx, off));
+}
+
+static inline unsigned long meram_read_icb(void __iomem *base, int idx, in=
t off)
+{
+	return ioread32(MERAM_ICB_OFFSET(base, idx, off));
+}
+
+static inline void meram_write_reg(void __iomem *base, int off,
+		unsigned long val)
+{
+	iowrite32(val, base + off);
+}
+
+static inline unsigned long meram_read_reg(void __iomem *base, int off)
+{
+	return ioread32(base + off);
+}
+
+/*
+ * register ICB
+ */
+
+#define MERAM_CACHE_START(p)	 ((p) >> 16)
+#define MERAM_CACHE_END(p)	 ((p) & 0xffff)
+#define MERAM_CACHE_SET(o, s)	 ((((o) & 0xffff) << 16) | \
+				  (((o) + (s) - 1) & 0xffff))
+
+/*
+ * check if there's no overlaps in MERAM allocation.
+ */
+
+static inline int meram_check_overlap(struct sh_mobile_meram_priv *priv,
+				      struct sh_mobile_meram_icb *new)
+{
+	int i;
+	int used_start, used_end, meram_start, meram_end;
+
+	/* valid ICB? */
+	if (new->marker_icb & ~0x1f || new->cache_icb & ~0x1f)
+		return 1;
+
+	if (test_bit(new->marker_icb, &priv->used_icb) ||
+			test_bit(new->cache_icb,  &priv->used_icb))
+		return  1;
+
+	for (i =3D 0; i < priv->used_meram_cache_regions; i++) {
+		used_start =3D MERAM_CACHE_START(priv->used_meram_cache[i]);
+		used_end   =3D MERAM_CACHE_END(priv->used_meram_cache[i]);
+		meram_start =3D new->meram_offset;
+		meram_end   =3D new->meram_offset + new->meram_size;
+
+		if ((meram_start >=3D used_start && meram_start < used_end) ||
+			(meram_end > used_start && meram_end < used_end))
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * mark the specified ICB as used
+ */
+
+static inline void meram_mark(struct sh_mobile_meram_priv *priv,
+			      struct sh_mobile_meram_icb *new)
+{
+	int n;
+
+	if (new->marker_icb < 0 || new->cache_icb < 0)
+		return;
+
+	__set_bit(new->marker_icb, &priv->used_icb);
+	__set_bit(new->cache_icb, &priv->used_icb);
+
+	n =3D priv->used_meram_cache_regions;
+
+	priv->used_meram_cache[n] =3D MERAM_CACHE_SET(new->meram_offset,
+						    new->meram_size);
+
+	priv->used_meram_cache_regions++;
+}
+
+/*
+ * unmark the specified ICB as used
+ */
+
+static inline void meram_unmark(struct sh_mobile_meram_priv *priv,
+				struct sh_mobile_meram_icb *icb)
+{
+	int i;
+	unsigned long pattern;
+
+	if (icb->marker_icb < 0 || icb->cache_icb < 0)
+		return;
+
+	__clear_bit(icb->marker_icb, &priv->used_icb);
+	__clear_bit(icb->cache_icb, &priv->used_icb);
+
+	pattern =3D MERAM_CACHE_SET(icb->meram_offset, icb->meram_size);
+	for (i =3D 0; i < priv->used_meram_cache_regions; i++) {
+		if (priv->used_meram_cache[i] =3D pattern) {
+			while (i < priv->used_meram_cache_regions - 1) {
+				priv->used_meram_cache[i] +					priv->used_meram_cache[i + 1] ;
+				i++;
+			}
+			priv->used_meram_cache[i] =3D 0;
+			priv->used_meram_cache_regions--;
+			break;
+		}
+	}
+}
+
+
+/*
+ * set the next address to fetch
+ */
+static inline void meram_set_next_addr(struct sh_mobile_meram_priv *priv,
+				       struct sh_mobile_meram_cfg *cfg,
+				       unsigned long base_addr_y,
+				       unsigned long base_addr_c)
+{
+	unsigned long target;
+
+	target =3D (cfg->current_reg) ? MExxSARA : MExxSARB;
+	cfg->current_reg ^=3D 1;
+
+	/* set the next address to fetch */
+	meram_write_icb(priv->base, cfg->icb[0].cache_icb,  target,
+			base_addr_y);
+	meram_write_icb(priv->base, cfg->icb[0].marker_icb, target,
+			base_addr_y + cfg->icb[0].cache_unit);
+
+	if (cfg->pixelformat =3D SH_MOBILE_MERAM_PF_NV) {
+		meram_write_icb(priv->base, cfg->icb[1].cache_icb,  target,
+				base_addr_c);
+		meram_write_icb(priv->base, cfg->icb[1].marker_icb, target,
+				base_addr_c + cfg->icb[1].cache_unit);
+	}
+}
+
+/*
+ * get the next ICB address
+ */
+static inline void meram_get_next_icb_addr(struct sh_mobile_meram_info *pd=
ata,
+					   struct sh_mobile_meram_cfg *cfg,
+					   unsigned long *icb_addr_y,
+					   unsigned long *icb_addr_c)
+{
+	unsigned long icb_offset;
+
+	if (pdata->addr_mode =3D SH_MOBILE_MERAM_MODE0)
+		icb_offset =3D 0x80000000 | (cfg->current_reg << 29);
+	else
+		icb_offset =3D 0xc0000000 | (cfg->current_reg << 23);
+
+	*icb_addr_y =3D icb_offset | (cfg->icb[0].marker_icb << 24);
+	if ((*icb_addr_c) && cfg->pixelformat =3D SH_MOBILE_MERAM_PF_NV)
+		*icb_addr_c =3D icb_offset | (cfg->icb[1].marker_icb << 24);
+}
+
+#define MERAM_CALC_BYTECOUNT(x, y) \
+	(((x) * (y) + (MERAM_LINE_WIDTH - 1)) & ~(MERAM_LINE_WIDTH - 1))
+
+/*
+ * initialize MERAM
+ */
+
+static int meram_init(struct sh_mobile_meram_priv *priv,
+		      struct sh_mobile_meram_icb *icb,
+		      int xres, int yres, int *out_pitch)
+{
+	unsigned long total_byte_count =3D MERAM_CALC_BYTECOUNT(xres, yres);
+	unsigned long bnm;
+	int lcdc_pitch, xpitch, line_cnt;
+	int save_lines;
+
+	/* adjust pitch to 1024, 2048, 4096 or 8192 */
+	lcdc_pitch =3D (xres - 1) | 1023;
+	lcdc_pitch =3D lcdc_pitch | (lcdc_pitch >> 1);
+	lcdc_pitch =3D lcdc_pitch | (lcdc_pitch >> 2);
+	lcdc_pitch +=3D 1;
+
+	/* derive settings */
+	if (lcdc_pitch =3D 8192 && yres >=3D 1024) {
+		lcdc_pitch =3D xpitch =3D MERAM_LINE_WIDTH;
+		line_cnt =3D total_byte_count >> 11;
+		*out_pitch =3D xres;
+		save_lines =3D (icb->meram_size / 16 / MERAM_SEC_LINE);
+		save_lines *=3D MERAM_SEC_LINE;
+	} else {
+		xpitch =3D xres;
+		line_cnt =3D yres;
+		*out_pitch =3D lcdc_pitch;
+		save_lines =3D icb->meram_size / (lcdc_pitch >> 10) / 2;
+		save_lines &=3D 0xff;
+	}
+	bnm =3D (save_lines - 1) << 16;
+
+	/* TODO: we better to check if we have enough MERAM buffer size */
+
+	/* set up ICB */
+	meram_write_icb(priv->base, icb->cache_icb,  MExxBSIZE,
+			MERAM_MExxBSIZE_VAL(0x0, line_cnt - 1, xpitch - 1));
+	meram_write_icb(priv->base, icb->marker_icb, MExxBSIZE,
+			MERAM_MExxBSIZE_VAL(0xf, line_cnt - 1, xpitch - 1));
+
+	meram_write_icb(priv->base, icb->cache_icb,  MExxMNCF, bnm);
+	meram_write_icb(priv->base, icb->marker_icb, MExxMNCF, bnm);
+
+	meram_write_icb(priv->base, icb->cache_icb,  MExxSBSIZE, xpitch);
+	meram_write_icb(priv->base, icb->marker_icb, MExxSBSIZE, xpitch);
+
+	/* save a cache unit size */
+	icb->cache_unit =3D xres * save_lines;
+
+	/*
+	 * Set MERAM for framebuffer
+	 *
+	 * 0x70f:  WD =3D 0x3, WS=3D0x1, CM=3D0x1, MD=FB mode
+	 * we also chain the cache_icb and the marker_icb.
+	 * we also split the allocated MERAM buffer between two ICBs.
+	 */
+	meram_write_icb(priv->base, icb->cache_icb, MExxCTL,
+			MERAM_MExxCTL_VAL(0x70f, icb->marker_icb,
+					  icb->meram_offset));
+	meram_write_icb(priv->base, icb->marker_icb, MExxCTL,
+			MERAM_MExxCTL_VAL(0x70f, icb->cache_icb,
+					  icb->meram_offset +
+					  icb->meram_size / 2));
+
+	return 0;
+}
+
+static void meram_deinit(struct sh_mobile_meram_priv *priv,
+			struct sh_mobile_meram_icb *icb)
+{
+	/* disable ICB */
+	meram_write_icb(priv->base, icb->cache_icb,  MExxCTL, 0);
+	meram_write_icb(priv->base, icb->marker_icb, MExxCTL, 0);
+	icb->cache_unit =3D 0;
+}
+
+/*
+ * register the ICB
+ */
+
+static int sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
+				    struct sh_mobile_meram_cfg *cfg,
+				    int xres, int yres, int pixelformat,
+				    unsigned long base_addr_y,
+				    unsigned long base_addr_c,
+				    unsigned long *icb_addr_y,
+				    unsigned long *icb_addr_c,
+				    int *pitch)
+{
+	struct platform_device *pdev;
+	struct sh_mobile_meram_priv *priv;
+	int n, out_pitch;
+	int error =3D 0;
+
+	if (!pdata || !pdata->priv || !pdata->pdev || !cfg)
+		return -EINVAL;
+
+	if (pixelformat !=3D SH_MOBILE_MERAM_PF_NV &&
+	    pixelformat !=3D SH_MOBILE_MERAM_PF_RGB)
+		return -EINVAL;
+
+	priv =3D pdata->priv;
+	pdev =3D pdata->pdev;
+
+	dev_dbg(&pdev->dev, "registering %dx%d (%s) (y=3D%08lx, c=3D%08lx)",
+		xres, yres, (!pixelformat) ? "yuv" : "rgb",
+		base_addr_y, base_addr_c);
+
+	mutex_lock(&priv->lock);
+
+	/* we can't handle wider than 8192px */
+	if (xres > 8192) {
+		dev_err(&pdev->dev, "width exceeding the limit (> 8192).");
+		error =3D -EINVAL;
+		goto err;
+	}
+
+	if (priv->used_meram_cache_regions + 2 > SH_MOBILE_MERAM_ICB_NUM) {
+		dev_err(&pdev->dev, "no more ICB available.");
+		error =3D -EINVAL;
+		goto err;
+	}
+
+	/* do we have at least one ICB config? */
+	if (cfg->icb[0].marker_icb < 0 || cfg->icb[0].cache_icb < 0) {
+		dev_err(&pdev->dev, "at least one ICB is required.");
+		error =3D -EINVAL;
+		goto err;
+	}
+
+	/* make sure that there's no overlaps */
+	if (meram_check_overlap(priv, &cfg->icb[0])) {
+		dev_err(&pdev->dev, "conflicting config detected.");
+		error =3D -EINVAL;
+		goto err;
+	}
+	n =3D 1;
+
+	/* do the same if we have the second ICB set */
+	if (cfg->icb[1].marker_icb >=3D 0 && cfg->icb[1].cache_icb >=3D 0) {
+		if (meram_check_overlap(priv, &cfg->icb[1])) {
+			dev_err(&pdev->dev, "conflicting config detected.");
+			error =3D -EINVAL;
+			goto err;
+		}
+		n =3D 2;
+	}
+
+	if (pixelformat =3D SH_MOBILE_MERAM_PF_NV && n !=3D 2) {
+		dev_err(&pdev->dev, "requires two ICB sets for planar Y/C.");
+		error =3D  -EINVAL;
+		goto err;
+	}
+
+	/* we now register the ICB */
+	cfg->pixelformat =3D pixelformat;
+	meram_mark(priv, &cfg->icb[0]);
+	if (pixelformat =3D SH_MOBILE_MERAM_PF_NV)
+		meram_mark(priv, &cfg->icb[1]);
+
+	/* initialize MERAM */
+	meram_init(priv, &cfg->icb[0], xres, yres, &out_pitch);
+	*pitch =3D out_pitch;
+	if (pixelformat =3D SH_MOBILE_MERAM_PF_NV)
+		meram_init(priv, &cfg->icb[1], xres, (yres + 1) / 2,
+			&out_pitch);
+
+	cfg->current_reg =3D 1;
+	meram_set_next_addr(priv, cfg, base_addr_y, base_addr_c);
+	meram_get_next_icb_addr(pdata, cfg, icb_addr_y, icb_addr_c);
+
+	dev_dbg(&pdev->dev, "registered - can access via y=3D%08lx, c=3D%08lx",
+		*icb_addr_y, *icb_addr_c);
+
+err:
+	mutex_unlock(&priv->lock);
+	return error;
+}
+
+static int sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata,
+				      struct sh_mobile_meram_cfg *cfg)
+{
+	struct sh_mobile_meram_priv *priv;
+
+	if (!pdata || !pdata->priv || !cfg)
+		return -EINVAL;
+
+	priv =3D pdata->priv;
+
+	mutex_lock(&priv->lock);
+
+	/* deinit & unmark */
+	if (cfg->pixelformat =3D SH_MOBILE_MERAM_PF_NV) {
+		meram_deinit(priv, &cfg->icb[1]);
+		meram_unmark(priv, &cfg->icb[1]);
+	}
+	meram_deinit(priv, &cfg->icb[0]);
+	meram_unmark(priv, &cfg->icb[0]);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int sh_mobile_meram_update(struct sh_mobile_meram_info *pdata,
+				  struct sh_mobile_meram_cfg *cfg,
+				  unsigned long base_addr_y,
+				  unsigned long base_addr_c,
+				  unsigned long *icb_addr_y,
+				  unsigned long *icb_addr_c)
+{
+	struct sh_mobile_meram_priv *priv;
+
+	if (!pdata || !pdata->priv || !cfg)
+		return -EINVAL;
+
+	priv =3D pdata->priv;
+
+	mutex_lock(&priv->lock);
+
+	meram_set_next_addr(priv, cfg, base_addr_y, base_addr_c);
+	meram_get_next_icb_addr(pdata, cfg, icb_addr_y, icb_addr_c);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static struct sh_mobile_meram_ops sh_mobile_meram_ops =3D {
+	.module			=3D THIS_MODULE,
+	.meram_register		=3D sh_mobile_meram_register,
+	.meram_unregister	=3D sh_mobile_meram_unregister,
+	.meram_update		=3D sh_mobile_meram_update,
+};
+
+/*
+ * initialize MERAM
+ */
+
+static int sh_mobile_meram_remove(struct platform_device *pdev);
+
+static int __devinit sh_mobile_meram_probe(struct platform_device *pdev)
+{
+	struct sh_mobile_meram_priv *priv;
+	struct sh_mobile_meram_info *pdata =3D pdev->dev.platform_data;
+	struct resource *res;
+	int error;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "cannot get platform resources\n");
+		return -ENOENT;
+	}
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "cannot allocate device data\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	/* initialize private data */
+	mutex_init(&priv->lock);
+	priv->base =3D ioremap_nocache(res->start, resource_size(res));
+	if (!priv->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		error =3D -EFAULT;
+		goto err;
+	}
+	pdata->ops =3D &sh_mobile_meram_ops;
+	pdata->priv =3D priv;
+	pdata->pdev =3D pdev;
+
+	/* initialize ICB addressing mode */
+	if (pdata->addr_mode =3D SH_MOBILE_MERAM_MODE1)
+		meram_write_reg(priv->base, MEVCR1, 1 << 29);
+
+	dev_info(&pdev->dev, "sh_mobile_meram initialized.");
+
+	return 0;
+
+err:
+	sh_mobile_meram_remove(pdev);
+
+	return error;
+}
+
+
+static int sh_mobile_meram_remove(struct platform_device *pdev)
+{
+	struct sh_mobile_meram_priv *priv =3D platform_get_drvdata(pdev);
+
+	if (priv->base)
+		iounmap(priv->base);
+
+	mutex_destroy(&priv->lock);
+
+	kfree(priv);
+
+	return 0;
+}
+
+static struct platform_driver sh_mobile_meram_driver =3D {
+	.driver	=3D {
+		.name		=3D "sh_mobile_meram",
+		.owner		=3D THIS_MODULE,
+	},
+	.probe		=3D sh_mobile_meram_probe,
+	.remove		=3D sh_mobile_meram_remove,
+};
+
+static int __init sh_mobile_meram_init(void)
+{
+	return platform_driver_register(&sh_mobile_meram_driver);
+}
+
+static void __exit sh_mobile_meram_exit(void)
+{
+	platform_driver_unregister(&sh_mobile_meram_driver);
+}
+
+module_init(sh_mobile_meram_init);
+module_exit(sh_mobile_meram_exit);
+
+MODULE_DESCRIPTION("SuperH Mobile MERAM driver");
+MODULE_AUTHOR("Damian Hobson-Garcia / Takanari Hayama");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/video/sh_mobile_meram.h b/drivers/video/sh_mobile_mera=
m.h
new file mode 100644
index 0000000..82c54fb
--- /dev/null
+++ b/drivers/video/sh_mobile_meram.h
@@ -0,0 +1,41 @@
+#ifndef __sh_mobile_meram_h__
+#define __sh_mobile_meram_h__
+
+#include <linux/mutex.h>
+#include <video/sh_mobile_meram.h>
+
+/*
+ * MERAM private
+ */
+
+#define MERAM_ICB_Y 0x1
+#define MERAM_ICB_C 0x2
+
+/* MERAM cache size */
+#define SH_MOBILE_MERAM_ICB_NUM		32
+
+#define SH_MOBILE_MERAM_CACHE_OFFSET(p)	((p) >> 16)
+#define SH_MOBILE_MERAM_CACHE_SIZE(p)	((p) & 0xffff)
+
+struct sh_mobile_meram_priv {
+	void __iomem	*base;
+	struct mutex	lock;
+	unsigned long	used_icb;
+	int		used_meram_cache_regions;
+	unsigned long	used_meram_cache[SH_MOBILE_MERAM_ICB_NUM];
+};
+
+int sh_mobile_meram_alloc_icb(const struct sh_mobile_meram_cfg *cfg,
+		   int xres,
+		   int yres,
+		   unsigned int base_addr,
+		   int yuv_mode,
+		   int *marker_icb,
+		   int *out_pitch);
+
+void sh_mobile_meram_free_icb(int marker_icb);
+
+#define SH_MOBILE_MERAM_START(ind, ab) \
+	(0xC0000000 | ((ab & 0x1) << 23) | ((ind & 0x1F) << 24))
+
+#endif /* !__sh_mobile_meram_h__ */
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 2c8d369..7d07ac8 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -2,6 +2,7 @@
 #define __ASM_SH_MOBILE_LCDC_H__
=20
 #include <linux/fb.h>
+#include <video/sh_mobile_meram.h>
=20
 enum {
 	RGB8,   /* 24bpp, 8:8:8 */
@@ -87,6 +88,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
 	int nonstd;
+	struct sh_mobile_meram_cfg *meram_cfg;
 };
=20
 struct sh_mobile_lcdc_info {
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_mera=
m.h
new file mode 100644
index 0000000..e6d2410
--- /dev/null
+++ b/include/video/sh_mobile_meram.h
@@ -0,0 +1,68 @@
+#ifndef __VIDEO_SH_MOBILE_MERAM_H__
+#define __VIDEO_SH_MOBILE_MERAM_H__
+
+/* For sh_mobile_meram_info.addr_mode */
+enum {
+	SH_MOBILE_MERAM_MODE0 =3D 0,
+	SH_MOBILE_MERAM_MODE1
+};
+
+enum {
+	SH_MOBILE_MERAM_PF_NV =3D 0,
+	SH_MOBILE_MERAM_PF_RGB
+};
+
+
+struct sh_mobile_meram_priv;
+struct sh_mobile_meram_ops;
+
+struct sh_mobile_meram_info {
+	int				addr_mode;
+	struct sh_mobile_meram_ops	*ops;
+	struct sh_mobile_meram_priv	*priv;
+	struct platform_device		*pdev;
+};
+
+/* icb config */
+struct sh_mobile_meram_icb {
+	int marker_icb;		/* ICB # for Marker ICB */
+	int cache_icb;		/* ICB # for Cache ICB */
+	int meram_offset;	/* MERAM Buffer Offset to use */
+	int meram_size;		/* MERAM Buffer Size to use */
+
+	int cache_unit;		/* bytes to cache per ICB */
+};
+
+struct sh_mobile_meram_cfg {
+	struct sh_mobile_meram_info	*meram_dev;
+	struct sh_mobile_meram_icb	icb[2];
+	int				pixelformat;
+	int				current_reg;
+};
+
+struct module;
+struct sh_mobile_meram_ops {
+	struct module	*module;
+	/* register usage of meram */
+	int (*meram_register)(struct sh_mobile_meram_info *meram_dev,
+			      struct sh_mobile_meram_cfg *cfg,
+			      int xres, int yres, int pixelformat,
+			      unsigned long base_addr_y,
+			      unsigned long base_addr_c,
+			      unsigned long *icb_addr_y,
+			      unsigned long *icb_addr_c, int *pitch);
+
+	/* unregister usage of meram */
+	int (*meram_unregister)(struct sh_mobile_meram_info *meram_dev,
+				struct sh_mobile_meram_cfg *cfg);
+
+	/* update meram settings */
+	int (*meram_update)(struct sh_mobile_meram_info *meram_dev,
+			    struct sh_mobile_meram_cfg *cfg,
+			    unsigned long base_addr_y,
+			    unsigned long base_addr_c,
+			    unsigned long *icb_addr_y,
+			    unsigned long *icb_addr_c);
+};
+
+#endif /* __VIDEO_SH_MOBILE_MERAM_H__  */
--=20
1.7.1

