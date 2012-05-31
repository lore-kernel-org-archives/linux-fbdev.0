From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 31 May 2012 16:34:00 +0000
Subject: [PATCH 2/2] fbdev: sh_mobile_lcdc: Use MERAM operations wrappers
Message-Id: <1338482040-29827-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 7a0b301..671685d 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -857,7 +857,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		 * re-initialize them.
 		 */
 		if (ch->meram) {
-			mdev->ops->meram_unregister(mdev, ch->meram);
+			sh_mobile_meram_unregister(mdev, ch->meram);
 			ch->meram = NULL;
 		}
 
@@ -880,11 +880,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			break;
 		}
 
-		meram = mdev->ops->meram_register(mdev, ch->cfg->meram_cfg,
+		meram = sh_mobile_meram_register(mdev, ch->cfg->meram_cfg,
 					ch->pitch, ch->yres, pixelformat,
 					&ch->pitch);
 		if (!IS_ERR(meram)) {
-			mdev->ops->meram_update(mdev, meram,
+			sh_mobile_meram_update(mdev, meram,
 					ch->base_addr_y, ch->base_addr_c,
 					&ch->base_addr_y, &ch->base_addr_c);
 			ch->meram = meram;
@@ -1070,14 +1070,10 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 			base_addr_c += var->xoffset;
 	}
 
-	if (ch->meram) {
-		struct sh_mobile_meram_info *mdev;
-
-		mdev = priv->meram_dev;
-		mdev->ops->meram_update(mdev, ch->meram,
-					base_addr_y, base_addr_c,
-					&base_addr_y, &base_addr_c);
-	}
+	if (ch->meram)
+		sh_mobile_meram_update(priv->meram_dev, ch->meram,
+				       base_addr_y, base_addr_c,
+				       &base_addr_y, &base_addr_c);
 
 	ch->base_addr_y = base_addr_y;
 	ch->base_addr_c = base_addr_c;
-- 
1.7.3.4

