From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 09 Jul 2012 06:04:23 +0000
Subject: [PATCHv3] pwm_backlight: pass correct brightness to callback
Message-Id: <1341813863-18822-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFA6BCA.2040101@nvidia.com>
In-Reply-To: <4FFA6BCA.2040101@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>

pwm_backlight_update_status calls the notify() and notify_after()
callbacks before and after applying the new PWM settings. However, if
brightness levels are used, the brightness value will be changed from
the index into the levels array to the PWM duty cycle length before
being passed to notify_after(), which results in inconsistent behavior.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 057389d..be48517 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -54,14 +54,17 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		pwm_config(pb->pwm, 0, pb->period);
 		pwm_disable(pb->pwm);
 	} else {
+		int duty_cycle;
 		if (pb->levels) {
-			brightness = pb->levels[brightness];
+			duty_cycle = pb->levels[brightness];
 			max = pb->levels[max];
+		} else {
+			duty_cycle = brightness;
 		}
 
-		brightness = pb->lth_brightness +
-			(brightness * (pb->period - pb->lth_brightness) / max);
-		pwm_config(pb->pwm, brightness, pb->period);
+		duty_cycle = pb->lth_brightness +
+		     (duty_cycle * (pb->period - pb->lth_brightness) / max);
+		pwm_config(pb->pwm, duty_cycle, pb->period);
 		pwm_enable(pb->pwm);
 	}
 
-- 
1.7.11.1

