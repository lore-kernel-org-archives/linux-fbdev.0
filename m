From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Jan 2014 10:56:43 +0000
Subject: [PATCHv3 11/41] OMAPDSS: Add DT support to HDMI
Message-Id: <1390301833-24944-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add DT support to HDMI driver. The only thing needed for DT support here
is the of_match_table.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 11e7500197c1..064bec4e08d4 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -682,6 +682,11 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 	.runtime_resume = hdmi_runtime_resume,
 };
 
+static const struct of_device_id hdmi_of_match[] = {
+	{ .compatible = "ti,omap4-hdmi", },
+	{},
+};
+
 static struct platform_driver omapdss_hdmihw_driver = {
 	.probe		= omapdss_hdmihw_probe,
 	.remove         = __exit_p(omapdss_hdmihw_remove),
@@ -689,6 +694,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
+		.of_match_table = hdmi_of_match,
 	},
 };
 
-- 
1.8.3.2

