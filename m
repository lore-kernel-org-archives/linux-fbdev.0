From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 16 May 2015 14:08:10 +0000
Subject: [PATCH] backlight: pwm_bl: Simplify usage of devm_gpiod_get_optional
Message-Id: <1431785290.6638.1.camel@ingics.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions),
the gpiod_get* functions take an additional parameter that allows to
specify direction and initial value for output.
Simplify the usage of devm_gpiod_get_optional accordingly.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/video/backlight/pwm_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3a145a6..57cb9ec 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -241,7 +241,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
 
-	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
+	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						  GPIOD_OUT_HIGH);
 	if (IS_ERR(pb->enable_gpio)) {
 		ret = PTR_ERR(pb->enable_gpio);
 		goto err_alloc;
@@ -263,9 +264,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
 	}
 
-	if (pb->enable_gpio)
-		gpiod_direction_output(pb->enable_gpio, 1);
-
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
 		ret = PTR_ERR(pb->power_supply);
-- 
2.1.0



