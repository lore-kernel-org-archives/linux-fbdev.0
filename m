From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:23 +0000
Subject: [PATCH 10/15] fbdev: sh_mobile_hdmi: implement locking
Message-Id: <Pine.LNX.4.64.1009030914550.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The SH-Mobile HDMI driver runs in several contexts: ISR, delayed work-queue,
task context, when called from the sh_mobile_lcdc framebuffer driver. This
creates ample race possibilities. Even though most these races are purely
theoretical, it is better to close them. To trace fb_info validity we install a
notification callback in the HDMI driver, and the only way for it to get to
driver internal data is by using struct sh_mobile_lcdc_chan, therefore it had
to be extracted into a separate common header.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c   |  103 ++++++++++++++++++++++++++++++++------
 drivers/video/sh_mobile_lcdcfb.c |   46 ++++++-----------
 drivers/video/sh_mobile_lcdcfb.h |   37 ++++++++++++++
 include/video/sh_mobile_lcdc.h   |    2 +
 4 files changed, 141 insertions(+), 47 deletions(-)
 create mode 100644 drivers/video/sh_mobile_lcdcfb.h

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 293b16d..a645d71 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -26,6 +26,8 @@
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 
+#include "sh_mobile_lcdcfb.h"
+
 #define HDMI_SYSTEM_CTRL			0x00 /* System control */
 #define HDMI_L_R_DATA_SWAP_CTRL_RPKT		0x01 /* L/R data swap control,
 							bits 19..16 of 20-bit N for Audio Clock Regeneration packet */
@@ -209,6 +211,7 @@ struct sh_hdmi {
 	struct clk *hdmi_clk;
 	struct device *dev;
 	struct fb_info *info;
+	struct mutex mutex;		/* Protect the info pointer */
 	struct delayed_work edid_work;
 	struct fb_var_screeninfo var;
 };
@@ -826,17 +829,21 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/* locking:	called with info->lock held, or before register_framebuffer() */
 static void hdmi_display_on(void *arg, struct fb_info *info)
 {
+	/*
+	 * info is guaranteed to be valid, when we are called, because our
+	 * FB_EVENT_FB_UNBIND notify is also called with info->lock held
+	 */
 	struct sh_hdmi *hdmi = arg;
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 
 	pr_debug("%s(%p): state %x\n", __func__, pdata->lcd_dev, info->state);
-	/*
-	 * FIXME: not a good place to store fb_info. And we cannot nullify it
-	 * even on monitor disconnect. What should the lifecycle be?
-	 */
+
+	/* No need to lock */
 	hdmi->info = info;
+
 	switch (hdmi->hp_state) {
 	case HDMI_HOTPLUG_EDID_DONE:
 		/* PS mode d->e. All functions are active */
@@ -850,6 +857,7 @@ static void hdmi_display_on(void *arg, struct fb_info *info)
 	}
 }
 
+/* locking: called with info->lock held */
 static void hdmi_display_off(void *arg)
 {
 	struct sh_hdmi *hdmi = arg;
@@ -872,6 +880,8 @@ static void edid_work_fn(struct work_struct *work)
 	if (!pdata->lcd_dev)
 		return;
 
+	mutex_lock(&hdmi->mutex);
+
 	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
 		pm_runtime_get_sync(hdmi->dev);
 		/* A device has been plugged in */
@@ -882,21 +892,25 @@ static void edid_work_fn(struct work_struct *work)
 		msleep(10);
 
 		if (!hdmi->info)
-			return;
+			goto out;
 
 		acquire_console_sem();
 
 		/* HDMI plug in */
 		hdmi->info->var = hdmi->var;
-		if (hdmi->info->state != FBINFO_STATE_RUNNING)
+		if (hdmi->info->state != FBINFO_STATE_RUNNING) {
 			fb_set_suspend(hdmi->info, 0);
-		else
-			hdmi_display_on(hdmi, hdmi->info);
+		} else {
+			if (lock_fb_info(hdmi->info)) {
+				hdmi_display_on(hdmi, hdmi->info);
+				unlock_fb_info(hdmi->info);
+			}
+		}
 
 		release_console_sem();
 	} else {
 		if (!hdmi->info)
-			return;
+			goto out;
 
 		acquire_console_sem();
 
@@ -907,13 +921,61 @@ static void edid_work_fn(struct work_struct *work)
 		pm_runtime_put(hdmi->dev);
 	}
 
+out:
+	mutex_unlock(&hdmi->mutex);
+
 	pr_debug("%s(%p): end\n", __func__, pdata->lcd_dev);
 }
 
