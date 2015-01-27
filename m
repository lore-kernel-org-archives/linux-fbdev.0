From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Jan 2015 10:50:41 +0000
Subject: [PATCH 13/14] OMAPDSS: HDMI: Add DRA7xx support
Message-Id: <1422355842-11234-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support for DRA7xx to the HDMI driver.

The HDMI block on DRA7xx is the same as on OMAP5, except we need to
enable and disable the HDMI PLL via the CONTROL module.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c    | 1 +
 drivers/video/fbdev/omap2/dss/hdmi_phy.c | 1 +
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 39aae3aa7136..3f0b34a7031a 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -787,6 +787,7 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 
 static const struct of_device_id hdmi_of_match[] = {
 	{ .compatible = "ti,omap5-hdmi", },
+	{ .compatible = "ti,dra7-hdmi", },
 	{},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/dss/hdmi_phy.c
index bc9e07d2afbe..1f5d19c119ce 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_phy.c
@@ -208,6 +208,7 @@ static int hdmi_phy_init_features(struct platform_device *pdev)
 		break;
 
 	case OMAPDSS_VER_OMAP5:
+	case OMAPDSS_VER_DRA7xx:
 		src = &omap54xx_phy_feats;
 		break;
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index b808f7c72d83..06e23a7c432c 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -104,6 +104,8 @@ static int hdmi_pll_enable(struct dss_pll *dsspll)
 	struct hdmi_wp_data *wp = pll->wp;
 	u16 r = 0;
 
+	dss_ctrl_pll_enable(DSS_PLL_HDMI, true);
+
 	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
 	if (r)
 		return r;
@@ -117,6 +119,8 @@ static void hdmi_pll_disable(struct dss_pll *dsspll)
 	struct hdmi_wp_data *wp = pll->wp;
 
 	hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_ALLOFF);
+
+	dss_ctrl_pll_enable(DSS_PLL_HDMI, false);
 }
 
 static const struct dss_pll_ops dsi_pll_ops = {
@@ -197,6 +201,7 @@ static int dsi_init_pll_data(struct platform_device *pdev, struct hdmi_pll_data
 		break;
 
 	case OMAPDSS_VER_OMAP5:
+	case OMAPDSS_VER_DRA7xx:
 		pll->hw = &dss_omap5_hdmi_pll_hw;
 		break;
 
-- 
2.2.2

