From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 22 Oct 2018 08:11:09 +0000
Subject: [PATCH v2] backlight: gpio-backlight: Correct initial power state handling
Message-Id: <20181022081109.21456-1-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, jingoohan1@gmail.com, daniel.thompson@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The default-on property - or the def_value via legacy pdata) should be
handled as:
if it is 1, the backlight must be enabled (kept enabled)
if it is 0, the backlight must be disabled (kept disabled)

This only works for the case when default-on is set. If it is not set then
the brightness of the backlight is set to 0. Now if the backlight is
enabled by external driver (graphics) the backlight will stay disabled since
the brightness is configured as 0. The backlight will not turn on.

In order to minimize screen flickering during device boot:

The initial brightness should be set to 1.

If booted in non DT mode or no phandle link to the backlight node:
follow the def_value/default-on to select UNBLANK or POWERDOWN

If in DT boot we have phandle link then leave the GPIO in a state which the
bootloader left it and let the user of the backlight to configure it
further.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- Implement similiar initial power state handling as pwm backlight have

Regards,
Peter

 drivers/video/backlight/gpio_backlight.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..51c49f03ed83 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -62,13 +62,11 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	enum gpiod_flags flags;
 	int ret;
 
 	gbl->def_value = of_property_read_bool(np, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
-	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
+	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
 	if (IS_ERR(gbl->gpiod)) {
 		ret = PTR_ERR(gbl->gpiod);
 
@@ -82,6 +80,22 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
+{
+	struct device_node *node = gbl->dev->of_node;
+
+	/* Not booted with device tree or no phandle link to the node */
+	if (!node || !node->phandle)
+		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+
+	/* if the enable GPIO is disabled, do not enable the backlight */
+	if (gpiod_get_value_cansleep(gbl->gpiod) = 0)
+		return FB_BLANK_POWERDOWN;
+
+	return FB_BLANK_UNBLANK;
+}
+
+
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct gpio_backlight_platform_data *pdata @@ -142,7 +156,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.power = gpio_backlight_initial_power_state(gbl);
+	bl->props.brightness = 1;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
