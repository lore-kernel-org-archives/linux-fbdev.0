From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 12 Nov 2014 14:41:01 +0000
Subject: [PATCH v7.1 10/19] OMAPDSS: Kconfig: Remove HDMI audio booleans from Kconfig
Message-Id: <252f750efa0fadaa58508e9fc87d3a128b915dfc.1415803065.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

The booleans are not used anymore. Just select SND_OMAP_SOC_HDMI_AUDIO
to enable OMAP HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 3d5eb6c..d1fa730 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -74,9 +74,6 @@ config OMAP4_DSS_HDMI
 	help
 	  HDMI support for OMAP4 based SoCs.
 
-config OMAP4_DSS_HDMI_AUDIO
-	bool
-
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
 	default n
@@ -86,10 +83,6 @@ config OMAP5_DSS_HDMI
 	  Definition Multimedia Interface. See http://www.hdmi.org/ for HDMI
 	  specification.
 
-config OMAP5_DSS_HDMI_AUDIO
-	depends on OMAP5_DSS_HDMI
-	bool
-
 config OMAP2_DSS_SDI
 	bool "SDI support"
         default n
-- 
1.7.9.5

