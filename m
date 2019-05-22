From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 22 May 2019 10:16:49 +0000
Subject: [PATCH 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
Message-Id: <2d2b283e-a5c5-3c94-423c-8cb085492921@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190522101651eucas1p18b5ce16f065cc83125b4bd97e141bdcd@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to pvr2fb driver for better compile
testing coverage.

While at it mark pvr2fb_interrupt() and pvr2fb_common_init()
with __maybe_unused tag (to silence build warnings when
!SH_DREAMCAST), also convert mmio_base in struct pvr2fb_par to
'void __iomem *' from 'unsigned long' (needed to silence
build warnings on ARM).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig  |    3 ++-
 drivers/video/fbdev/pvr2fb.c |   26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

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
 
@@ -757,7 +757,7 @@ static int pvr2_get_param(const struct p
  * in for flexibility anyways. Who knows, maybe someone has tv-out on a
  * PCI-based version of these things ;-)
  */
-static int pvr2fb_common_init(void)
+static int __maybe_unused pvr2fb_common_init(void)
 {
 	struct pvr2fb_par *par = currentpar;
 	unsigned long modememused, rev;
@@ -770,8 +770,8 @@ static int pvr2fb_common_init(void)
 		goto out_err;
 	}
 
-	par->mmio_base = (unsigned long)ioremap_nocache(pvr2_fix.mmio_start,
-							pvr2_fix.mmio_len);
+	par->mmio_base = ioremap_nocache(pvr2_fix.mmio_start,
+					 pvr2_fix.mmio_len);
 	if (!par->mmio_base) {
 		printk(KERN_ERR "pvr2fb: Failed to remap mmio space\n");
 		goto out_err;
@@ -838,7 +838,7 @@ out_err:
 	if (fb_info->screen_base)
 		iounmap(fb_info->screen_base);
 	if (par->mmio_base)
-		iounmap((void *)par->mmio_base);
+		iounmap(par->mmio_base);
 
 	return -ENXIO;
 }
@@ -905,8 +905,8 @@ static void __exit pvr2fb_dc_exit(void)
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	free_irq(HW_EVENT_VSYNC, fb_info);
@@ -955,8 +955,8 @@ static void pvr2fb_pci_remove(struct pci
 		fb_info->screen_base = NULL;
 	}
 	if (currentpar->mmio_base) {
-		iounmap((void *)currentpar->mmio_base);
-		currentpar->mmio_base = 0;
+		iounmap(currentpar->mmio_base);
+		currentpar->mmio_base = NULL;
 	}
 
 	pci_release_regions(pdev);
