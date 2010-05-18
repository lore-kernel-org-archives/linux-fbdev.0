From: Ben Dooks <ben-linux@fluff.org>
Date: Tue, 18 May 2010 10:54:04 +0000
Subject: [PATCH 4/5] s3c-fb: udpate to support s3c2416/s3c2443 style hardware
Message-Id: <1274180045-14645-5-git-send-email-ben-linux@fluff.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
In-Reply-To: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update the variant and window variant structures with the necessary
changes to support the older style of hardware where these are not
in the same place.

Add the support for the s3c2443/s3c2416 hardware by using the
platform-device s3c2443 to cover both, and add the initialisation
data for these.

Also change to including just the v4 header files for the moment
until the last of the merging of these is sorted out.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |    8 +-
 arch/arm/plat-samsung/include/plat/regs-fb.h    |    4 +
 drivers/video/s3c-fb.c                          |  162 ++++++++++++++++++-----
 3 files changed, 136 insertions(+), 38 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
index 0477e8a..8352f5d 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
@@ -40,16 +40,10 @@
 
 /* OSD1 and OSD4 do not have register D */
 
-#define VIDOSD_A(_win)				(0x40 + ((_win) * 16))
-#define VIDOSD_B(_win)				(0x44 + ((_win) * 16))
-#define VIDOSD_C(_win)				(0x48 + ((_win) * 16))
-#define VIDOSD_D(_win)				(0x4C + ((_win) * 16))
-
+#define VIDOSD_BASE				(0x40)
 
 #define VIDINTCON0				(0x130)
 
-#define WxKEYCONy(_win, _con)			((0x140 + ((_win) * 8)) + ((_con) * 4))
-
 /* WINCONx */
 
 #define WINCONx_CSCWIDTH_MASK			(0x3 << 26)
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index 0ef806e..73d1aae 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -321,6 +321,10 @@
 #define VIDINTCON1_INT_FIFO			(1 << 0)
 
 /* Window colour-key control registers */
+#define WKEYCON					(0x140)	/* 6410,V210 */
+
+#define WKEYCON0				(0x00)
+#define WKEYCON1				(0x04)
 
 #define WxKEYCON0_KEYBL_EN			(1 << 26)
 #define WxKEYCON0_KEYEN_F			(1 << 25)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2c2de49..8b49ea7 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -9,7 +9,7 @@
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * published by the Free Software FoundatIon.
 */
 
 #include <linux/kernel.h>
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 
 #include <mach/map.h>
-#include <mach/regs-fb.h>
+#include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
 
 /* This driver will export a number of framebuffer interfaces depending
@@ -52,13 +52,38 @@ struct s3c_fb;
 
 #define VALID_BPP(x) (1 << ((x) - 1))
 
+#define OSD_BASE(win, variant) ((variant).osd + ((win) * (variant).osd_stride))
+#define VIDOSD_A(win, variant) (OSD_BASE(win, variant) + 0x00)
+#define VIDOSD_B(win, variant) (OSD_BASE(win, variant) + 0x04)
+#define VIDOSD_C(win, variant) (OSD_BASE(win, variant) + 0x08)
+#define VIDOSD_D(win, variant) (OSD_BASE(win, variant) + 0x0C)
+
 /**
  * struct s3c_fb_variant - fb variant information
+ * @is_2443: Set if S3C2443/S3C2416 style hardware.
  * @nr_windows: The number of windows.
+ * @vidtcon: The base for the VIDTCONx registers
+ * @wincon: The base for the WINxCON registers.
+ * @winmap: The base for the WINxMAP registers.
+ * @keycon: The abse for the WxKEYCON registers.
+ * @buf_start: Offset of buffer start registers.
+ * @buf_size: Offset of buffer size registers.
+ * @buf_end: Offset of buffer end registers.
+ * @osd: The base for the OSD registers.
  * @palette: Address of palette memory, or 0 if none.
  */
 struct s3c_fb_variant {
+	unsigned int	is_2443:1;
 	unsigned short	nr_windows;
+	unsigned short	vidtcon;
+	unsigned short	wincon;
+	unsigned short	winmap;
+	unsigned short	keycon;
+	unsigned short	buf_start;
+	unsigned short	buf_end;
+	unsigned short	buf_size;
+	unsigned short	osd;
+	unsigned short	osd_stride;
 	unsigned short	palette[S3C_FB_MAX_WIN];
 };
 
