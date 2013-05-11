From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:59:54 +0000
Subject: [PATCH 13/15] video: tmiofb: remove unnecessary platform_set_drvdata()
Message-Id: <000d01ce4e47$6e9bc570$4bd35050$@samsung.com>
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
 drivers/video/tmiofb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index dc4fb86..deb8733 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -794,7 +794,6 @@ err_hw_init:
 		cell->disable(dev);
 err_enable:
 err_find_mode:
-	platform_set_drvdata(dev, NULL);
 	free_irq(irq, info);
 err_request_irq:
 	iounmap(info->screen_base);
@@ -823,8 +822,6 @@ static int tmiofb_remove(struct platform_device *dev)
 		if (cell->disable)
 			cell->disable(dev);
 
-		platform_set_drvdata(dev, NULL);
-
 		free_irq(irq, info);
 
 		iounmap(info->screen_base);
-- 
1.7.2.5


