From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:55:29 +0000
Subject: [PATCH 09/21] video: i810fb: remove unnecessary pci_set_drvdata()
Message-Id: <002301ceaf85$115c5ce0$341516a0$%han@samsung.com>
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
 drivers/video/i810/i810_main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 4ce3438..038192a 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -2129,7 +2129,6 @@ static void __exit i810fb_remove_pci(struct pci_dev *dev)
 
 	unregister_framebuffer(info);  
 	i810fb_release_resource(info, par);
-	pci_set_drvdata(dev, NULL);
 	printk("cleanup_module:  unloaded i810 framebuffer device\n");
 }                                                	
 
-- 
1.7.10.4


