From: Qinglang Miao <miaoqinglang@huawei.com>
Date: Mon, 21 Sep 2020 13:10:49 +0000
Subject: [PATCH -next] omapfb: connector-analog-tv: simplify the return expression of tvc_connect()
Message-Id: <20200921131049.92616-1-miaoqinglang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Qinglang Miao <miaoqinglang@huawei.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 .../fbdev/omap2/omapfb/displays/connector-analog-tv.c      | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
index 63bd13ba4..a9fd732f8 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
@@ -47,18 +47,13 @@ static int tvc_connect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
-	int r;
 
 	dev_dbg(ddata->dev, "connect\n");
 
 	if (omapdss_device_is_connected(dssdev))
 		return 0;
 
-	r = in->ops.atv->connect(in, dssdev);
-	if (r)
-		return r;
-
-	return 0;
+	return in->ops.atv->connect(in, dssdev);
 }
 
 static void tvc_disconnect(struct omap_dss_device *dssdev)
-- 
2.23.0
