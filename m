From: Grazvydas Ignotas <notasas@gmail.com>
Date: Thu, 15 Apr 2010 14:59:03 +0000
Subject: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: fix Kconfig dependency
Message-Id: <1271343543-14348-1-git-send-email-notasas@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>

This panel depends on SPI, not I2C.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/displays/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index dfb57ee..a2faf8a 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -33,7 +33,7 @@ config PANEL_TOPPOLY_TDO35S
 
 config PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
-        depends on OMAP2_DSS && I2C
+        depends on OMAP2_DSS && SPI
         help
           LCD Panel used in OMAP3 Pandora
 
-- 
1.6.3.3

