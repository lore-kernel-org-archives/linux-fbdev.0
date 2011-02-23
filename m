From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 23 Feb 2011 10:16:50 +0000
Subject: [PATCH 2/2] fbdev: sh_mobile_lcdc: Define additional .nonstd flags for sh7372
Message-Id: <1298456210-26519-3-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The value of the .nonstd member of struct sh_mobile_lcdc_info is written
directly into bits 16 and up of LDDFR in the LCDC. This patch defines
additional flags that can be "or'ed" with the .nonstd value to control
the LCDC behaviour when operating the the YUV display mode.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 5736efc..cdbc2cf 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -13,6 +13,17 @@
 
 #include <linux/sh_clk.h>
 
+/* LCDC YUV support:
+ * The following bit flags are used to set the bits 17 and up
+ * in the MLDDFR. These flags should be used to set the
+ * .nonstd field in the struct sh_mobile_lcdc_info.
+ * Bit 16, which is accessible from user space is defined in
+ * <linux/sh_mobile_fb.h>
+ * The flags have different values for different chips
+ */
+#define LCDC_YUV_FULL_RANGE ((0x1 << 17) >> 16)
+#define LCDC_YUV_BT_709 ((0x1 << 18) >> 16)
+
 /*
  * Pin Function Controller:
  *	GPIO_FN_xx - GPIO used to select pin function
-- 
1.7.1

