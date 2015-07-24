From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Jul 2015 13:31:28 +0000
Subject: [PATCH] ARM/fb: ep93xx: switch framebuffer to use modedb only
Message-Id: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

All the EP93xx boards exclusively use modedb to look up video
modes from the command line. Root out the parametrization of
custom video modes from the platform data and board files
and simplify the driver.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
J-C/Tomi: please ACK this if you're OK with it so I can take
it through the ARM SoC tree.
---
 arch/arm/mach-ep93xx/edb93xx.c             |  2 --
 arch/arm/mach-ep93xx/simone.c              |  2 --
 arch/arm/mach-ep93xx/snappercl15.c         |  2 --
 arch/arm/mach-ep93xx/vision_ep9307.c       |  2 --
 drivers/video/fbdev/ep93xx-fb.c            | 30 ++++--------------------------
 include/linux/platform_data/video-ep93xx.h |  8 --------
 6 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 27b14ae92c7e..ad92d9f7e4df 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -205,8 +205,6 @@ static void __init edb93xx_register_pwm(void)
  * EDB93xx framebuffer
  *************************************************************************/
 static struct ep93xxfb_mach_info __initdata edb93xxfb_info = {
-	.num_modes	= EP93XXFB_USE_MODEDB,
-	.bpp		= 16,
 	.flags		= 0,
 };
 
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index d0938a219443..7bb540c421ee 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -40,8 +40,6 @@ static struct ep93xx_eth_data __initdata simone_eth_data = {
 };
 
 static struct ep93xxfb_mach_info __initdata simone_fb_info = {
-	.num_modes	= EP93XXFB_USE_MODEDB,
-	.bpp		= 16,
 	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
 };
 
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index aa86f86638dd..c4904264256a 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -144,8 +144,6 @@ static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
 };
 
 static struct ep93xxfb_mach_info __initdata snappercl15_fb_info = {
-	.num_modes		= EP93XXFB_USE_MODEDB,
-	.bpp			= 16,
 };
 
 static struct platform_device snappercl15_audio_device = {
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index ff22a6a6e2bf..5cced5988498 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -106,8 +106,6 @@ static void vision_lcd_blank(int blank_mode, struct fb_info *info)
 }
 
 static struct ep93xxfb_mach_info ep93xxfb_info __initdata = {
-	.num_modes	= EP93XXFB_USE_MODEDB,
-	.bpp		= 16,
 	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
 	.setup		= vision_lcd_setup,
 	.teardown	= vision_lcd_teardown,
diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 7ec251cc9c03..5b1081030cbb 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -419,36 +419,15 @@ static struct fb_ops ep93xxfb_ops = {
 	.fb_mmap	= ep93xxfb_mmap,
 };
 
-static int ep93xxfb_calc_fbsize(struct ep93xxfb_mach_info *mach_info)
-{
-	int i, fb_size = 0;
-
-	if (mach_info->num_modes = EP93XXFB_USE_MODEDB) {
-		fb_size = EP93XXFB_MAX_XRES * EP93XXFB_MAX_YRES *
-			mach_info->bpp / 8;
-	} else {
-		for (i = 0; i < mach_info->num_modes; i++) {
-			const struct fb_videomode *mode;
-			int size;
-
-			mode = &mach_info->modes[i];
-			size = mode->xres * mode->yres * mach_info->bpp / 8;
-			if (size > fb_size)
-				fb_size = size;
-		}
-	}
-
-	return fb_size;
-}
-
 static int ep93xxfb_alloc_videomem(struct fb_info *info)
 {
-	struct ep93xx_fbi *fbi = info->par;
 	char __iomem *virt_addr;
 	dma_addr_t phys_addr;
 	unsigned int fb_size;
 
-	fb_size = ep93xxfb_calc_fbsize(fbi->mach_info);
+	/* Maximum 16bpp -> used memory is maximum x*y*2 bytes */
+	fb_size = EP93XXFB_MAX_XRES * EP93XXFB_MAX_YRES * 2;
+
 	virt_addr = dma_alloc_writecombine(info->dev, fb_size,
 					   &phys_addr, GFP_KERNEL);
 	if (!virt_addr)
@@ -550,8 +529,7 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 
 	fb_get_options("ep93xx-fb", &video_mode);
 	err = fb_find_mode(&info->var, info, video_mode,
-			   fbi->mach_info->modes, fbi->mach_info->num_modes,
-			   fbi->mach_info->default_mode, fbi->mach_info->bpp);
+			   NULL, 0, NULL, 16);
 	if (err = 0) {
 		dev_err(info->dev, "No suitable video mode found\n");
 		err = -EINVAL;
diff --git a/include/linux/platform_data/video-ep93xx.h b/include/linux/platform_data/video-ep93xx.h
index 92fc2b2232e7..699ac4109366 100644
--- a/include/linux/platform_data/video-ep93xx.h
+++ b/include/linux/platform_data/video-ep93xx.h
@@ -2,11 +2,8 @@
 #define __VIDEO_EP93XX_H
 
 struct platform_device;
-struct fb_videomode;
 struct fb_info;
 
-#define EP93XXFB_USE_MODEDB		0
-
 /* VideoAttributes flags */
 #define EP93XXFB_STATE_MACHINE_ENABLE	(1 << 0)
 #define EP93XXFB_PIXEL_CLOCK_ENABLE	(1 << 1)
@@ -38,12 +35,7 @@ struct fb_info;
 					 EP93XXFB_PIXEL_DATA_ENABLE)
 
 struct ep93xxfb_mach_info {
-	unsigned int			num_modes;
-	const struct fb_videomode	*modes;
-	const struct fb_videomode	*default_mode;
-	int				bpp;
 	unsigned int			flags;
-
 	int	(*setup)(struct platform_device *pdev);
 	void	(*teardown)(struct platform_device *pdev);
 	void	(*blank)(int blank_mode, struct fb_info *info);
-- 
2.4.3

