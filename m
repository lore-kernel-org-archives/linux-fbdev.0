From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 27 Jun 2014 18:38:51 +0000
Subject: [PATCH v2 09/13] OMAPDSS: hdmi5: Register HDMI audio ASoC drivers from HDMI driver
Message-Id: <f895feed34be1c9e6e77608e61ff8d08aea1f5df.1403894190.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403894190.git.jsarha@ti.com>
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Call register and unregister functions form hdmi_audio.c. Register
function registers the integrated cpu dai, dummy HDMI codec, and
simple-card machine driver for complete HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c |   46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 83925a9..a2b2589 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -39,6 +39,9 @@
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
 #include "hdmi5_core.h"
 #include "dss.h"
 #include "dss_features.h"
@@ -680,6 +683,33 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+static int audio_start(struct hdmi_core_data *core, struct hdmi_wp_data *wp)
+{
+	hdmi_wp_audio_core_req_enable(wp, true);
+
+	return 0;
+}
+
+static void audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp)
+{
+	hdmi_wp_audio_core_req_enable(wp, false);
+}
+
+static struct snd_soc_dai_driver omap_hdmi_dai = {
+	.name = "omap5-hdmi-dai",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			  SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+#endif
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -738,6 +768,19 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	hdmi.audio.hdmi_dai_drv = &omap_hdmi_dai;
+	hdmi.audio.audio_start = audio_start;
+	hdmi.audio.audio_stop = audio_stop;
+	hdmi.audio.audio_config = hdmi5_audio_config;
+	r = hdmi_audio_register(pdev);
+	if (r) {
+		DSSERR("Registering HDMI audio failed\n");
+		hdmi_uninit_output(pdev);
+		pm_runtime_disable(&pdev->dev);
+		return r;
+	}
+#endif
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	return 0;
@@ -745,6 +788,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(pdev);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