@@ -308,6 +333,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 	struct s3c_fb_win *win = info->par;
 	struct s3c_fb *sfb = win->parent;
 	void __iomem *regs = sfb->regs;
+	void __iomem *buf = regs;
 	int win_no = win->index;
 	u32 osdc_data = 0;
 	u32 data;
@@ -357,6 +383,9 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 		/* write the timing data to the panel */
 
+		if (sfb->variant.is_2443)
+			data |= (1 << 5);
+
 		data |= VIDCON0_ENVID | VIDCON0_ENVID_F;
 		writel(data, regs + VIDCON0);
 
@@ -364,41 +393,45 @@ static int s3c_fb_set_par(struct fb_info *info)
 		       VIDTCON0_VFPD(var->lower_margin - 1) |
 		       VIDTCON0_VSPW(var->vsync_len - 1);
 
-		writel(data, regs + VIDTCON0);
+		writel(data, regs + sfb->variant.vidtcon);
 
 		data = VIDTCON1_HBPD(var->left_margin - 1) |
 		       VIDTCON1_HFPD(var->right_margin - 1) |
 		       VIDTCON1_HSPW(var->hsync_len - 1);
 
-		writel(data, regs + VIDTCON1);
+		/* VIDTCON1 */
+		writel(data, regs + sfb->variant.vidtcon + 4);
 
 		data = VIDTCON2_LINEVAL(var->yres - 1) |
 		       VIDTCON2_HOZVAL(var->xres - 1);
-		writel(data, regs + VIDTCON2);
+		writel(data, regs +sfb->variant.vidtcon + 8 );
 	}
 
 	/* write the buffer address */
 
-	writel(info->fix.smem_start, regs + VIDW_BUF_START(win_no));
+	/* start and end registers stride is 8 */
+	buf = regs + win_no * 8;
+
+	writel(info->fix.smem_start, buf + sfb->variant.buf_start);
 
 	data = info->fix.smem_start + info->fix.line_length * var->yres;
-	writel(data, regs + VIDW_BUF_END(win_no));
+	writel(data, buf + sfb->variant.buf_end);
 
 	pagewidth = (var->xres * var->bits_per_pixel) >> 3;
 	data = VIDW_BUF_SIZE_OFFSET(info->fix.line_length - pagewidth) |
 	       VIDW_BUF_SIZE_PAGEWIDTH(pagewidth);
-	writel(data, regs + VIDW_BUF_SIZE(win_no));
+	writel(data, regs + sfb->variant.buf_size + (win_no * 4));
 
 	/* write 'OSD' registers to control position of framebuffer */
 
 	data = VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0);
-	writel(data, regs + VIDOSD_A(win_no));
+	writel(data, regs + VIDOSD_A(win_no, sfb->variant));
 
 	data = VIDOSDxB_BOTRIGHT_X(s3c_fb_align_word(var->bits_per_pixel,
 						     var->xres - 1)) |
 	       VIDOSDxB_BOTRIGHT_Y(var->yres - 1);
 
-	writel(data, regs + VIDOSD_B(win_no));
+	writel(data, regs + VIDOSD_B(win_no, sfb->variant));
 
 	data = var->xres * var->yres;
 
@@ -407,10 +440,10 @@ static int s3c_fb_set_par(struct fb_info *info)
 		VIDISD14C_ALPHA1_B(0xf);
 
 	if (win->variant.has_osd_d) {
-		writel(data, regs + VIDOSD_D(win_no));
-		writel(osdc_data, regs + VIDOSD_C(win_no));
+		writel(data, regs + VIDOSD_D(win_no, sfb->variant));
+		writel(osdc_data, regs + VIDOSD_C(win_no, sfb->variant));
 	} else
-		writel(data, regs + VIDOSD_C(win_no));
+		writel(data, regs + VIDOSD_C(win_no, sfb->variant));
 
 	data = WINCONx_ENWIN;
 
