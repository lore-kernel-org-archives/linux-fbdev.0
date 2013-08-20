From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 20 Aug 2013 02:33:56 +0000
Subject: [PATCH v2] drivers: video: fbcmap: remove the redundency and incorrect checkings
Message-Id: <5212D594.3020802@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fb_set_cmap() already checks the parameters, so need remove the
redundancy checking.

This redundancy checking is also incorrect, the related warning:

  drivers/video/fbcmap.c:288:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/video/fbcmap.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index 5c3960d..f89245b 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -285,13 +285,8 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		rc = -ENODEV;
 		goto out;
 	}
-	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
-				!info->fbops->fb_setcmap)) {
-		rc = -EINVAL;
-		goto out1;
-	}
+
 	rc = fb_set_cmap(&umap, info);
-out1:
 	unlock_fb_info(info);
 out:
 	fb_dealloc_cmap(&umap);
-- 
1.7.7.6
