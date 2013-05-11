From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:56:55 +0000
Subject: [PATCH 12/15] video: sh7760fb: remove unnecessary platform_set_drvdata()
Message-Id: <000c01ce4e47$03d37f80$0b7a7e80$@samsung.com>
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
 drivers/video/sh7760fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 5fbb0c7..a8c6c43 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -571,7 +571,6 @@ static int sh7760fb_remove(struct platform_device *dev)
 	iounmap(par->base);
 	release_mem_region(par->ioarea->start, resource_size(par->ioarea));
 	framebuffer_release(info);
-	platform_set_drvdata(dev, NULL);
 
 	return 0;
 }
-- 
1.7.2.5


