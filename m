From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 29 Mar 2011 03:35:57 +0000
Subject: [RFC][PATCH 2/3] sh_mobile_meram: Add support for NV24 framebuffers
Message-Id: <1301369758-18394-3-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since the NV24 framebuffer has a CbCr plane that is twice as wide
as the Y plane, it needs to be handled as a special case.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |   10 +++++++---
 drivers/video/sh_mobile_meram.c  |   24 +++++++++++++++++++-----
 include/video/sh_mobile_meram.h  |    3 ++-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 92366bd..6b1db92 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -626,10 +626,14 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 			ch->meram_enabled = 0;
 
-			if (ch->info->var.nonstd)
-				pf = SH_MOBILE_MERAM_PF_NV;
-			else
+			if (ch->info->var.nonstd) {
+				if (ch->info->var.bits_per_pixel = 24)
+					pf = SH_MOBILE_MERAM_PF_NV24;
+				else
+					pf = SH_MOBILE_MERAM_PF_NV;
+			} else {
 				pf = SH_MOBILE_MERAM_PF_RGB;
+			}
 
 			ret = mdev->ops->meram_register(mdev, cfg, pitch,
 						ch->info->var.yres,
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index bd68f3d..9170c82 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -164,6 +164,16 @@ static inline void meram_unmark(struct sh_mobile_meram_priv *priv,
 	}
 }
 
+/*
+ * is this a YCbCr(NV12, NV16 or NV24) colorspace
+ */
+static inline int is_nvcolor(int cspace)
+{
+	if (cspace = SH_MOBILE_MERAM_PF_NV ||
+			cspace = SH_MOBILE_MERAM_PF_NV24)
+		return 1;
+	return 0;
+}
 
 /*
  * set the next address to fetch
@@ -184,7 +194,7 @@ static inline void meram_set_next_addr(struct sh_mobile_meram_priv *priv,
 	meram_write_icb(priv->base, cfg->icb[0].marker_icb, target,
 			base_addr_y + cfg->icb[0].cache_unit);
 
-	if (cfg->pixelformat = SH_MOBILE_MERAM_PF_NV) {
+	if (is_nvcolor(cfg->pixelformat)) {
 		meram_write_icb(priv->base, cfg->icb[1].cache_icb,  target,
 				base_addr_c);
 		meram_write_icb(priv->base, cfg->icb[1].marker_icb, target,
@@ -208,7 +218,7 @@ static inline void meram_get_next_icb_addr(struct sh_mobile_meram_info *pdata,
 		icb_offset = 0xc0000000 | (cfg->current_reg << 23);
 
 	*icb_addr_y = icb_offset | (cfg->icb[0].marker_icb << 24);
-	if ((*icb_addr_c) && cfg->pixelformat = SH_MOBILE_MERAM_PF_NV)
+	if ((*icb_addr_c) && is_nvcolor(cfg->pixelformat))
 		*icb_addr_c = icb_offset | (cfg->icb[1].marker_icb << 24);
 }
 
@@ -316,6 +326,7 @@ static int sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 		return -EINVAL;
 
 	if (pixelformat != SH_MOBILE_MERAM_PF_NV &&
+	    pixelformat != SH_MOBILE_MERAM_PF_NV24 &&
 	    pixelformat != SH_MOBILE_MERAM_PF_RGB)
 		return -EINVAL;
 
@@ -366,7 +377,7 @@ static int sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 		n = 2;
 	}
 
-	if (pixelformat = SH_MOBILE_MERAM_PF_NV && n != 2) {
+	if (is_nvcolor(pixelformat) && n != 2) {
 		dev_err(&pdev->dev, "requires two ICB sets for planar Y/C.");
 		error =  -EINVAL;
 		goto err;
@@ -375,7 +386,7 @@ static int sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 	/* we now register the ICB */
 	cfg->pixelformat = pixelformat;
 	meram_mark(priv, &cfg->icb[0]);
-	if (pixelformat = SH_MOBILE_MERAM_PF_NV)
+	if (is_nvcolor(pixelformat))
 		meram_mark(priv, &cfg->icb[1]);
 
 	/* initialize MERAM */
@@ -384,6 +395,9 @@ static int sh_mobile_meram_register(struct sh_mobile_meram_info *pdata,
 	if (pixelformat = SH_MOBILE_MERAM_PF_NV)
 		meram_init(priv, &cfg->icb[1], xres, (yres + 1) / 2,
 			&out_pitch);
+	else if (pixelformat = SH_MOBILE_MERAM_PF_NV24)
+		meram_init(priv, &cfg->icb[1], 2 * xres, (yres + 1) / 2,
+			&out_pitch);
 
 	cfg->current_reg = 1;
 	meram_set_next_addr(priv, cfg, base_addr_y, base_addr_c);
@@ -410,7 +424,7 @@ static int sh_mobile_meram_unregister(struct sh_mobile_meram_info *pdata,
 	mutex_lock(&priv->lock);
 
 	/* deinit & unmark */
-	if (cfg->pixelformat = SH_MOBILE_MERAM_PF_NV) {
+	if (is_nvcolor(cfg->pixelformat)) {
 		meram_deinit(priv, &cfg->icb[1]);
 		meram_unmark(priv, &cfg->icb[1]);
 	}
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index e6d2410..989eb23 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -9,7 +9,8 @@ enum {
 
 enum {
 	SH_MOBILE_MERAM_PF_NV = 0,
-	SH_MOBILE_MERAM_PF_RGB
+	SH_MOBILE_MERAM_PF_RGB,
+	SH_MOBILE_MERAM_PF_NV24
 };
 
 
-- 
1.7.1

