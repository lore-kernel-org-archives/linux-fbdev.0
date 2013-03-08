From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:52:37 +0000
Subject: [PATCH 02/14] OMAPDSS: DSI: fix wrong unsigned long long use
Message-Id: <1362743569-10289-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dsi_configure_dispc_clocks() stores dsi func clock into unsigned long
long, but it should really be just unsigned long. Fix this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 2d95ed9..5f5b475 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4611,7 +4611,7 @@ static int dsi_configure_dispc_clocks(struct platform_device *dsidev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dispc_clock_info dispc_cinfo;
 	int r;
-	unsigned long long fck;
+	unsigned long fck;
 
 	fck = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 
-- 
1.7.10.4

