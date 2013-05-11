From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:48:01 +0000
Subject: [PATCH 03/15] video: imxfb: remove unnecessary platform_set_drvdata()
Message-Id: <000301ce4e45$c5d95e30$518c1a90$@samsung.com>
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
 drivers/video/imxfb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 0abf2bf..c1945b3 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -923,7 +923,6 @@ failed_getclock:
 failed_req:
 	kfree(info->pseudo_palette);
 failed_init:
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(info);
 	return ret;
 }
@@ -955,8 +954,6 @@ static int imxfb_remove(struct platform_device *pdev)
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.2.5


