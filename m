From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jun 2014 10:03:50 +0000
Subject: [PATCH 05/15] OMAPDSS: Kconfig: select HDMI
Message-Id: <1403604240-16738-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Select HDMI support to be able to use HDMI infoframe helpers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 285bcd103dce..3d5eb6c36c22 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -5,6 +5,7 @@ menuconfig OMAP2_DSS
         tristate "OMAP2+ Display Subsystem support"
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
+	select HDMI
         help
 	  OMAP2+ Display Subsystem support.
 
-- 
1.9.1

