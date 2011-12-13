From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:02 +0000
Subject: [PATCH 07/57] sh_mobile_hdmi: Remove platform data lcd_dev field
Message-Id: <1323784972-24205-8-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The field is used to print debug messages only. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    1 -
 arch/arm/mach-shmobile/board-mackerel.c |    1 -
 drivers/video/sh_mobile_hdmi.c          |   17 +++++------------
 include/video/sh_mobile_hdmi.h          |    1 -
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 42b4dda..dca4860 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -851,7 +851,6 @@ static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
 
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
-	.lcd_dev = &lcdc1_device.dev,
 	.flags = HDMI_SND_SRC_SPDIF,
 	.clk_optimize_parent = ap4evb_clk_optimize,
 };
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7db6a17..4ed0138 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -485,7 +485,6 @@ static struct platform_device hdmi_lcdc_device = {
 
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan	= &hdmi_lcdc_info.ch[0],
-	.lcd_dev	= &hdmi_lcdc_device.dev,
 	.flags		= HDMI_SND_SRC_SPDIF,
 };
 
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index b1e90f5..1ff3baf 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1008,11 +1008,9 @@ static void sh_hdmi_display_on(void *arg, struct fb_info *info)
 	 * FB_EVENT_FB_UNBIND notify is also called with info->lock held
 	 */
 	struct sh_hdmi *hdmi = arg;
-	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
-	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__,
-		pdata->lcd_dev, info->state);
+	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi, info->state);
 
 	/* No need to lock */
 	hdmi->info = info;
@@ -1040,9 +1038,8 @@ static void sh_hdmi_display_on(void *arg, struct fb_info *info)
 static void sh_hdmi_display_off(void *arg)
 {
 	struct sh_hdmi *hdmi = arg;
-	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 
-	dev_dbg(hdmi->dev, "%s(%p)\n", __func__, pdata->lcd_dev);
+	dev_dbg(hdmi->dev, "%s(%p)\n", __func__, hdmi);
 	/* PS mode e->a */
 	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
 }
@@ -1114,15 +1111,11 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 {
 	struct sh_hdmi *hdmi = container_of(work, struct sh_hdmi, edid_work.work);
 	struct fb_info *info;
-	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 	struct sh_mobile_lcdc_chan *ch;
 	int ret;
 
-	dev_dbg(hdmi->dev, "%s(%p): begin, hotplug status %d\n", __func__,
-		pdata->lcd_dev, hdmi->hp_state);
-
-	if (!pdata->lcd_dev)
-		return;
+	dev_dbg(hdmi->dev, "%s(%p): begin, hotplug status %d\n", __func__, hdmi,
+		hdmi->hp_state);
 
 	mutex_lock(&hdmi->mutex);
 
@@ -1198,7 +1191,7 @@ out:
 		hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
 	mutex_unlock(&hdmi->mutex);
 
-	dev_dbg(hdmi->dev, "%s(%p): end\n", __func__, pdata->lcd_dev);
+	dev_dbg(hdmi->dev, "%s(%p): end\n", __func__, hdmi);
 }
 
 static int sh_hdmi_notify(struct notifier_block *nb,
diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
index b569329..0b8d2cf 100644
--- a/include/video/sh_mobile_hdmi.h
+++ b/include/video/sh_mobile_hdmi.h
@@ -32,7 +32,6 @@ struct clk;
 
 struct sh_mobile_hdmi_info {
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
-	struct device			*lcd_dev;
 	unsigned int			 flags;
 	long (*clk_optimize_parent)(unsigned long target, unsigned long *best_freq,
 				    unsigned long *parent_freq);
-- 
1.7.3.4

