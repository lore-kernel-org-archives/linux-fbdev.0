From: Archit Taneja <archit@ti.com>
Date: Wed, 01 Aug 2012 10:43:14 +0000
Subject: [RFC 03/17] OMAPDSS: HDMI: Remove omap_dss_device argument from hdmi_compute_pll
Message-Id: <1343817088-29645-4-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The clock related info for DSS modules is not tied anymore to a panel's
omap_dss_device struct. It's now passed via platform data. The function
hdmi_compute_pll() do not need the omap_dss_device argument to retieve these
clocks. They use the api dss_get_platform_clock_config() get the clocks. Remove
the omap_dss_device argument from hdmi_compute_pll()

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 16b2386..6635b09 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -405,8 +405,7 @@ unsigned long hdmi_get_pixel_clock(void)
 	return hdmi.ip_data.cfg.timings.pixel_clock * 1000;
 }
 
-static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
-		struct hdmi_pll_info *pi)
+static void hdmi_compute_pll(int phy, struct hdmi_pll_info *pi)
 {
 	const struct omapdss_clock_config *clks;
 	unsigned long clkin, refclk;
@@ -491,7 +490,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	}
 	phy = p->pixel_clock;
 
-	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
+	hdmi_compute_pll(phy, &hdmi.ip_data.pll_data);
 
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 
-- 
1.7.9.5

