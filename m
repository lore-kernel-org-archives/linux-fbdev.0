From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:51:43 +0000
Subject: [PATCH 08/20] OMAPDSS: HDMI: init output earlier
Message-Id: <1362743515-10152-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Move hdmi driver's output initialization a bit earlier, so that it
happens before hdmi panel init. In the future the hdmi panel will depend
on the output being ready.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index e5682ae..f3768d0 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1094,6 +1094,8 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
 	hdmi.ip_data.phy_offset = HDMI_PHY;
 
+	hdmi_init_output(pdev);
+
 	r = hdmi_panel_init();
 	if (r) {
 		DSSERR("can't init panel\n");
@@ -1102,8 +1104,6 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
-	hdmi_init_output(pdev);
-
 	hdmi_probe_pdata(pdev);
 
 	return 0;
-- 
1.7.10.4

