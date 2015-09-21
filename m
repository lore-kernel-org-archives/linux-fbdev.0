From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 21 Sep 2015 09:33:28 +0000
Subject: [PATCH v3 11/12] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Message-Id: <1442828009-6241-12-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Implement the ->enable(), ->disable() and ->is_enabled methods and remove
the PWM call in ->set_voltage_sel().
This is particularly important for critical regulators tagged as always-on,
because not claiming the PWM (and its dependencies) might lead to
unpredictable behavior (like a system hang because the PWM clk is only
claimed when the PWM device is enabled).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/regulator/pwm-regulator.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index cc549b7..9ffdbd6 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -69,12 +69,6 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 
 	drvdata->state = selector;
 
-	ret = pwm_enable(drvdata->pwm);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to enable PWM\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -89,6 +83,29 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 	return drvdata->duty_cycle_table[selector].uV;
 }
 
+static int pwm_regulator_enable(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	return pwm_enable(drvdata->pwm);
+}
+
+static int pwm_regulator_disable(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	pwm_disable(drvdata->pwm);
+
+	return 0;
+}
+
+static int pwm_regulator_is_enabled(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	return pwm_is_enabled(drvdata->pwm);
+}
+
 /**
  * Continuous voltage call-backs
  */
@@ -144,11 +161,17 @@ static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
 	.map_voltage     = regulator_map_voltage_iterate,
+	.enable          = pwm_regulator_enable,
+	.disable         = pwm_regulator_disable,
+	.is_enabled      = pwm_regulator_is_enabled,
 };
 
 static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
 	.get_voltage = pwm_regulator_get_voltage,
 	.set_voltage = pwm_regulator_set_voltage,
+	.enable          = pwm_regulator_enable,
+	.disable         = pwm_regulator_disable,
+	.is_enabled      = pwm_regulator_is_enabled,
 };
 
 static struct regulator_desc pwm_regulator_desc = {
-- 
1.9.1

