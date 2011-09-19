From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:59 +0000
Subject: [WIP/RFC 21/31] sh_mobile_hdmi: Use sh_mobile_lcdc_entity::channel to access fb_info
Message-Id: <1316392089-27598-22-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The fb_info parameter passed to the display_on operation will be
removed, don't use it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c |   81 ++++++---------------------------------
 1 files changed, 13 insertions(+), 68 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index d89645e..deca755 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -219,16 +219,12 @@ struct sh_hdmi {
 	u8 edid_blocks;
 	struct clk *hdmi_clk;
 	struct device *dev;
-	struct fb_info *info;
-	struct mutex mutex;		/* Protect the info pointer */
 	struct delayed_work edid_work;
 	struct fb_var_screeninfo var;
 	struct fb_monspecs monspec;
-	struct notifier_block notifier;
 };
 
 #define entity_to_sh_hdmi(e)	container_of(e, struct sh_hdmi, entity)
-#define notifier_to_sh_hdmi(n)	container_of(n, struct sh_hdmi, notifier)
 
 static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
 {
@@ -737,10 +733,11 @@ static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
 static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 			     unsigned long *parent_rate)
 {
+	struct fb_info *info = hdmi->entity.lcdc
+			     ? hdmi->entity.lcdc->info : NULL;
 	struct fb_var_screeninfo tmpvar;
 	struct fb_var_screeninfo *var = &tmpvar;
 	const struct fb_videomode *mode, *found = NULL;
-	struct fb_info *info = hdmi->info;
 	struct fb_modelist *modelist = NULL;
 	unsigned int f_width = 0, f_height = 0, f_refresh = 0;
 	unsigned long found_rate_error = ULONG_MAX; /* silly compiler... */
@@ -1012,13 +1009,11 @@ static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
 	 * FB_EVENT_FB_UNBIND notify is also called with info->lock held
 	 */
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
-	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_chan *ch = entity->lcdc;
+	struct fb_info *info = ch->info;
 
 	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi, info->state);
 
-	/* No need to lock */
-	hdmi->info = info;
-
 	/*
 	 * hp_state can be set to
 	 * HDMI_HOTPLUG_DISCONNECTED:	on monitor unplug
@@ -1038,7 +1033,6 @@ static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
 	}
 }
 
-/* locking: called with info->lock held */
 static void sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
