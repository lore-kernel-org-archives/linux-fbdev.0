From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Mar 2012 17:43:50 +0000
Subject: [RFC/PATCH 2/6] sh_mobile_meram: Use direct function calls for the public API
Message-Id: <1331833434-11934-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There's no reason to use abstract operation pointers to implement the
MERAM API. Replace them by direct function calls.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   27 +++++++-------------
 drivers/video/sh_mobile_meram.c  |   34 +++++++++++--------------
 include/video/sh_mobile_meram.h  |   50 ++++++++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1efc65e..cf80194 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -849,13 +849,12 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		ch->base_addr_c = ch->base_addr_y + ch->xres * ch->yres_virtual;
 
 		/* Enable MERAM if possible. */
-		if (mdev = NULL || mdev->ops = NULL ||
-		    ch->cfg->meram_cfg = NULL)
+		if (mdev = NULL || ch->cfg->meram_cfg = NULL)
 			continue;
 
 		/* Free the allocated MERAM cache. */
 		if (ch->cache) {
-			mdev->ops->cache_free(mdev, ch->cache);
+			sh_mobile_meram_cache_free(mdev, ch->cache);
 			ch->cache = NULL;
 		}
 
@@ -878,11 +877,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			break;
 		}
 
-		cache = mdev->ops->cache_alloc(mdev, ch->cfg->meram_cfg,
+		cache = sh_mobile_meram_cache_alloc(mdev, ch->cfg->meram_cfg,
 					ch->pitch, ch->yres, pixelformat,
 					&ch->pitch);
 		if (!IS_ERR(cache)) {
-			mdev->ops->cache_update(mdev, cache,
+			sh_mobile_meram_cache_update(mdev, cache,
 					ch->base_addr_y, ch->base_addr_c,
 					&ch->base_addr_y, &ch->base_addr_c);
 			ch->cache = cache;
@@ -952,9 +951,7 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 
 		/* Free the MERAM cache. */
 		if (ch->cache) {
-			struct sh_mobile_meram_info *mdev;
-			mdev = priv->meram_dev;
-			mdev->ops->cache_free(mdev, ch->cache);
+			sh_mobile_meram_cache_free(priv->meram_dev, ch->cache);
 			ch->cache = 0;
 		}
 
@@ -1039,7 +1036,7 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
 	unsigned long ldrcntr;
 	unsigned long new_pan_offset;
-	unsigned long base_addr_y, base_addr_c;
+	unsigned long base_addr_y, base_addr_c = 0;
 	unsigned long c_offset;
 
 	if (!ch->format->yuv)
@@ -1068,14 +1065,10 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 			base_addr_c += var->xoffset;
 	}
 
-	if (ch->cache) {
-		struct sh_mobile_meram_info *mdev;
-
-		mdev = priv->meram_dev;
-		mdev->ops->cache_update(mdev, ch->cache,
-					base_addr_y, base_addr_c,
-					&base_addr_y, &base_addr_c);
-	}
+	if (ch->cache)
+		sh_mobile_meram_cache_update(priv->meram_dev, ch->cache,
+					     base_addr_y, base_addr_c,
+					     &base_addr_y, &base_addr_c);
 
 	ch->base_addr_y = base_addr_y;
 	ch->base_addr_c = base_addr_c;
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 4aa3fcb..843fb29 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -429,11 +429,10 @@ error:
 	return ERR_PTR(-ENOMEM);
 }
 
-static void *sh_mobile_cache_alloc(struct sh_mobile_meram_info *pdata,
-				   const struct sh_mobile_meram_cfg *cfg,
-				   unsigned int xres, unsigned int yres,
-				   unsigned int pixelformat,
-				   unsigned int *pitch)
+void *sh_mobile_meram_cache_alloc(struct sh_mobile_meram_info *pdata,
+				  const struct sh_mobile_meram_cfg *cfg,
+				  unsigned int xres, unsigned int yres,
+				  unsigned int pixelformat, unsigned int *pitch)
 {
 	struct sh_mobile_meram_fb_cache *cache;
 	struct sh_mobile_meram_priv *priv = pdata->priv;
@@ -441,6 +440,9 @@ static void *sh_mobile_cache_alloc(struct sh_mobile_meram_info *pdata,
 	unsigned int nplanes = is_nvcolor(pixelformat) ? 2 : 1;
 	unsigned int out_pitch;
 
+	if (priv = NULL)
+		return ERR_PTR(-ENODEV);
+
 	if (pixelformat != SH_MOBILE_MERAM_PF_NV &&
 	    pixelformat != SH_MOBILE_MERAM_PF_NV24 &&
 	    pixelformat != SH_MOBILE_MERAM_PF_RGB)
@@ -486,8 +488,8 @@ err:
 	return cache;
 }
 
-static void
-sh_mobile_cache_free(struct sh_mobile_meram_info *pdata, void *data)
+void
+sh_mobile_meram_cache_free(struct sh_mobile_meram_info *pdata, void *data)
 {
 	struct sh_mobile_meram_fb_cache *cache = data;
 	struct sh_mobile_meram_priv *priv = pdata->priv;
@@ -508,10 +510,12 @@ sh_mobile_cache_free(struct sh_mobile_meram_info *pdata, void *data)
 	mutex_unlock(&priv->lock);
 }
 
-static void
-sh_mobile_cache_update(struct sh_mobile_meram_info *pdata, void *data,
-		       unsigned long base_addr_y, unsigned long base_addr_c,
-		       unsigned long *icb_addr_y, unsigned long *icb_addr_c)
+void
+sh_mobile_meram_cache_update(struct sh_mobile_meram_info *pdata, void *data,
+			     unsigned long base_addr_y,
+			     unsigned long base_addr_c,
+			     unsigned long *icb_addr_y,
+			     unsigned long *icb_addr_c)
 {
 	struct sh_mobile_meram_fb_cache *cache = data;
 	struct sh_mobile_meram_priv *priv = pdata->priv;
@@ -524,13 +528,6 @@ sh_mobile_cache_update(struct sh_mobile_meram_info *pdata, void *data,
 	mutex_unlock(&priv->lock);
 }
 
-static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
-	.module			= THIS_MODULE,
-	.cache_alloc		= sh_mobile_cache_alloc,
-	.cache_free		= sh_mobile_cache_free,
-	.cache_update		= sh_mobile_cache_update,
-};
-
 /* -----------------------------------------------------------------------------
  * Power management
  */
@@ -620,7 +617,6 @@ static int __devinit sh_mobile_meram_probe(struct platform_device *pdev)
 	for (i = 0; i < MERAM_ICB_NUM; ++i)
 		priv->icbs[i].index = i;
 
-	pdata->ops = &sh_mobile_meram_ops;
 	pdata->priv = priv;
 	pdata->pdev = pdev;
 
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index 8a5afaf..1134837 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -15,7 +15,6 @@ enum {
 
 
 struct sh_mobile_meram_priv;
-struct sh_mobile_meram_ops;
 
 /*
  * struct sh_mobile_meram_info - MERAM platform data
@@ -24,7 +23,6 @@ struct sh_mobile_meram_ops;
 struct sh_mobile_meram_info {
 	int				addr_mode;
 	u32				reserved_icbs;
-	struct sh_mobile_meram_ops	*ops;
 	struct sh_mobile_meram_priv	*priv;
 	struct platform_device		*pdev;
 };
@@ -38,21 +36,43 @@ struct sh_mobile_meram_cfg {
 	struct sh_mobile_meram_icb_cfg icb[2];
 };
 
-struct module;
-struct sh_mobile_meram_ops {
-	struct module	*module;
-
-	/* LCDC cache management */
-	void *(*cache_alloc)(struct sh_mobile_meram_info *meram_dev,
-			     const struct sh_mobile_meram_cfg *cfg,
-			     unsigned int xres, unsigned int yres,
-			     unsigned int pixelformat, unsigned int *pitch);
-	void (*cache_free)(struct sh_mobile_meram_info *meram_dev, void *data);
-	void (*cache_update)(struct sh_mobile_meram_info *meram_dev, void *data,
+#if defined(CONFIG_FB_SH_MOBILE_MERAM) || \
+    defined(CONFIG_FB_SH_MOBILE_MERAM_MODULE)
+void *sh_mobile_meram_cache_alloc(struct sh_mobile_meram_info *dev,
+				  const struct sh_mobile_meram_cfg *cfg,
+				  unsigned int xres, unsigned int yres,
+				  unsigned int pixelformat,
+				  unsigned int *pitch);
+void sh_mobile_meram_cache_free(struct sh_mobile_meram_info *dev, void *data);
+void sh_mobile_meram_cache_update(struct sh_mobile_meram_info *dev, void *data,
+				  unsigned long base_addr_y,
+				  unsigned long base_addr_c,
+				  unsigned long *icb_addr_y,
+				  unsigned long *icb_addr_c);
+#else
+static inline void *
+sh_mobile_meram_cache_alloc(struct sh_mobile_meram_info *dev,
+			    const struct sh_mobile_meram_cfg *cfg,
+			    unsigned int xres, unsigned int yres,
+			    unsigned int pixelformat,
+			    unsigned int *pitch)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void
+sh_mobile_meram_cache_free(struct sh_mobile_meram_info *dev, void *data)
+{
+}
+
+static inline void
+sh_mobile_meram_cache_update(struct sh_mobile_meram_info *dev, void *data,
 			     unsigned long base_addr_y,
 			     unsigned long base_addr_c,
 			     unsigned long *icb_addr_y,
-			     unsigned long *icb_addr_c);
-};
+			     unsigned long *icb_addr_c)
+{
+}
+#endif
 
 #endif /* __VIDEO_SH_MOBILE_MERAM_H__  */
-- 
1.7.3.4

