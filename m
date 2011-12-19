From: Timur Tabi <timur@freescale.com>
Date: Mon, 19 Dec 2011 22:26:14 +0000
Subject: [PATCH 1/5] drivers/video: fsl-diu-fb: merge init_fbinfo() into install_fb()
Message-Id: <1324333578-23992-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Function init_fbinfo() is called only from install_fb(), and it's only a few
lines long.  Plus, it ignores the return code from fb_alloc_cmap().  Merge
its contents into install_fb() and handle errors properly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 408272c..411a7b3 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1220,21 +1220,6 @@ static struct fb_ops fsl_diu_ops = {
 	.fb_release = fsl_diu_release,
 };
 
-static int init_fbinfo(struct fb_info *info)
-{
-	struct mfb_info *mfbi = info->par;
-
-	info->device = NULL;
-	info->var.activate = FB_ACTIVATE_NOW;
-	info->fbops = &fsl_diu_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
-	info->pseudo_palette = &mfbi->pseudo_palette;
-
-	/* Allocate colormap */
-	fb_alloc_cmap(&info->cmap, 16, 0);
-	return 0;
-}
-
 static int __devinit install_fb(struct fb_info *info)
 {
 	int rc;
@@ -1244,8 +1229,14 @@ static int __devinit install_fb(struct fb_info *info)
 	unsigned int dbsize = ARRAY_SIZE(fsl_diu_mode_db);
 	int has_default_mode = 1;
 
-	if (init_fbinfo(info))
-		return -EINVAL;
+	info->var.activate = FB_ACTIVATE_NOW;
+	info->fbops = &fsl_diu_ops;
+	info->flags = FBINFO_DEFAULT;
+	info->pseudo_palette = mfbi->pseudo_palette;
+
+	rc = fb_alloc_cmap(&info->cmap, 16, 0);
+	if (rc)
+		return rc;
 
 	if (mfbi->index = PLANE0) {
 		if (mfbi->edid_data) {
-- 
1.7.3.4


