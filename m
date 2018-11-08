From: Peter Rosin <peda@axentia.se>
Date: Thu, 08 Nov 2018 09:54:28 +0000
Subject: [REGRESSION PATCH] fbdev: fbmem: behave better with small rotated displays and many CPUs
Message-Id: <20181108095347.19326-1-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Fabian Frederick <ffrederick@users.sourceforge.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Geoff Levand <geoff@infradead.org>, James Simmons <jsimmons@users.sf.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Blitting an image with "negative" offsets is not working since there
is no clipping. It hopefully just crashes. For the bootup logo, there
is protection so that blitting does not happen as the image is drawn
further and further to the right (ROTATE_UR) or further and further
down (ROTATE_CW). There is however no protection when drawing in the
opposite directions (ROTATE_UD and ROTATE_CCW).

Add back this protection.

The regression is 20-odd years old but the mindless warning-killing
mentality displayed in commit 34bdb666f4b2 ("fbdev: fbmem: remove
positive test on unsigned values") is also to blame, methinks.

Fixes: 448d479747b8 ("fbdev: fb_do_show_logo() updates")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index bb7f5f23e347..1abeb0b72455 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -435,7 +435,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num; x++) {
+		u32 dx = image->dx;
+
+		for (x = 0; x < num && image->dx <= dx; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dx -= image->width + 8;
 		}
@@ -447,7 +449,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num; x++) {
+		u32 dy = image->dy;
+
+		for (x = 0; x < num && image->dy <= dy; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dy -= image->height + 8;
 		}
-- 
2.11.0
