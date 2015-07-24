From: Rob Herring <robherring2@gmail.com>
Date: Fri, 24 Jul 2015 15:29:03 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <CAL_JsqKxdF5sj=edURFLDCk1OyCJR-w6+STL4r3zM6+be3tjhg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Thu, Jul 23, 2015 at 2:52 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Add the possibility of specifying the default brightness in DT.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>
> This depends on the patch moving pm8941-wled to backlight [1]. The dt property
> is used by several other backlight drivers, so I considered this to be a
> "common" property and it's hence not prefixed with "qcom,".

Well, we have "default-brightness" and "default-brightness-level" used
by 1 driver each. But default-brightness-level is much more commonly
used (in dts files) since it is in the pwm backlight binding, so we
should go with it. I'd like to see this moved to a common backlight
doc.

Really, I think all the backlight documentation should be merged with
LEDs docs. Things like "default-on" are common. But I won't ask to do
that here.

Rob

>
> [1] https://lkml.org/lkml/2015/7/21/906
>
>  Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt | 1 +
>  drivers/video/backlight/pm8941-wled.c                             | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> index 424f8444a6cd..37503f8c3620 100644
> --- a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - reg: slave address
>
>  Optional properties:
> +- default-brightness: value from: 0-4095
>  - label: The name of the backlight device
>  - qcom,cs-out: bool; enable current sink output
>  - qcom,cabc: bool; enable content adaptive backlight control
> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
> index c704c3236034..b875e58df0fc 100644
> --- a/drivers/video/backlight/pm8941-wled.c
> +++ b/drivers/video/backlight/pm8941-wled.c
> @@ -373,6 +373,7 @@ static int pm8941_wled_probe(struct platform_device *pdev)
>         struct backlight_device *bl;
>         struct pm8941_wled *wled;
>         struct regmap *regmap;
> +       u32 val = 0;
>         int rc;
>
>         regmap = dev_get_regmap(pdev->dev.parent, NULL);
> @@ -395,8 +396,11 @@ static int pm8941_wled_probe(struct platform_device *pdev)
>         if (rc)
>                 return rc;
>
> +       of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
> +
>         memset(&props, 0, sizeof(struct backlight_properties));
>         props.type = BACKLIGHT_RAW;
> +       props.brightness = val;
>         props.max_brightness = PM8941_WLED_REG_VAL_MAX;
>         bl = devm_backlight_device_register(&pdev->dev, wled->name,
>                                             &pdev->dev, wled,
> --
> 1.8.2.2
>
