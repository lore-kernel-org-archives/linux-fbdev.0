From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:47 +0000
Subject: [PATCH v4 24/24] regulator: pwm: properly initialize the ->state field
Message-Id: <1447664207-24370-25-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 9ffdbd6..449e3b3 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -41,10 +41,35 @@ struct pwm_voltages {
 /**
  * Voltage table call-backs
  */
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
 
@@ -211,6 +236,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 		return ret;
 	}
 
+	drvdata->state			= -EINVAL;
 	drvdata->duty_cycle_table	= duty_cycle_table;
 	pwm_regulator_desc.ops		= &pwm_regulator_voltage_table_ops;
 	pwm_regulator_desc.n_voltages	= length / sizeof(*duty_cycle_table);
-- 
2.1.4

