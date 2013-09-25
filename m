From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Sep 2013 11:31:01 +0000
Subject: [PATCH] OMAPDSS: Add missing dependency on backlight for DSI-CM panel drier
Message-Id: <1380108661-22702-1-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

The DSI-CM driver uses the backlight class so needs to build depend on it.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/video/omap2/displays-new/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/omap2/displays-new/Kconfig
index 6c90885..10b25e7 100644
--- a/drivers/video/omap2/displays-new/Kconfig
+++ b/drivers/video/omap2/displays-new/Kconfig
@@ -35,6 +35,7 @@ config DISPLAY_PANEL_DPI
 
 config DISPLAY_PANEL_DSI_CM
 	tristate "Generic DSI Command Mode Panel"
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Driver for generic DSI command mode panels.
 
-- 
1.8.4.rc3

