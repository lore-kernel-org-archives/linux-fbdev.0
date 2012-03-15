From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Mar 2012 17:43:51 +0000
Subject: [RFC/PATCH 3/6] sh_mobile_meram: Add direct MERAM allocation API
Message-Id: <1331833434-11934-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The API can be used to allocate and free MERAM blocks directly, without
going through ICBs.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |   39 +++++++++++++++++++++++++++++++++++----
 include/video/sh_mobile_meram.h |   16 ++++++++++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 843fb29..ae9dc3b 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -194,6 +194,21 @@ static inline unsigned long meram_read_reg(void __iomem *base, unsigned int off)
 }
 
 /* -----------------------------------------------------------------------------
+ * MERAM allocation and free
+ */
+
+static unsigned long meram_alloc(struct sh_mobile_meram_priv *priv, size_t size)
+{
+	return gen_pool_alloc(priv->pool, size);
+}
+
+static void meram_free(struct sh_mobile_meram_priv *priv, unsigned long mem,
+		       size_t size)
+{
+	gen_pool_free(priv->pool, mem, size);
+}
+
+/* -----------------------------------------------------------------------------
  * LCDC cache planes allocation, init, cleanup and free
  */
 
@@ -215,7 +230,7 @@ static int meram_plane_alloc(struct sh_mobile_meram_priv *priv,
 		return -ENOMEM;
 	plane->marker = &priv->icbs[idx];
 
-	mem = gen_pool_alloc(priv->pool, size * 1024);
+	mem = meram_alloc(priv, size * 1024);
 	if (mem = 0)
 		return -ENOMEM;
 
@@ -232,8 +247,8 @@ static int meram_plane_alloc(struct sh_mobile_meram_priv *priv,
 static void meram_plane_free(struct sh_mobile_meram_priv *priv,
 			     struct sh_mobile_meram_fb_plane *plane)
 {
-	gen_pool_free(priv->pool, priv->meram + plane->marker->offset,
-		      plane->marker->size * 1024);
+	meram_free(priv, priv->meram + plane->marker->offset,
+		   plane->marker->size * 1024);
 
 	__clear_bit(plane->marker->index, &priv->used_icb);
 	__clear_bit(plane->cache->index, &priv->used_icb);
@@ -385,9 +400,25 @@ static void meram_plane_cleanup(struct sh_mobile_meram_priv *priv,
 }
 
 /* -----------------------------------------------------------------------------
- * LCDC cache operations
+ * MERAM operations
  */
 
+unsigned long sh_mobile_meram_alloc(struct sh_mobile_meram_info *pdata,
+				    size_t size)
+{
+	struct sh_mobile_meram_priv *priv = pdata->priv;
+
+	return meram_alloc(priv, size);
+}
+
+void sh_mobile_meram_free(struct sh_mobile_meram_info *pdata, unsigned long mem,
+			  size_t size)
+{
+	struct sh_mobile_meram_priv *priv = pdata->priv;
+
+	meram_free(priv, mem, size);
+}
+
 /* Allocate memory for the ICBs and mark them as used. */
 static struct sh_mobile_meram_fb_cache *
 meram_cache_alloc(struct sh_mobile_meram_priv *priv,
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index 1134837..062e6e7 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -38,6 +38,10 @@ struct sh_mobile_meram_cfg {
 
 #if defined(CONFIG_FB_SH_MOBILE_MERAM) || \
     defined(CONFIG_FB_SH_MOBILE_MERAM_MODULE)
+unsigned long sh_mobile_meram_alloc(struct sh_mobile_meram_info *meram_dev,
+				    size_t size);
+void sh_mobile_meram_free(struct sh_mobile_meram_info *meram_dev,
+			  unsigned long mem, size_t size);
 void *sh_mobile_meram_cache_alloc(struct sh_mobile_meram_info *dev,
 				  const struct sh_mobile_meram_cfg *cfg,
 				  unsigned int xres, unsigned int yres,
@@ -50,6 +54,18 @@ void sh_mobile_meram_cache_update(struct sh_mobile_meram_info *dev, void *data,
 				  unsigned long *icb_addr_y,
 				  unsigned long *icb_addr_c);
 #else
+static inline unsigned long
+sh_mobile_meram_alloc(struct sh_mobile_meram_info *meram_dev, size_t size)
+{
+	return 0;
+}
+
+static inline void
+sh_mobile_meram_free(struct sh_mobile_meram_info *meram_dev,
+		     unsigned long mem, size_t size)
+{
+}
+
 static inline void *
 sh_mobile_meram_cache_alloc(struct sh_mobile_meram_info *dev,
 			    const struct sh_mobile_meram_cfg *cfg,
-- 
1.7.3.4

