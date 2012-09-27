From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:47:58 +0000
Subject: [PATCH 6/7] video: s3c-fb: move the bit definitions for DITHMODE register
Message-Id: <000e01cd9c8c$cb709540$6251bfc0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The bit definitions for DITHMODE registers are moved according to
address order. Also, the bit definition of VIDCON1_FSTATUS_EVEN
is moved.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |   42 ++++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index d5fe38b..634b18b 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -77,6 +77,7 @@
 #define VIDCON1_LINECNT_MASK			(0x7ff << 16)
 #define VIDCON1_LINECNT_SHIFT			(16)
 #define VIDCON1_LINECNT_GET(_v)			(((_v) >> 16) & 0x7ff)
+#define VIDCON1_FSTATUS_EVEN			(1 << 15)
 #define VIDCON1_VSTATUS_MASK			(0x3 << 13)
 #define VIDCON1_VSTATUS_SHIFT			(13)
 #define VIDCON1_VSTATUS_VSYNC			(0x0 << 13)
@@ -376,6 +377,25 @@
 #define WxKEYCON1_COLVAL_LIMIT			(0xffffff)
 #define WxKEYCON1_COLVAL(_x)			((_x) << 0)
 
+/* Dithering control */
+#define DITHMODE				(0x170)
+#define DITHMODE_R_POS_MASK			(0x3 << 5)
+#define DITHMODE_R_POS_SHIFT			(5)
+#define DITHMODE_R_POS_8BIT			(0x0 << 5)
+#define DITHMODE_R_POS_6BIT			(0x1 << 5)
+#define DITHMODE_R_POS_5BIT			(0x2 << 5)
+#define DITHMODE_G_POS_MASK			(0x3 << 3)
+#define DITHMODE_G_POS_SHIFT			(3)
+#define DITHMODE_G_POS_8BIT			(0x0 << 3)
+#define DITHMODE_G_POS_6BIT			(0x1 << 3)
+#define DITHMODE_G_POS_5BIT			(0x2 << 3)
+#define DITHMODE_B_POS_MASK			(0x3 << 1)
+#define DITHMODE_B_POS_SHIFT			(1)
+#define DITHMODE_B_POS_8BIT			(0x0 << 1)
+#define DITHMODE_B_POS_6BIT			(0x1 << 1)
+#define DITHMODE_B_POS_5BIT			(0x2 << 1)
+#define DITHMODE_DITH_EN			(1 << 0)
+
 /* Window blanking (MAP) */
 #define WINxMAP(_win)				(0x180 + ((_win) * 4))
 #define WINxMAP_MAP				(1 << 24)
@@ -416,28 +436,6 @@
 #define BLENDCON_NEW_4BIT_ALPHA_VALUE		(0 << 0)
 
 #define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
-#define VIDCON1_FSTATUS_EVEN	(1 << 15)
-
-#define DITHMODE				(0x170)
-#define DITHMODE_R_POS_MASK			(0x3 << 5)
-#define DITHMODE_R_POS_SHIFT			(5)
-#define DITHMODE_R_POS_8BIT			(0x0 << 5)
-#define DITHMODE_R_POS_6BIT			(0x1 << 5)
-#define DITHMODE_R_POS_5BIT			(0x2 << 5)
-
-#define DITHMODE_G_POS_MASK			(0x3 << 3)
-#define DITHMODE_G_POS_SHIFT			(3)
-#define DITHMODE_G_POS_8BIT			(0x0 << 3)
-#define DITHMODE_G_POS_6BIT			(0x1 << 3)
-#define DITHMODE_G_POS_5BIT			(0x2 << 3)
-
-#define DITHMODE_B_POS_MASK			(0x3 << 1)
-#define DITHMODE_B_POS_SHIFT			(1)
-#define DITHMODE_B_POS_8BIT			(0x0 << 1)
-#define DITHMODE_B_POS_6BIT			(0x1 << 1)
-#define DITHMODE_B_POS_5BIT			(0x2 << 1)
-
-#define DITHMODE_DITH_EN			(1 << 0)
 
 /* Notes on per-window bpp settings
  *
-- 
1.7.1


