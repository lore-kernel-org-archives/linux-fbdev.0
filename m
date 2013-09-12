From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 07:28:27 +0000
Subject: [PATCH 14/21] video: pm2fb: remove unnecessary pci_set_drvdata()
Message-Id: <000401ceaf89$ac6f2ab0$054d8010$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002801ceaf85$71f3d740$55db85c0$%han@samsung.com>
In-Reply-To: <002801ceaf85$71f3d740$55db85c0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/pm2fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 81354ee..45d9a3f 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1744,7 +1744,6 @@ static void pm2fb_remove(struct pci_dev *pdev)
 	iounmap(par->v_regs);
 	release_mem_region(fix->mmio_start, fix->mmio_len);
 
-	pci_set_drvdata(pdev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
-- 
1.7.10.4


