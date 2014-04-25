From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:42 +0000
Subject: [PATCH RFC 04/17] OMAPDSS: Kconfig: Add depencies and help section to OMAP4_DSS_HDMI_AUDIO
Message-Id: <15845a2dbec26e4154071dd511a8af9cd70c36b8.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 8921a7a..ecc2f50 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -70,7 +70,15 @@ config OMAP4_DSS_HDMI
 	  HDMI support for OMAP4 based SoCs.
 
 config OMAP4_DSS_HDMI_AUDIO
-	bool
+	bool "HDMI audio support for OMAP4"
+	depends on OMAP4_DSS_HDMI
+	depends on SND_OMAP_SOC=y || OMAP2_DSS = SND_OMAP_SOC
+	default y
+	help
+	  HDMI audio support for OMAP4 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. Select SND_SOC_HDMI_CODEC and SND_SIMPLE_CARD with
+	  devicetree description for full HDMI audio support.
 
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
-- 
1.7.9.5

