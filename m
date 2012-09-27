From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 08:48:34 +0000
Subject: [PATCH 7/7] video: s3c-fb: add the bit definitions for VIDCON0_VIDOUT_WB
Message-Id: <000f01cd9c8c$e0b846a0$a228d3e0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds the bit definitions for VIDCON0_VIDOUT_WB.
These definitions are used to support writeback for RGB and
i80 interface. Also, output format of writeback is YUV444.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index 634b18b..e755448 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -24,12 +24,15 @@
 
 #define VIDCON0					(0x00)
 #define VIDCON0_INTERLACE			(1 << 29)
-#define VIDCON0_VIDOUT_MASK			(0x3 << 26)
+#define VIDCON0_VIDOUT_MASK			(0x7 << 26)
 #define VIDCON0_VIDOUT_SHIFT			(26)
 #define VIDCON0_VIDOUT_RGB			(0x0 << 26)
 #define VIDCON0_VIDOUT_TV			(0x1 << 26)
 #define VIDCON0_VIDOUT_I80_LDI0			(0x2 << 26)
 #define VIDCON0_VIDOUT_I80_LDI1			(0x3 << 26)
+#define VIDCON0_VIDOUT_WB_RGB			(0x4 << 26)
+#define VIDCON0_VIDOUT_WB_I80_LDI0		(0x6 << 26)
+#define VIDCON0_VIDOUT_WB_I80_LDI1		(0x7 << 26)
 
 #define VIDCON0_L1_DATA_MASK			(0x7 << 23)
 #define VIDCON0_L1_DATA_SHIFT			(23)
-- 
1.7.1


