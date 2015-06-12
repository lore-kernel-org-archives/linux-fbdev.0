From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 12 Jun 2015 16:26:17 +0000
Subject: [PATCH] pwm-backlight: Avoid backlight flicker when probed from DT
Message-Id: <1434126377-22545-1-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

If the driver is probed from the device tree, and there is a phandle
property set on it, and the enable GPIO is already configured as output,
and the backlight is currently disabled, keep it disabled.
If all these conditions are met, assume there will be some other driver
that can enable the backlight at the appropriate time.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
I have seen the thread at https://lkml.org/lkml/2014/7/31/259, but I'm not
sure if it has come to a resolution. This is what I think could be useful
to keep the current default behaviour of enabling the backlight while at the
same time allowing to keep it disabled if we are absolutely certain that the
backlight is currently off, and we think there is some other driver that will
control it:
---
 drivers/video/backlight/pwm_bl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 6897f1c..dcb6bfb 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -199,6 +199,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct pwm_bl_data *pb;
+	int initial_blank = FB_BLANK_UNBLANK;
 	int ret;
 
 	if (!data) {
@@ -263,8 +264,21 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
 	}
 
-	if (pb->enable_gpio)
-		gpiod_direction_output(pb->enable_gpio, 1);
+	if (pb->enable_gpio) {
+		/*
+		 * If the driver is probed from the device tree and there is a
+		 * phandle link pointing to the backlight node, it is safe to
+		 * assume that another driver will enable the backlight at the
+		 * appropriate time. Therefore, if it is disabled, keep it so.
+		 */
+		if (of_find_property(pdev->dev.of_node, "phandle", NULL) &&
+		    gpiod_get_direction(pb->enable_gpio) = GPIOF_DIR_OUT &&
+		    gpiod_get_value(pb->enable_gpio) = 0) {
+			initial_blank = FB_BLANK_POWERDOWN;
+		} else {
+			gpiod_direction_output(pb->enable_gpio, 1);
+		}
+	}
 
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
@@ -323,6 +337,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	bl->props.brightness = data->dft_brightness;
+	bl->props.power = initial_blank;
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.1.4

