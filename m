From: Chen Gang <gang.chen@asianux.com>
Date: Mon, 22 Jul 2013 08:26:10 +0000
Subject: [PATCH] drivers: video: fbcmap: add signed type cast for comparation
Message-Id: <51ECECA2.1020006@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

According to fb_set_cmap() in this file, knows about it is necessary to
check 'start' whether less than zero or not, so need add related type
cast for its comparing.

The related warning:

  drivers/video/fbcmap.c:288:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/video/fbcmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index 5c3960d..44c88e3 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -285,7 +285,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		rc = -ENODEV;
 		goto out;
 	}
-	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
+	if ((int)cmap->start < 0 || (!info->fbops->fb_setcolreg &&
 				!info->fbops->fb_setcmap)) {
 		rc = -EINVAL;
 		goto out1;
-- 
1.7.7.6
