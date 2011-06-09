From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jun 2011 13:56:29 +0000
Subject: [PATCHv2 07/28] OMAP: DSS2: Remove clk optimization at dss init
Message-Id: <1307627810-3768-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS enables core clocks for the duration of initialization to avoid
unnecessary context saves and restores.

With PM runtime the clocks cannot be handled in this way, outside the
dss module drivers. Thus we need to remove the optimization.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 02187df..f0bae6d 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -183,8 +183,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_dss;
 	}
 
-	/* keep clocks enabled to prevent context saves/restores during init */
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	r = dispc_init_platform_driver();
 	if (r) {
 		DSSERR("Failed to initialize dispc platform driver\n");
@@ -237,8 +235,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 			pdata->default_device = dssdev;
 	}
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
-
 	return 0;
 
 err_register:
-- 
1.7.4.1

