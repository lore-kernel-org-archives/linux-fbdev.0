From: roel kluin <roel.kluin@gmail.com>
Subject: [PATCH] gbefb: unsigned var->pixclock cannot be less than 0
Date: Wed, 26 Nov 2008 17:18:56 -0500
Message-ID: <492DCB50.9040005@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754043AbYKZWTT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

unsigned var->pixclock cannot be less than 0

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
var->pixclock has type __u32, see
vi include/linux/fb.h +231

compute_gbe_timing() returns int, see
vi drivers/video/gbefb.c +466

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index f89c3cc..fe5b519 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -912,6 +912,7 @@ static int gbefb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	unsigned int line_length;
 	struct gbe_timing_info timing;
+	int ret;
 
 	/* Limit bpp to 8, 16, and 32 */
 	if (var->bits_per_pixel <= 8)
@@ -930,8 +931,10 @@ static int gbefb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	var->grayscale = 0;	/* No grayscale for now */
 
-	if ((var->pixclock = compute_gbe_timing(var, &timing)) < 0)
-		return(-EINVAL);
+	ret = compute_gbe_timing(var, &timing);
+	var->pixclock = ret;
+	if (ret < 0)
+		return -EINVAL;
 
 	/* Adjust virtual resolution, if necessary */
 	if (var->xres > var->xres_virtual || (!ywrap && !ypan))
