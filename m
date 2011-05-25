From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:03 +0000
Subject: [PATCH 11/29] hgafb: use display information in info not in var for panning
Message-Id: <1306364301-8195-12-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: Brent Cook <busterb@gmail.com>
---
 drivers/video/hgafb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index 4052718..4394389 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -422,8 +422,8 @@ static int hgafb_pan_display(struct fb_var_screeninfo *var,
 		    var->xoffset)
 			return -EINVAL;
 	} else {
-		if (var->xoffset + var->xres > info->var.xres_virtual
-		 || var->yoffset + var->yres > info->var.yres_virtual
+		if (var->xoffset + info->var.xres > info->var.xres_virtual
+		 || var->yoffset + info->var.yres > info->var.yres_virtual
 		 || var->yoffset % 8)
 			return -EINVAL;
 	}
-- 
1.7.3.4

