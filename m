From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:58:44 +0000
Subject: [PATCH 15/21] video: pm3fb: remove unnecessary pci_set_drvdata()
Message-Id: <002901ceaf85$857f59b0$907e0d10$%han@samsung.com>
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
 drivers/video/pm3fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 7718faa..9c17474 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1489,7 +1489,6 @@ static void pm3fb_remove(struct pci_dev *dev)
 		iounmap(par->v_regs);
 		release_mem_region(fix->mmio_start, fix->mmio_len);
 
-		pci_set_drvdata(dev, NULL);
 		kfree(info->pixmap.addr);
 		framebuffer_release(info);
 	}
-- 
1.7.10.4


