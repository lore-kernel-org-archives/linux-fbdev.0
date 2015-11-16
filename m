From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:36 +0000
Subject: [PATCH v4 13/24] hwmon: pwm-fan: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <1447664207-24370-14-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pwm_set/get_default_xxx() helpers have been introduced to differentiate
the default PWM states (those retrieved through DT, PWM lookup table or
statically assigned by the driver) and the current ones.
Make use of those helpers where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/hwmon/pwm-fan.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 105b964..989d7b4 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -47,8 +47,9 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	if (ctx->pwm_value = pwm)
 		goto exit_set_pwm_err;
 
-	duty = DIV_ROUND_UP(pwm * (pwm_get_period((ctx->pwm)) - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
+	duty = DIV_ROUND_UP(pwm * (pwm_get_default_period((ctx->pwm)) - 1),
+			    MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pwm_get_default_period((ctx->pwm)));
 	if (ret)
 		goto exit_set_pwm_err;
 
@@ -234,10 +235,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	/* Set duty cycle to maximum allowed */
-	duty_cycle = pwm_get_period((ctx->pwm)) - 1;
+	duty_cycle = pwm_get_default_period((ctx->pwm)) - 1;
 	ctx->pwm_value = MAX_PWM;
 
-	ret = pwm_config(ctx->pwm, duty_cycle, pwm_get_period((ctx->pwm)));
+	ret = pwm_config(ctx->pwm, duty_cycle,
+			 pwm_get_default_period((ctx->pwm)));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to configure PWM\n");
 		return ret;
@@ -309,9 +311,10 @@ static int pwm_fan_resume(struct device *dev)
 	if (ctx->pwm_value = 0)
 		return 0;
 
-	duty = DIV_ROUND_UP(ctx->pwm_value * (pwm_get_period((ctx->pwm)) - 1),
+	duty = DIV_ROUND_UP(ctx->pwm_value *
+			    (pwm_get_default_period((ctx->pwm)) - 1),
 			    MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
+	ret = pwm_config(ctx->pwm, duty, pwm_get_default_period((ctx->pwm)));
 	if (ret)
 		return ret;
 	return pwm_enable(ctx->pwm);
-- 
2.1.4

