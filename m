From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:08 +0000
Subject: [PATCH 06/15] fbdev: sh_mobile_lcdcfb: fix notifier callback return
Message-Id: <Pine.LNX.4.64.1009030913070.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Notifier callbacks have to return either one of NOTIFY_* codes or a negative
errno, converted to a suitable value by the notifier_from_errno() inline, if
the notifier chain shall not be continued.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index ce3ed4b..2f6e37e 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -964,7 +964,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	struct fb_var_screeninfo *var;
 
 	if (&ch->lcdc->notifier != nb)
-		return 0;
+		return NOTIFY_DONE;
 
 	dev_dbg(info->dev, "%s(): action = %lu, data = %p\n",
 		__func__, action, event->data);
@@ -991,23 +991,25 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 			/* Can we handle this display? */
 			if (var->xres > ch->cfg.lcd_cfg[0].xres ||
 			    var->yres > ch->cfg.lcd_cfg[0].yres)
-				return -ENOMEM;
+				/*
+				 * LCDC resume failed, no need to continue with
+				 * the notifier chain
+				 */
+				return notifier_from_errno(-ENOMEM);
 
 			/* Add to the modelist */
 			fb_var_to_videomode(&mode, var);
 			ret = fb_add_videomode(&mode, &ch->info->modelist);
 			if (ret < 0)
-				return ret;
+				return notifier_from_errno(ret);
 		}
 
 		pm_runtime_get_sync(info->device);
 
 		sh_mobile_lcdc_geometry(ch);
-
-		break;
 	}
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static int sh_mobile_lcdc_remove(struct platform_device *pdev);
-- 
1.7.1

