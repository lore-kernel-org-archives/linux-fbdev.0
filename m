From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 26 Jun 2014 19:20:56 +0000
Subject: [PATCH 05/12] OMAPDSS: Kconfig: Select audio dependencies if OMAP4_DSS_HDMI_AUDIO=y
Message-Id: <d7c86041e9631a15f5b0aef5f0d460c30dbb9eb4.1403807781.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403807781.git.jsarha@ti.com>
In-Reply-To: <cover.1403807781.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Adds help section and SND_SOC dependency to OMAP4_DSS_HDMI_AUDIO.
Selects SND_OMAP_SOC, SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD if
OMAP4_DSS_HDMI_AUDIO is enabled.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 3d5eb6c..871f722 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -6,6 +6,9 @@ menuconfig OMAP2_DSS
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
 	select HDMI
+	select SND_OMAP_SOC if OMAP4_DSS_HDMI_AUDIO
+	select SND_SOC_HDMI_CODEC if OMAP4_DSS_HDMI_AUDIO
+	select SND_SIMPLE_CARD if OMAP4_DSS_HDMI_AUDIO
         help
 	  OMAP2+ Display Subsystem support.
 
@@ -75,7 +78,16 @@ config OMAP4_DSS_HDMI
 	  HDMI support for OMAP4 based SoCs.
 
 config OMAP4_DSS_HDMI_AUDIO
-	bool
+	bool "HDMI audio support for OMAP4"
+	depends on OMAP4_DSS_HDMI
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	default y
+	help
+	  HDMI audio support for OMAP4 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. If enabled OMAP2_DSS selects SND_OMAP_SOC,
+	  SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD for full HDMI
+	  audio support.
 
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
-- 
1.7.9.5

