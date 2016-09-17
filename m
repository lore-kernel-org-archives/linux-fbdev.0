From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 17 Sep 2016 15:53:34 +0000
Subject: [PATCH] omapfb: fix return value check in dsi_bind()
Message-Id: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the retrn value check which testing the wrong variable
in dsi_bind().

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 9e4800a..951dd93 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -5348,7 +5348,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 
 	dsi->phy_base = devm_ioremap(&dsidev->dev, res->start,
 		resource_size(res));
-	if (!dsi->proto_base) {
+	if (!dsi->phy_base) {
 		DSSERR("can't ioremap DSI PHY\n");
 		return -ENOMEM;
 	}
@@ -5368,7 +5368,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 
 	dsi->pll_base = devm_ioremap(&dsidev->dev, res->start,
 		resource_size(res));
-	if (!dsi->proto_base) {
+	if (!dsi->pll_base) {
 		DSSERR("can't ioremap DSI PLL\n");
 		return -ENOMEM;
 	}