@@ -1055,15 +1049,14 @@ static const struct sh_mobile_lcdc_entity_ops sh_hdmi_ops = {
 
 static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
 {
-	struct fb_info *info = hdmi->info;
-	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_chan *ch = hdmi->entity.lcdc;
 	struct fb_var_screeninfo *new_var = &hdmi->var, *old_var = &ch->display_var;
 	struct fb_videomode mode1, mode2;
 
 	fb_var_to_videomode(&mode1, old_var);
 	fb_var_to_videomode(&mode2, new_var);
 
-	dev_dbg(info->dev, "Old %ux%u, new %ux%u\n",
+	dev_dbg(hdmi->dev, "Old %ux%u, new %ux%u\n",
 		mode1.xres, mode1.yres, mode2.xres, mode2.yres);
 
 	if (fb_mode_is_equal(&mode1, &mode2)) {
@@ -1073,7 +1066,7 @@ static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
 		return false;
 	}
 
-	dev_dbg(info->dev, "Switching %u -> %u lines\n",
+	dev_dbg(hdmi->dev, "Switching %u -> %u lines\n",
 		mode1.yres, mode2.yres);
 	*old_var = *new_var;
 
@@ -1119,17 +1112,15 @@ static long sh_hdmi_clk_configure(struct sh_hdmi *hdmi, unsigned long hdmi_rate,
 static void sh_hdmi_edid_work_fn(struct work_struct *work)
 {
 	struct sh_hdmi *hdmi = container_of(work, struct sh_hdmi, edid_work.work);
-	struct sh_mobile_lcdc_chan *ch;
 	int ret;
 
 	dev_dbg(hdmi->dev, "%s(%p): begin, hotplug status %d\n", __func__, hdmi,
 		hdmi->hp_state);
 
-	mutex_lock(&hdmi->mutex);
-
 	if (hdmi->hp_state = HDMI_HOTPLUG_CONNECTED) {
-		struct fb_info *info = hdmi->info;
+		struct sh_mobile_lcdc_chan *ch = hdmi->entity.lcdc;
 		unsigned long parent_rate = 0, hdmi_rate;
+		struct fb_info *info;
 
 		ret = sh_hdmi_read_edid(hdmi, &hdmi_rate, &parent_rate);
 		if (ret < 0)
@@ -1147,10 +1138,10 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		/* Switched to another (d) power-save mode */
 		msleep(10);
 
-		if (!info)
+		if (ch = NULL)
 			goto out;
 
-		ch = info->par;
+		info = ch->info;
 
 		console_lock();
 
@@ -1175,7 +1166,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		console_unlock();
 	} else {
 		ret = 0;
-		if (!hdmi->info)
+		if (hdmi->entity.lcdc = NULL)
 			goto out;
 
 		hdmi->monspec.modedb_len = 0;
@@ -1185,7 +1176,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		console_lock();
 
 		/* HDMI disconnect */
-		fb_set_suspend(hdmi->info, 1);
+		fb_set_suspend(hdmi->entity.lcdc->info, 1);
 
 		console_unlock();
 	}
@@ -1193,47 +1184,10 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 out:
 	if (ret < 0 && ret != -EAGAIN)
 		hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
-	mutex_unlock(&hdmi->mutex);
 
 	dev_dbg(hdmi->dev, "%s(%p): end\n", __func__, hdmi);
 }
 
-static int sh_hdmi_notify(struct notifier_block *nb,
-			  unsigned long action, void *data)
-{
-	struct fb_event *event = data;
-	struct fb_info *info = event->info;
-	struct sh_hdmi *hdmi = notifier_to_sh_hdmi(nb);
-
-	if (!hdmi || nb != &hdmi->notifier || hdmi->info != info)
-		return NOTIFY_DONE;
-
-	switch(action) {
-	case FB_EVENT_FB_REGISTERED:
-		/* Unneeded, activation taken care by sh_hdmi_display_on() */
-		break;
-	case FB_EVENT_FB_UNREGISTERED:
-		/*
-		 * We are called from unregister_framebuffer() with the
-		 * info->lock held. This is bad for us, because we can race with
-		 * the scheduled work, which has to call fb_set_suspend(), which
-		 * takes info->lock internally, so, sh_hdmi_edid_work_fn()
-		 * cannot take and hold info->lock for the whole function
-		 * duration. Using an additional lock creates a classical AB-BA
-		 * lock up. Therefore, we have to release the info->lock
-		 * temporarily, synchronise with the work queue and re-acquire
-		 * the info->lock.
-		 */
-		unlock_fb_info(info);
-		mutex_lock(&hdmi->mutex);
-		hdmi->info = NULL;
-		mutex_unlock(&hdmi->mutex);
-		lock_fb_info(info);
-		return NOTIFY_OK;
-	}
-	return NOTIFY_DONE;
-}
-
 static int __init sh_hdmi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
@@ -1251,8 +1205,6 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	mutex_init(&hdmi->mutex);
-
 	hdmi->dev = &pdev->dev;
 	hdmi->entity.owner = THIS_MODULE;
 	hdmi->entity.ops = &sh_hdmi_ops;
@@ -1320,9 +1272,6 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto ecodec;
 	}
 
-	hdmi->notifier.notifier_call = sh_hdmi_notify;
-	fb_register_client(&hdmi->notifier);
-
 	return 0;
 
 ecodec:
@@ -1338,7 +1287,6 @@ ereqreg:
 erate:
 	clk_put(hdmi->hdmi_clk);
 egetclk:
-	mutex_destroy(&hdmi->mutex);
 	kfree(hdmi);
 
 	return ret;
@@ -1352,8 +1300,6 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_codec(&pdev->dev);
 
-	fb_unregister_client(&hdmi->notifier);
-
 	/* No new work will be scheduled, wait for running ISR */
 	free_irq(irq, hdmi);
 	/* Wait for already scheduled work */
@@ -1364,7 +1310,6 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	clk_put(hdmi->hdmi_clk);
 	iounmap(hdmi->base);
 	release_mem_region(res->start, resource_size(res));
-	mutex_destroy(&hdmi->mutex);
 	kfree(hdmi);
 
 	return 0;
-- 
1.7.3.4

