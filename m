From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:47:16 +0000
Subject: [PATCH 5/7] video: s3c-fb: move the bit definitions for WINxMAP and WPALCON register
Message-Id: <000d01cd9c8c$b257deb0$17079c10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The bit definitions for WINxMAP and WPALCON register are moved to
right place.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index 7c9a9bc..d5fe38b 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -376,16 +376,20 @@
 #define WxKEYCON1_COLVAL_LIMIT			(0xffffff)
 #define WxKEYCON1_COLVAL(_x)			((_x) << 0)
 
-
 /* Window blanking (MAP) */
-
+#define WINxMAP(_win)				(0x180 + ((_win) * 4))
 #define WINxMAP_MAP				(1 << 24)
 #define WINxMAP_MAP_COLOUR_MASK			(0xffffff << 0)
 #define WINxMAP_MAP_COLOUR_SHIFT		(0)
 #define WINxMAP_MAP_COLOUR_LIMIT		(0xffffff)
 #define WINxMAP_MAP_COLOUR(_x)			((_x) << 0)
 
+/* Winodw palette control */
+#define WPALCON					(0x1A0)
 #define WPALCON_PAL_UPDATE			(1 << 9)
+#define WPALCON_W4PAL_16BPP_A555		(1 << 8)
+#define WPALCON_W3PAL_16BPP_A555		(1 << 7)
+#define WPALCON_W2PAL_16BPP_A555		(1 << 6)
 #define WPALCON_W1PAL_MASK			(0x7 << 3)
 #define WPALCON_W1PAL_SHIFT			(3)
 #define WPALCON_W1PAL_25BPP_A888		(0x0 << 3)
@@ -395,7 +399,6 @@
 #define WPALCON_W1PAL_18BPP			(0x4 << 3)
 #define WPALCON_W1PAL_16BPP_A555		(0x5 << 3)
 #define WPALCON_W1PAL_16BPP_565			(0x6 << 3)
-
 #define WPALCON_W0PAL_MASK			(0x7 << 0)
 #define WPALCON_W0PAL_SHIFT			(0)
 #define WPALCON_W0PAL_25BPP_A888		(0x0 << 0)
@@ -416,9 +419,6 @@
 #define VIDCON1_FSTATUS_EVEN	(1 << 15)
 
 #define DITHMODE				(0x170)
-#define WINxMAP(_win)				(0x180 + ((_win) * 4))
-
-
 #define DITHMODE_R_POS_MASK			(0x3 << 5)
 #define DITHMODE_R_POS_SHIFT			(5)
 #define DITHMODE_R_POS_8BIT			(0x0 << 5)
@@ -439,16 +439,6 @@
 
 #define DITHMODE_DITH_EN			(1 << 0)
 
-#define WPALCON					(0x1A0)
-
-/* Palette control */
-/* Note for S5PC100: you can still use those macros on WPALCON (aka WPALCON_L),
- * but make sure that WPALCON_H W2PAL-W4PAL entries are zeroed out */
-#define WPALCON_W4PAL_16BPP_A555		(1 << 8)
-#define WPALCON_W3PAL_16BPP_A555		(1 << 7)
-#define WPALCON_W2PAL_16BPP_A555		(1 << 6)
-
-
 /* Notes on per-window bpp settings
  *
  * Value	Win0	 Win1	  Win2	   Win3	    Win 4
-- 
1.7.1


