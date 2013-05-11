From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:47:08 +0000
Subject: [PATCH 02/15] video: ep93xx: remove unnecessary platform_set_drvdata()
Message-Id: <000201ce4e45$a5da7330$f18f5990$@samsung.com>
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
 drivers/video/ep93xx-fb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index ee1ee54..28a837d 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -595,7 +595,6 @@ failed_videomem:
 	fb_dealloc_cmap(&info->cmap);
 failed_cmap:
 	kfree(info);
-	platform_set_drvdata(pdev, NULL);
 
 	return err;
 }
@@ -614,7 +613,6 @@ static int ep93xxfb_remove(struct platform_device *pdev)
 		fbi->mach_info->teardown(pdev);
 
 	kfree(info);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.2.5