+static int sh_hdmi_notify(struct notifier_block *nb,
+			  unsigned long action, void *data);
+
+static struct notifier_block sh_hdmi_notifier = {
+	.notifier_call = sh_hdmi_notify,
+};
+
+static int sh_hdmi_notify(struct notifier_block *nb,
+			  unsigned long action, void *data)
+{
+	struct fb_event *event = data;
+	struct fb_info *info = event->info;
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
+	struct sh_hdmi *hdmi = board_cfg->board_data;
+
+	if (nb != &sh_hdmi_notifier || !hdmi || hdmi->info != info)
+		return NOTIFY_DONE;
+
+	switch(action) {
+	case FB_EVENT_FB_REGISTERED:
+		/* Unneeded, activation taken care by hdmi_display_on() */
+		break;
+	case FB_EVENT_FB_UNREGISTERED:
+		/*
+		 * We are called from unregister_framebuffer() with the
+		 * info->lock held. This is bad for us, because we can race with
+		 * the scheduled work, which has to call fb_set_suspend(), which
+		 * takes info->lock internally, so, edid_work_fn() cannot take
+		 * and hold info->lock for the whole function duration. Using an
+		 * additional lock creates a classical AB-BA lock up. Therefore,
+		 * we have to release the info->lock temporarily, synchronise
+		 * with the work queue and re-acquire the info->lock.
+		 */
+		unlock_fb_info(hdmi->info);
+		mutex_lock(&hdmi->mutex);
+		hdmi->info = NULL;
+		mutex_unlock(&hdmi->mutex);
+		lock_fb_info(hdmi->info);
+		return NOTIFY_OK;
+	}
+	return NOTIFY_DONE;
+}
+
 static int __init sh_hdmi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	int irq = platform_get_irq(pdev, 0), ret;
 	struct sh_hdmi *hdmi;
 	long rate;
@@ -927,6 +989,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	mutex_init(&hdmi->mutex);
 	hdmi->dev = &pdev->dev;
 
 	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
@@ -984,9 +1047,11 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 #endif
 
 	/* Set up LCDC callbacks */
-	pdata->lcd_chan->board_cfg.board_data = hdmi;
-	pdata->lcd_chan->board_cfg.display_on = hdmi_display_on;
-	pdata->lcd_chan->board_cfg.display_off = hdmi_display_off;
+	board_cfg = &pdata->lcd_chan->board_cfg;
+	board_cfg->owner = THIS_MODULE;
+	board_cfg->board_data = hdmi;
+	board_cfg->display_on = hdmi_display_on;
+	board_cfg->display_off = hdmi_display_off;
 
 	INIT_DELAYED_WORK(&hdmi->edid_work, edid_work_fn);
 
@@ -1013,6 +1078,7 @@ eclkenable:
 erate:
 	clk_put(hdmi->hdmi_clk);
 egetclk:
+	mutex_destroy(&hdmi->mutex);
 	kfree(hdmi);
 
 	return ret;
@@ -1023,19 +1089,24 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
 	struct sh_hdmi *hdmi = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct sh_mobile_lcdc_board_cfg	*board_cfg = &pdata->lcd_chan->board_cfg;
 	int irq = platform_get_irq(pdev, 0);
 
-	pdata->lcd_chan->board_cfg.display_on = NULL;
-	pdata->lcd_chan->board_cfg.display_off = NULL;
-	pdata->lcd_chan->board_cfg.board_data = NULL;
+	board_cfg->display_on = NULL;
+	board_cfg->display_off = NULL;
+	board_cfg->board_data = NULL;
+	board_cfg->owner = NULL;
 
+	/* No new work will be scheduled, wait for running ISR */
 	free_irq(irq, hdmi);
-	pm_runtime_disable(&pdev->dev);
+	/* Wait for already scheduled work */
 	cancel_delayed_work_sync(&hdmi->edid_work);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable(hdmi->hdmi_clk);
 	clk_put(hdmi->hdmi_clk);
 	iounmap(hdmi->base);
 	release_mem_region(res->start, resource_size(res));
+	mutex_destroy(&hdmi->mutex);
 	kfree(hdmi);
 
 	return 0;
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index ddd6c46..29d7ce7 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#include <linux/fb.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -24,7 +23,8 @@
 #include <video/sh_mobile_lcdc.h>
 #include <asm/atomic.h>
 
-#define PALETTE_NR 16
+#include "sh_mobile_lcdcfb.h"
+
 #define SIDE_B_OFFSET 0x1000
 #define MIRROR_OFFSET 0x2000
 
@@ -53,12 +53,6 @@ static int lcdc_shared_regs[] = {
 };
 #define NR_SHARED_REGS ARRAY_SIZE(lcdc_shared_regs)
 
