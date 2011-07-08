From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:16 +0000
Subject: [PATCH v3 02/29] acornfb: Dont BUG() on invalid pan parameters
Message-Id: <1310123683-8064-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver currently BUG()s if the pan parameters passed directly from
userspace are invalid. Return -EINVAL instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/acornfb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 6183a57..3bacc12 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -852,7 +852,8 @@ acornfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (!(var->vmode & FB_VMODE_YWRAP))
 		y_bottom += var->yres;
 
-	BUG_ON(y_bottom > var->yres_virtual);
+	if (y_bottom > var->yres_virtual)
+		return -EINVAL;
 
 	acornfb_update_dma(info, var);
 
-- 
1.7.3.4

