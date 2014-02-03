From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 03 Feb 2014 08:45:01 +0000
Subject: [PATCH Resend 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <1391416382-25285-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Exynos is now a DT only platform. Hence there is no need
for an explicit OF dependency. Remove it.

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

