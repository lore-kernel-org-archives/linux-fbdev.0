From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 25 Jun 2013 14:22:29 +0000
Subject: [PATCH 01/23] video: da8xx-fb: fb_check_var enhancement
Message-Id: <1372170171-9561-2-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

Check whether "struct fb_var_screeninfo" fields are sane, if not
update it to be within allowed limits.

If user sends down buggy "var" values, this will bring those within
allowable limits. And fb_set_par is not supposed to change "var"
values, fb_check_var has to ensure that values are proper.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0810939..d00dd17 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -888,6 +888,9 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 			struct fb_info *info)
 {
 	int err = 0;
+	struct da8xx_fb_par *par = info->par;
+	int bpp = var->bits_per_pixel >> 3;
+	unsigned long line_size = var->xres_virtual * bpp;
 
 	if (var->bits_per_pixel > 16 && lcd_revision = LCD_VERSION_1)
 		return -EINVAL;
@@ -955,6 +958,21 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 	var->green.msb_right = 0;
 	var->blue.msb_right = 0;
 	var->transp.msb_right = 0;
+
+	if (line_size * var->yres_virtual > par->vram_size)
+		var->yres_virtual = par->vram_size / line_size;
+
+	if (var->yres > var->yres_virtual)
+		var->yres = var->yres_virtual;
+
+	if (var->xres > var->xres_virtual)
+		var->xres = var->xres_virtual;
+
+	if (var->xres + var->xoffset > var->xres_virtual)
+		var->xoffset = var->xres_virtual - var->xres;
+	if (var->yres + var->yoffset > var->yres_virtual)
+		var->yoffset = var->yres_virtual - var->yres;
+
 	return err;
 }
 
-- 
1.7.0.4

