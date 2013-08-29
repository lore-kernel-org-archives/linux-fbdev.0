From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Aug 2013 13:31:46 +0000
Subject: [PATCH 01/15] OMAPDSS: RFBI: Mark RFBI as broken
Message-Id: <1377783120-14001-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAPDSS's RFBI encoder driver has not been working for some time. The
Nokia N800 is the only board in the mainline that uses RFBI, but it has
never been fully functional.

The RFBI driver needs to be updated to the new panel model, but as
the driver is rather unmaintained and there's no way to test the
changes, let's mark the driver as broken.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 8f70a83..dde4281 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -42,6 +42,7 @@ config OMAP2_DSS_DPI
 
 config OMAP2_DSS_RFBI
 	bool "RFBI support"
+	depends on BROKEN
         default n
 	help
 	  MIPI DBI support (RFBI, Remote Framebuffer Interface, in Texas
-- 
1.8.1.2

