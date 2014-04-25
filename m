From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:45 +0000
Subject: [PATCH RFC 07/17] OMAPDSS: hdmi5: Integrated ASoC DAI component driver implementation
Message-Id: <ff0d11d9d57b653d261ac4565ebc460fc141bb3d.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Integrate ASoC DAI component driver in to OMAP5 hdmi driver. The
implementation removes the callbacks for an external audio driver and
the old external DAI driver does not work anymore after this patch.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c |  216 +++++++++++++++++++++++----------
 1 file changed, 151 insertions(+), 65 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index c468b9e..c6a8862 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -39,6 +39,16 @@
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+#include <linux/dmaengine.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <uapi/sound/asound.h>
+#include <sound/asoundef.h>
+#include <sound/omap-pcm.h>
+#endif
+
 #include "hdmi5_core.h"
 #include "dss.h"
 #include "dss_features.h"
@@ -57,6 +67,13 @@ static struct {
 	struct clk *sys_clk;
 	struct regulator *vdda_reg;
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	struct snd_dmaengine_dai_dma_data dma_data;
+	struct omap_dss_audio dss_audio;
+	struct snd_aes_iec958 iec;
+	struct snd_cea_861_aud_if cea;
+#endif
+
 	bool core_enabled;
 
 	struct omap_dss_device output;
@@ -535,7 +552,36 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev,
 }
 
 #if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
-static int hdmi_audio_enable(struct omap_dss_device *dssdev)
+static int hdmi_dai_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	int ret;
+	/*
+	 * Make sure that the period bytes are multiple of the DMA packet size.
+	 * Largest packet size we use is 32 32-bit words = 128 bytes
+	 */
+	ret = snd_pcm_hw_constraint_step(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
+	if (ret < 0) {
+		dev_err(dai->dev, "could not apply constraint\n");
+		return ret;
+	}
+
+	mutex_lock(&hdmi.lock);
+	ret = hdmi_mode_has_audio(hdmi.cfg.cm.mode);
+	mutex_unlock(&hdmi.lock);
+	if (!ret) {
+		dev_err(dai->dev, "audio not supported\n");
+		return -ENODEV;
+	}
+
+	snd_soc_dai_set_dma_data(dai, substream, &hdmi.dma_data);
+
+	return 0;
+}
+
+static int hdmi_dai_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
 {
 	int r;
 
@@ -547,96 +593,137 @@ static int hdmi_audio_enable(struct omap_dss_device *dssdev)
 	}
 
 	r = hdmi_wp_audio_enable(&hdmi.wp, true);
-	if (r)
-		goto err;
-
-	mutex_unlock(&hdmi.lock);
-	return 0;
 
 err:
 	mutex_unlock(&hdmi.lock);
 	return r;
 }
 
-static void hdmi_audio_disable(struct omap_dss_device *dssdev)
-{
-	hdmi_wp_audio_enable(&hdmi.wp, false);
-}
-
-static int hdmi_audio_start(struct omap_dss_device *dssdev)
-{
-	return hdmi_wp_audio_core_req_enable(&hdmi.wp, true);
-}
-
-static void hdmi_audio_stop(struct omap_dss_device *dssdev)
+static int hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *dai)
 {
-	hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
-}
+	int err;
 
-static bool hdmi_audio_supported(struct omap_dss_device *dssdev)
-{
-	bool r;
-
-	mutex_lock(&hdmi.lock);
-
-	r = hdmi_mode_has_audio(hdmi.cfg.cm.mode);
-
-	mutex_unlock(&hdmi.lock);
-	return r;
-}
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		hdmi.dma_data.maxburst = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		hdmi.dma_data.maxburst = 32;
+		break;
+	default:
+		dev_err(dai->dev, "format not supported!\n");
+		return -EINVAL;
+	}
 
-static int hdmi_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	int r;
-	u32 pclk = hdmi.cfg.timings.pixelclock;
+	hdmi.dss_audio.iec = &hdmi.iec;
+	hdmi.dss_audio.cea = &hdmi.cea;
+	err = hdmi_dss_audio_from_hw_params(params, &hdmi.dss_audio, dai);
+	if (err)
+		return err;
 
 	mutex_lock(&hdmi.lock);
 
 	if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
