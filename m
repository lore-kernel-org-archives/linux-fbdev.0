From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 13:03:04 +0000
Subject: [PATCH 15/15] video: mmp: remove unnecessary platform_set_drvdata()
Message-Id: <000f01ce4e47$e00c4c70$a024e550$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/mmp/fb/mmpfb.c    |    1 -
 drivers/video/mmp/hw/mmp_ctrl.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index 6d1fa96..4ab95b8 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -659,7 +659,6 @@ failed_destroy_mutex:
 	mutex_destroy(&fbi->access_ok);
 failed:
 	dev_err(fbi->dev, "mmp-fb: frame buffer device init failed\n");
-	platform_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
 
diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 4bd31b2..c46bf5a 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -566,7 +566,6 @@ failed:
 		devm_kfree(ctrl->dev, ctrl);
 	}
 
-	platform_set_drvdata(pdev, NULL);
 	dev_err(&pdev->dev, "device init failed\n");
 
 	return ret;
-- 
1.7.2.5


