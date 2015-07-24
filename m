From: Rob Clark <robdclark@gmail.com>
Date: Fri, 24 Jul 2015 13:10:21 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <CAF6AEGsJdLYzCA_=M8hf1XfhRxFAaY6VFdSBRP+y56uKsnQHiA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1437681127-15760-1-git-send-email-bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jul 23, 2015 at 3:52 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Add the possibility of specifying the default brightness in DT.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>
> This depends on the patch moving pm8941-wled to backlight [1]. The dt property
> is used by several other backlight drivers, so I considered this to be a
> "common" property and it's hence not prefixed with "qcom,".
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

as discussed on IRC, it would be better if the default read back the
current settings (so-as to inherit bootloader splash smoothly..
drm/msm supports a memory-region phandle, for example, so it can take
over the bootloader splash-screen as stolen-mem)

and it would I think be useful to have a comment in the bindings file
explaining that you *should* use the default-brightness property to
set a sane default if bootloader isn't putting up a splash, and you
should *not* use the property if it is..

BR,
-R

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
