From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 23 May 2010 07:15:58 +0000
Subject: [PATCH] fbdev: bf54x-lq043fb: fix unused warnings with backlight code
Message-Id: <1274598958-12892-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org

The current backlight code is stubbed out, so the new props changes added
some warnings:
drivers/video/bf54x-lq043fb.c: In function 'bfin_bf54x_probe':
drivers/video/bf54x-lq043fb.c:666: warning: label 'out9' defined but not used
drivers/video/bf54x-lq043fb.c:504: warning: unused variable 'props'

Fix em !

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bf54x-lq043fb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 23b2a8c..b020ba7 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -501,7 +501,9 @@ static irqreturn_t bfin_bf54x_irq_error(int irq, void *dev_id)
 
 static int __devinit bfin_bf54x_probe(struct platform_device *pdev)
 {
+#ifndef NO_BL_SUPPORT
 	struct backlight_properties props;
+#endif
 	struct bfin_bf54xfb_info *info;
 	struct fb_info *fbinfo;
 	int ret;
@@ -654,7 +656,8 @@ static int __devinit bfin_bf54x_probe(struct platform_device *pdev)
 		printk(KERN_ERR DRIVER_NAME
 			": unable to register backlight.\n");
 		ret = -EINVAL;
-		goto out9;
+		unregister_framebuffer(fbinfo);
+		goto out8;
 	}
 
 	lcd_dev = lcd_device_register(DRIVER_NAME, &pdev->dev, NULL, &bfin_lcd_ops);
@@ -663,8 +666,6 @@ static int __devinit bfin_bf54x_probe(struct platform_device *pdev)
 
 	return 0;
 
-out9:
-	unregister_framebuffer(fbinfo);
 out8:
 	free_irq(info->irq, info);
 out7:
-- 
1.7.1

