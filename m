From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:48 +0000
Subject: [PATCH RFC 10/17] OMAPDSS: Remove obsolete audio code
Message-Id: <73ac2eaf2f68480cfb721366c82469c9ff46b09c.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Removes all code related to external audio driver callbacks. There is
no need for those now that sound/soc/omap/omap-hdmi.c is removed.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 --------------------
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 -----------
 include/video/omapdss.h                            |   31 ------
 3 files changed, 186 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
index 4420ccb..aa8231a 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
@@ -170,98 +170,6 @@ static bool hdmic_detect(struct omap_dss_device *dssdev)
 		return in->ops.hdmi->detect(in);
 }
 
-static int hdmic_audio_enable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-	int r;
-
-	/* enable audio only if the display is active */
-	if (!omapdss_device_is_enabled(dssdev))
-		return -EPERM;
-
-	r = in->ops.hdmi->audio_enable(in);
-	if (r)
-		return r;
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
-
-	return 0;
-}
-
-static void hdmic_audio_disable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_disable(in);
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_DISABLED;
-}
-
-static int hdmic_audio_start(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-	int r;
-
-	/*
-	 * No need to check the panel state. It was checked when trasitioning
-	 * to AUDIO_ENABLED.
-	 */
-	if (dssdev->audio_state != OMAP_DSS_AUDIO_ENABLED)
-		return -EPERM;
-
-	r = in->ops.hdmi->audio_start(in);
-	if (r)
-		return r;
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_PLAYING;
-
-	return 0;
-}
-
-static void hdmic_audio_stop(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_stop(in);
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
-}
-
-static bool hdmic_audio_supported(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	if (!omapdss_device_is_enabled(dssdev))
-		return false;
-
-	return in->ops.hdmi->audio_supported(in);
-}
-
-static int hdmic_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-	int r;
-
-	/* config audio only if the display is active */
-	if (!omapdss_device_is_enabled(dssdev))
-		return -EPERM;
-
-	r = in->ops.hdmi->audio_config(in, audio);
-	if (r)
-		return r;
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_CONFIGURED;
-
-	return 0;
-}
-
 static struct omap_dss_driver hdmic_driver = {
 	.connect		= hdmic_connect,
 	.disconnect		= hdmic_disconnect,
@@ -277,13 +185,6 @@ static struct omap_dss_driver hdmic_driver = {
 
 	.read_edid		= hdmic_read_edid,
 	.detect			= hdmic_detect,
-
-	.audio_enable		= hdmic_audio_enable,
-	.audio_disable		= hdmic_audio_disable,
-	.audio_start		= hdmic_audio_start,
-	.audio_stop		= hdmic_audio_stop,
-	.audio_supported	= hdmic_audio_supported,
-	.audio_config		= hdmic_audio_config,
 };
 
 static int hdmic_probe_pdata(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index 7e33686..d47e30f 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -193,55 +193,6 @@ static bool tpd_detect(struct omap_dss_device *dssdev)
 	return gpio_get_value_cansleep(ddata->hpd_gpio);
 }
 
-static int tpd_audio_enable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_enable(in);
-}
-
-static void tpd_audio_disable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_disable(in);
-}
-
-static int tpd_audio_start(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_start(in);
-}
-
-static void tpd_audio_stop(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_stop(in);
-}
-
-static bool tpd_audio_supported(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_supported(in);
-}
-
-static int tpd_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_config(in, audio);
-}
-
 static const struct omapdss_hdmi_ops tpd_hdmi_ops = {
 	.connect		= tpd_connect,
 	.disconnect		= tpd_disconnect,
@@ -255,13 +206,6 @@ static const struct omapdss_hdmi_ops tpd_hdmi_ops = {
 
 	.read_edid		= tpd_read_edid,
 	.detect			= tpd_detect,
-
-	.audio_enable		= tpd_audio_enable,
-	.audio_disable		= tpd_audio_disable,
-	.audio_start		= tpd_audio_start,
-	.audio_stop		= tpd_audio_stop,
-	.audio_supported	= tpd_audio_supported,
-	.audio_config		= tpd_audio_config,
 };
 
 static int tpd_probe_pdata(struct platform_device *pdev)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6adb445..9eefbc7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -629,19 +629,6 @@ struct omapdss_hdmi_ops {
 
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
-
-	/*
-	 * Note: These functions might sleep. Do not call while
-	 * holding a spinlock/readlock.
-	 */
-	int (*audio_enable)(struct omap_dss_device *dssdev);
-	void (*audio_disable)(struct omap_dss_device *dssdev);
-	bool (*audio_supported)(struct omap_dss_device *dssdev);
-	int (*audio_config)(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio);
-	/* Note: These functions may not sleep */
-	int (*audio_start)(struct omap_dss_device *dssdev);
-	void (*audio_stop)(struct omap_dss_device *dssdev);
 };
 
 struct omapdss_dsi_ops {
@@ -848,24 +835,6 @@ struct omap_dss_driver {
 
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
-
-	/*
-	 * For display drivers that support audio. This encompasses
-	 * HDMI and DisplayPort at the moment.
-	 */
-	/*
-	 * Note: These functions might sleep. Do not call while
-	 * holding a spinlock/readlock.
-	 */
-	int (*audio_enable)(struct omap_dss_device *dssdev);
-	void (*audio_disable)(struct omap_dss_device *dssdev);
-	bool (*audio_supported)(struct omap_dss_device *dssdev);
-	int (*audio_config)(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio);
-	/* Note: These functions may not sleep */
-	int (*audio_start)(struct omap_dss_device *dssdev);
-	void (*audio_stop)(struct omap_dss_device *dssdev);
-
 };
 
 enum omapdss_version omapdss_get_version(void);
-- 
1.7.9.5

