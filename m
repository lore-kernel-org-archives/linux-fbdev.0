From: dilee@nvidia.com
Date: Mon, 08 Aug 2011 10:37:55 +0000
Subject: [PATCH] video: Added a callback 'notify_after' for backlight control
Message-Id: <1312799875-18629-1-git-send-email-dilee@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, arun.murthy-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, rmorell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
Cc: jnien-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dilan Lee <dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

From: Dilan Lee <dilee@nvidia.com>

We need a callback to do some things after pwm_enable,pwm_disable
and pwm_config.

For example, GPIO backlight_en has to be rised after pwm has been enabled
to meet panel power on sequence defined in panel specification.

Signed-off-by: Dilan Lee <dilee@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c |    9 +++++++++
 include/linux/pwm_backlight.h    |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b8f38ec..d9a16e5 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -28,6 +28,8 @@ struct pwm_bl_data {
 	unsigned int		lth_brightness;
 	int			(*notify)(struct device *,
 					  int brightness);
+	void		(*notify_after)(struct device *,
+					  int brightness);
 	int			(*check_fb)(struct device *, struct fb_info *);
 };
 
@@ -55,6 +57,10 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		pwm_config(pb->pwm, brightness, pb->period);
 		pwm_enable(pb->pwm);
 	}
+
+	if (pb->notify_after)
+		pb->notify_after(pb->dev, brightness);
+
 	return 0;
 }
 
@@ -105,6 +111,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->period = data->pwm_period_ns;
 	pb->notify = data->notify;
+	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
 	pb->lth_brightness = data->lth_brightness *
 		(data->pwm_period_ns / data->max_brightness);
@@ -172,6 +179,8 @@ static int pwm_backlight_suspend(struct platform_device *pdev,
 		pb->notify(pb->dev, 0);
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
+	if (pb->notify_after)
+		pb->notify_after(pb->dev, 0);
 	return 0;
 }
 
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index 5e3e25a..63d2df4 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -14,6 +14,7 @@ struct platform_pwm_backlight_data {
 	unsigned int pwm_period_ns;
 	int (*init)(struct device *dev);
 	int (*notify)(struct device *dev, int brightness);
+	void (*notify_after)(struct device *dev, int brightness);
 	void (*exit)(struct device *dev);
 	int (*check_fb)(struct device *dev, struct fb_info *info);
 };
-- 
1.7.5.4

