From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Jul 2015 12:27:11 +0000
Subject: [PATCH 1/2] ARM: integrator: move framebuffers to driver
Message-Id: <1438172831-11450-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
"video: move Versatile CLCD helpers" already moved the
CLCD mode setting helpers for Versatile and Integrator/CP
to drivers/video/fbdev. Let's do the same for the IM-PD1
add-on board, copy the missing displays into the database
and simplify the code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
FBDEV maintainers: requesting your ACK so I can take this into
the ARM SoC tree.
---
 arch/arm/mach-integrator/impd1.c          | 181 +++---------------------------
 drivers/video/fbdev/amba-clcd-versatile.c |  80 +++++++++++++
 2 files changed, 94 insertions(+), 167 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 38b0da300dd5..f164643b7c59 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl061.h>
 #include <linux/io.h>
@@ -64,131 +65,6 @@ static struct mmci_platform_data mmc_data = {
 /*
  * CLCD support
  */
-#define PANEL		PROSPECTOR
-
-#define LTM10C209		1
-#define PROSPECTOR		2
-#define SVGA			3
-#define VGA			4
-
-#if PANEL = VGA
-#define PANELTYPE	vga
-static struct clcd_panel vga = {
-	.mode		= {
-		.name		= "VGA",
-		.refresh	= 60,
-		.xres		= 640,
-		.yres		= 480,
-		.pixclock	= 39721,
-		.left_margin	= 40,
-		.right_margin	= 24,
-		.upper_margin	= 32,
-		.lower_margin	= 11,
-		.hsync_len	= 96,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551,
-	.connector	= IMPD1_CTRL_DISP_VGA,
-	.bpp		= 16,
-	.grayscale	= 0,
-};
-
-#elif PANEL = SVGA
-#define PANELTYPE	svga
-static struct clcd_panel svga = {
-	.mode		= {
-		.name		= "SVGA",
-		.refresh	= 0,
-		.xres		= 800,
-		.yres		= 600,
-		.pixclock	= 27778,
-		.left_margin	= 20,
-		.right_margin	= 20,
-		.upper_margin	= 5,
-		.lower_margin	= 5,
-		.hsync_len	= 164,
-		.vsync_len	= 62,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.connector	= IMPD1_CTRL_DISP_VGA,
-	.caps		= CLCD_CAP_5551,
-	.bpp		= 16,
-	.grayscale	= 0,
-};
-
-#elif PANEL = PROSPECTOR
-#define PANELTYPE	prospector
-static struct clcd_panel prospector = {
-	.mode		= {
-		.name		= "PROSPECTOR",
-		.refresh	= 0,
-		.xres		= 640,
-		.yres		= 480,
-		.pixclock	= 40000,
-		.left_margin	= 33,
-		.right_margin	= 64,
-		.upper_margin	= 36,
-		.lower_margin	= 7,
-		.hsync_len	= 64,
-		.vsync_len	= 25,
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551,
-	.fixedtimings	= 1,
-	.connector	= IMPD1_CTRL_DISP_LCD,
-	.bpp		= 16,
-	.grayscale	= 0,
-};
-
-#elif PANEL = LTM10C209
-#define PANELTYPE	ltm10c209
-/*
- * Untested.
- */
-static struct clcd_panel ltm10c209 = {
-	.mode		= {
-		.name		= "LTM10C209",
-		.refresh	= 0,
-		.xres		= 640,
-		.yres		= 480,
-		.pixclock	= 40000,
-		.left_margin	= 20,
-		.right_margin	= 20,
-		.upper_margin	= 19,
-		.lower_margin	= 19,
-		.hsync_len	= 20,
-		.vsync_len	= 10,
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551,
-	.fixedtimings	= 1,
-	.connector	= IMPD1_CTRL_DISP_LCD,
-	.bpp		= 16,
-	.grayscale	= 0,
-};
-#endif
-
 /*
  * Disable all display connectors on the interface module.
  */
@@ -206,51 +82,22 @@ static void impd1fb_clcd_enable(struct clcd_fb *fb)
 			fb->panel->connector | IMPD1_CTRL_DISP_ENABLE);
 }
 
-static int impd1fb_clcd_setup(struct clcd_fb *fb)
-{
-	unsigned long framebase = fb->dev->res.start + 0x01000000;
-	unsigned long framesize = SZ_1M;
-	int ret = 0;
+#define PANEL "PROSPECTOR"
 
-	fb->panel = &PANELTYPE;
-
-	if (!request_mem_region(framebase, framesize, "clcd framebuffer")) {
-		printk(KERN_ERR "IM-PD1: unable to reserve framebuffer\n");
-		return -EBUSY;
-	}
-
-	fb->fb.screen_base = ioremap(framebase, framesize);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "IM-PD1: unable to map framebuffer\n");
-		ret = -ENOMEM;
-		goto free_buffer;
-	}
-
-	fb->fb.fix.smem_start	= framebase;
-	fb->fb.fix.smem_len	= framesize;
-
-	return 0;
-
- free_buffer:
-	release_mem_region(framebase, framesize);
-	return ret;
-}
-
-static int impd1fb_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
+static int impd1fb_clcd_setup(struct clcd_fb *fb)
 {
-	unsigned long start, size;
+	fb->panel = versatile_clcd_get_panel(PANEL);
 
-	start = vma->vm_pgoff + (fb->fb.fix.smem_start >> PAGE_SHIFT);
-	size = vma->vm_end - vma->vm_start;
+	if (!fb->panel)
+		return -EINVAL;
 
-	return remap_pfn_range(vma, vma->vm_start, start, size,
-			       vma->vm_page_prot);
-}
+	if (!strcmp(PANEL, "VGA") || !strcmp(PANEL, "SVGA") ||
+	    !strcmp(PANEL, "XVGA"))
+		fb->panel->connector = IMPD1_CTRL_DISP_VGA;
+	else
+		fb->panel->connector = IMPD1_CTRL_DISP_LCD;
 
-static void impd1fb_clcd_remove(struct clcd_fb *fb)
-{
-	iounmap(fb->fb.screen_base);
-	release_mem_region(fb->fb.fix.smem_start, fb->fb.fix.smem_len);
+	return versatile_clcd_setup_dma(fb, SZ_1M);
 }
 
 static struct clcd_board impd1_clcd_data = {
@@ -261,8 +108,8 @@ static struct clcd_board impd1_clcd_data = {
 	.disable	= impd1fb_clcd_disable,
 	.enable		= impd1fb_clcd_enable,
 	.setup		= impd1fb_clcd_setup,
-	.mmap		= impd1fb_clcd_mmap,
-	.remove		= impd1fb_clcd_remove,
+	.mmap		= versatile_clcd_mmap_dma,
+	.remove		= versatile_clcd_remove_dma,
 };
 
 struct impd1_device {
diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 7a8afcd4573e..293499981031 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -28,6 +28,31 @@ static struct clcd_panel vga = {
 	.bpp		= 16,
 };
 
+static struct clcd_panel svga = {
+	.mode		= {
+		.name		= "SVGA",
+		.refresh	= 0,
+		.xres		= 800,
+		.yres		= 600,
+		.pixclock	= 27778,
+		.left_margin	= 20,
+		.right_margin	= 20,
+		.upper_margin	= 5,
+		.lower_margin	= 5,
+		.hsync_len	= 164,
+		.vsync_len	= 62,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD,
+	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+	.grayscale	= 0,
+};
+
 static struct clcd_panel xvga = {
 	.mode		= {
 		.name		= "XVGA",
@@ -126,12 +151,67 @@ static struct clcd_panel epson_l2f50113t00 = {
 	.bpp		= 16,
 };
 
+static struct clcd_panel prospector = {
+	.mode		= {
+		.name		= "PROSPECTOR",
+		.refresh	= 0,
+		.xres		= 640,
+		.yres		= 480,
+		.pixclock	= 40000,
+		.left_margin	= 33,
+		.right_margin	= 64,
+		.upper_margin	= 36,
+		.lower_margin	= 7,
+		.hsync_len	= 64,
+		.vsync_len	= 25,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD,
+	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.fixedtimings	= 1,
+	.bpp		= 16,
+	.grayscale	= 0,
+};
+
+static struct clcd_panel ltm10c209 = {
+	.mode		= {
+		.name		= "LTM10C209",
+		.refresh	= 0,
+		.xres		= 640,
+		.yres		= 480,
+		.pixclock	= 40000,
+		.left_margin	= 20,
+		.right_margin	= 20,
+		.upper_margin	= 19,
+		.lower_margin	= 19,
+		.hsync_len	= 20,
+		.vsync_len	= 10,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD,
+	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.fixedtimings	= 1,
+	.bpp		= 16,
+	.grayscale	= 0,
+};
+
 static struct clcd_panel *panels[] = {
 	&vga,
+	&svga,
 	&xvga,
 	&sanyo_tm38qv67a02a,
 	&sanyo_2_5_in,
 	&epson_l2f50113t00,
+	&prospector,
+	&ltm10c209,
 };
 
 struct clcd_panel *versatile_clcd_get_panel(const char *name)
-- 
2.4.3

