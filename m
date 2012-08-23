From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 23 Aug 2012 13:45:08 +0000
Subject: [PATCH 2/8] OMAPDSS: HDMI: Add delay to wait for 5V power
Message-Id: <1345729514-2441-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

TPD12S015A spec says to wait 300us after setting CT_CP_HPD gpio for the
5V power output to reach 90% of the voltage. This patch adds the delay
to the driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 4fbe271..96a6e29 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -492,6 +492,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
 	gpio_set_value(hdmi.ls_oe_gpio, 1);
 
+	/* wait 300us after CT_CP_HPD for the 5V power output to reach 90% */
+	udelay(300);
+
 	r = hdmi_runtime_get();
 	if (r)
 		goto err_runtime_get;
-- 
1.7.9.5

