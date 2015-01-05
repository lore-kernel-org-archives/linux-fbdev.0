From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Mon, 05 Jan 2015 13:09:47 +0000
Subject: [PATCH] fbdev: omap2: Fix typo in tvc_probe_pdata
Message-Id: <1420463387-26391-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Assigning ddata->invert_polarity to itself is not very useful; the
context suggests that the right-hand side should have been
pdata->invert_polarity.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
index 9a2b5ce58545..8511c648a15c 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
@@ -208,7 +208,7 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 	ddata->in = in;
 
 	ddata->connector_type = pdata->connector_type;
-	ddata->invert_polarity = ddata->invert_polarity;
+	ddata->invert_polarity = pdata->invert_polarity;
 
 	dssdev = &ddata->dssdev;
 	dssdev->name = pdata->name;
-- 
2.1.3

