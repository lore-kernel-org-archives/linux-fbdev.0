From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:55 +0000
Subject: [PATCH 10/13] drivers/video: fsl-diu-fb: fix memory leak on error
Message-Id: <1316123098-30967-11-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We were forgetting to unmap the video memory if fsl_diu_check_var() fails.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 3776949..c66f6ed 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1200,6 +1200,7 @@ static int __devinit install_fb(struct fb_info *info)
 
 	if (fsl_diu_check_var(&info->var, info)) {
 		dev_err(info->dev, "fsl_diu_check_var failed\n");
+		unmap_video_memory(info);
 		fb_dealloc_cmap(&info->cmap);
 		return -EINVAL;
 	}
-- 
1.7.3.4


