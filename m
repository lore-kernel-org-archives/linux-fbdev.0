From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:46 +0000
Subject: [PATCH v2 08/29] fbdev: unicore32: use display information in info not in var for panning
Message-Id: <1308043507-11083-9-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 drivers/video/fb-puv3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fb-puv3.c b/drivers/video/fb-puv3.c
index 27f2c57..60a787f 100644
--- a/drivers/video/fb-puv3.c
+++ b/drivers/video/fb-puv3.c
@@ -624,8 +624,8 @@ static int unifb_pan_display(struct fb_var_screeninfo *var,
 		    || var->xoffset)
 			return -EINVAL;
 	} else {
-		if (var->xoffset + var->xres > info->var.xres_virtual ||
-		    var->yoffset + var->yres > info->var.yres_virtual)
+		if (var->xoffset + info->var.xres > info->var.xres_virtual ||
+		    var->yoffset + info->var.yres > info->var.yres_virtual)
 			return -EINVAL;
 	}
 	info->var.xoffset = var->xoffset;
-- 
1.7.3.4

