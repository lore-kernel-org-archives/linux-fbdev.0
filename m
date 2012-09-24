From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:39 +0000
Subject: [PATCH 9/9] OMAPDSS: DSI: make OMAP2_DSS_DSI depend on ARCH_OMAP5
Message-Id: <1348495119-8262-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Change omapdss Kconfig file to make OMAP2_DSS_DSI depend on ARCH_OMAP5.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index b337a84..80f5390 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -84,7 +84,7 @@ config OMAP2_DSS_SDI
 
 config OMAP2_DSS_DSI
 	bool "DSI support"
-	depends on ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5
         default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
-- 
1.7.9.5

