From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 08 Aug 2014 13:23:50 +0000
Subject: [PATCH v3 09/14] OMAPDSS: Kconfig: Update OMAP5_DSS_HDMI_AUDIO option
Message-Id: <7c6c5be0fd1df38f8b28e82f24f9cc012fa32b40.1407503813.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1407503813.git.jsarha@ti.com>
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com

Add help section to OMAP5_DSS_HDMI_AUDIO with dependency to
OMAP5_DSS_HDMI and select for OMAP_DSS_HDMI_AUDIO.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 701164a..abd2e92 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -103,8 +103,17 @@ config OMAP5_DSS_HDMI
 	  specification.
 
 config OMAP5_DSS_HDMI_AUDIO
+	bool "HDMI audio support for OMAP5"
 	depends on OMAP5_DSS_HDMI
-	bool
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	select OMAP_DSS_HDMI_AUDIO
+	default y
+	help
+	  HDMI audio support for OMAP5 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. If enabled OMAP2_DSS selects SND_OMAP_SOC,
+	  SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD for full HDMI
+	  audio support.
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-- 
1.7.9.5

