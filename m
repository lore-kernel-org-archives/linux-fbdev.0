From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:01:57 +0000
Subject: [PATCH 02/57] fbdev: sh_mobile_lcdc: Mark init-only symbols with __devinit(const)
Message-Id: <1323784972-24205-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

default_720p and sh_mobile_lcdc_check_interface are used at device
initialization time only. Mark them as __devinitconst and __devinit
respectively.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 8b18360..a6bf4fb 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1459,7 +1459,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
  * Probe/remove and driver init/exit
  */
 
-static const struct fb_videomode default_720p = {
+static const struct fb_videomode default_720p __devinitconst = {
 	.name = "HDMI 720p",
 	.xres = 1280,
 	.yres = 720,
@@ -1528,7 +1528,8 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
+static int __devinit
+sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
 {
 	int interface_type = ch->cfg.interface_type;
 
-- 
1.7.3.4

