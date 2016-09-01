From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Thu, 01 Sep 2016 11:49:49 +0000
Subject: [PATCH v2 2/2] ARM: exynos_defconfig: Remove old non-working MIPI driver
Message-Id: <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472730589-18683-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1472730589-18683-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Exynos MIPI driver does not work anymore (it is board file only) so
it is removed.  Remove also config option.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. New patch.
---
 arch/arm/configs/exynos_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 4e484f406419..fea8edef1534 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -168,7 +168,6 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
 CONFIG_DRM_NXP_PTN3460=y
 CONFIG_DRM_PARADE_PS8622=y
-CONFIG_EXYNOS_VIDEO=y
 CONFIG_EXYNOS_MIPI_DSI=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
-- 
1.9.1

