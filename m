From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 21 Nov 2012 19:48:51 +0000
Subject: [PATCH 1/2] OMAP: DSS: do not fail if dpll4_m4_ck is missing
Message-Id: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Do not fail if dpll4_m4_ck is missing. The clock is not there on omap24xx,
so this should not be a hard error.

The patch retains the functionality before the commit 185bae10 (OMAPDSS:
DSS: Cleanup cpu_is_xxxx checks).

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap2/dss/dss.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2ab1c3e..55f2ea9 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -697,11 +697,15 @@ static int dss_get_clocks(void)
 
 	dss.dss_clk = clk;
 
-	clk = clk_get(NULL, dss.feat->clk_name);
-	if (IS_ERR(clk)) {
-		DSSERR("Failed to get %s\n", dss.feat->clk_name);
-		r = PTR_ERR(clk);
-		goto err;
+	if (dss.feat->clk_name) {
+		clk = clk_get(NULL, dss.feat->clk_name);
+		if (IS_ERR(clk)) {
+			DSSERR("Failed to get %s\n", dss.feat->clk_name);
+			r = PTR_ERR(clk);
+			goto err;
+		}
+	} else {
+		clk = NULL;
 	}
 
 	dss.dpll4_m4_ck = clk;
-- 
1.7.10.4

