From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 14 Apr 2016 19:17:24 +0000
Subject: [PATCH v5 04/24] hwmon: pwm-fan: use pwm_get_args() where appropriate
Message-Id: <1460661464-11216-5-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Stephen Barber <smbarber@chromium.org>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger

The PWM framework has clarified the concept of reference PWM config
(the platform dependent config retrieved from the DT or the PWM
lookup table) and real PWM state.

Use pwm_get_args() when the PWM user wants to retrieve this reference
config and not the current state.

This is part of the rework allowing the PWM framework to support
hardware readout and expose real PWM state even when the PWM has
just been requested (before the user calls pwm_config/enable/disable()).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Kamil Debski <k.debski@samsung.com>
---
 drivers/hwmon/pwm-fan.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 3e23003..f9af393 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -40,15 +40,18 @@ struct pwm_fan_ctx {
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
+	struct pwm_args pargs;
 	unsigned long duty;
 	int ret = 0;
 
+	pwm_get_args(ctx->pwm, &pargs);
+
 	mutex_lock(&ctx->lock);
 	if (ctx->pwm_value = pwm)
 		goto exit_set_pwm_err;
 
-	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
+	duty = DIV_ROUND_UP(pwm * (pargs.period - 1), MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		goto exit_set_pwm_err;
 
@@ -215,6 +218,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
 	struct pwm_fan_ctx *ctx;
+	struct pwm_args pargs;
 	struct device *hwmon;
 	int duty_cycle;
 	int ret;
@@ -233,11 +237,19 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to the
+	 * atomic PWM API.
+	 */
+	pwm_apply_args(ctx->pwm);
+
 	/* Set duty cycle to maximum allowed */
-	duty_cycle = ctx->pwm->period - 1;
+	pwm_get_args(ctx->pwm, &pargs);
+
+	duty_cycle = pargs.period - 1;
 	ctx->pwm_value = MAX_PWM;
 
-	ret = pwm_config(ctx->pwm, duty_cycle, ctx->pwm->period);
+	ret = pwm_config(ctx->pwm, duty_cycle, pargs.period);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to configure PWM\n");
 		return ret;
@@ -303,14 +315,16 @@ static int pwm_fan_suspend(struct device *dev)
 static int pwm_fan_resume(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct pwm_args pargs;
 	unsigned long duty;
 	int ret;
 
 	if (ctx->pwm_value = 0)
 		return 0;
 
-	duty = DIV_ROUND_UP(ctx->pwm_value * (ctx->pwm->period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
+	pwm_get_args(ctx->pwm, &pargs);
+	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
+	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		return ret;
 	return pwm_enable(ctx->pwm);
-- 
2.5.0

