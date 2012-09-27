From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:07:30 +0000
Subject: [PATCH 2/7] video: s3c-fb: move the address definitions for VIDTCON registers
Message-Id: <000a01cd9c87$23fca3d0$6bf5eb70$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The address definitions for VIDTCON registers are moved to right
place.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index bd0a04e..bc22f3c 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -116,6 +116,7 @@
 
 /* VIDTCON0 */
 
+#define VIDTCON0				(0x10)
 #define VIDTCON0_VBPDE_MASK			(0xff << 24)
 #define VIDTCON0_VBPDE_SHIFT			(24)
 #define VIDTCON0_VBPDE_LIMIT			(0xff)
@@ -138,6 +139,7 @@
 
 /* VIDTCON1 */
 
+#define VIDTCON1				(0x14)
 #define VIDTCON1_VFPDE_MASK			(0xff << 24)
 #define VIDTCON1_VFPDE_SHIFT			(24)
 #define VIDTCON1_VFPDE_LIMIT			(0xff)
@@ -159,6 +161,7 @@
 #define VIDTCON1_HSPW(_x)			((_x) << 0)
 
 #define VIDTCON2				(0x18)
+#define VIDTCON2				(0x18)
 #define VIDTCON2_LINEVAL_E(_x)			((((_x) & 0x800) >> 11) << 23)
 #define VIDTCON2_LINEVAL_MASK			(0x7ff << 11)
 #define VIDTCON2_LINEVAL_SHIFT			(11)
@@ -405,11 +408,6 @@
 #define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
 #define VIDCON1_FSTATUS_EVEN	(1 << 15)
 
-/* Video timing controls */
-#define VIDTCON0				(0x10)
-#define VIDTCON1				(0x14)
-#define VIDTCON2				(0x18)
-
 /* OSD1 and OSD4 do not have register D */
 
 #define VIDOSD_BASE				(0x40)
-- 
1.7.1


