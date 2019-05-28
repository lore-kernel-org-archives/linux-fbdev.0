From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:51 +0000
Subject: [PATCH 20/33] fbdev/sh_mob: Remove fb notifier callback
Message-Id: <20190528090304.9388-21-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Markus Elfring <elfring@users.sourceforge.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>

This seems to be entirely defunct:

- The FB_EVEN_SUSPEND/RESUME events are only sent out by
  fb_set_suspend. Which is supposed to be called by drivers in their
  suspend/resume hooks, and not itself call into drivers. Luckily
  sh_mob doesn't call fb_set_suspend, so this seems to do nothing
  useful.

- The notify hook calls sh_mobile_fb_reconfig() which in turn can
  call into the fb notifier. Or attempt too, since that would
  deadlock.

So looks like leftover hacks from when this was originally introduced
in

commit 6011bdeaa6089d49c02de69f05980da7bad314ab
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Wed Jul 21 10:13:21 2010 +0000

    fbdev: sh-mobile: HDMI support for SH-Mobile SoCs

So let's just remove it.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 38 --------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 1437695415c9..015a02a29d37 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -213,7 +213,6 @@ struct sh_mobile_lcdc_priv {
 	struct sh_mobile_lcdc_chan ch[2];
 	struct sh_mobile_lcdc_overlay overlays[4];
 
-	struct notifier_block notifier;
 	int started;
 	int forced_fourcc; /* 2 channel LCDC must share fourcc setting */
 };
@@ -2239,37 +2238,6 @@ static const struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
  * Framebuffer notifier
  */
 
-/* locking: called with info->lock held */
-static int sh_mobile_lcdc_notify(struct notifier_block *nb,
-				 unsigned long action, void *data)
-{
-	struct fb_event *event = data;
-	struct fb_info *info = event->info;
-	struct sh_mobile_lcdc_chan *ch = info->par;
-
-	if (&ch->lcdc->notifier != nb)
-		return NOTIFY_DONE;
-
-	dev_dbg(info->dev, "%s(): action = %lu, data = %p\n",
-		__func__, action, event->data);
-
-	switch(action) {
-	case FB_EVENT_SUSPEND:
-		sh_mobile_lcdc_display_off(ch);
-		sh_mobile_lcdc_stop(ch->lcdc);
-		break;
-	case FB_EVENT_RESUME:
-		mutex_lock(&ch->open_lock);
-		sh_mobile_fb_reconfig(info);
-		mutex_unlock(&ch->open_lock);
-
-		sh_mobile_lcdc_display_on(ch);
-		sh_mobile_lcdc_start(ch->lcdc);
-	}
-
-	return NOTIFY_OK;
-}
-
 /* -----------------------------------------------------------------------------
  * Probe/remove and driver init/exit
  */
@@ -2297,8 +2265,6 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	fb_unregister_client(&priv->notifier);
-
 	for (i = 0; i < ARRAY_SIZE(priv->overlays); i++)
 		sh_mobile_lcdc_overlay_fb_unregister(&priv->overlays[i]);
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
@@ -2688,10 +2654,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 			goto err1;
 	}
 
-	/* Failure ignored */
-	priv->notifier.notifier_call = sh_mobile_lcdc_notify;
-	fb_register_client(&priv->notifier);
-
 	return 0;
 err1:
 	sh_mobile_lcdc_remove(pdev);
-- 
2.20.1
