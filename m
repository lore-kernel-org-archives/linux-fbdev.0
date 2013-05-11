From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:54:49 +0000
Subject: [PATCH 10/15] video: au1100fb: remove unnecessary platform_set_drvdata()
Message-Id: <000a01ce4e46$b8e362b0$2aaa2810$@samsung.com>
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
 drivers/video/au1100fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 700cac0..606a3ba 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -579,7 +579,6 @@ failed:
 	if (fbdev->info.cmap.len != 0) {
 		fb_dealloc_cmap(&fbdev->info.cmap);
 	}
-	platform_set_drvdata(dev, NULL);
 
 	return -ENODEV;
 }
-- 
1.7.2.5


