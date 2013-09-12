From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 07:01:18 +0000
Subject: [PATCH 20/21] video: tridentfb: remove unnecessary pci_set_drvdata()
Message-Id: <002e01ceaf85$e18453a0$a48cfae0$%han@samsung.com>
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
 drivers/video/tridentfb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index ab57d38..7ed9a22 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -1553,7 +1553,6 @@ static void trident_pci_remove(struct pci_dev *dev)
 	iounmap(info->screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
 	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
-	pci_set_drvdata(dev, NULL);
 	kfree(info->pixmap.addr);
 	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);
-- 
1.7.10.4