-/* per-channel registers */
-enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
-       LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR,
-       LDHAJR,
-       NR_CH_REGS };
-
 static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDDCKPAT1R] = 0x400,
 	[LDDCKPAT2R] = 0x404,
@@ -112,25 +106,6 @@ static unsigned long lcdc_offs_sublcd[NR_CH_REGS] = {
 #define LDRCNTR_MRC	0x00000001
 #define LDSR_MRS	0x00000100
 
-struct sh_mobile_lcdc_priv;
-struct sh_mobile_lcdc_chan {
-	struct sh_mobile_lcdc_priv *lcdc;
-	unsigned long *reg_offs;
-	unsigned long ldmt1r_value;
-	unsigned long enabled; /* ME and SE in LDCNT2R */
-	struct sh_mobile_lcdc_chan_cfg cfg;
-	u32 pseudo_palette[PALETTE_NR];
-	unsigned long saved_ch_regs[NR_CH_REGS];
-	struct fb_info *info;
-	dma_addr_t dma_handle;
-	struct fb_deferred_io defio;
-	struct scatterlist *sglist;
-	unsigned long frame_end;
-	unsigned long pan_offset;
-	wait_queue_head_t frame_end_wait;
-	struct completion vsync_completion;
-};
-
 struct sh_mobile_lcdc_priv {
 	void __iomem *base;
 	int irq;
@@ -589,8 +564,10 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			continue;
 
 		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->display_on)
+		if (try_module_get(board_cfg->owner) && board_cfg->display_on) {
 			board_cfg->display_on(board_cfg->board_data, ch->info);
+			module_put(board_cfg->owner);
+		}
 	}
 
 	return 0;
@@ -622,8 +599,10 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 		}
 
 		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->display_off)
+		if (try_module_get(board_cfg->owner) && board_cfg->display_off) {
 			board_cfg->display_off(board_cfg->board_data);
+			module_put(board_cfg->owner);
+		}
 	}
 
 	/* stop the lcdc */
@@ -954,6 +933,7 @@ static const struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
 	.runtime_resume = sh_mobile_lcdc_runtime_resume,
 };
 
+/* locking: called with info->lock held */
 static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -971,16 +951,20 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 
 	switch(action) {
 	case FB_EVENT_SUSPEND:
-		if (board_cfg->display_off)
+		if (try_module_get(board_cfg->owner) && board_cfg->display_off) {
 			board_cfg->display_off(board_cfg->board_data);
+			module_put(board_cfg->owner);
+		}
 		pm_runtime_put(info->device);
 		break;
 	case FB_EVENT_RESUME:
 		var = &info->var;
 
 		/* HDMI must be enabled before LCDC configuration */
-		if (board_cfg->display_on)
+		if (try_module_get(board_cfg->owner) && board_cfg->display_on) {
 			board_cfg->display_on(board_cfg->board_data, ch->info);
+			module_put(board_cfg->owner);
+		}
 
 		/* Check if the new display is not in our modelist */
 		if (ch->info->modelist.next &&
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
new file mode 100644
index 0000000..6fcfc0f
--- /dev/null
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -0,0 +1,37 @@
+#ifndef SH_MOBILE_LCDCFB_H
+#define SH_MOBILE_LCDCFB_H
+
+#include <linux/completion.h>
+#include <linux/fb.h>
+#include <linux/wait.h>
+
+/* per-channel registers */
+enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
+       LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR,
+       LDHAJR,
+       NR_CH_REGS };
+
+#define PALETTE_NR 16
+
+struct sh_mobile_lcdc_priv;
+struct fb_info;
+
+struct sh_mobile_lcdc_chan {
+	struct sh_mobile_lcdc_priv *lcdc;
+	unsigned long *reg_offs;
+	unsigned long ldmt1r_value;
+	unsigned long enabled; /* ME and SE in LDCNT2R */
+	struct sh_mobile_lcdc_chan_cfg cfg;
+	u32 pseudo_palette[PALETTE_NR];
+	unsigned long saved_ch_regs[NR_CH_REGS];
+	struct fb_info *info;
+	dma_addr_t dma_handle;
+	struct fb_deferred_io defio;
+	struct scatterlist *sglist;
+	unsigned long frame_end;
+	unsigned long pan_offset;
+	wait_queue_head_t frame_end_wait;
+	struct completion vsync_completion;
+};
+
+#endif
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 19c69d7..daabae5 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -49,7 +49,9 @@ struct sh_mobile_lcdc_sys_bus_ops {
 	unsigned long (*read_data)(void *handle);
 };
 
+struct module;
 struct sh_mobile_lcdc_board_cfg {
+	struct module *owner;
 	void *board_data;
 	int (*setup_sys)(void *board_data, void *sys_ops_handle,
 			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
-- 
1.7.1

