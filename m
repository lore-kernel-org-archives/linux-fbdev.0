From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 05 Feb 2013 13:35:13 +0000
Subject: [PATCH 3/5] atmel_lcdfb: remove unsupported 15-bpp mode
Message-Id: <1360071315-4032-4-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130129135435.GN7360@game.jcrosoft.org>
 <1360071315-4032-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1360071315-4032-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since commit 787f9fd23283 ("atmel_lcdfb: support 16bit BGR:565 mode,
remove unsupported 15bit modes") atmel_lcdfb_check_var does not accept
15-bpp mode so remove it from atmel_lcdfb_set_par as well.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/atmel_lcdfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 025428e..93910e3 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -567,7 +567,6 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 		case 2: value |= ATMEL_LCDC_PIXELSIZE_2; break;
 		case 4: value |= ATMEL_LCDC_PIXELSIZE_4; break;
 		case 8: value |= ATMEL_LCDC_PIXELSIZE_8; break;
-		case 15: /* fall through */
 		case 16: value |= ATMEL_LCDC_PIXELSIZE_16; break;
 		case 24: value |= ATMEL_LCDC_PIXELSIZE_24; break;
 		case 32: value |= ATMEL_LCDC_PIXELSIZE_32; break;
-- 
1.8.1.1

