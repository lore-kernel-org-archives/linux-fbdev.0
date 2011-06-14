From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:41 +0000
Subject: [PATCH v2 03/29] acornfb: use display information in info not in var for panning
Message-Id: <1308043507-11083-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/acornfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 3bacc12..b303f17 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -850,9 +850,9 @@ acornfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	u_int y_bottom = var->yoffset;
 
 	if (!(var->vmode & FB_VMODE_YWRAP))
-		y_bottom += var->yres;
+		y_bottom += info->var.yres;
 
-	if (y_bottom > var->yres_virtual)
+	if (y_bottom > info->var.yres_virtual)
 		return -EINVAL;
 
 	acornfb_update_dma(info, var);
-- 
1.7.3.4

