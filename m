From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Jul 2015 13:31:12 +0000
Subject: [PATCH] fbdev: select versatile helpers for the integrator
Message-Id: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
"video: move Versatile CLCD helpers" missed the fact
that the Integrator/CP is also using the helper, and
as a result the platform got only stubs and no graphics.
Add this as a default selection to Kconfig so we have
graphics again.

Fixes: 11c32d7b6274 (video: move Versatile CLCD helpers)
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2d98de535e0f..f888561568d9 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -298,7 +298,7 @@ config FB_ARMCLCD
 
 # Helper logic selected only by the ARM Versatile platform family.
 config PLAT_VERSATILE_CLCD
-	def_bool ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
+	def_bool ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_INTEGRATOR
 	depends on ARM
 	depends on FB_ARMCLCD && FB=y
 
-- 
2.4.3

