From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 03 Mar 2015 20:56:03 +0000
Subject: [PATCH 4/4] [resend] tridentfb: Add DDC support
Message-Id: <1425416163-10700-4-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425416163-10700-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1425416163-10700-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Add DDC support for Trident cards.

Tested on TGUI9440, TGUI9680, 3DImage 9750, Blade3D 9880 and Blade XP.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/Kconfig     |    9 ++
 drivers/video/fbdev/tridentfb.c |  192 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 4916c97..08a7a04 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1682,6 +1682,15 @@ config FB_TRIDENT
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
+config FB_TRIDENT_DDC
+	bool "DDC for Trident support"
+	depends on FB_TRIDENT
+	select FB_DDC
+	select FB_MODE_HELPERS
+	default y
+	help
+	  Say Y here if you want DDC support for your Trident graphics card.
+
 config FB_ARK
 	tristate "ARK 2000PV support"
 	depends on FB && PCI
diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 01b43e9..59471a0 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -25,6 +25,9 @@
 #include <video/vga.h>
 #include <video/trident.h>
 
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
 struct tridentfb_par {
 	void __iomem *io_virt;	/* iospace virtual memory address */
 	u32 pseudo_pal[16];
@@ -40,6 +43,11 @@ struct tridentfb_par {
 		(struct tridentfb_par *par, const char*,
 		 u32, u32, u32, u32, u32, u32);
 	unsigned char eng_oper;	/* engine operation... */
+#ifdef CONFIG_FB_TRIDENT_DDC
+	bool ddc_registered;
+	struct i2c_adapter ddc_adapter;
+	struct i2c_algo_bit_data ddc_algo;
+#endif
 };
 
 static struct fb_fix_screeninfo tridentfb_fix = {
@@ -53,7 +61,7 @@ static struct fb_fix_screeninfo tridentfb_fix = {
 /* defaults which are normally overriden by user values */
 
 /* video mode */
-static char *mode_option = "640x480-8@60";
+static char *mode_option;
 static int bpp = 8;
 
 static int noaccel;
@@ -174,6 +182,124 @@ static inline u32 readmmr(struct tridentfb_par *par, u16 r)
 	return fb_readl(par->io_virt + r);
 }
 
+#ifdef CONFIG_FB_TRIDENT_DDC
+
+#define DDC_SDA_TGUI		BIT(0)
+#define DDC_SCL_TGUI		BIT(1)
+#define DDC_SCL_DRIVE_TGUI	BIT(2)
+#define DDC_SDA_DRIVE_TGUI	BIT(3)
+#define DDC_MASK_TGUI		(DDC_SCL_DRIVE_TGUI | DDC_SDA_DRIVE_TGUI)
+
+static void tridentfb_ddc_setscl_tgui(void *data, int val)
+{
+	struct tridentfb_par *par = data;
+	u8 reg = vga_mm_rcrt(par->io_virt, I2C) & DDC_MASK_TGUI;
+
+	if (val)
+		reg &= ~DDC_SCL_DRIVE_TGUI; /* disable drive - don't drive hi */
+	else
+		reg |= DDC_SCL_DRIVE_TGUI; /* drive low */
+
+	vga_mm_wcrt(par->io_virt, I2C, reg);
+}
+
+static void tridentfb_ddc_setsda_tgui(void *data, int val)
+{
+	struct tridentfb_par *par = data;
+	u8 reg = vga_mm_rcrt(par->io_virt, I2C) & DDC_MASK_TGUI;
+
+	if (val)
+		reg &= ~DDC_SDA_DRIVE_TGUI; /* disable drive - don't drive hi */
+	else
+		reg |= DDC_SDA_DRIVE_TGUI; /* drive low */
+
+	vga_mm_wcrt(par->io_virt, I2C, reg);
+}
+
+static int tridentfb_ddc_getsda_tgui(void *data)
+{
+	struct tridentfb_par *par = data;
+
+	return !!(vga_mm_rcrt(par->io_virt, I2C) & DDC_SDA_TGUI);
+}
+
+#define DDC_SDA_IN	BIT(0)
+#define DDC_SCL_OUT	BIT(1)
+#define DDC_SDA_OUT	BIT(3)
+#define DDC_SCL_IN	BIT(6)
+#define DDC_MASK	(DDC_SCL_OUT | DDC_SDA_OUT)
+
+static void tridentfb_ddc_setscl(void *data, int val)
+{
+	struct tridentfb_par *par = data;
+	unsigned char reg;
+
+	reg = vga_mm_rcrt(par->io_virt, I2C) & DDC_MASK;
+	if (val)
+		reg |= DDC_SCL_OUT;
+	else
+		reg &= ~DDC_SCL_OUT;
+	vga_mm_wcrt(par->io_virt, I2C, reg);
+}
+
+static void tridentfb_ddc_setsda(void *data, int val)
+{
+	struct tridentfb_par *par = data;
+	unsigned char reg;
+
+	reg = vga_mm_rcrt(par->io_virt, I2C) & DDC_MASK;
+	if (!val)
+		reg |= DDC_SDA_OUT;
+	else
+		reg &= ~DDC_SDA_OUT;
+	vga_mm_wcrt(par->io_virt, I2C, reg);
+}
+
+static int tridentfb_ddc_getscl(void *data)
+{
+	struct tridentfb_par *par = data;
+
+	return !!(vga_mm_rcrt(par->io_virt, I2C) & DDC_SCL_IN);
+}
+
+static int tridentfb_ddc_getsda(void *data)
+{
+	struct tridentfb_par *par = data;
+
+	return !!(vga_mm_rcrt(par->io_virt, I2C) & DDC_SDA_IN);
+}
+
+static int tridentfb_setup_ddc_bus(struct fb_info *info)
+{
+	struct tridentfb_par *par = info->par;
+
+	strlcpy(par->ddc_adapter.name, info->fix.id,
+		sizeof(par->ddc_adapter.name));
+	par->ddc_adapter.owner		= THIS_MODULE;
+	par->ddc_adapter.class		= I2C_CLASS_DDC;
+	par->ddc_adapter.algo_data	= &par->ddc_algo;
+	par->ddc_adapter.dev.parent	= info->device;
+	if (is_oldclock(par->chip_id)) { /* not sure if this check is OK */
+		par->ddc_algo.setsda	= tridentfb_ddc_setsda_tgui;
+		par->ddc_algo.setscl	= tridentfb_ddc_setscl_tgui;
+		par->ddc_algo.getsda	= tridentfb_ddc_getsda_tgui;
+		/* no getscl */
+	} else {
+		par->ddc_algo.setsda	= tridentfb_ddc_setsda;
+		par->ddc_algo.setscl	= tridentfb_ddc_setscl;
+		par->ddc_algo.getsda	= tridentfb_ddc_getsda;
+		par->ddc_algo.getscl	= tridentfb_ddc_getscl;
+	}
+	par->ddc_algo.udelay		= 10;
+	par->ddc_algo.timeout		= 20;
+	par->ddc_algo.data		= par;
+
+	i2c_set_adapdata(&par->ddc_adapter, par);
+
+	return i2c_bit_add_bus(&par->ddc_adapter);
+}
+#endif /* CONFIG_FB_TRIDENT_DDC */
+
 /*
  * Blade specific acceleration.
  */
@@ -1346,6 +1472,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	struct tridentfb_par *default_par;
 	int chip3D;
 	int chip_id;
+	bool found = false;
 
 	err = pci_enable_device(dev);
 	if (err)
@@ -1499,6 +1626,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	info->pixmap.scan_align = 1;
 	info->pixmap.access_align = 32;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+	info->var.bits_per_pixel = 8;
 
 	if (default_par->image_blit) {
 		info->flags |= FBINFO_HWACCEL_IMAGEBLIT;
@@ -1511,11 +1639,57 @@ static int trident_pci_probe(struct pci_dev *dev,
 		info->pixmap.scan_align = 1;
 	}
 
-	if (!fb_find_mode(&info->var, info,
-			  mode_option, NULL, 0, NULL, bpp)) {
-		err = -EINVAL;
-		goto out_unmap2;
+#ifdef CONFIG_FB_TRIDENT_DDC
+	if (tridentfb_setup_ddc_bus(info) = 0) {
+		u8 *edid = fb_ddc_read(&default_par->ddc_adapter);
+
+		default_par->ddc_registered = true;
+		if (edid) {
+			fb_edid_to_monspecs(edid, &info->monspecs);
+			kfree(edid);
+			if (!info->monspecs.modedb)
+				dev_err(info->device, "error getting mode database\n");
+			else {
+				const struct fb_videomode *m;
+
+				fb_videomode_to_modelist(info->monspecs.modedb,
+						 info->monspecs.modedb_len,
+						 &info->modelist);
+				m = fb_find_best_display(&info->monspecs,
+							 &info->modelist);
+				if (m) {
+					fb_videomode_to_var(&info->var, m);
+					/* fill all other info->var's fields */
+					if (tridentfb_check_var(&info->var,
+								info) = 0)
+						found = true;
+				}
+			}
+		}
 	}
+#endif
+	if (!mode_option && !found)
+		mode_option = "640x480-8@60";
+
+	/* Prepare startup mode */
+	if (mode_option) {
+		err = fb_find_mode(&info->var, info, mode_option,
+				   info->monspecs.modedb,
+				   info->monspecs.modedb_len,
+				   NULL, info->var.bits_per_pixel);
+		if (!err || err = 4) {
+			err = -EINVAL;
+			dev_err(info->device, "mode %s not found\n",
+								mode_option);
+			fb_destroy_modedb(info->monspecs.modedb);
+			info->monspecs.modedb = NULL;
+			goto out_unmap2;
+		}
+	}
+
+	fb_destroy_modedb(info->monspecs.modedb);
+	info->monspecs.modedb = NULL;
+
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0)
 		goto out_unmap2;
@@ -1536,6 +1710,10 @@ static int trident_pci_probe(struct pci_dev *dev,
 	return 0;
 
 out_unmap2:
+#ifdef CONFIG_FB_TRIDENT_DDC
+	if (default_par->ddc_registered)
+		i2c_del_adapter(&default_par->ddc_adapter);
+#endif
 	kfree(info->pixmap.addr);
 	if (info->screen_base)
 		iounmap(info->screen_base);
@@ -1555,6 +1733,10 @@ static void trident_pci_remove(struct pci_dev *dev)
 	struct tridentfb_par *par = info->par;
 
 	unregister_framebuffer(info);
+#ifdef CONFIG_FB_TRIDENT_DDC
+	if (par->ddc_registered)
+		i2c_del_adapter(&par->ddc_adapter);
+#endif
 	iounmap(par->io_virt);
 	iounmap(info->screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
-- 
Ondrej Zary

