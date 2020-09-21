From: Qinglang Miao <miaoqinglang@huawei.com>
Date: Mon, 21 Sep 2020 13:10:48 +0000
Subject: [PATCH -next] omapdrm: panel: td028ttec1: simplify the return expression of td028ttec1_panel_connect
Message-Id: <20200921131048.92571-1-miaoqinglang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Qinglang Miao <miaoqinglang@huawei.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 .../fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c     | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 595ebd8bd..3939fe8d5 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -159,16 +159,11 @@ static int td028ttec1_panel_connect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
-	int r;
 
 	if (omapdss_device_is_connected(dssdev))
 		return 0;
 
-	r = in->ops.dpi->connect(in, dssdev);
-	if (r)
-		return r;
-
-	return 0;
+	return in->ops.dpi->connect(in, dssdev);
 }
 
 static void td028ttec1_panel_disconnect(struct omap_dss_device *dssdev)
-- 
2.23.0
