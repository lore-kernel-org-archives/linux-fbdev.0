From: Rob Clark <robdclark@gmail.com>
Date: Tue, 21 Jul 2015 18:22:06 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Move PM8941 WLED driver to backlight
Message-Id: <CAF6AEGv401WG_yynK6aRRRHynPu79i+U_uJb3mB+JvK200f3Pw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Wed, Jul 15, 2015 at 4:02 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> The Qualcomm PM8941 WLED block is used for backlight and should therefor
> be in the backlight framework and not in the LED framework. This moves
> the driver and adapts to the backlight api instead.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Tested-by: Rob Clark <robdclark@gmail.com>

(also on a z3, with work-in-progress panel driver for the AUO panel + drm/msm)

BR,
-R

> ---
>  .../devicetree/bindings/leds/leds-pm8941-wled.txt  |  5 +-
>  drivers/leds/Kconfig                               |  8 ---
>  drivers/leds/Makefile                              |  1 -
>  drivers/video/backlight/Kconfig                    |  8 +++
>  drivers/video/backlight/Makefile                   |  1 +
>  .../backlight/pm8941-wled.c}                       | 59 ++++++++++------------
>  6 files changed, 36 insertions(+), 46 deletions(-)
>  rename drivers/{leds/leds-pm8941-wled.c => video/backlight/pm8941-wled.c} (90%)
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt b/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> index a85a964d61f5..424f8444a6cd 100644
> --- a/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> @@ -5,10 +5,7 @@ Required properties:
>  - reg: slave address
>
>  Optional properties:
> -- label: The label for this led
> -  See Documentation/devicetree/bindings/leds/common.txt
> -- linux,default-trigger: Default trigger assigned to the LED
> -  See Documentation/devicetree/bindings/leds/common.txt
> +- label: The name of the backlight device
>  - qcom,cs-out: bool; enable current sink output
>  - qcom,cabc: bool; enable content adaptive backlight control
>  - qcom,ext-gen: bool; use externally generated modulator signal to dim
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9ad35f72ab4c..b8d4b965ca2a 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -578,14 +578,6 @@ config LEDS_VERSATILE
>           This option enabled support for the LEDs on the ARM Versatile
>           and RealView boards. Say Y to enabled these.
>
> -config LEDS_PM8941_WLED
> -       tristate "LED support for the Qualcomm PM8941 WLED block"
> -       depends on LEDS_CLASS
> -       select REGMAP
> -       help
> -         This option enables support for the 'White' LED block
> -         on Qualcomm PM8941 PMICs.
> -
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
>
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 8d6a24a2f513..abe96d960ebe 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -63,7 +63,6 @@ obj-$(CONFIG_LEDS_BLINKM)             += leds-blinkm.o
>  obj-$(CONFIG_LEDS_SYSCON)              += leds-syscon.o
>  obj-$(CONFIG_LEDS_VERSATILE)           += leds-versatile.o
>  obj-$(CONFIG_LEDS_MENF21BMC)           += leds-menf21bmc.o
> -obj-$(CONFIG_LEDS_PM8941_WLED)         += leds-pm8941-wled.o
>  obj-$(CONFIG_LEDS_KTD2692)             += leds-ktd2692.o
>
>  # LED SPI Drivers
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 0505b796d743..6c67c5430933 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -299,6 +299,14 @@ config BACKLIGHT_TOSA
>           If you have an Sharp SL-6000 Zaurus say Y to enable a driver
>           for its backlight
>
> +config BACKLIGHT_PM8941_WLED
> +       tristate "Qualcomm PM8941 WLED Driver"
> +       depends on LEDS_CLASS
> +       select REGMAP
> +       help
> +         If you have the Qualcomm PM8941, say Y to enable a driver for the
> +         WLED block.
> +
>  config BACKLIGHT_SAHARA
>         tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
>         depends on X86
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index d67073f9d421..16ec534cff30 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)         += omap1_bl.o
>  obj-$(CONFIG_BACKLIGHT_OT200)          += ot200_bl.o
>  obj-$(CONFIG_BACKLIGHT_PANDORA)                += pandora_bl.o
>  obj-$(CONFIG_BACKLIGHT_PCF50633)       += pcf50633-backlight.o
> +obj-$(CONFIG_BACKLIGHT_PM8941_WLED)    += pm8941-wled.o
>  obj-$(CONFIG_BACKLIGHT_PWM)            += pwm_bl.o
>  obj-$(CONFIG_BACKLIGHT_SAHARA)         += kb3886_bl.o
>  obj-$(CONFIG_BACKLIGHT_SKY81452)       += sky81452-backlight.o
> diff --git a/drivers/leds/leds-pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
> similarity index 90%
> rename from drivers/leds/leds-pm8941-wled.c
> rename to drivers/video/backlight/pm8941-wled.c
> index bf64a593fbf1..4f5ae95331a1 100644
> --- a/drivers/leds/leds-pm8941-wled.c
> +++ b/drivers/video/backlight/pm8941-wled.c
> @@ -11,7 +11,7 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/leds.h>
> +#include <linux/backlight.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -76,30 +76,29 @@ struct pm8941_wled_config {
>  };
>
>  struct pm8941_wled {
> +       const char *name;
>         struct regmap *regmap;
>         u16 addr;
>
> -       struct led_classdev cdev;
> -
>         struct pm8941_wled_config cfg;
>  };
>
> -static int pm8941_wled_set(struct led_classdev *cdev,
> -                          enum led_brightness value)
> +static int pm8941_wled_update_status(struct backlight_device *bl)
>  {
> -       struct pm8941_wled *wled;
> +       struct pm8941_wled *wled = bl_get_data(bl);
> +       u16 val = bl->props.brightness;
>         u8 ctrl = 0;
> -       u16 val;
>         int rc;
>         int i;
>
> -       wled = container_of(cdev, struct pm8941_wled, cdev);
> +       if (bl->props.power != FB_BLANK_UNBLANK ||
> +           bl->props.fb_blank != FB_BLANK_UNBLANK ||
> +           bl->props.state & BL_CORE_FBBLANK)
> +               val = 0;
>
> -       if (value != 0)
> +       if (val != 0)
>                 ctrl = PM8941_WLED_REG_MOD_EN_BIT;
>
> -       val = value * PM8941_WLED_REG_VAL_MAX / LED_FULL;
> -
>         rc = regmap_update_bits(wled->regmap,
>                         wled->addr + PM8941_WLED_REG_MOD_EN,
>                         PM8941_WLED_REG_MOD_EN_MASK, ctrl);
> @@ -128,16 +127,6 @@ static int pm8941_wled_set(struct led_classdev *cdev,
>         return rc;
>  }
>
> -static void pm8941_wled_set_brightness(struct led_classdev *cdev,
> -                                      enum led_brightness value)
> -{
> -       if (pm8941_wled_set(cdev, value)) {
> -               dev_err(cdev->dev, "Unable to set brightness\n");
> -               return;
> -       }
> -       cdev->brightness = value;
> -}
> -
>  static int pm8941_wled_setup(struct pm8941_wled *wled)
>  {
>         int rc;
> @@ -336,12 +325,9 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
>         }
>         wled->addr = val;
>
> -       rc = of_property_read_string(dev->of_node, "label", &wled->cdev.name);
> +       rc = of_property_read_string(dev->of_node, "label", &wled->name);
>         if (rc)
> -               wled->cdev.name = dev->of_node->name;
> -
> -       wled->cdev.default_trigger = of_get_property(dev->of_node,
> -                       "linux,default-trigger", NULL);
> +               wled->name = dev->of_node->name;
>
>         *cfg = pm8941_wled_config_defaults;
>         for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
> @@ -377,8 +363,14 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
>         return 0;
>  }
>
> +static const struct backlight_ops pm8941_wled_ops = {
> +       .update_status = pm8941_wled_update_status,
> +};
> +
>  static int pm8941_wled_probe(struct platform_device *pdev)
>  {
> +       struct backlight_properties props;
> +       struct backlight_device *bl;
>         struct pm8941_wled *wled;
>         struct regmap *regmap;
>         int rc;
> @@ -403,13 +395,14 @@ static int pm8941_wled_probe(struct platform_device *pdev)
>         if (rc)
>                 return rc;
>
> -       wled->cdev.brightness_set = pm8941_wled_set_brightness;
> -
> -       rc = devm_led_classdev_register(&pdev->dev, &wled->cdev);
> -       if (rc)
> -               return rc;
> -
> -       platform_set_drvdata(pdev, wled);
> +       memset(&props, 0, sizeof(struct backlight_properties));
> +       props.type = BACKLIGHT_RAW;
> +       props.max_brightness = PM8941_WLED_REG_VAL_MAX;
> +       bl = devm_backlight_device_register(&pdev->dev, wled->name,
> +                                           &pdev->dev, wled,
> +                                           &pm8941_wled_ops, &props);
> +       if (IS_ERR(bl))
> +               return PTR_ERR(bl);
>
>         return 0;
>  };
> --
> 1.8.2.2
>
