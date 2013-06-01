From: Shuah Khan <shuah.kh@samsung.com>
Date: Sat, 01 Jun 2013 03:33:47 +0000
Subject: [PATCH] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <2236503749-2998-1-git-send-email-shuah.kh@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rpurdie@rpsys.net, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, rafael.j.wysocki@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

Convert drivers/video/backlight/class to use dev_pm_ops for power
management and remove Legacy PM ops hooks. With this change, rtc class
registers suspend/resume callbacks via class->pm (dev_pm_ops) instead of
Legacy class->suspend/resume. When __device_suspend() runs call-backs,
it will find class->pm ops for the rtc class.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
Cc: Shuah Khan <shuahkhan@gmail.com>
---
 drivers/video/backlight/backlight.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index c74e7aa..0ffb251 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -208,7 +208,7 @@ static ssize_t backlight_show_actual_brightness(struct device *dev,
 
 static struct class *backlight_class;
 
-static int backlight_suspend(struct device *dev, pm_message_t state)
+static int backlight_suspend(struct device *dev)
 {
 	struct backlight_device *bd = to_backlight_device(dev);
 
@@ -236,6 +236,9 @@ static int backlight_resume(struct device *dev)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(backlight_class_dev_pm_ops, backlight_suspend,
+			 backlight_resume);
+
 static void bl_device_release(struct device *dev)
 {
 	struct backlight_device *bd = to_backlight_device(dev);
@@ -414,8 +417,7 @@ static int __init backlight_class_init(void)
 	}
 
 	backlight_class->dev_attrs = bl_device_attributes;
-	backlight_class->suspend = backlight_suspend;
-	backlight_class->resume = backlight_resume;
+	backlight_class->pm = &backlight_class_dev_pm_ops;
 	return 0;
 }
 
-- 
1.7.10.4

