From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:27:16 +0000
Subject: [PATCH 4/4] OMAP: DSS2: Remove "EXPERIMENTAL" from Kconfig
Message-Id: <1314001636-18036-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS driver has not been "experimental" for many years now, so perhaps
it's time to remove the text from Kconfig titles.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig    |    2 +-
 drivers/video/omap2/omapfb/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 0d12524..7be7c06 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -1,5 +1,5 @@
 menuconfig OMAP2_DSS
-        tristate "OMAP2+ Display Subsystem support (EXPERIMENTAL)"
+        tristate "OMAP2+ Display Subsystem support"
         depends on ARCH_OMAP2PLUS
         help
 	  OMAP2+ Display Subsystem support.
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index aa33386..83d3fe7 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -1,5 +1,5 @@
 menuconfig FB_OMAP2
-        tristate "OMAP2+ frame buffer support (EXPERIMENTAL)"
+        tristate "OMAP2+ frame buffer support"
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
-- 
1.7.4.1

