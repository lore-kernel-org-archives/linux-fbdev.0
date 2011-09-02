From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 02 Sep 2011 14:40:50 +0000
Subject: [PATCH 5/6] au1200fb: fix hardcoded IRQ
Message-Id: <1314974451-8535-6-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the IRQ provided by platform resource information.
Required for Au1300 support.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/au1200fb.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index b1b16d9..ed5dcdb2 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1595,7 +1595,7 @@ static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 	struct au1200fb_device *fbdev;
 	struct fb_info *fbi = NULL;
 	unsigned long page;
-	int bpp, plane, ret;
+	int bpp, plane, ret, irq;
 
 	/* shut gcc up */
 	ret = 0;
@@ -1671,10 +1671,12 @@ static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 	}
 
 	/* Now hook interrupt too */
-	if ((ret = request_irq(AU1200_LCD_INT, au1200fb_handle_irq,
-		 	  IRQF_DISABLED | IRQF_SHARED, "lcd", (void *)dev)) < 0) {
+	irq = platform_get_irq(dev, 0);
+	ret = request_irq(irq, au1200fb_handle_irq,
+			  IRQF_DISABLED | IRQF_SHARED, "lcd", (void *)dev);
+	if (ret) {
 		print_err("fail to request interrupt line %d (err: %d)",
-			  AU1200_LCD_INT, ret);
+			  irq, ret);
 		goto failed;
 	}
 
@@ -1722,7 +1724,7 @@ static int __devexit au1200fb_drv_remove(struct platform_device *dev)
 		_au1200fb_infos[plane] = NULL;
 	}
 
-	free_irq(AU1200_LCD_INT, (void *)dev);
+	free_irq(platform_get_irq(dev, 0), (void *)dev);
 
 	return 0;
 }
-- 
1.7.6

