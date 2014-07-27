From: Mark Brown <broonie@kernel.org>
Date: Sun, 27 Jul 2014 17:04:18 +0000
Subject: [PATCH] video: clcd-versatile: Depend on ARM
Message-Id: <1406480658-27243-1-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The Versatile CLCD helpers call dma_alloc_writecombine() which is only
available on ARM and AVR32, meaning they won't build on other platforms
including arm64. Unfortunately the current Kconfig enables the symbol
by default if ARCH_VEXPRESS is defined which means that it is enabled on
arm64 when building for the ARM reference platforms and models for ARMv8
since they have many hardware similarities with their pre-ARMv8 systems.

Since all the systems that need the helpers are ARM systems fix this by
adding a dependency on ARM.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/video/fbdev/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e83ed760141b..ce7c76676a70 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -293,6 +293,7 @@ config FB_ARMCLCD
 # Helper logic selected only by the ARM Versatile platform family.
 config PLAT_VERSATILE_CLCD
 	def_bool ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
+	depends on ARM
 	depends on FB_ARMCLCD && FB=y
 
 config FB_ACORN
-- 
2.0.1

