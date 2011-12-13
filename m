From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:48 +0000
Subject: [PATCH 53/57] fbdev: sh_mobile_meram: Don't perform update in register operation
Message-Id: <1323784972-24205-54-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove the RGB or Y/C base address update from the meram_register()
operation, as this belongs to the meram_update() operation.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    8 +++++---
 drivers/video/sh_mobile_meram.c  |   15 ++-------------
 include/video/sh_mobile_meram.h  |    4 ----
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 4e9572c..e10a78a 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -880,11 +880,13 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		meram = mdev->ops->meram_register(mdev, ch->cfg->meram_cfg,
 					ch->pitch, ch->yres, pixelformat,
-					ch->base_addr_y, ch->base_addr_c,
-					&ch->base_addr_y, &ch->base_addr_c,
 					&ch->pitch);
-		if (!IS_ERR(meram))
+		if (!IS_ERR(meram)) {
+			mdev->ops->meram_update(mdev, meram,
+					ch->base_addr_y, ch->base_addr_c,
+					&ch->base_addr_y, &ch->base_addr_c);
 			ch->meram = meram;
+		}
 	}
 
 	/* Start the LCDC. */
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 01ae5b6..aad8b0b 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -447,10 +447,6 @@ static void *sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 				      const struct sh_mobile_meram_cfg *cfg,
 				      unsigned int xres, unsigned int yres,
 				      unsigned int pixelformat,
-				      unsigned long base_addr_y,
-				      unsigned long base_addr_c,
-				      unsigned long *icb_addr_y,
-				      unsigned long *icb_addr_c,
 				      unsigned int *pitch)
 {
 	struct sh_mobile_meram_fb_cache *cache;
@@ -469,9 +465,8 @@ static void *sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 	priv = pdata->priv;
 	pdev = pdata->pdev;
 
-	dev_dbg(&pdev->dev, "registering %dx%d (%s) (y=%08lx, c=%08lx)",
-		xres, yres, (!pixelformat) ? "yuv" : "rgb",
-		base_addr_y, base_addr_c);
+	dev_dbg(&pdev->dev, "registering %dx%d (%s)", xres, yres,
+		!pixelformat ? "yuv" : "rgb");
 
 	/* we can't handle wider than 8192px */
 	if (xres > 8192) {
@@ -499,12 +494,6 @@ static void *sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 		meram_init(priv, &cache->planes[1], 2 * xres, (yres + 1) / 2,
 			&out_pitch);
 
-	meram_set_next_addr(priv, cache, base_addr_y, base_addr_c);
-	meram_get_next_icb_addr(pdata, cache, icb_addr_y, icb_addr_c);
-
-	dev_dbg(&pdev->dev, "registered - can access via y=%08lx, c=%08lx",
-		*icb_addr_y, *icb_addr_c);
-
 err:
 	mutex_unlock(&priv->lock);
 	return cache;
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index 8ff98eb..51c98ca 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -41,10 +41,6 @@ struct sh_mobile_meram_ops {
 				const struct sh_mobile_meram_cfg *cfg,
 				unsigned int xres, unsigned int yres,
 				unsigned int pixelformat,
-				unsigned long base_addr_y,
-				unsigned long base_addr_c,
-				unsigned long *icb_addr_y,
-				unsigned long *icb_addr_c,
 				unsigned int *pitch);
 
 	/* unregister usage of meram */
-- 
1.7.3.4

