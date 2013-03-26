From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Mar 2013 13:33:44 +0000
Subject: [PATCH 14/26] OMAPDSS: HDMI: new panel registration
Message-Id: <1364304836-18134-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds new way to register HDMI panels. This new method will be
used by the panel drivers that are converted away from the current dss
bus based model.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h  |    2 ++
 drivers/video/omap2/dss/hdmi.c |   41 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d603a40..eb1e325 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -450,6 +450,8 @@ static inline unsigned long hdmi_get_pixel_clock(void)
 	return 0;
 }
 #endif
+int omap_hdmi_register_panel(struct omap_dss_device *dssdev);
+void omap_hdmi_free_panel(struct omap_dss_device *dssdev);
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
 int omapdss_hdmi_core_enable(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 4b32dd3..f9e38c4 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -328,7 +328,7 @@ static void hdmi_runtime_put(void)
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
-static int __init hdmi_init_display(struct omap_dss_device *dssdev)
+static int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	int r;
 
@@ -960,6 +960,45 @@ int hdmi_audio_config(struct omap_dss_audio *audio)
 
 #endif
 
+int omap_hdmi_register_panel(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_hdmi_data *priv = dssdev->data;
+	int r;
+
+	dssdev->type = OMAP_DISPLAY_TYPE_HDMI;
+
+	hdmi.ct_cp_hpd_gpio = priv->ct_cp_hpd_gpio;
+	hdmi.ls_oe_gpio = priv->ls_oe_gpio;
+	hdmi.hpd_gpio = priv->hpd_gpio;
+
+	r = hdmi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return r;
+	}
+
+	r = omapdss_output_set_device(&hdmi.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		hdmi_uninit_display(dssdev);
+		return r;
+	}
+
+	dss_add_panel(dssdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_hdmi_register_panel);
+
+void omap_hdmi_free_panel(struct omap_dss_device *dssdev)
+{
+	hdmi_uninit_display(dssdev);
+	omapdss_output_unset_device(&hdmi.output);
+	dss_remove_panel(dssdev);
+}
+EXPORT_SYMBOL(omap_hdmi_free_panel);
+
 static struct omap_dss_device * __init hdmi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-- 
1.7.10.4

