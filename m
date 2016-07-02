From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Date: Sat, 02 Jul 2016 08:37:40 +0000
Subject: [PATCH] omapfb: panel-dsi-cm: Remove deprecated create_singlethread_workqueue
Message-Id: <20160702082540.GA26570@Karyakshetra>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The workqueue "workqueue" has only a single workitem(&ddata->ulps_work)
and hence doesn't require ordering. Also, it is not being used on a
memory reclaim path. Hence, the singlethreaded workqueue has been
replaced with the use of system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

dsicm_remove() calls dsicm_cancel_ulps_work which uses
cancel_delayed_work() to ensure that there are no pending tasks while
disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index 3414c26..281ac7e 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -76,8 +76,6 @@ struct panel_drv_data {

 	bool intro_printed;

-	struct workqueue_struct *workqueue;
-
 	bool ulps_enabled;
 	unsigned ulps_timeout;
 	struct delayed_work ulps_work;
@@ -233,7 +231,7 @@ static int dsicm_set_update_window(struct panel_drv_data *ddata,
 static void dsicm_queue_ulps_work(struct panel_drv_data *ddata)
 {
 	if (ddata->ulps_timeout > 0)
-		queue_delayed_work(ddata->workqueue, &ddata->ulps_work,
+		schedule_delayed_work(&ddata->ulps_work,
 				msecs_to_jiffies(ddata->ulps_timeout));
 }

@@ -1284,11 +1282,6 @@ static int dsicm_probe(struct platform_device *pdev)
 		dev_dbg(dev, "Using GPIO TE\n");
 	}

-	ddata->workqueue = create_singlethread_workqueue("dsicm_wq");
-	if (ddata->workqueue = NULL) {
-		dev_err(dev, "can't create workqueue\n");
-		return -ENOMEM;
-	}
 	INIT_DELAYED_WORK(&ddata->ulps_work, dsicm_ulps_work);

 	dsicm_hw_reset(ddata);
@@ -1302,7 +1295,7 @@ static int dsicm_probe(struct platform_device *pdev)
 				dev, ddata, &dsicm_bl_ops, &props);
 		if (IS_ERR(bldev)) {
 			r = PTR_ERR(bldev);
-			goto err_bl;
+			goto err_reg;
 		}

 		ddata->bldev = bldev;
@@ -1325,8 +1318,6 @@ static int dsicm_probe(struct platform_device *pdev)
 err_sysfs_create:
 	if (bldev != NULL)
 		backlight_device_unregister(bldev);
-err_bl:
-	destroy_workqueue(ddata->workqueue);
 err_reg:
 	return r;
 }
@@ -1356,7 +1347,6 @@ static int __exit dsicm_remove(struct platform_device *pdev)
 	omap_dss_put_device(ddata->in);

 	dsicm_cancel_ulps_work(ddata);
-	destroy_workqueue(ddata->workqueue);

 	/* reset, to be sure that the panel is in a valid state */
 	dsicm_hw_reset(ddata);
--
2.1.4

