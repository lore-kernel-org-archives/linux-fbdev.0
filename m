From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 18 May 2010 12:35:05 +0000
Subject: [PATCH 14/23] OMAP: DSS2: TPO-TD03MTEA1: fix Kconfig dependency
Message-Id: <1274186114-26951-15-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Grazvydas Ignotas <notasas@gmail.com>

This panel depends on SPI, not I2C.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index ea8ccd3..4221957 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -34,7 +34,7 @@ config PANEL_TOPPOLY_TDO35S
 
 config PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
-        depends on OMAP2_DSS && I2C
+        depends on OMAP2_DSS && SPI
         help
           LCD Panel used in OMAP3 Pandora
 
-- 
1.7.0.4

