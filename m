From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:51:47 +0000
Subject: [PATCH 12/20] OMAPDSS: DPI: use output->recommended_channel
Message-Id: <1362743515-10152-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use output's recommended_channel instead of dssdev->channel in DPI
driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index fb38019..eba6b87 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -448,7 +448,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 		dpi.vdds_dsi_reg = vdds_dsi;
 	}
 
-	dsidev = dpi_get_dsidev(dssdev->channel);
+	dsidev = dpi_get_dsidev(dpi.output.recommended_channel);
 
 	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
 		dsidev = NULL;
-- 
1.7.10.4