@@ -470,9 +503,10 @@ static int s3c_fb_set_par(struct fb_info *info)
 		break;
 	}
 
-	/* It has no color key control register for window0 */
+	/* Enable the colour keying for the window below this one */
 	if (win_no > 0) {
 		u32 keycon0_data = 0, keycon1_data = 0;
+		void __iomem *keycon = regs + sfb->variant.keycon;
 
 		keycon0_data = ~(WxKEYCON0_KEYBL_EN |
 				WxKEYCON0_KEYEN_F |
@@ -480,12 +514,14 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 		keycon1_data = WxKEYCON1_COLVAL(0xffffff);
 
-		writel(keycon0_data, regs + WxKEYCONy(win_no-1, 0));
-		writel(keycon1_data, regs + WxKEYCONy(win_no-1, 1));
+		keycon += (win_no - 1) * 8;
+
+		writel(keycon0_data, keycon + WKEYCON0);
+		writel(keycon1_data, keycon + WKEYCON1);
 	}
 
-	writel(data, regs + WINCON(win_no));
-	writel(0x0, regs + WINxMAP(win_no));
+	writel(data, regs + sfb->variant.wincon + (win_no * 4));
+	writel(0x0, regs + sfb->variant.winmap + (win_no * 4));
 
 	return 0;
 }
@@ -633,7 +669,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 
 	dev_dbg(sfb->dev, "blank mode %d\n", blank_mode);
 
-	wincon = readl(sfb->regs + WINCON(index));
+	wincon = readl(sfb->regs + sfb->variant.wincon + (index * 4));
 
 	switch (blank_mode) {
 	case FB_BLANK_POWERDOWN:
@@ -644,11 +680,11 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 	case FB_BLANK_NORMAL:
 		/* disable the DMA and display 0x0 (black) */
 		writel(WINxMAP_MAP | WINxMAP_MAP_COLOUR(0x0),
-		       sfb->regs + WINxMAP(index));
+		       sfb->regs + sfb->variant.winmap + (index * 4));
 		break;
 
 	case FB_BLANK_UNBLANK:
-		writel(0x0, sfb->regs + WINxMAP(index));
+		writel(0x0, sfb->regs + sfb->variant.winmap + (index * 4));
 		wincon |= WINCONx_ENWIN;
 		sfb->enabled |= (1 << index);
 		break;
@@ -659,7 +695,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 		return 1;
 	}
 
-	writel(wincon, sfb->regs + WINCON(index));
+	writel(wincon, sfb->regs + sfb->variant.wincon + (index * 4));
 
 	/* Check the enabled state to see if we need to be running the
 	 * main LCD interface, as if there are no active windows then
@@ -795,7 +831,7 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	int palette_size;
 	int ret;
 
-	dev_dbg(sfb->dev, "probing window %d\n", win_no);
+	dev_dbg(sfb->dev, "probing window %d, variant %p\n", win_no, variant);
 
 	palette_size = variant->palette_sz * 4;
 
@@ -888,10 +924,10 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 {
 	void __iomem *regs = sfb->regs;
 
-	writel(0, regs + WINCON(win));
-	writel(0, regs + VIDOSD_A(win));
-	writel(0, regs + VIDOSD_B(win));
-	writel(0, regs + VIDOSD_C(win));
+	writel(0, regs + sfb->variant.wincon + (win * 4));
+	writel(0, regs + VIDOSD_A(win, sfb->variant));
+	writel(0, regs + VIDOSD_B(win, sfb->variant));
+	writel(0, regs + VIDOSD_C(win, sfb->variant));
 }
 
 static int __devinit s3c_fb_probe(struct platform_device *pdev)
@@ -923,6 +959,8 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	dev_dbg(dev, "allocate new framebuffer %p\n", sfb);
+
 	sfb->dev = dev;
 	sfb->pdata = pd;
 	sfb->variant = fbdrv->variant;
@@ -972,8 +1010,11 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	/* initialise colour key controls */
 	for (win = 0; win < (fbdrv->variant.nr_windows - 1); win++) {
-		writel(0xffffff, sfb->regs + WxKEYCONy(win, 0));
-		writel(0xffffff, sfb->regs + WxKEYCONy(win, 1));
+		void __iomem *regs = sfb->regs + sfb->variant.keycon;
+
+		regs += (win * 8);
+		writel(0xffffff, regs + WKEYCON0);
+		writel(0xffffff, regs + WKEYCON1);
 	}
 
 	/* we have the register setup, start allocating framebuffers */
