From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 07 Jun 2013 01:39:20 +0000
Subject: [PATCH] backlight: add CONFIG_PM_SLEEP to suspend/resume functions
Message-Id: <000201ce631f$d4ad0d50$7e0727f0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Shuah Khan' <shuah.kh@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, rafael.j.wysocki@intel.com, 'Arnd Bergmann' <arnd@arndb.de>, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/video/backlight/backlight.c:211:12: warning: 'backlight_suspend' defined but not used [-Wunused-function]
drivers/video/backlight/backlight.c:225:12: warning: 'backlight_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/backlight/backlight.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index cedbcbe..750807c 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -208,6 +208,7 @@ static ssize_t backlight_show_actual_brightness(struct device *dev,
 
 static struct class *backlight_class;
 
+#ifdef CONFIG_PM_SLEEP
 static int backlight_suspend(struct device *dev)
 {
 	struct backlight_device *bd = to_backlight_device(dev);
@@ -235,6 +236,7 @@ static int backlight_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(backlight_class_dev_pm_ops, backlight_suspend,
 			 backlight_resume);
-- 
1.7.10.4


