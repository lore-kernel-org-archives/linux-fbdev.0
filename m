From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 29 Apr 2014 15:28:59 +0000
Subject: [PATCH 3/3] pwm-backlight: Disable backlight on shutdown
Message-Id: <1398785339-8107-3-git-send-email-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>

From: Thierry Reding <treding@nvidia.com>

When a device is shut down, make sure to disable the backlight. If it
stays lit, it gives the impression that the device hasn't turned off.
Furthermore keeping the backlight on may consume power, which is not
what users expect when they shut down a device.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 994f424eb289..b85479b14971 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -368,6 +368,14 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void pwm_backlight_shutdown(struct platform_device *pdev)
+{
+	struct backlight_device *bl = platform_get_drvdata(pdev);
+	struct pwm_bl_data *pb = bl_get_data(bl);
+
+	pwm_backlight_power_off(pb);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int pwm_backlight_suspend(struct device *dev)
 {
@@ -413,6 +421,7 @@ static struct platform_driver pwm_backlight_driver = {
 	},
 	.probe		= pwm_backlight_probe,
 	.remove		= pwm_backlight_remove,
+	.shutdown	= pwm_backlight_shutdown,
 };
 
 module_platform_driver(pwm_backlight_driver);
-- 
1.9.2

