From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 24 May 2019 11:55:52 +0000
Subject: [PATCH v2 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
Message-Id: <a8ba0a36-b9b3-4039-5f49-ddc1d900a9d1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190524115553eucas1p2f900901e65f06ec33e478d433f96e34f@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to pvr2fb driver for better compile
testing coverage.

While at it:

- mark pvr2fb_interrupt() and pvr2fb_common_init() with
  __maybe_unused tag (to silence build warnings when
  !SH_DREAMCAST)

- convert mmio_base in struct pvr2fb_par to 'void __iomem *'
  from 'unsigned long' (needed to silence build warnings on
  ARM).

- split pvr2_get_param() on pvr2_get_param_name() and
  pvr2_get_param_val() (needed to silence build warnings on
  x86).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: fix build warnings on x86 reported by kbuild test robot

patch #1/2 is unchanged so I'm not sending it again

 drivers/video/fbdev/Kconfig  |    3 +-
 drivers/video/fbdev/pvr2fb.c |   61 +++++++++++++++++++++++--------------------
 2 files changed, 36 insertions(+), 28 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -807,7 +807,8 @@ config FB_XVR1000
 
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
-	depends on FB && SH_DREAMCAST
+	depends on FB && HAS_IOMEM
+	depends on SH_DREAMCAST || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/pvr2fb.c
=================================--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -139,7 +139,7 @@ static struct pvr2fb_par {
 	unsigned char is_doublescan;	/* Are scanlines output twice? (doublescan) */
 	unsigned char is_lowres;	/* Is horizontal pixel-doubling enabled? */
 
-	unsigned long mmio_base;	/* MMIO base */
+	void __iomem *mmio_base;	/* MMIO base */
 	u32 palette[16];
 } *currentpar;
 
@@ -325,9 +325,9 @@ static int pvr2fb_setcolreg(unsigned int
  * anything if the cable type has been overidden (via "cable:XX").
  */
 
-#define PCTRA 0xff80002c
-#define PDTRA 0xff800030
-#define VOUTC 0xa0702c00
+#define PCTRA ((void __iomem *)0xff80002c)
+#define PDTRA ((void __iomem *)0xff800030)
+#define VOUTC ((void __iomem *)0xa0702c00)
 
 static int pvr2_init_cable(void)
 {
@@ -619,7 +619,7 @@ static void pvr2_do_blank(void)
 	is_blanked = do_blank > 0 ? do_blank : 0;
 }
 
-static irqreturn_t pvr2fb_interrupt(int irq, void *dev_id)
+static irqreturn_t __maybe_unused pvr2fb_interrupt(int irq, void *dev_id)
 {
 	struct fb_info *info = dev_id;
 
@@ -722,23 +722,30 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int pvr2_get_param(const struct pvr2_params *p, const char *s, int val,
-			  int size)
+static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
+			      int size)
 {
 	int i;
 
-	for (i = 0 ; i < size ; i++ ) {
-		if (s != NULL) {
-			if (!strncasecmp(p[i].name, s, strlen(s)))
-				return p[i].val;
-		} else {
-			if (p[i].val = val)
-				return (int)p[i].name;
-		}
+	for (i = 0 ; i < size; i++ ) {
+		if (!strncasecmp(p[i].name, s, strlen(s)))
+			return p[i].val;
 	}
 	return -1;
 }
 
+static char *pvr2_get_param_name(const struct pvr2_params *p, int val,
+			  int size)
+{
+	int i;
+
+	for (i = 0 ; i < size; i++ ) {
+		if (p[i].val = val)
+			return p[i].name;
+	}
+	return NULL;
+}
+
 /**
  * pvr2fb_common_init
  *
@@ -757,7 +764,7 @@ static int pvr2_get_param(const struct p
  * in for flexibility anyways. Who knows, maybe someone has tv-out on a
  * PCI-based version of these things ;-)
  */
-static int pvr2fb_common_init(void)
+static int __maybe_unused pvr2fb_common_init(void)
 {
 	struct pvr2fb_par *par = currentpar;
 	unsigned long modememused, rev;
@@ -770,8 +777,8 @@ static int pvr2fb_common_init(void)
 		goto out_err;
 	}
 
-	par->mmio_base = (unsigned long)ioremap_nocache(pvr2_fix.mmio_start,
-							pvr2_fix.mmio_len);
+	par->mmio_base = ioremap_nocache(pvr2_fix.mmio_start,
+					 pvr2_fix.mmio_len);
 	if (!par->mmio_base) {
 		printk(KERN_ERR "pvr2fb: Failed to remap mmio space\n");
 		goto out_err;
@@ -819,8 +826,8 @@ static int pvr2fb_common_init(void)
 		fb_info->var.xres, fb_info->var.yres,
 		fb_info->var.bits_per_pixel,
 		get_line_length(fb_info->var.xres, fb_info->var.bits_per_pixel),
-		(char *)pvr2_get_param(cables, NULL, cable_type, 3),
-		(char *)pvr2_get_param(outputs, NULL, video_output, 3));
+		pvr2_get_param_name(cables, cable_type, 3),
+		pvr2_get_param_name(outputs, video_output, 3));
 
 #ifdef CONFIG_SH_STORE_QUEUES
 	fb_notice(fb_info, "registering with SQ API\n");
@@ -838,7 +845,7 @@ out_err:
 	if (fb_info->screen_base)
 		iounmap(fb_info->screen_base);
 	if (par->mmio_base)
-		iounmap((void *)par->mmio_base);
+		iounmap(par->mmio_base);
 
 	return -ENXIO;
 }
@@ -905,8 +912,8 @@ static void __exit pvr2fb_dc_exit(void)
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	free_irq(HW_EVENT_VSYNC, fb_info);
@@ -955,8 +962,8 @@ static void pvr2fb_pci_remove(struct pci
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	pci_release_regions(pdev);
@@ -1027,9 +1034,9 @@ static int __init pvr2fb_setup(char *opt
 	}
 
 	if (*cable_arg)
-		cable_type = pvr2_get_param(cables, cable_arg, 0, 3);
+		cable_type = pvr2_get_param_val(cables, cable_arg, 3);
 	if (*output_arg)
-		video_output = pvr2_get_param(outputs, output_arg, 0, 3);
+		video_output = pvr2_get_param_val(outputs, output_arg, 3);
 
 	return 0;
 }