@@ -1078,8 +1119,11 @@ static int s3c_fb_resume(struct platform_device *pdev)
 		s3c_fb_clear_win(sfb, win_no);
 
 	for (win_no = 0; win_no < sfb->variant.nr_windows - 1; win_no++) {
-		writel(0xffffff, sfb->regs + WxKEYCONy(win_no, 1));
-		writel(0xffffff, sfb->regs + WxKEYCONy(win_no, 1));
+		void __iomem *regs = sfb->regs + sfb->variant.keycon;
+
+		regs += (win_no * 8);
+		writel(0xffffff, regs + WKEYCON0);
+		writel(0xffffff, regs + WKEYCON1);
 	}
 
 	/* restore framebuffers */
@@ -1148,6 +1192,15 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
 static struct s3c_fb_driverdata s3c_fb_data_64xx __devinitdata = {
 	.variant = {
 		.nr_windows	= 5,
+		.vidtcon	= VIDTCON0,
+		.wincon		= WINCON(0),
+		.winmap		= WINxMAP(0),
+		.keycon		= WKEYCON,
+		.osd		= VIDOSD_BASE,
+		.osd_stride	= 16,
+		.buf_start	= VIDW_BUF_START(0),
+		.buf_size	= VIDW_BUF_SIZE(0),
+		.buf_end	= VIDW_BUF_END(0),
 
 		.palette = {
 			[0] = 0x400,
@@ -1167,6 +1220,15 @@ static struct s3c_fb_driverdata s3c_fb_data_64xx __devinitdata = {
 static struct s3c_fb_driverdata s3c_fb_data_s5p __devinitdata = {
 	.variant = {
 		.nr_windows	= 5,
+		.vidtcon	= VIDTCON0,
+		.wincon		= WINCON(0),
+		.winmap		= WINxMAP(0),
+		.keycon		= WKEYCON,
+		.osd		= VIDOSD_BASE,
+		.osd_stride	= 16,
+		.buf_start	= VIDW_BUF_START(0),
+		.buf_size	= VIDW_BUF_SIZE(0),
+		.buf_end	= VIDW_BUF_END(0),
 
 		.palette = {
 			[0] = 0x2400,
@@ -1183,6 +1245,41 @@ static struct s3c_fb_driverdata s3c_fb_data_s5p __devinitdata = {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
+/* S3C2443/S3C2416 style hardware */
+static struct s3c_fb_driverdata s3c_fb_data_s3c2443 __devinitdata = {
+	.variant = {
+		.nr_windows	= 2,
+		.is_2443	= 1,
+
+		.vidtcon	= 0x08,
+		.wincon		= 0x14,
+		.winmap		= 0xd0,
+		.keycon		= 0xb0,
+		.osd		= 0x28,
+		.osd_stride	= 12,
+		.buf_start	= 0x64,
+		.buf_size	= 0x94,
+		.buf_end	= 0x7c,
+
+		.palette = {
+			[0] = 0x400,
+			[1] = 0x800,
+		},
+	},
+	.win[0] = &(struct s3c_fb_win_variant) {
+		.palette_sz	= 256,
+		.valid_bpp	= VALID_BPP1248 | VALID_BPP(16) | VALID_BPP(24),
+	},
+	.win[1] = &(struct s3c_fb_win_variant) {
+		.has_osd_c	= 1,
+		.palette_sz	= 256,
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(19) |
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(28)),
+	},
+};
+
 static struct platform_device_id s3c_fb_driver_ids[] = {
 	{
 		.name		= "s3c-fb",
@@ -1190,6 +1287,9 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 	}, {
 		.name		= "s5p-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s5p,
+	}, {
+		.name		= "s3c2443-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
 	},
 	{},
 };
-- 
1.6.3.3

