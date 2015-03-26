From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:26:37 +0000
Subject: [PATCH v2 09/12] staging: sm750: blank line after declaration
Message-Id: <624153b59166fb9ee199d45a9ac5d57b56622592.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes "WARNING: Missing a blank line after declaration"
checkpatch.pl warnings.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---

v2: fix ident
---
 drivers/staging/sm750fb/sm750.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 6887926..c72d9d6 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -156,6 +156,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
 		u16 fg, bg;
+
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
 		      ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
 		      ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
@@ -269,7 +270,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 
 	if (image->depth = 1) {
 		if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
-				info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
+		    info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
 			fgcol = ((u32*)info->pseudo_palette)[image->fg_color];
 			bgcol = ((u32*)info->pseudo_palette)[image->bg_color];
 		} else {
@@ -620,9 +621,12 @@ exit:
 }
 
 
-static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
-				unsigned green, unsigned blue,
-				unsigned transp, struct fb_info *info)
+static int lynxfb_ops_setcolreg(unsigned regno,
+				unsigned red,
+				unsigned green,
+				unsigned blue,
+				unsigned transp,
+				struct fb_info *info)
 {
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
@@ -654,9 +658,10 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256) {
 		u32 val;
+
 		if (var->bits_per_pixel = 16 ||
-		   var->bits_per_pixel = 32 ||
-		   var->bits_per_pixel = 24) {
+		    var->bits_per_pixel = 32 ||
+		    var->bits_per_pixel = 24) {
 			val = chan_to_field(red, &var->red);
 			val |= chan_to_field(green, &var->green);
 			val |= chan_to_field(blue, &var->blue);
@@ -1189,6 +1194,7 @@ ALLOC_FB:
 	} else {
 		struct lynxfb_par *par;
 		int errno;
+
 		pr_info("framebuffer #%d alloc okay\n", fbidx);
 		share->fbinfo[fbidx] = info[fbidx];
 		par = info[fbidx]->par;
@@ -1208,8 +1214,8 @@ ALLOC_FB:
 		errno = register_framebuffer(info[fbidx]);
 		if (errno < 0) {
 			pr_err("Failed to register fb_info #%d. err %d\n",
-				fbidx,
-				errno);
+			       fbidx,
+			       errno);
 			if (fbidx = 0)
 				goto err_register0;
 			else
-- 
2.3.3

