From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 31 Aug 2011 11:00:54 +0000
Subject: [PATCH v2 3/8] fbdev: sh_mobile_lcdc: Add support for format changes at runtime
Message-Id: <1314788459-31791-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Implement .fb_set_par to support frame buffer format changes at runtime.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 33b0ff8..f9f420d 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1154,6 +1154,19 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 	return 0;
 }
 
+static int sh_mobile_set_par(struct fb_info *info)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	int ret;
+
+	sh_mobile_lcdc_stop(ch->lcdc);
+	ret = sh_mobile_lcdc_start(ch->lcdc);
+	if (ret < 0)
+		dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
+
+	return ret;
+}
+
 /*
  * Screen blanking. Behavior is as follows:
  * FB_BLANK_UNBLANK: screen unblanked, clocks enabled
@@ -1211,6 +1224,7 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_open	= sh_mobile_open,
 	.fb_release	= sh_mobile_release,
 	.fb_check_var	= sh_mobile_check_var,
+	.fb_set_par	= sh_mobile_set_par,
 };
 
 static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
-- 
1.7.3.4

