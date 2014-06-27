From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 27 Jun 2014 18:38:45 +0000
Subject: [PATCH v2 03/13] OMAPDSS: hdmi_wp: Add function for getting audio dma address
Message-Id: <e90168befc41157a0b06b719b3b62c42ad16c53d.1403894190.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403894190.git.jsarha@ti.com>
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

The audio dma port is found in the hdmi_wp physical address space.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h    |    2 ++
 drivers/video/fbdev/omap2/dss/hdmi_wp.c |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 1f01068..9e85b86 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -250,6 +250,7 @@ struct hdmi_core_audio_config {
 
 struct hdmi_wp_data {
 	void __iomem *base;
+	phys_addr_t phys_base;
 };
 
 struct hdmi_pll_data {
@@ -317,6 +318,7 @@ void hdmi_wp_video_config_timing(struct hdmi_wp_data *wp,
 void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,
 		struct omap_video_timings *timings, struct hdmi_config *param);
 int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp);
+phys_addr_t hdmi_wp_get_audio_dma_addr(struct hdmi_wp_data *wp);
 
 /* HDMI PLL funcs */
 int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
index 496327e..43bf93e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
@@ -247,6 +247,7 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 		DSSERR("can't get WP mem resource\n");
 		return -EINVAL;
 	}
+	wp->phys_base = res->start;
 
 	wp->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(wp->base)) {
@@ -256,3 +257,8 @@ int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp)
 
 	return 0;
 }
+
+phys_addr_t hdmi_wp_get_audio_dma_addr(struct hdmi_wp_data *wp)
+{
+	return wp->phys_base + HDMI_WP_AUDIO_DATA;
+}
-- 
1.7.9.5

