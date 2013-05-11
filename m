From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:53:25 +0000
Subject: [PATCH 09/15] video: vt8500: remove unnecessary platform_set_drvdata()
Message-Id: <000901ce4e46$86fe40d0$94fac270$@samsung.com>
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
 drivers/video/vt8500lcdfb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 9547e18..897484903 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -448,7 +448,6 @@ failed_free_io:
 failed_free_res:
 	release_mem_region(res->start, resource_size(res));
 failed_fbi:
-	platform_set_drvdata(pdev, NULL);
 	kfree(fbi);
 failed:
 	return ret;
-- 
1.7.2.5


