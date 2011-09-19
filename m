From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:43 +0000
Subject: [WIP/RFC 05/31] fbdev: sh_mobile_lcdc: Create functions to turn the display on/off
Message-Id: <1316392089-27598-6-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   53 ++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index c7e6074..78f531c 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -223,7 +223,7 @@ static int sh_mobile_lcdc_setup_clocks(struct sh_mobile_lcdc_priv *priv,
 }
 
 /* -----------------------------------------------------------------------------
- * Sys panel and deferred I/O
+ * Display, panel and deferred I/O
  */
 
 static void lcdc_sys_write_index(void *handle, unsigned long data)
@@ -334,6 +334,27 @@ static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
 		schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 }
 
+static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
+{
+	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
+
+	/* HDMI must be enabled before LCDC configuration */
+	if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
+		board_cfg->display_on(board_cfg->board_data, ch->info);
+		module_put(board_cfg->owner);
+	}
+}
+
+static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
+{
+	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
+
+	if (board_cfg->display_off && try_module_get(board_cfg->owner)) {
+		board_cfg->display_off(board_cfg->board_data);
+		module_put(board_cfg->owner);
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * Format helpers
  */
@@ -642,7 +663,6 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 {
 	struct sh_mobile_meram_info *mdev = priv->meram_dev;
-	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	struct sh_mobile_lcdc_chan *ch;
 	unsigned long tmp;
 	int ret;
@@ -659,8 +679,9 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	lcdc_wait_bit(priv, _LDCNT2R, LDCNT2R_BR, 0);
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		ch = &priv->ch[k];
+		struct sh_mobile_lcdc_board_cfg	*board_cfg;
 
+		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
 
@@ -748,11 +769,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			fb_deferred_io_init(ch->info);
 		}
 
-		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
-			board_cfg->display_on(board_cfg->board_data, ch->info);
-			module_put(board_cfg->owner);
-		}
+		sh_mobile_lcdc_display_on(ch);
 
 		if (ch->bl) {
 			ch->bl->props.power = FB_BLANK_UNBLANK;
@@ -766,7 +783,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 {
 	struct sh_mobile_lcdc_chan *ch;
-	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	int k;
 
 	/* clean up deferred io and ask board code to disable panel */
@@ -793,11 +809,7 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 			backlight_update_status(ch->bl);
 		}
 
-		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->display_off && try_module_get(board_cfg->owner)) {
-			board_cfg->display_off(board_cfg->board_data);
-			module_put(board_cfg->owner);
-		}
+		sh_mobile_lcdc_display_off(ch);
 
 		/* disable the meram */
 		if (ch->meram_enabled) {
@@ -1418,7 +1430,6 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
 	struct sh_mobile_lcdc_chan *ch = info->par;
-	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
 
 	if (&ch->lcdc->notifier != nb)
 		return NOTIFY_DONE;
@@ -1428,10 +1439,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 
 	switch(action) {
 	case FB_EVENT_SUSPEND:
-		if (board_cfg->display_off && try_module_get(board_cfg->owner)) {
-			board_cfg->display_off(board_cfg->board_data);
-			module_put(board_cfg->owner);
-		}
+		sh_mobile_lcdc_display_off(ch);
 		sh_mobile_lcdc_stop(ch->lcdc);
 		break;
 	case FB_EVENT_RESUME:
@@ -1439,12 +1447,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 		sh_mobile_fb_reconfig(info);
 		mutex_unlock(&ch->open_lock);
 
-		/* HDMI must be enabled before LCDC configuration */
-		if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
-			board_cfg->display_on(board_cfg->board_data, info);
-			module_put(board_cfg->owner);
-		}
-
+		sh_mobile_lcdc_display_on(ch);
 		sh_mobile_lcdc_start(ch->lcdc);
 	}
 
-- 
1.7.3.4

