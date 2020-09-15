From: Liu Shixin <liushixin2@huawei.com>
Date: Tue, 15 Sep 2020 03:26:27 +0000
Subject: [PATCH -next] omapfb: connector-dvi: simplify the return expression of dvic_connect()
Message-Id: <20200915032627.1772517-1-liushixin2@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Liu Shixin <liushixin2@huawei.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
index b4a1aefff766..2fa436475b40 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
@@ -51,16 +51,11 @@ static int dvic_connect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
-	int r;
 
 	if (omapdss_device_is_connected(dssdev))
 		return 0;
 
-	r = in->ops.dvi->connect(in, dssdev);
-	if (r)
-		return r;
-
-	return 0;
+	return in->ops.dvi->connect(in, dssdev);
 }
 
 static void dvic_disconnect(struct omap_dss_device *dssdev)
-- 
2.25.1
