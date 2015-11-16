From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:40 +0000
Subject: [PATCH v4 17/24] backlight: pwm_bl: remove useless call to pwm_set_period
Message-Id: <1447664207-24370-18-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The PWM period will be set when calling pwm_config. Remove this useless
call to pwm_set_period, which might mess up with the initial PWM state
once we have added proper support for PWM init state retrieval.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 54d5a03..5ff2976 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -292,12 +292,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * period, parsed from the DT, in the PWM device. For the non-DT case,
 	 * set the period from platform data if it has not already been set
 	 * via the PWM lookup table.
+	 * FIXME: This assignment should be dropped as soon as all the boards
+	 * have moved to the PWM lookup table approach. The same goes for the
+	 * pb->period field which should be replaced by
+	 * pwm_get_default_period() calls.
 	 */
 	pb->period = pwm_get_default_period(pb->pwm);
-	if (!pb->period && (data->pwm_period_ns > 0)) {
+	if (!pb->period && (data->pwm_period_ns > 0))
 		pb->period = data->pwm_period_ns;
-		pwm_set_period(pb->pwm, data->pwm_period_ns);
-	}
 
 	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
 
-- 
2.1.4

