From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 23 May 2014 19:07:59 +0000
Subject: [PATCH 10/13] OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
Message-Id: <28bddf9165a24122af11fd2c5270deb4e7917877.1400871999.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1400871999.git.jsarha@ti.com>
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The registering is best done here to share the resources owned by OMAPDSS
HDMI driver with ASoC DAI and platform drivers.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 626aad2..62ad1d9 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -52,6 +52,9 @@ static struct {
 	struct clk *sys_clk;
 	struct regulator *vdda_hdmi_dac_reg;
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	struct hdmi_audio_data audio;
+#endif
 	bool core_enabled;
 
 	struct omap_dss_device output;
@@ -736,6 +739,15 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	r = hdmi_audio_register(pdev, &hdmi.audio, &hdmi.output, &hdmi.wp);
+	if (r) {
+		DSSERR("Registering HDMI audio failed\n");
+		hdmi_uninit_output(pdev);
+		pm_runtime_disable(&pdev->dev);
+		return r;
+	}
+#endif
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	return 0;
@@ -743,6 +755,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(&hdmi.audio);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

