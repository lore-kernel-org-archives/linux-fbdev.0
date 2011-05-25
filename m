From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:21 +0000
Subject: [PATCH 29/29] staging: xgifb: use display information in info not in var for panning
Message-Id: <1306364301-8195-30-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnaud Patard <apatard@mandriva.com>
---
 drivers/staging/xgifb/XGI_main_26.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 721bd25..10a6142 100644
--- a/drivers/staging/xgifb/XGI_main_26.c
+++ b/drivers/staging/xgifb/XGI_main_26.c
@@ -1148,26 +1148,16 @@ static int XGIfb_do_set_var(struct fb_var_screeninfo *var, int isactive,
 }
 
 #ifdef XGIFB_PAN
-static int XGIfb_pan_var(struct fb_var_screeninfo *var)
+static int XGIfb_pan_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	unsigned int base;
 
 	/* printk("Inside pan_var"); */
 
-	if (var->xoffset > (var->xres_virtual - var->xres)) {
-		/* printk("Pan: xo: %d xv %d xr %d\n",
-			var->xoffset, var->xres_virtual, var->xres); */
-		return -EINVAL;
-	}
-	if (var->yoffset > (var->yres_virtual - var->yres)) {
-		/* printk("Pan: yo: %d yv %d yr %d\n",
-			var->yoffset, var->yres_virtual, var->yres); */
-		return -EINVAL;
-	}
-	base = var->yoffset * var->xres_virtual + var->xoffset;
+	base = var->yoffset * info->var.xres_virtual + var->xoffset;
 
 	/* calculate base bpp dep. */
-	switch (var->bits_per_pixel) {
+	switch (info->var.bits_per_pixel) {
 	case 16:
 		base >>= 1;
 		break;
@@ -1425,9 +1415,9 @@ static int XGIfb_pan_display(struct fb_var_screeninfo *var,
 
 	/* printk("\nInside pan_display:\n"); */
 
-	if (var->xoffset > (var->xres_virtual - var->xres))
+	if (var->xoffset > (info->var.xres_virtual - info->var.xres))
 		return -EINVAL;
-	if (var->yoffset > (var->yres_virtual - var->yres))
+	if (var->yoffset > (info->var.yres_virtual - info->var.yres))
 		return -EINVAL;
 
 	if (var->vmode & FB_VMODE_YWRAP) {
@@ -1440,7 +1430,7 @@ static int XGIfb_pan_display(struct fb_var_screeninfo *var,
 						> info->var.yres_virtual)
 			return -EINVAL;
 	}
-	err = XGIfb_pan_var(var);
+	err = XGIfb_pan_var(var, info);
 	if (err < 0)
 		return err;
 
-- 
1.7.3.4

