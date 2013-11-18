From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Nov 2013 12:39:04 +0000
Subject: [PATCH 7/7] OMAPDSS: add dedicated fck PLL support
Message-Id: <1384778344-8226-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds support for SoCs that have a dedicated DSS PLL used for
DSS function clock.

If there is no dss parent clock defined, it is presumed that the
functionl clock rate can be set (almost) freely. The code calculates the
highest allowed fck rate, which when divided with some integer gives the
required pck.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 08c58eb..9a145da 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -446,12 +446,20 @@ bool dss_div_calc(unsigned long pck, unsigned long fck_min,
 	unsigned long prate;
 	unsigned m;
 
+	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+
 	if (dss.parent_clk = NULL) {
-		fck = clk_get_rate(dss.dss_clk);
+		unsigned pckd;
+
+		pckd = fck_hw_max / pck;
+
+		fck = pck * pckd;
+
+		fck = clk_round_rate(dss.dss_clk, fck);
+
 		return func(fck, data);
 	}
 
-	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 	fckd_hw_max = dss.feat->fck_div_max;
 
 	m = dss.feat->dss_fck_multiplier;
@@ -503,16 +511,17 @@ static int dss_setup_default_clock(void)
 	unsigned fck_div;
 	int r;
 
-	if (dss.parent_clk = NULL)
-		return 0;
-
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	prate = clk_get_rate(dss.parent_clk);
+	if (dss.parent_clk = NULL) {
+		fck = clk_round_rate(dss.dss_clk, max_dss_fck);
+	} else {
+		prate = clk_get_rate(dss.parent_clk);
 
-	fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
-			max_dss_fck);
-	fck = prate / fck_div * dss.feat->dss_fck_multiplier;
+		fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
+				max_dss_fck);
+		fck = prate / fck_div * dss.feat->dss_fck_multiplier;
+	}
 
 	r = dss_set_fck_rate(fck);
 	if (r)
-- 
1.8.3.2

