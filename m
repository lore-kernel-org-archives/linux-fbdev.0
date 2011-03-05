From: Robert Morell <rmorell@nvidia.com>
Date: Sat, 05 Mar 2011 01:08:59 +0000
Subject: [PATCH] video: pwm_backlight: Add check_fb hook
Message-Id: <1299287339-11494-1-git-send-email-rmorell@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Arun Murthy <arun.murthy@stericsson.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Morell <rmorell@nvidia.com>

In systems with multiple framebuffer devices, one of the devices might
be blanked while another is unblanked.  In order for the backlight
blanking logic to know whether to turn off the backlight for a
particular framebuffer's blanking notification, it needs to be able to
check if a given framebuffer device corresponds to the backlight.

This plumbs the check_fb hook from core backlight through the
pwm_backlight helper to allow platform code to plug in a check_fb hook.

Signed-off-by: Robert Morell <rmorell@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c |   11 +++++++++++
 include/linux/pwm_backlight.h    |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 21866ec..0f2c131 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -28,6 +28,7 @@ struct pwm_bl_data {
 	unsigned int		lth_brightness;
 	int			(*notify)(struct device *,
 					  int brightness);
+	int			(*check_fb)(struct device *, struct fb_info *);
 };
 
 static int pwm_backlight_update_status(struct backlight_device *bl)
@@ -62,9 +63,18 @@ static int pwm_backlight_get_brightness(struct backlight_device *bl)
 	return bl->props.brightness;
 }
 
+static int pwm_backlight_check_fb(struct backlight_device *bl,
+				  struct fb_info *info)
+{
+	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
+
+	return !pb->check_fb || pb->check_fb(pb->dev, info);
+}
+
 static const struct backlight_ops pwm_backlight_ops = {
 	.update_status	= pwm_backlight_update_status,
 	.get_brightness	= pwm_backlight_get_brightness,
+	.check_fb	= pwm_backlight_check_fb,
 };
 
 static int pwm_backlight_probe(struct platform_device *pdev)
@@ -95,6 +105,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->period = data->pwm_period_ns;
 	pb->notify = data->notify;
+	pb->check_fb = data->check_fb;
 	pb->lth_brightness = data->lth_brightness *
 		(data->pwm_period_ns / data->max_brightness);
 	pb->dev = &pdev->dev;
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index e031e1a..5e3e25a 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -4,6 +4,8 @@
 #ifndef __LINUX_PWM_BACKLIGHT_H
 #define __LINUX_PWM_BACKLIGHT_H
 
+#include <linux/backlight.h>
+
 struct platform_pwm_backlight_data {
 	int pwm_id;
 	unsigned int max_brightness;
@@ -13,6 +15,7 @@ struct platform_pwm_backlight_data {
 	int (*init)(struct device *dev);
 	int (*notify)(struct device *dev, int brightness);
 	void (*exit)(struct device *dev);
+	int (*check_fb)(struct device *dev, struct fb_info *info);
 };
 
 #endif
-- 
1.7.3.4

