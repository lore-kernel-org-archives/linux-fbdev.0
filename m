From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:51:33 +0000
Subject: [PATCH 07/15] video: sa1100fb: remove unnecessary platform_set_drvdata()
Message-Id: <000701ce4e46$43c31a20$cb494e60$@samsung.com>
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
 drivers/video/sa1100fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index f34c858..de76da0 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1271,7 +1271,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
  failed:
 	if (fbi)
 		iounmap(fbi->base);
-	platform_set_drvdata(pdev, NULL);
 	kfree(fbi);
 	release_mem_region(res->start, resource_size(res));
 	return ret;
-- 
1.7.2.5


