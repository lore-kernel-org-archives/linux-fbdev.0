From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Feb 2019 08:59:01 +0000
Subject: [PATCH 4/4] fbdev: atafb: Modernize printing of kernel messages
Message-Id: <20190215085901.21479-5-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190215085901.21479-1-geert@linux-m68k.org>
In-Reply-To: <20190215085901.21479-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Schmitz <schmitzmic@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org

Now the driver has been converted to a platform driver, the legacy
printk() calls without any log level can be replaced by proper dev_*()
calls.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 4db8166d11b30409..b986af2a80428003 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -3083,12 +3083,12 @@ static int __init atafb_probe(struct platform_device *pdev)
 	if (fb_get_options("atafb", &option))
 		return -ENODEV;
 	atafb_setup(option);
-	printk("atafb_init: start\n");
+	dev_dbg(&pdev->dev, "%s: start\n", __func__);
 
 	do {
 #ifdef ATAFB_EXT
 		if (external_addr) {
-			printk("atafb_init: initializing external hw\n");
+			dev_dbg(&pdev->dev, "initializing external hw\n");
 			fbhw = &ext_switch;
 			atafb_ops.fb_setcolreg = &ext_setcolreg;
 			defmode = DEFMODE_EXT;
@@ -3097,7 +3097,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 #endif
 #ifdef ATAFB_TT
 		if (ATARIHW_PRESENT(TT_SHIFTER)) {
-			printk("atafb_init: initializing TT hw\n");
+			dev_dbg(&pdev->dev, "initializing TT hw\n");
 			fbhw = &tt_switch;
 			atafb_ops.fb_setcolreg = &tt_setcolreg;
 			defmode = DEFMODE_TT;
@@ -3106,7 +3106,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 #endif
 #ifdef ATAFB_FALCON
 		if (ATARIHW_PRESENT(VIDEL_SHIFTER)) {
-			printk("atafb_init: initializing Falcon hw\n");
+			dev_dbg(&pdev->dev, "initializing Falcon hw\n");
 			fbhw = &falcon_switch;
 			atafb_ops.fb_setcolreg = &falcon_setcolreg;
 			error = request_irq(IRQ_AUTO_4, falcon_vbl_switcher, 0,
@@ -3121,7 +3121,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 #ifdef ATAFB_STE
 		if (ATARIHW_PRESENT(STND_SHIFTER) ||
 		    ATARIHW_PRESENT(EXTD_SHIFTER)) {
-			printk("atafb_init: initializing ST/E hw\n");
+			dev_dbg(&pdev->dev, "initializing ST/E hw\n");
 			fbhw = &st_switch;
 			atafb_ops.fb_setcolreg = &stste_setcolreg;
 			defmode = DEFMODE_STE;
@@ -3129,7 +3129,8 @@ static int __init atafb_probe(struct platform_device *pdev)
 		}
 		fbhw = &st_switch;
 		atafb_ops.fb_setcolreg = &stste_setcolreg;
-		printk("Cannot determine video hardware; defaulting to ST(e)\n");
+		dev_warn(&pdev->dev,
+			 "Cannot determine video hardware; defaulting to ST(e)\n");
 #else /* ATAFB_STE */
 		/* no default driver included */
 		/* Nobody will ever see this message :-) */
@@ -3169,8 +3170,8 @@ static int __init atafb_probe(struct platform_device *pdev)
 			kernel_set_cachemode(screen_base, screen_len,
 					     IOMAP_WRITETHROUGH);
 		}
-		printk("atafb: phys_screen_base %lx screen_len %d\n",
-		       phys_screen_base, screen_len);
+		dev_info(&pdev->dev, "phys_screen_base %lx screen_len %d\n",
+			 phys_screen_base, screen_len);
 #ifdef ATAFB_EXT
 	} else {
 		/* Map the video memory (physical address given) to somewhere
@@ -3217,12 +3218,12 @@ static int __init atafb_probe(struct platform_device *pdev)
 	fb_alloc_cmap(&(fb_info.cmap), 1 << fb_info.var.bits_per_pixel, 0);
 
 
-	printk("Determined %dx%d, depth %d\n",
-	       fb_info.var.xres, fb_info.var.yres, fb_info.var.bits_per_pixel);
+	dev_info(&pdev->dev, "Determined %dx%d, depth %d\n", fb_info.var.xres,
+		 fb_info.var.yres, fb_info.var.bits_per_pixel);
 	if ((fb_info.var.xres != fb_info.var.xres_virtual) ||
 	    (fb_info.var.yres != fb_info.var.yres_virtual))
-		printk("   virtual %dx%d\n", fb_info.var.xres_virtual,
-		       fb_info.var.yres_virtual);
+		dev_info(&pdev->dev, "   virtual %dx%d\n",
+			 fb_info.var.xres_virtual, fb_info.var.yres_virtual);
 
 	if (register_framebuffer(&fb_info) < 0) {
 #ifdef ATAFB_EXT
-- 
2.17.1
