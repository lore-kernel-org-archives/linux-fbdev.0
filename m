From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 19 May 2014 20:42:42 +0000
Subject: [PATCHv2 resend 11/11] backlight: pwm_bl: retrieve configured pwm period
Message-Id: <1400532162-29483-12-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The PWM core is now able to initialize the PWM period from platform_data. Use it
and if it is not configured, use the supplied pwm_period_ns.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b75201ff46f6..1bb8a69062c5 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -304,12 +304,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	/*
 	 * The DT case will set the pwm_period_ns field to 0 and store the
 	 * period, parsed from the DT, in the PWM device. For the non-DT case,
-	 * set the period from platform data.
+	 * set the period from platform data if it is not already set.
 	 */
-	if (data->pwm_period_ns > 0)
+	pb->period = pwm_get_period(pb->pwm);
+	if (!pb->period && (data->pwm_period_ns > 0)) {
+		pb->period = data->pwm_period_ns;
 		pwm_set_period(pb->pwm, data->pwm_period_ns);
+	}
 
-	pb->period = pwm_get_period(pb->pwm);
 	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
 
 	memset(&props, 0, sizeof(struct backlight_properties));
-- 
1.9.1

