From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:26:10 +0000
Subject: [PATCH 2/3] Revert "OMAP: DSS2: HDMI: fix hdmi clock name"
Message-Id: <1314001571-17877-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This reverts commit df5d3ed23cf73ee0763a8963003bda9b69d9620f.

The HDMI clock name has been fixed in HWMOD data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3767323..9353dcf 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1704,9 +1704,9 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 
 	hdmi.sys_clk = clk;
 
-	clk = clk_get(&pdev->dev, "dss_48mhz_clk");
+	clk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
-		DSSERR("can't get hdmi_clk\n");
+		DSSERR("can't get fck\n");
 		clk_put(hdmi.sys_clk);
 		return PTR_ERR(clk);
 	}
-- 
1.7.4.1

