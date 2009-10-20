From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fbdev: Wrong test on unsigned in fb_set_user_cmap()?
Date: Tue, 20 Oct 2009 21:30:38 +0200
Message-ID: <4ADE0FDE.5070101@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752484AbZJTTUf@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

struct fb_cmap_user member start is unsigned.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this required?

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index f53b9f1..f46f05f 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -266,7 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		rc = -ENODEV;
 		goto out;
 	}
-	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
+	if ((int)cmap->start < 0 || (!info->fbops->fb_setcolreg &&
 				!info->fbops->fb_setcmap)) {
 		rc = -EINVAL;
 		goto out1;