-		r = -EPERM;
+		err = -EPERM;
 		goto err;
 	}
 
-	r = hdmi5_audio_config(&hdmi.core, &hdmi.wp, audio, pclk);
-	if (r)
-		goto err;
-
-	mutex_unlock(&hdmi.lock);
-	return 0;
-
+	err = hdmi5_audio_config(&hdmi.core, &hdmi.wp, &hdmi.dss_audio,
+				 hdmi.cfg.timings.pixelclock);
 err:
 	mutex_unlock(&hdmi.lock);
-	return r;
-}
-#else
-static int hdmi_audio_enable(struct omap_dss_device *dssdev)
-{
-	return -EPERM;
+	return err;
+}
+
+static int hdmi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *dai)
+{
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		err = hdmi_wp_audio_core_req_enable(&hdmi.wp, true);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
+		break;
+	default:
+		err = -EINVAL;
+	}
+	return err;
 }
 
-static void hdmi_audio_disable(struct omap_dss_device *dssdev)
+static void hdmi_dai_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
 {
+	hdmi_wp_audio_enable(&hdmi.wp, false);
 }
 
-static int hdmi_audio_start(struct omap_dss_device *dssdev)
+static const struct snd_soc_dai_ops hdmi_dai_ops = {
+	.startup	= hdmi_dai_startup,
+	.hw_params	= hdmi_dai_hw_params,
+	.prepare	= hdmi_dai_prepare,
+	.trigger	= hdmi_dai_trigger,
+	.shutdown	= hdmi_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver omap_hdmi_dai = {
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			  SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &hdmi_dai_ops,
+};
+
+static const struct snd_soc_component_driver omap_hdmi_component = {
+	.name = "omapdss_hdmi",
+};
+
+static int hdmi_audio_init(struct platform_device *pdev)
 {
-	return -EPERM;
+	struct resource *res;
+	int ret;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wp");
+	if (!res) {
+		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM l4\n");
+		return -ENODEV;
+	}
+	hdmi.dma_data.addr = res->start + HDMI_WP_AUDIO_DATA;
+	hdmi.dma_data.filter_data = "audio_tx";
+	hdmi.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
+					 &omap_hdmi_dai, 1);
+	if (ret)
+		return ret;
+
+	return omap_pcm_platform_register(&pdev->dev);
 }
 
-static void hdmi_audio_stop(struct omap_dss_device *dssdev)
+static void hdmi_audio_remove(struct platform_device *pdev)
 {
+	snd_soc_unregister_component(&pdev->dev);
 }
 
-static bool hdmi_audio_supported(struct omap_dss_device *dssdev)
+#else
+static int hdmi_audio_init(struct platform_device *pdev)
 {
-	return false;
+	return 0;
 }
 
-static int hdmi_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
+static void hdmi_audio_remove(struct platform_device *pdev)
 {
-	return -EPERM;
 }
 #endif
 
@@ -652,13 +739,6 @@ static const struct omapdss_hdmi_ops hdmi_ops = {
 	.get_timings		= hdmi_display_get_timings,
 
 	.read_edid		= hdmi_read_edid,
-
-	.audio_enable		= hdmi_audio_enable,
-	.audio_disable		= hdmi_audio_disable,
-	.audio_start		= hdmi_audio_start,
-	.audio_stop		= hdmi_audio_stop,
-	.audio_supported	= hdmi_audio_supported,
-	.audio_config		= hdmi_audio_config,
 };
 
 static void hdmi_init_output(struct platform_device *pdev)
@@ -757,6 +837,10 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 		return r;
 	}
 
+	r = hdmi_audio_init(pdev);
+	if (r)
+		return r;
+
 	pm_runtime_enable(&pdev->dev);
 
 	hdmi_init_output(pdev);
@@ -770,6 +854,8 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_uninit_output(pdev);
 
+	hdmi_audio_remove(pdev);
+
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
1.7.9.5

