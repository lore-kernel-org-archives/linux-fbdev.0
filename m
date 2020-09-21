From: Liu Shixin <liushixin2@huawei.com>
Date: Mon, 21 Sep 2020 08:24:45 +0000
Subject: [PATCH -next] omapfb: simplify the return expression of tpo_td043_connect
Message-Id: <20200921082445.2591825-1-liushixin2@huawei.com>
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
 .../fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c     | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index bb85b21f0724..afac1d9445aa 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -337,16 +337,11 @@ static int tpo_td043_connect(struct omap_dss_device *dssdev)
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
 
 static void tpo_td043_disconnect(struct omap_dss_device *dssdev)
-- 
2.25.1
