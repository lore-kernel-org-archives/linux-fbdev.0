From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 01 Jul 2015 08:22:01 +0000
Subject: [RFC PATCH 15/15] regulator: pwm: properly initialize the ->state field
Message-Id: <1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The ->state field is currently initialized to 0, thus referencing the
voltage selector at index 0, which might not reflect the current voltage
value.
If possible, retrieve the current voltage selector from the PWM state, else
return -EINVAL.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/regulator/pwm-regulator.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 8159518..4e29717 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -31,10 +31,35 @@ struct pwm_voltages {
 	unsigned int dutycycle;
 };
 
+static void pwm_regulator_init_state(struct regulator_dev *rdev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	struct pwm_state pwm_state;
+	unsigned int dutycycle;
+	int i;
+
+	pwm_get_state(drvdata->pwm, &pwm_state);
+
+	if (!pwm_state.period)
+		return;
+
+	dutycycle = (pwm_state.duty_cycle * 100) / pwm_state.period;
+
+	for (i = 0; i < rdev->desc->n_voltages; i++) {
+		if (dutycycle = drvdata->duty_cycle_table[i].dutycycle) {
+			drvdata->state = i;
+			return;
+		}
+	}
+}
+
 static int pwm_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 
+	if (drvdata->state < 0)
+		pwm_regulator_init_state(rdev);
+
 	return drvdata->state;
 }
 
@@ -170,6 +195,7 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	config.of_node = np;
 	config.dev = &pdev->dev;
 	config.driver_data = drvdata;
+	drvdata->state = -EINVAL;
 
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
-- 
1.9.1

