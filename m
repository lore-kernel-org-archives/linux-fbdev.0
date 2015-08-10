From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 10 Aug 2015 15:53:22 +0000
Subject: Re: [PATCH v2] backlight: pm8941-wled: Move PM8941 WLED driver to backlight
Message-Id: <20150810155322.GD12631@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1437525889-24928-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1437525889-24928-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Tue, 21 Jul 2015, Bjorn Andersson wrote:

> The Qualcomm PM8941 WLED block is used for backlight and should therefor
> be in the backlight framework and not in the LED framework. This moves
> the driver and adapts to the backlight api instead.
>=20
> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Tested-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  .../backlight/pm8941-wled.txt}                     |  5 +-
>  drivers/leds/Kconfig                               |  8 ---
>  drivers/leds/Makefile                              |  1 -
>  drivers/video/backlight/Kconfig                    |  7 +++
>  drivers/video/backlight/Makefile                   |  1 +
>  .../backlight/pm8941-wled.c}                       | 60 ++++++++++------=
------
>  6 files changed, 35 insertions(+), 47 deletions(-)
>  rename Documentation/devicetree/bindings/{leds/leds-pm8941-wled.txt =3D>=
 video/backlight/pm8941-wled.txt} (84%)
>  rename drivers/{leds/leds-pm8941-wled.c =3D> video/backlight/pm8941-wled=
.c} (90%)

Applied with Jingoo's Ack, thanks.

