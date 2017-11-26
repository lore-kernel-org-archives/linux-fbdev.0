From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 20:42:49 +0000
Subject: [PATCH 1/2] video: fbdev-MMP: Delete an error message for a failed memory allocation in two function
Message-Id: <9aa9c376-22a3-f682-d9a4-5ee95cfd75a0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
In-Reply-To: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 21:16:30 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c    | 5 ++---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index 92279e02dd94..292b3e403044 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -495,10 +495,9 @@ static int modes_setup(struct mmpfb_info *fbi)
 	/* put videomode list to info structure */
 	videomodes = kzalloc(sizeof(struct fb_videomode) * videomode_num,
 			GFP_KERNEL);
-	if (!videomodes) {
-		dev_err(fbi->dev, "can't malloc video modes\n");
+	if (!videomodes)
 		return -ENOMEM;
-	}
+
 	for (i = 0; i < videomode_num; i++)
 		mmpmode_to_fbmode(&videomodes[i], &mmp_modes[i]);
 	fb_videomode_to_modelist(videomodes, videomode_num, &info->modelist);
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index b6f83d5df9fd..9f912ea0bfce 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -407,11 +407,9 @@ static int path_init(struct mmphw_path_plat *path_plat,
 
 	/* init driver data */
 	path_info = kzalloc(sizeof(struct mmp_path_info), GFP_KERNEL);
-	if (!path_info) {
-		dev_err(ctrl->dev, "%s: unable to alloc path_info for %s\n",
-				__func__, config->name);
+	if (!path_info)
 		return 0;
-	}
+
 	path_info->name = config->name;
 	path_info->id = path_plat->id;
 	path_info->dev = ctrl->dev;
-- 
2.15.0

