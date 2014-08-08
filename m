From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 08 Aug 2014 13:23:44 +0000
Subject: [PATCH v3 03/14] OMAPDSS: hdmi_common: hdmi_compute_acr is needed for OMAP5 HDMI audio too
Message-Id: <22827f3eccc3180024785869b4cc7c860cc9a043.1407503813.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1407503813.git.jsarha@ti.com>
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/video/fbdev/omap2/dss/hdmi_common.c
index 7d5f103..2e48d90 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_common.c
@@ -48,7 +48,7 @@ int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
 	return 0;
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
-- 
1.7.9.5

