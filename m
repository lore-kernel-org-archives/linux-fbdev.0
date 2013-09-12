From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:51:25 +0000
Subject: [PATCH 02/21] video: carminefb: remove unnecessary pci_set_drvdata()
Message-Id: <001c01ceaf84$7f9c0bc0$7ed42340$%han@samsung.com>
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
 drivers/video/carminefb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/carminefb.c b/drivers/video/carminefb.c
index 153dd65..b98f709 100644
--- a/drivers/video/carminefb.c
+++ b/drivers/video/carminefb.c
@@ -746,7 +746,6 @@ static void carminefb_remove(struct pci_dev *dev)
 	iounmap(hw->v_regs);
 	release_mem_region(fix.mmio_start, fix.mmio_len);
 
-	pci_set_drvdata(dev, NULL);
 	pci_disable_device(dev);
 	kfree(hw);
 }
-- 
1.7.10.4


