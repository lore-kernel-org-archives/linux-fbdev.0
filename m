From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 16 Dec 2014 23:54:42 +0000
Subject: [patch] OMAPDSS: pll: NULL dereference in error handling
Message-Id: <20141216235442.GE31467@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

The regulator_disable() doesn't accept NULL pointers.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/omap2/dss/pll.c b/drivers/video/fbdev/omap2/dss/pll.c
index 50bc62c5..335ffac 100644
--- a/drivers/video/fbdev/omap2/dss/pll.c
+++ b/drivers/video/fbdev/omap2/dss/pll.c
@@ -97,7 +97,8 @@ int dss_pll_enable(struct dss_pll *pll)
 	return 0;
 
 err_enable:
-	regulator_disable(pll->regulator);
+	if (pll->regulator)
+		regulator_disable(pll->regulator);
 err_reg:
 	clk_disable_unprepare(pll->clkin);
 	return r;
