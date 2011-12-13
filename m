From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:36 +0000
Subject: [PATCH 41/57] fbdev: sh_mobile_meram: Add _cfg suffix to struct sh_mobile_meram_icb
Message-Id: <1323784972-24205-42-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The structure describe ICB configuration, no ICB objects themselves.
Rename it to sh_mobile_meram_icb_cfg in preparation for the addition of
an ICB structure.

All the structure fields are unsigned integers, make them so.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |   10 +++++-----
 include/video/sh_mobile_meram.h |   14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index dbf5c43..2ad5a45 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -156,7 +156,7 @@ static inline unsigned long meram_read_reg(void __iomem *base, int off)
  */
 
 static inline int meram_check_overlap(struct sh_mobile_meram_priv *priv,
-				      struct sh_mobile_meram_icb *new)
+				      struct sh_mobile_meram_icb_cfg *new)
 {
 	int i;
 	int used_start, used_end, meram_start, meram_end;
@@ -188,7 +188,7 @@ static inline int meram_check_overlap(struct sh_mobile_meram_priv *priv,
  */
 
 static inline void meram_mark(struct sh_mobile_meram_priv *priv,
-			      struct sh_mobile_meram_icb *new)
+			      struct sh_mobile_meram_icb_cfg *new)
 {
 	int n;
 
@@ -211,7 +211,7 @@ static inline void meram_mark(struct sh_mobile_meram_priv *priv,
  */
 
 static inline void meram_unmark(struct sh_mobile_meram_priv *priv,
-				struct sh_mobile_meram_icb *icb)
+				struct sh_mobile_meram_icb_cfg *icb)
 {
 	int i;
 	unsigned long pattern;
@@ -303,7 +303,7 @@ static inline void meram_get_next_icb_addr(struct sh_mobile_meram_info *pdata,
  */
 
 static int meram_init(struct sh_mobile_meram_priv *priv,
-		      struct sh_mobile_meram_icb *icb,
+		      struct sh_mobile_meram_icb_cfg *icb,
 		      int xres, int yres, int *out_pitch)
 {
 	unsigned long total_byte_count = MERAM_CALC_BYTECOUNT(xres, yres);
@@ -370,7 +370,7 @@ static int meram_init(struct sh_mobile_meram_priv *priv,
 }
 
 static void meram_deinit(struct sh_mobile_meram_priv *priv,
-			struct sh_mobile_meram_icb *icb)
+			 struct sh_mobile_meram_icb_cfg *icb)
 {
 	/* disable ICB */
 	meram_write_icb(priv->base, icb->cache_icb,  MExxCTL,
diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index af602d6..caae558 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -25,17 +25,17 @@ struct sh_mobile_meram_info {
 };
 
 /* icb config */
-struct sh_mobile_meram_icb {
-	int marker_icb;		/* ICB # for Marker ICB */
-	int cache_icb;		/* ICB # for Cache ICB */
-	int meram_offset;	/* MERAM Buffer Offset to use */
-	int meram_size;		/* MERAM Buffer Size to use */
+struct sh_mobile_meram_icb_cfg {
+	unsigned int marker_icb;	/* ICB # for Marker ICB */
+	unsigned int cache_icb;		/* ICB # for Cache ICB */
+	unsigned int meram_offset;	/* MERAM Buffer Offset to use */
+	unsigned int meram_size;	/* MERAM Buffer Size to use */
 
-	int cache_unit;		/* bytes to cache per ICB */
+	unsigned int cache_unit;	/* bytes to cache per ICB */
 };
 
 struct sh_mobile_meram_cfg {
-	struct sh_mobile_meram_icb	icb[2];
+	struct sh_mobile_meram_icb_cfg	icb[2];
 	int				pixelformat;
 	int				current_reg;
 };
-- 
1.7.3.4

