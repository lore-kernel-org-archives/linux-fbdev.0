From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Thu, 30 Apr 2020 20:09:25 +0000
Subject: [PATCH 2/3] staging: sm750fb: add common function to set color offsets and visual mode
Message-Id: <1588277366-19354-3-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
In-Reply-To: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch will unify code for updating color offsets and frame buffer
visual mode.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/sm750.c | 149 ++++++++++++++------------------
 1 file changed, 67 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 39e610cc3c06..c3ce7e653c7f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -297,6 +297,62 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 	return hw_sm750_pan_display(crtc, var, info);
 }
 
+static inline void lynxfb_set_visual_mode(struct fb_info *info)
+{
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 24:
+	case 32:
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	default:
+		break;
+	}
+}
+
+static inline int lynxfb_set_color_offsets(struct fb_info *info)
+{
+	lynxfb_set_visual_mode(info);
+
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		info->var.red.offset = 0;
+		info->var.red.length = 8;
+		info->var.green.offset = 0;
+		info->var.green.length = 8;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 8;
+		info->var.transp.length = 0;
+		info->var.transp.offset = 0;
+		break;
+	case 16:
+		info->var.red.offset = 11;
+		info->var.red.length = 5;
+		info->var.green.offset = 5;
+		info->var.green.length = 6;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 5;
+		info->var.transp.length = 0;
+		info->var.transp.offset = 0;
+		break;
+	case 24:
+	case 32:
+		info->var.red.offset = 16;
+		info->var.red.length = 8;
+		info->var.green.offset = 8;
+		info->var.green.length = 8;
+		info->var.blue.offset = 0;
+		info->var.blue.length = 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int lynxfb_ops_set_par(struct fb_info *info)
 {
 	struct lynxfb_par *par;
@@ -328,43 +384,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	 * and these data should be set before setcolreg routine
 	 */
 
-	switch (var->bits_per_pixel) {
-	case 8:
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 16:
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		break;
-	case 24:
-	case 32:
-		var->red.offset = 16;
-		var->red.length = 8;
-		var->green.offset = 8;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
+	ret = lynxfb_set_color_offsets(info);
+
 	var->height = var->width = -1;
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
@@ -511,10 +532,12 @@ static int lynxfb_resume(struct pci_dev *pdev)
 static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info)
 {
+	int ret;
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
 	resource_size_t request;
 
+	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
 
@@ -523,43 +546,13 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		 var->yres,
 		 var->bits_per_pixel);
 
-	switch (var->bits_per_pixel) {
-	case 8:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		break;
-	case 16:
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		var->transp.length = 0;
-		var->transp.offset = 0;
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		break;
-	case 24:
-	case 32:
-		var->red.offset = 16;
-		var->red.length = 8;
-		var->green.offset = 8;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		break;
-	default:
+	ret = lynxfb_set_color_offsets(info);
+
+	if (ret) {
 		pr_err("bpp %d not supported\n", var->bits_per_pixel);
-		return -EINVAL;
+		return ret;
 	}
+
 	var->height = var->width = -1;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
@@ -895,16 +888,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = sm750_dev->vidreg_size;
 	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
-	switch (var->bits_per_pixel) {
-	case 8:
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	case 16:
-	case 24:
-	case 32:
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		break;
-	}
+
+	lynxfb_set_visual_mode(info);
 
 	/* set var */
 	var->activate = FB_ACTIVATE_NOW;
-- 
2.26.2