> diff --git a/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt =
b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> similarity index 84%
> rename from Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> rename to Documentation/devicetree/bindings/video/backlight/pm8941-wled.t=
xt
> index a85a964d61f5..424f8444a6cd 100644
> --- a/Documentation/devicetree/bindings/leds/leds-pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> @@ -5,10 +5,7 @@ Required properties:
>  - reg: slave address
> =20
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
>  	  This option enabled support for the LEDs on the ARM Versatile
>  	  and RealView boards. Say Y to enabled these.
> =20
> -config LEDS_PM8941_WLED
> -	tristate "LED support for the Qualcomm PM8941 WLED block"
> -	depends on LEDS_CLASS
> -	select REGMAP
> -	help
> -	  This option enables support for the 'White' LED block
> -	  on Qualcomm PM8941 PMICs.
> -
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
> =20
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 8d6a24a2f513..abe96d960ebe 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -63,7 +63,6 @@ obj-$(CONFIG_LEDS_BLINKM)		+=3D leds-blinkm.o
>  obj-$(CONFIG_LEDS_SYSCON)		+=3D leds-syscon.o
>  obj-$(CONFIG_LEDS_VERSATILE)		+=3D leds-versatile.o
>  obj-$(CONFIG_LEDS_MENF21BMC)		+=3D leds-menf21bmc.o
> -obj-$(CONFIG_LEDS_PM8941_WLED)		+=3D leds-pm8941-wled.o
>  obj-$(CONFIG_LEDS_KTD2692)		+=3D leds-ktd2692.o
> =20
>  # LED SPI Drivers
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 0505b796d743..5ffa4b4e26c0 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -299,6 +299,13 @@ config BACKLIGHT_TOSA
>  	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
>  	  for its backlight
> =20
> +config BACKLIGHT_PM8941_WLED
> +	tristate "Qualcomm PM8941 WLED Driver"
> +	select REGMAP
> +	help
> +	  If you have the Qualcomm PM8941, say Y to enable a driver for the
> +	  WLED block.
> +
>  config BACKLIGHT_SAHARA
>  	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
>  	depends on X86
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index d67073f9d421..16ec534cff30 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+=3D omap1_bl.o
>  obj-$(CONFIG_BACKLIGHT_OT200)		+=3D ot200_bl.o
>  obj-$(CONFIG_BACKLIGHT_PANDORA)		+=3D pandora_bl.o
>  obj-$(CONFIG_BACKLIGHT_PCF50633)	+=3D pcf50633-backlight.o
> +obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+=3D pm8941-wled.o
>  obj-$(CONFIG_BACKLIGHT_PWM)		+=3D pwm_bl.o
>  obj-$(CONFIG_BACKLIGHT_SAHARA)		+=3D kb3886_bl.o
>  obj-$(CONFIG_BACKLIGHT_SKY81452)	+=3D sky81452-backlight.o
> diff --git a/drivers/leds/leds-pm8941-wled.c b/drivers/video/backlight/pm=
8941-wled.c
> similarity index 90%
> rename from drivers/leds/leds-pm8941-wled.c
> rename to drivers/video/backlight/pm8941-wled.c
> index bf64a593fbf1..c704c3236034 100644
> --- a/drivers/leds/leds-pm8941-wled.c
> +++ b/drivers/video/backlight/pm8941-wled.c
> @@ -11,7 +11,7 @@
>   */
> =20
>  #include <linux/kernel.h>
> -#include <linux/leds.h>
> +#include <linux/backlight.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -76,30 +76,29 @@ struct pm8941_wled_config {
>  };
> =20
>  struct pm8941_wled {
> +	const char *name;
>  	struct regmap *regmap;
>  	u16 addr;
> =20
> -	struct led_classdev cdev;
> -
>  	struct pm8941_wled_config cfg;
>  };
> =20
> -static int pm8941_wled_set(struct led_classdev *cdev,
> -			   enum led_brightness value)
> +static int pm8941_wled_update_status(struct backlight_device *bl)
>  {
> -	struct pm8941_wled *wled;
> +	struct pm8941_wled *wled =3D bl_get_data(bl);
> +	u16 val =3D bl->props.brightness;
>  	u8 ctrl =3D 0;
> -	u16 val;
>  	int rc;
>  	int i;
> =20
> -	wled =3D container_of(cdev, struct pm8941_wled, cdev);
> +	if (bl->props.power !=3D FB_BLANK_UNBLANK ||
> +	    bl->props.fb_blank !=3D FB_BLANK_UNBLANK ||
> +	    bl->props.state & BL_CORE_FBBLANK)
> +		val =3D 0;
> =20
> -	if (value !=3D 0)
> +	if (val !=3D 0)
>  		ctrl =3D PM8941_WLED_REG_MOD_EN_BIT;
> =20
> -	val =3D value * PM8941_WLED_REG_VAL_MAX / LED_FULL;
> -
>  	rc =3D regmap_update_bits(wled->regmap,
>  			wled->addr + PM8941_WLED_REG_MOD_EN,
>  			PM8941_WLED_REG_MOD_EN_MASK, ctrl);
> @@ -128,16 +127,6 @@ static int pm8941_wled_set(struct led_classdev *cdev,
>  	return rc;
>  }
> =20
> -static void pm8941_wled_set_brightness(struct led_classdev *cdev,
> -				       enum led_brightness value)
> -{
> -	if (pm8941_wled_set(cdev, value)) {
> -		dev_err(cdev->dev, "Unable to set brightness\n");
> -		return;
> -	}
> -	cdev->brightness =3D value;
> -}
> -
>  static int pm8941_wled_setup(struct pm8941_wled *wled)
>  {
>  	int rc;
> @@ -336,12 +325,9 @@ static int pm8941_wled_configure(struct pm8941_wled =
*wled, struct device *dev)
>  	}
>  	wled->addr =3D val;
> =20
> -	rc =3D of_property_read_string(dev->of_node, "label", &wled->cdev.name);
> +	rc =3D of_property_read_string(dev->of_node, "label", &wled->name);
>  	if (rc)
> -		wled->cdev.name =3D dev->of_node->name;
> -
> -	wled->cdev.default_trigger =3D of_get_property(dev->of_node,
> -			"linux,default-trigger", NULL);
> +		wled->name =3D dev->of_node->name;
> =20
>  	*cfg =3D pm8941_wled_config_defaults;
>  	for (i =3D 0; i < ARRAY_SIZE(u32_opts); ++i) {
> @@ -377,8 +363,14 @@ static int pm8941_wled_configure(struct pm8941_wled =
*wled, struct device *dev)
>  	return 0;
>  }
> =20
> +static const struct backlight_ops pm8941_wled_ops =3D {
> +	.update_status =3D pm8941_wled_update_status,
> +};
> +
>  static int pm8941_wled_probe(struct platform_device *pdev)
>  {
> +	struct backlight_properties props;
> +	struct backlight_device *bl;
>  	struct pm8941_wled *wled;
>  	struct regmap *regmap;
>  	int rc;
> @@ -403,13 +395,14 @@ static int pm8941_wled_probe(struct platform_device=
 *pdev)
>  	if (rc)
>  		return rc;
> =20
> -	wled->cdev.brightness_set =3D pm8941_wled_set_brightness;
> -
> -	rc =3D devm_led_classdev_register(&pdev->dev, &wled->cdev);
> -	if (rc)
> -		return rc;
> -
> -	platform_set_drvdata(pdev, wled);
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +	props.type =3D BACKLIGHT_RAW;
> +	props.max_brightness =3D PM8941_WLED_REG_VAL_MAX;
> +	bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
> +					    &pdev->dev, wled,
> +					    &pm8941_wled_ops, &props);
> +	if (IS_ERR(bl))
> +		return PTR_ERR(bl);
> =20
>  	return 0;
>  };
> @@ -432,4 +425,3 @@ module_platform_driver(pm8941_wled_driver);
> =20
>  MODULE_DESCRIPTION("pm8941 wled driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:pm8941-wled");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
