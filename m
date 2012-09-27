From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:46:41 +0000
Subject: [PATCH 4/7] video: s3c-fb: move the bit definitions for VIDINTCON0 register
Message-Id: <000c01cd9c8c$9d4c4bf0$d7e4e3d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The bit definitions for VIDINTCON0 registers are moved to right
place.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index c398728..7c9a9bc 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -308,6 +308,7 @@
 
 /* Interrupt controls and status */
 
+#define VIDINTCON0				(0x130)
 #define VIDINTCON0_FIFOINTERVAL_MASK		(0x3f << 20)
 #define VIDINTCON0_FIFOINTERVAL_SHIFT		(20)
 #define VIDINTCON0_FIFOINTERVAL_LIMIT		(0x3f)
@@ -336,6 +337,9 @@
 #define VIDINTCON0_FIFIOSEL_SHIFT		(5)
 #define VIDINTCON0_FIFIOSEL_WINDOW0		(0x1 << 5)
 #define VIDINTCON0_FIFIOSEL_WINDOW1		(0x2 << 5)
+#define VIDINTCON0_FIFIOSEL_WINDOW2		(0x10 << 5)
+#define VIDINTCON0_FIFIOSEL_WINDOW3		(0x20 << 5)
+#define VIDINTCON0_FIFIOSEL_WINDOW4		(0x40 << 5)
 
 #define VIDINTCON0_FIFOLEVEL_MASK		(0x7 << 2)
 #define VIDINTCON0_FIFOLEVEL_SHIFT		(2)
@@ -411,12 +415,6 @@
 #define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
 #define VIDCON1_FSTATUS_EVEN	(1 << 15)
 
-#define VIDINTCON0				(0x130)
-
-#define VIDINTCON0_FIFIOSEL_WINDOW2		(0x10 << 5)
-#define VIDINTCON0_FIFIOSEL_WINDOW3		(0x20 << 5)
-#define VIDINTCON0_FIFIOSEL_WINDOW4		(0x40 << 5)
-
 #define DITHMODE				(0x170)
 #define WINxMAP(_win)				(0x180 + ((_win) * 4))
 
-- 
1.7.1


