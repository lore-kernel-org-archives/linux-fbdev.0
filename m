From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 16:33:40 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: remove runtime PM calls from the
Message-Id: <Pine.LNX.4.64.1105051832380.29735@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The notifier function calls sh_mobile_lcdc_stop() and
sh_mobile_lcdc_start(), which already take care about the runtime PM
state. Remove redundant calls.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 466834c..04f2260 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1288,7 +1288,6 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	struct fb_info *info = event->info;
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
-	int ret;
 
 	if (&ch->lcdc->notifier != nb)
 		return NOTIFY_DONE;
@@ -1302,7 +1301,6 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 			board_cfg->display_off(board_cfg->board_data);
 			module_put(board_cfg->owner);
 		}
-		pm_runtime_put(info->device);
 		sh_mobile_lcdc_stop(ch->lcdc);
 		break;
 	case FB_EVENT_RESUME:
@@ -1316,9 +1314,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 			module_put(board_cfg->owner);
 		}
 
-		ret = sh_mobile_lcdc_start(ch->lcdc);
-		if (!ret)
-			pm_runtime_get_sync(info->device);
+		sh_mobile_lcdc_start(ch->lcdc);
 	}
 
 	return NOTIFY_OK;
-- 
1.7.2.5

