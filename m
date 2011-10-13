From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 13 Oct 2011 14:52:50 +0000
Subject: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported 15bit modes
Message-Id: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Allow framebuffer to be configured in 16bit mode when panel is wired in
(the default) BGR configuration, and don't claim to support 15bit input
modes, which the LCD controller cannot handle.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/video/atmel_lcdfb.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 7ca3eaf..143f6d9 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -418,24 +418,18 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 		var->red.length = var->green.length = var->blue.length
 			= var->bits_per_pixel;
 		break;
-	case 15:
 	case 16:
 		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
 			/* RGB:565 mode */
 			var->red.offset = 11;
 			var->blue.offset = 0;
-			var->green.length = 6;
-		} else if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB555) {
-			var->red.offset = 10;
-			var->blue.offset = 0;
-			var->green.length = 5;
 		} else {
-			/* BGR:555 mode */
+			/* BGR:565 mode */
 			var->red.offset = 0;
-			var->blue.offset = 10;
-			var->green.length = 5;
+			var->blue.offset = 11;
 		}
 		var->green.offset = 5;
+		var->green.length = 6;
 		var->red.length = var->blue.length = 5;
 		break;
 	case 32:
-- 
1.7.6.3

