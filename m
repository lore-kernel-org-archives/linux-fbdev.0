From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 25 Nov 2013 03:19:56 +0000
Subject: [PATCH 3/4] video: rivafb: remove unnecessary pci_set_drvdata()
Message-Id: <002101cee98d$3732cde0$a59869a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/riva/fbdev.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index a5514ac..8a8d7f0 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -2128,7 +2128,6 @@ static void rivafb_remove(struct pci_dev *pd)
 	pci_release_regions(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
-	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
 }
 
-- 
1.7.10.4


