From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Wed, 04 Aug 2010 14:43:09 +0000
Subject: [PATCH] atmel_lcdfb: Fix for HFP substraction
Message-Id: <1280932989-20843-1-git-send-email-alexander.stein@systec-electronic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

According to AT91SAM9263 manual:
> Number of idle LCDDOTCK cycles at the end of the line.
> Idle period is (HFP+2) LCDDOTCK cycles.

So substract 2 instead of 1 on right_margin to match manual description.
Also adjust the LCD timings in at91 board configs

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/mach-at91/board-cap9adk.c      |    2 +-
 arch/arm/mach-at91/board-neocore926.c   |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c    |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c    |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c     |    2 +-
 drivers/video/atmel_lcdfb.c             |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index d694087..9c6f5ed 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -313,7 +313,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
 		.xres		= 240,		.yres		= 320,
 		.pixclock	= KHZ2PICOS(4965),
 
-		.left_margin	= 1,		.right_margin	= 33,
+		.left_margin	= 1,		.right_margin	= 34,
 		.upper_margin	= 1,		.lower_margin	= 0,
 		.hsync_len	= 5,		.vsync_len	= 1,
 
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 7c1e382..dcb04b6 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -241,7 +241,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
 		.xres		= 240,		.yres		= 320,
 		.pixclock	= KHZ2PICOS(5000),
 
-		.left_margin	= 1,		.right_margin	= 33,
+		.left_margin	= 1,		.right_margin	= 34,
 		.upper_margin	= 1,		.lower_margin	= 0,
 		.hsync_len	= 5,		.vsync_len	= 1,
 
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index c4c8865..52f5785 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -372,7 +372,7 @@ static struct fb_videomode at91_stn_modes[] = {
 		.xres           = 320,          .yres           = 240,
 		.pixclock       = KHZ2PICOS(1440),
 
-		.left_margin    = 1,            .right_margin   = 1,
+		.left_margin    = 1,            .right_margin   = 2,
 		.upper_margin   = 0,            .lower_margin   = 0,
 		.hsync_len      = 1,            .vsync_len      = 1,
 
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 2d867fb..d7e36ca 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -267,7 +267,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
 		.xres		= 240,		.yres		= 320,
 		.pixclock	= KHZ2PICOS(4965),
 
-		.left_margin	= 1,		.right_margin	= 33,
+		.left_margin	= 1,		.right_margin	= 34,
 		.upper_margin	= 1,		.lower_margin	= 0,
 		.hsync_len	= 5,		.vsync_len	= 1,
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ee80059..2114488 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -186,7 +186,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
 		.xres		= 480,		.yres		= 272,
 		.pixclock	= KHZ2PICOS(9000),
 
-		.left_margin	= 1,		.right_margin	= 1,
+		.left_margin	= 1,		.right_margin	= 2,
 		.upper_margin	= 40,		.lower_margin	= 1,
 		.hsync_len	= 45,		.vsync_len	= 1,
 
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 7ac20f3..3cd0a34 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -160,7 +160,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
 		.xres		= 240,		.yres		= 320,
 		.pixclock	= KHZ2PICOS(4965),
 
-		.left_margin	= 1,		.right_margin	= 33,
+		.left_margin	= 1,		.right_margin	= 34,
 		.upper_margin	= 1,		.lower_margin	= 0,
 		.hsync_len	= 5,		.vsync_len	= 1,
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 8dce251..e0191c4 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -573,7 +573,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 	lcdc_writel(sinfo, ATMEL_LCDC_TIM1, value);
 
 	/* Horizontal timing */
-	value = (info->var.right_margin - 1) << ATMEL_LCDC_HFP_OFFSET;
+	value = (info->var.right_margin - 2) << ATMEL_LCDC_HFP_OFFSET;
 	value |= (info->var.hsync_len - 1) << ATMEL_LCDC_HPW_OFFSET;
 	value |= (info->var.left_margin - 1);
 	dev_dbg(info->device, "  * LCDTIM2 = %08lx\n", value);
-- 
1.7.1

