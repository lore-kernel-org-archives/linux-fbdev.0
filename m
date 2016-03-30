From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 30 Mar 2016 20:03:53 +0000
Subject: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
Message-Id: <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The continuous PWM voltage regulator is caching the voltage value in
the ->volt_uV field. While most of the time this value should reflect the
real voltage, sometime it can be sightly different if the PWM device
rounded the set_duty_cycle request.
Moreover, this value is not valid until someone has modified the regulator
output.

Remove the ->volt_uV field and always rely on the PWM state to calculate
the regulator output.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/regulator/pwm-regulator.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 9374796..77f42d8 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -35,9 +35,6 @@ struct pwm_regulator_data {
 	struct regulator_ops ops;
 
 	int state;
-
-	/* Continuous voltage */
-	int volt_uV;
 };
 
 struct pwm_voltages {
@@ -167,11 +164,27 @@ static int pwm_voltage_to_duty_cycle_percentage(struct regulator_dev *rdev, int
 	return ((req_uV * 100) - (min_uV * 100)) / diff;
 }
 
+static int pwm_duty_cycle_percentage_to_voltage(struct regulator_dev *rdev,
+						int dutycycle)
+{
+	int min_uV = rdev->constraints->min_uV;
+	int max_uV = rdev->constraints->max_uV;
+	int diff = max_uV - min_uV;
+
+	return min_uV + ((diff * dutycycle) / 100);
+}
+
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	struct pwm_state pstate;
+	u64 dutycycle;
 
-	return drvdata->volt_uV;
+	pwm_get_state(drvdata->pwm, &pstate);
+	dutycycle = pstate.duty_cycle * 100;
+	do_div(dutycycle, pstate.period);
+
+	return pwm_duty_cycle_percentage_to_voltage(rdev, dutycycle);
 }
 
 static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
@@ -196,8 +209,6 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 		return ret;
 	}
 
-	drvdata->volt_uV = min_uV;
-
 	/* Delay required by PWM regulator to settle to the new voltage */
 	usleep_range(ramp_delay, ramp_delay + 1000);
 
-- 
2.5.0

