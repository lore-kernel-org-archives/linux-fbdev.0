From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:12 +0000
Subject: [PATCH 17/57] fbdev: sh_mobile_lcdc: Remove board configuration owner field
Message-Id: <1323784972-24205-18-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The field is unused, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    8 ++------
 include/video/sh_mobile_lcdc.h   |    2 --
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index f1bbae6..3734faf 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -347,20 +347,16 @@ static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 	}
 
 	/* HDMI must be enabled before LCDC configuration */
-	if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
+	if (board_cfg->display_on)
 		board_cfg->display_on(board_cfg->board_data, ch->info);
-		module_put(board_cfg->owner);
-	}
 }
 
 static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 {
 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
 
-	if (board_cfg->display_off && try_module_get(board_cfg->owner)) {
+	if (board_cfg->display_off)
 		board_cfg->display_off(board_cfg->board_data);
-		module_put(board_cfg->owner);
-	}
 
 	if (ch->tx_dev)
 		ch->tx_dev->ops->display_off(ch->tx_dev);
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 0ec59e1..b1b3e8d 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -147,9 +147,7 @@ struct sh_mobile_lcdc_sys_bus_ops {
 	unsigned long (*read_data)(void *handle);
 };
 
-struct module;
 struct sh_mobile_lcdc_board_cfg {
-	struct module *owner;
 	void *board_data;
 	int (*setup_sys)(void *board_data, void *sys_ops_handle,
 			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
-- 
1.7.3.4

