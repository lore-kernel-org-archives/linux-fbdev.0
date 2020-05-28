From: wu000273@umn.edu
Date: Thu, 28 May 2020 19:44:23 +0000
Subject: [PATCH] omapfb: Fix reference count leak in display_init_sysfs.
Message-Id: <20200528194424.11596-1-wu000273@umn.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kjlu@umn.edu
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexios Zavras <alexios.zavras@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, wu000273@umn.edu, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.
Because function omap_dss_put_device() doesn't handle dssdev->kobj,
thus we need insert kobject_put() to clean up the kobject,
when kobject_init_and_add() fails.

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index 6dbe265b312d..51322ac7df07 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -316,6 +316,7 @@ int display_init_sysfs(struct platform_device *pdev)
 			&pdev->dev.kobj, "%s", dssdev->alias);
 		if (r) {
 			DSSERR("failed to create sysfs files\n");
+			kobject_put(&dssdev->kobj);
 			omap_dss_put_device(dssdev);
 			goto err;
 		}
-- 
2.17.1
