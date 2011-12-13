From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:40 +0000
Subject: [PATCH 45/57] fbdev: sh_mobile_meram: Don't inline everything
Message-Id: <1323784972-24205-46-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Let the compiler decide which complex functions to inline, and constify
constant static arrays.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_meram.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index cddb180..0c5b301 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -83,14 +83,14 @@
 
 #define SH_MOBILE_MERAM_ICB_NUM		32
 
-static unsigned long common_regs[] = {
+static const unsigned long common_regs[] = {
 	MEVCR1,
 	MEQSEL1,
 	MEQSEL2,
 };
 #define CMN_REGS_SIZE ARRAY_SIZE(common_regs)
 
-static unsigned long icb_regs[] = {
+static const unsigned long icb_regs[] = {
 	MExxCTL,
 	MExxBSIZE,
 	MExxMNCF,
@@ -180,8 +180,8 @@ static inline unsigned long meram_read_reg(void __iomem *base, unsigned int off)
  * check if there's no overlaps in MERAM allocation.
  */
 
-static inline int meram_check_overlap(struct sh_mobile_meram_priv *priv,
-				      const struct sh_mobile_meram_icb_cfg *new)
+static int meram_check_overlap(struct sh_mobile_meram_priv *priv,
+			       const struct sh_mobile_meram_icb_cfg *new)
 {
 	unsigned int used_start, used_end, meram_start, meram_end;
 	unsigned int i;
@@ -215,9 +215,9 @@ static inline int meram_check_overlap(struct sh_mobile_meram_priv *priv,
  * mark the specified ICB as used
  */
 
-static inline void meram_mark(struct sh_mobile_meram_priv *priv,
-			      const struct sh_mobile_meram_icb_cfg *new,
-			      int pixelformat)
+static void meram_mark(struct sh_mobile_meram_priv *priv,
+		       const struct sh_mobile_meram_icb_cfg *new,
+		       int pixelformat)
 {
 	__set_bit(new->marker_icb, &priv->used_icb);
 	__set_bit(new->cache_icb, &priv->used_icb);
@@ -234,8 +234,8 @@ static inline void meram_mark(struct sh_mobile_meram_priv *priv,
  * unmark the specified ICB as used
  */
 
-static inline void meram_unmark(struct sh_mobile_meram_priv *priv,
-				const struct sh_mobile_meram_icb_cfg *icb)
+static void meram_unmark(struct sh_mobile_meram_priv *priv,
+			 const struct sh_mobile_meram_icb_cfg *icb)
 {
 	__clear_bit(icb->marker_icb, &priv->used_icb);
 	__clear_bit(icb->cache_icb, &priv->used_icb);
@@ -244,7 +244,7 @@ static inline void meram_unmark(struct sh_mobile_meram_priv *priv,
 /*
  * is this a YCbCr(NV12, NV16 or NV24) colorspace
  */
-static inline int is_nvcolor(int cspace)
+static int is_nvcolor(int cspace)
 {
 	if (cspace = SH_MOBILE_MERAM_PF_NV ||
 	    cspace = SH_MOBILE_MERAM_PF_NV24)
@@ -255,10 +255,10 @@ static inline int is_nvcolor(int cspace)
 /*
  * set the next address to fetch
  */
-static inline void meram_set_next_addr(struct sh_mobile_meram_priv *priv,
-				       const struct sh_mobile_meram_cfg *cfg,
-				       unsigned long base_addr_y,
-				       unsigned long base_addr_c)
+static void meram_set_next_addr(struct sh_mobile_meram_priv *priv,
+				const struct sh_mobile_meram_cfg *cfg,
+				unsigned long base_addr_y,
+				unsigned long base_addr_c)
 {
 	struct sh_mobile_meram_icb *icb = &priv->icbs[cfg->icb[0].marker_icb];
 	unsigned long target;
@@ -285,7 +285,7 @@ static inline void meram_set_next_addr(struct sh_mobile_meram_priv *priv,
 /*
  * get the next ICB address
  */
-static inline void
+static void
 meram_get_next_icb_addr(struct sh_mobile_meram_info *pdata,
 			const struct sh_mobile_meram_cfg *cfg,
 			unsigned long *icb_addr_y, unsigned long *icb_addr_c)
-- 
1.7.3.4

