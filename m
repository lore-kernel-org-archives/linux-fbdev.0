From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 09 Jul 2018 22:41:45 +0000
Subject: [PATCH] video: fbdev: mark expected switch fall-throughs
Message-Id: <20180709224145.GA15004@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/i740fb.c  | 1 +
 drivers/video/fbdev/pm2fb.c   | 2 ++
 drivers/video/fbdev/tdfxfb.c  | 1 +
 drivers/video/fbdev/via/lcd.c | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 7bc5f60..f6d7b04 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -429,6 +429,7 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
 		break;
 	case 9 ... 15:
 		bpp = 15;
+		/* fall through */
 	case 16:
 		if ((1000000 / var->pixclock) > DACSPEED16) {
 			dev_err(info->device, "requested pixclock %i MHz out of range (max. %i MHz at 15/16bpp)\n",
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index bd6c2f5..1dcf02e 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -233,8 +233,10 @@ static u32 to3264(u32 timing, int bpp, int is64)
 	switch (bpp) {
 	case 24:
 		timing *= 3;
+		/* fall through */
 	case 8:
 		timing >>= 1;
+		/* fall through */
 	case 16:
 		timing >>= 1;
 	case 32:
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index dec1fed..fbbf26b 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -522,6 +522,7 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	case 32:
 		var->transp.offset = 24;
 		var->transp.length = 8;
+		/* fall through */
 	case 24:
 		var->red.offset = 16;
 		var->green.offset = 8;
diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd.c
index 5d21ff4..b9305d7 100644
--- a/drivers/video/fbdev/via/lcd.c
+++ b/drivers/video/fbdev/via/lcd.c
@@ -758,6 +758,7 @@ static void set_lcd_output_path(int set_iga, int output_interface)
 		    viaparinfo->chip_info->gfx_chip_name))
 			viafb_write_reg_mask(CR97, VIACR, 0x84,
 				       BIT7 + BIT2 + BIT1 + BIT0);
+		/* fall through */
 	case INTERFACE_DVP0:
 	case INTERFACE_DVP1:
 	case INTERFACE_DFP_HIGH:
-- 
2.7.4

