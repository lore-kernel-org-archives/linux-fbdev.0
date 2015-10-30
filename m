From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 30 Oct 2015 18:49:03 +0000
Subject: Re: [RESEND PATCH v2] backlight: pm8941-wled: Add default-brightness property
Message-Id: <20151030184903.GK4058@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445881508-18025-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1445881508-18025-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Mon, 26 Oct 2015, Bjorn Andersson wrote:

> Default the brightness to 2048 and add possibility to override this in
> device tree.
>=20
> Suggested-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>=20
> Resend of v2, with updated backlight dt binding location.
>=20
>  Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt | 2 ++

In future please submit documentation as a separate patch.

>  drivers/video/backlight/pm8941-wled.c                            | 8 +++=
+++++
>  2 files changed, 10 insertions(+)

Applied with Rob's Ack.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled=
.txt b/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> index 424f8444a6cd..e5b294dafc58 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> @@ -5,6 +5,8 @@ Required properties:
>  - reg: slave address
> =20
>  Optional properties:
> +- default-brightness: brightness value on boot, value from: 0-4095
> +	default: 2048
>  - label: The name of the backlight device
>  - qcom,cs-out: bool; enable current sink output
>  - qcom,cabc: bool; enable content adaptive backlight control
> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backli=
ght/pm8941-wled.c
> index c704c3236034..e1298147bcbb 100644
> --- a/drivers/video/backlight/pm8941-wled.c
> +++ b/drivers/video/backlight/pm8941-wled.c
> @@ -17,6 +17,9 @@
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> =20
> +/* From DT binding */
> +#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
> +
>  #define PM8941_WLED_REG_VAL_BASE		0x40
>  #define  PM8941_WLED_REG_VAL_MAX		0xFFF
> =20
> @@ -373,6 +376,7 @@ static int pm8941_wled_probe(struct platform_device *=
pdev)
>  	struct backlight_device *bl;
>  	struct pm8941_wled *wled;
>  	struct regmap *regmap;
> +	u32 val;
>  	int rc;
> =20
>  	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> @@ -395,8 +399,12 @@ static int pm8941_wled_probe(struct platform_device =
*pdev)
>  	if (rc)
>  		return rc;
> =20
> +	val =3D PM8941_WLED_DEFAULT_BRIGHTNESS;
> +	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
> +
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type =3D BACKLIGHT_RAW;
> +	props.brightness =3D val;
>  	props.max_brightness =3D PM8941_WLED_REG_VAL_MAX;
>  	bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
>  					    &pdev->dev, wled,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
