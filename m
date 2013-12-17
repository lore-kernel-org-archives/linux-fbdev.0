From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Dec 2013 23:37:01 +0000
Subject: [PATCH] video: vgacon: Don't build on arm64
Message-Id: <1387323421-26126-1-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

arm64 is unlikely to have a VGA console and does not export screen_info
causing build failures if the driver is build, for example in all*config.
Add a dependency on !ARM64 to prevent this.

This list is getting quite long, it may be easier to depend on a symbol
which architectures that do support the driver can select.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/video/console/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 846caab75a46..c39d6c42c3ef 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -8,7 +8,8 @@ config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
-		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER)
+		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) \
+		&& !ARM64
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
1.8.5.1

