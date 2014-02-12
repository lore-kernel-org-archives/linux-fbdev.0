From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 12 Feb 2014 08:45:22 +0000
Subject: [PATCH Resend] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <1392194002-6670-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

OF dependency can be removed as the driver does not actually
depend on it at all.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfig
index 1129d0e9e640..976594d578a9 100644
--- a/drivers/video/exynos/Kconfig
+++ b/drivers/video/exynos/Kconfig
@@ -30,7 +30,7 @@ config EXYNOS_LCD_S6E8AX0
 
 config EXYNOS_DP
 	bool "EXYNOS DP driver support"
-	depends on OF && ARCH_EXYNOS
+	depends on ARCH_EXYNOS
 	default n
 	help
 	  This enables support for DP device.
-- 
1.7.9.5

