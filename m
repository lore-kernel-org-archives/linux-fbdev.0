From: Shawn Guo <shawn.guo@linaro.org>
Date: Tue, 26 Jun 2012 09:02:58 +0000
Subject: [PATCH 1/2] video: mxsfb: move mxsfb.h into include/linux
Message-Id: <1340701379-8619-2-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move mxsfb.h into include/linux, so that mxsfb driver does not have to
include <mach/*> header.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/devices-mx23.h                   |    2 +-
 arch/arm/mach-mxs/devices-mx28.h                   |    2 +-
 arch/arm/mach-mxs/devices/platform-mxsfb.c         |    2 +-
 drivers/video/mxsfb.c                              |    2 +-
 .../include/mach => include/linux}/mxsfb.h         |    6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename {arch/arm/mach-mxs/include/mach => include/linux}/mxsfb.h (95%)

diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index 9acdd63..9ee5ced 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -10,7 +10,7 @@
  */
 #include <mach/mx23.h>
 #include <mach/devices-common.h>
-#include <mach/mxsfb.h>
+#include <linux/mxsfb.h>
 #include <linux/amba/bus.h>
 
 static inline int mx23_add_duart(void)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 84b2960..fcab431 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -10,7 +10,7 @@
  */
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
-#include <mach/mxsfb.h>
+#include <linux/mxsfb.h>
 #include <linux/amba/bus.h>
 
 static inline int mx28_add_duart(void)
diff --git a/arch/arm/mach-mxs/devices/platform-mxsfb.c b/arch/arm/mach-mxs/devices/platform-mxsfb.c
index 5a75b71..76b53f73 100644
--- a/arch/arm/mach-mxs/devices/platform-mxsfb.c
+++ b/arch/arm/mach-mxs/devices/platform-mxsfb.c
@@ -10,7 +10,7 @@
 #include <mach/mx23.h>
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
-#include <mach/mxsfb.h>
+#include <linux/mxsfb.h>
 
 #ifdef CONFIG_SOC_IMX23
 struct platform_device *__init mx23_add_mxsfb(
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index abbe691..08dad8d 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -46,7 +46,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
-#include <mach/mxsfb.h>
+#include <linux/mxsfb.h>
 
 #define REG_SET	4
 #define REG_CLR	8
diff --git a/arch/arm/mach-mxs/include/mach/mxsfb.h b/include/linux/mxsfb.h
similarity index 95%
rename from arch/arm/mach-mxs/include/mach/mxsfb.h
rename to include/linux/mxsfb.h
index e4d7979..f14943d 100644
--- a/arch/arm/mach-mxs/include/mach/mxsfb.h
+++ b/include/linux/mxsfb.h
@@ -14,8 +14,8 @@
  * MA 02110-1301, USA.
  */
 
-#ifndef __MACH_FB_H
-#define __MACH_FB_H
+#ifndef __LINUX_MXSFB_H
+#define __LINUX_MXSFB_H
 
 #include <linux/fb.h>
 
@@ -46,4 +46,4 @@ struct mxsfb_platform_data {
 				 */
 };
 
-#endif /* __MACH_FB_H */
+#endif /* __LINUX_MXSFB_H */
-- 
1.7.5.4


