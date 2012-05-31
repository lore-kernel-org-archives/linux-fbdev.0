From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 31 May 2012 16:33:59 +0000
Subject: [PATCH 1/2] fbdev: sh_mobile_meram: Add MERAM operations wrappers
Message-Id: <1338482040-29827-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove direct dependency on the MERAM driver implementation by
introducing inline wrappers for MERAM operations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |   24 ++++++++++++------------
 include/video/sh_mobile_meram.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 82ba830..c51849f 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -444,11 +444,11 @@ static void meram_deinit(struct sh_mobile_meram_priv *priv,
  * Registration/unregistration
  */
 
-static void *sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
-				      const struct sh_mobile_meram_cfg *cfg,
-				      unsigned int xres, unsigned int yres,
-				      unsigned int pixelformat,
-				      unsigned int *pitch)
+static void *__sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
+					const struct sh_mobile_meram_cfg *cfg,
+					unsigned int xres, unsigned int yres,
+					unsigned int pixelformat,
+					unsigned int *pitch)
 {
 	struct sh_mobile_meram_fb_cache *cache;
 	struct sh_mobile_meram_priv *priv = pdata->priv;
@@ -495,7 +495,7 @@ err:
 }
 
 static void
-sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata, void *data)
+__sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata, void *data)
 {
 	struct sh_mobile_meram_fb_cache *cache = data;
 	struct sh_mobile_meram_priv *priv = pdata->priv;
@@ -513,9 +513,9 @@ sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata, void *data)
 }
 
 static void
-sh_mobile_meram_update(struct sh_mobile_meram_info *pdata, void *data,
-		       unsigned long base_addr_y, unsigned long base_addr_c,
-		       unsigned long *icb_addr_y, unsigned long *icb_addr_c)
+__sh_mobile_meram_update(struct sh_mobile_meram_info *pdata, void *data,
+			 unsigned long base_addr_y, unsigned long base_addr_c,
+			 unsigned long *icb_addr_y, unsigned long *icb_addr_c)
 {
 	struct sh_mobile_meram_fb_cache *cache = data;
 	struct sh_mobile_meram_priv *priv = pdata->priv;
@@ -530,9 +530,9 @@ sh_mobile_meram_update(struct sh_mobile_meram_info *pdata, void *data,
 
 static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
 	.module			= THIS_MODULE,
-	.meram_register		= sh_mobile_meram_register,
-	.meram_unregister	= sh_mobile_meram_unregister,
-	.meram_update		= sh_mobile_meram_update,
+	.meram_register		= __sh_mobile_meram_register,
+	.meram_unregister	= __sh_mobile_meram_unregister,
+	.meram_update		= __sh_mobile_meram_update,
 };
 
 /* -----------------------------------------------------------------------------
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index 29b2fd3..b03f823 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -60,4 +60,32 @@ struct sh_mobile_meram_ops {
 			     unsigned long *icb_addr_c);
 };
 
+static inline void *
+sh_mobile_meram_register(struct sh_mobile_meram_info *mdev,
+			 const struct sh_mobile_meram_cfg *cfg,
+			 unsigned int xres, unsigned int yres,
+			 unsigned int pixelformat, unsigned int *pitch)
+{
+	if (mdev = NULL || mdev->ops = NULL || cfg = NULL)
+		return NULL;
+
+	return mdev->ops->meram_register(mdev, cfg, xres, yres, pixelformat,
+					 pitch);
+}
+
+static inline void
+sh_mobile_meram_unregister(struct sh_mobile_meram_info *mdev, void *data)
+{
+	mdev->ops->meram_unregister(mdev, data);
+}
+
+static inline void
+sh_mobile_meram_update(struct sh_mobile_meram_info *mdev, void *data,
+		       unsigned long base_addr_y, unsigned long base_addr_c,
+		       unsigned long *icb_addr_y, unsigned long *icb_addr_c)
+{
+	mdev->ops->meram_update(mdev, data, base_addr_y, base_addr_c,
+				icb_addr_y, icb_addr_c);
+}
+
 #endif /* __VIDEO_SH_MOBILE_MERAM_H__  */
-- 
1.7.3.4

