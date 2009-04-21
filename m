From: Roel Kluin <roel.kluin@gmail.com>
Subject: fbcmap: non working tests on unsigned cmap->start
Date: Tue, 21 Apr 2009 16:26:33 +0200
Message-ID: <49EDD799.8060607@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754849AbZDUO0t@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

vi include/linux/fb.h +478

Note that struct fb_cmap_user cmap->start in fb_set_user_cmap() is unsigned.
Should there maybe be a test:

if (cmap->start > MAX || ...)

(and what should MAX be then?)

Otherwise you may want to apply the cleanup patch below

Roel
------------------------------>8-------------8<---------------------------------
Remove redundant tests on unsigned

Signed-off-by: Roel Kluin <roel.kluin@gmail.com> 
---
diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index f53b9f1..958bf4e 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -266,8 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		rc = -ENODEV;
 		goto out;
 	}
-	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
-				!info->fbops->fb_setcmap)) {
+	if (!info->fbops->fb_setcolreg && !info->fbops->fb_setcmap) {
 		rc = -EINVAL;
 		goto out1;
 	}
