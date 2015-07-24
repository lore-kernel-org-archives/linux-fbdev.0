From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 24 Jul 2015 08:22:04 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <20150724082204.GX3436@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Thu, 23 Jul 2015, Bjorn Andersson wrote:

> Add the possibility of specifying the default brightness in DT.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>=20
> This depends on the patch moving pm8941-wled to backlight [1]. The dt pro=
perty
> is used by several other backlight drivers, so I considered this to be a
> "common" property and it's hence not prefixed with "qcom,".
>=20
> [1] https://lkml.org/lkml/2015/7/21/906
>=20
>  Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt | 1 +

This needs to be in a seperate patch.

>  drivers/video/backlight/pm8941-wled.c                             | 4 ++=
++

You can't send patches on top of non-existent drivers.

>  2 files changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/video/backlight/pm8941-wle=
d.txt b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> index 424f8444a6cd..37503f8c3620 100644
> --- a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - reg: slave address
> =20
>  Optional properties:
> +- default-brightness: value from: 0-4095
>  - label: The name of the backlight device
>  - qcom,cs-out: bool; enable current sink output
>  - qcom,cabc: bool; enable content adaptive backlight control
> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backli=
ght/pm8941-wled.c
> index c704c3236034..b875e58df0fc 100644
> --- a/drivers/video/backlight/pm8941-wled.c
> +++ b/drivers/video/backlight/pm8941-wled.c
> @@ -373,6 +373,7 @@ static int pm8941_wled_probe(struct platform_device *=
pdev)
>  	struct backlight_device *bl;
>  	struct pm8941_wled *wled;
>  	struct regmap *regmap;
> +	u32 val =3D 0;
>  	int rc;
> =20
>  	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> @@ -395,8 +396,11 @@ static int pm8941_wled_probe(struct platform_device =
*pdev)
>  	if (rc)
>  		return rc;
> =20
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
