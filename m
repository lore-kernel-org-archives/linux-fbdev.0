From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:43:14 +0000
Subject: [PATCH 3/7] video: s3c-fb: move the address definition for VIDOSD register
Message-Id: <000b01cd9c8c$222fb9c0$668f2d40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The address definition for VIDTCON VIDOSD is moved to right
place.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index bc22f3c..c398728 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -237,6 +237,9 @@
 /* Local input channels (windows 0-2) */
 #define SHADOWCON_CHx_LOCAL_ENABLE(_win)	(1 << (5 + (_win)))
 
+/* VIDOSDx */
+
+#define VIDOSD_BASE				(0x40)
 #define VIDOSDxA_TOPLEFT_X_E(_x)		((((_x) & 0x800) >> 11) << 23)
 #define VIDOSDxA_TOPLEFT_X_MASK			(0x7ff << 11)
 #define VIDOSDxA_TOPLEFT_X_SHIFT		(11)
@@ -408,10 +411,6 @@
 #define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
 #define VIDCON1_FSTATUS_EVEN	(1 << 15)
 
-/* OSD1 and OSD4 do not have register D */
-
-#define VIDOSD_BASE				(0x40)
-
 #define VIDINTCON0				(0x130)
 
 #define VIDINTCON0_FIFIOSEL_WINDOW2		(0x10 << 5)
-- 
1.7.1


