From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:47 +0000
Subject: [PATCH v2 09/29] g364fb: use display information in info not in var for panning
Message-Id: <1308043507-11083-10-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/g364fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/g364fb.c b/drivers/video/g364fb.c
index d662317..223896c 100644
--- a/drivers/video/g364fb.c
+++ b/drivers/video/g364fb.c
@@ -149,10 +149,11 @@ int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 static int g364fb_pan_display(struct fb_var_screeninfo *var, 
 			      struct fb_info *info)
 {
-	if (var->xoffset || var->yoffset + var->yres > var->yres_virtual)
+	if (var->xoffset ||
+	    var->yoffset + info->var.yres > info->var.yres_virtual)
 		return -EINVAL;
 
-	*(unsigned int *) TOP_REG = var->yoffset * var->xres;
+	*(unsigned int *) TOP_REG = var->yoffset * info->var.xres;
 	return 0;
 }
 
-- 
1.7.3.4

