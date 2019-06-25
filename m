From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 25 Jun 2019 16:01:03 +0000
Subject: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-Id: <20190625160103.GA13133@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_blank’:
drivers/video/fbdev/s3c-fb.c:811:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
   sfb->enabled &= ~(1 << index);
   ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
drivers/video/fbdev/s3c-fb.c:814:2: note: here
  case FB_BLANK_NORMAL:
  ^~~~
  LD [M]  drivers/staging/greybus/gb-light.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp10b.o
drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_check_var’:
drivers/video/fbdev/s3c-fb.c:286:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
   var->transp.length = 1;
   ~~~~~~~~~~~~~~~~~~~^~~
drivers/video/fbdev/s3c-fb.c:288:2: note: here
  case 18:
  ^~~~
drivers/video/fbdev/s3c-fb.c:314:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
   var->transp.offset = 24;
   ~~~~~~~~~~~~~~~~~~~^~~~
drivers/video/fbdev/s3c-fb.c:316:2: note: here
  case 24:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comments are modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/s3c-fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 288300035164..f0b0643ab195 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -284,7 +284,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 		/* 666 with one bit alpha/transparency */
 		var->transp.offset	= 18;
 		var->transp.length	= 1;
-		/* drop through */
+		/* fall through */
 	case 18:
 		var->bits_per_pixel	= 32;
 
@@ -312,7 +312,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 	case 25:
 		var->transp.length	= var->bits_per_pixel - 24;
 		var->transp.offset	= 24;
-		/* drop through */
+		/* fall through */
 	case 24:
 		/* our 24bpp is unpacked, so 32bpp */
 		var->bits_per_pixel	= 32;
@@ -809,7 +809,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 	case FB_BLANK_POWERDOWN:
 		wincon &= ~WINCONx_ENWIN;
 		sfb->enabled &= ~(1 << index);
-		/* fall through to FB_BLANK_NORMAL */
+		/* fall through - to FB_BLANK_NORMAL */
 
 	case FB_BLANK_NORMAL:
 		/* disable the DMA and display 0x0 (black) */
-- 
2.21.0
