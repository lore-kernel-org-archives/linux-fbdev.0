From: Liu Shixin <liushixin2@huawei.com>
Date: Mon, 21 Sep 2020 08:24:44 +0000
Subject: [PATCH -next] omapfb: simplify the return expression of sharp_ls_connect
Message-Id: <20200921082444.2591773-1-liushixin2@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200921082443.2591721-1-liushixin2@huawei.com>
In-Reply-To: <20200921082443.2591721-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Liu Shixin <liushixin2@huawei.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 .../fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c  | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
index a3912fc8031f..602324c5c9f9 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
@@ -59,16 +59,11 @@ static int sharp_ls_connect(struct omap_dss_device *dssdev)
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
 
 static void sharp_ls_disconnect(struct omap_dss_device *dssdev)
-- 
2.25.1
