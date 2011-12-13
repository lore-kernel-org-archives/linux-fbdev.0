From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:49 +0000
Subject: [PATCH 54/57] fbdev: sh_mobile_meram: Remove unneeded sanity checks
Message-Id: <1323784972-24205-55-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The meram_register(), meram_unregister() and meram_update() operations
check that the pointers they get from the caller are not NULL. Those
checks can be remove, as the caller already ensures that the pointers
are valid.

The platform sanity checks can also be removed, as the operations can't
be accessed without valid platform data anyway.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    5 +----
 drivers/video/sh_mobile_meram.c  |   32 ++++++--------------------------
 include/video/sh_mobile_meram.h  |   15 +++++++--------
 3 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index e10a78a..edd195a 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1070,14 +1070,11 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 
 	if (ch->meram) {
 		struct sh_mobile_meram_info *mdev;
-		int ret;
 
 		mdev = priv->meram_dev;
-		ret = mdev->ops->meram_update(mdev, ch->meram,
+		mdev->ops->meram_update(mdev, ch->meram,
 					base_addr_y, base_addr_c,
 					&base_addr_y, &base_addr_c);
-		if (ret)
-			return ret;
 	}
 
 	ch->base_addr_y = base_addr_y;
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index aad8b0b..f0ae342 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -450,21 +450,15 @@ static void *sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 				      unsigned int *pitch)
 {
 	struct sh_mobile_meram_fb_cache *cache;
-	struct sh_mobile_meram_priv *priv;
-	struct platform_device *pdev;
+	struct sh_mobile_meram_priv *priv = pdata->priv;
+	struct platform_device *pdev = pdata->pdev;
 	unsigned int out_pitch;
 
-	if (!pdata || !pdata->priv || !pdata->pdev || !cfg)
-		return ERR_PTR(-EINVAL);
-
 	if (pixelformat != SH_MOBILE_MERAM_PF_NV &&
 	    pixelformat != SH_MOBILE_MERAM_PF_NV24 &&
 	    pixelformat != SH_MOBILE_MERAM_PF_RGB)
 		return ERR_PTR(-EINVAL);
 
-	priv = pdata->priv;
-	pdev = pdata->pdev;
-
 	dev_dbg(&pdev->dev, "registering %dx%d (%s)", xres, yres,
 		!pixelformat ? "yuv" : "rgb");
 
@@ -499,16 +493,11 @@ err:
 	return cache;
 }
 
-static int
+static void
 sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata, void *data)
 {
 	struct sh_mobile_meram_fb_cache *cache = data;
-	struct sh_mobile_meram_priv *priv;
-
-	if (!pdata || !pdata->priv || !data)
-		return -EINVAL;
-
-	priv = pdata->priv;
+	struct sh_mobile_meram_priv *priv = pdata->priv;
 
 	mutex_lock(&priv->lock);
 
@@ -520,22 +509,15 @@ sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata, void *data)
 	meram_free(priv, cache);
 
 	mutex_unlock(&priv->lock);
-
-	return 0;
 }
 
-static int
+static void
 sh_mobile_meram_update(struct sh_mobile_meram_info *pdata, void *data,
 		       unsigned long base_addr_y, unsigned long base_addr_c,
 		       unsigned long *icb_addr_y, unsigned long *icb_addr_c)
 {
 	struct sh_mobile_meram_fb_cache *cache = data;
-	struct sh_mobile_meram_priv *priv;
-
-	if (!pdata || !pdata->priv || !data)
-		return -EINVAL;
-
-	priv = pdata->priv;
+	struct sh_mobile_meram_priv *priv = pdata->priv;
 
 	mutex_lock(&priv->lock);
 
@@ -543,8 +525,6 @@ sh_mobile_meram_update(struct sh_mobile_meram_info *pdata, void *data,
 	meram_get_next_icb_addr(pdata, cache, icb_addr_y, icb_addr_c);
 
 	mutex_unlock(&priv->lock);
-
-	return 0;
 }
 
 static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index 51c98ca..089e6d3 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -44,16 +44,15 @@ struct sh_mobile_meram_ops {
 				unsigned int *pitch);
 
 	/* unregister usage of meram */
-	int (*meram_unregister)(struct sh_mobile_meram_info *meram_dev,
-				void *data);
+	void (*meram_unregister)(struct sh_mobile_meram_info *meram_dev,
+				 void *data);
 
 	/* update meram settings */
-	int (*meram_update)(struct sh_mobile_meram_info *meram_dev,
-			    void *data,
-			    unsigned long base_addr_y,
-			    unsigned long base_addr_c,
-			    unsigned long *icb_addr_y,
-			    unsigned long *icb_addr_c);
+	void (*meram_update)(struct sh_mobile_meram_info *meram_dev, void *data,
+			     unsigned long base_addr_y,
+			     unsigned long base_addr_c,
+			     unsigned long *icb_addr_y,
+			     unsigned long *icb_addr_c);
 };
 
 #endif /* __VIDEO_SH_MOBILE_MERAM_H__  */
-- 
1.7.3.4

