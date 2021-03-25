Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F75C433C1
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 08:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4014619F9
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 08:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYIWg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCYIWY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 Mar 2021 04:22:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56583C06174A;
        Thu, 25 Mar 2021 01:22:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b83so1219346lfd.11;
        Thu, 25 Mar 2021 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G826T6os5KhrXWhgWWSol9eRD4q55UejsVL4Aih0kVk=;
        b=nkK7ygHCjzogkk85Hs85aPvKDl9+y9aHUUxCc/JPwvqHRwreCYcqEoBSlHZJRAC526
         meVjDtOWr3Ub1/hGxUxqgGg23+WyX1Q3jXCxhvy0T8e8vEwq/Kg0ulhjPdpUuQpD4odT
         zP3buTH4Crg4mBy7ydWLObie0uC0qdQYAYwZmxwD2bPwxYLZXAgi6/K+kTe4PVTAmxpf
         2caREH833aSsd+iiEll92r2kWBUdOh+mh2F+em2BveLKygEEd1vCAcpW0tJhSp2mtGhv
         cpEfskC2Ce0sPmwnC40/XP/LGo1gpO9MhCBwm8r0noLNnPP2iS442cFkXcJdQh5fRb8i
         asPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G826T6os5KhrXWhgWWSol9eRD4q55UejsVL4Aih0kVk=;
        b=jc0mnAUyklBH9FR3lIdmWROTe38EbHWngYs4qnEj3UmP3hPCnE8LgkT3dprmyh8hm1
         VHja+H85vtb9HEYRA30py6Jopavx87US39ZOi2+D2thff0f8zJJ1cWQwrYidO9Dz7uvQ
         akcUu1ivqzc+OSom9FfKct2Vy0X/HaS6hKO47tp0QTECVak8cL4bLNy5mPmM/CygS/6u
         zA6Op3t8VHcNwf4IvmTw+SQJETKnvUDLyzF6j4rpN/vwF91nVhoVXUr8x9kXdk3RQYJ4
         Q1FAFr+JVXZoW8U2WFMpVWB1WalnDK/GvXzs46sE80w30kmcfG+vnd+05qNx7Hp+TN7d
         IekA==
X-Gm-Message-State: AOAM530IB7FqrP5GvunvIjZwPJ6x4uJepgVziJSljqWdk9+OIcmQsOHO
        Hb6ulMZQKxGL7/IOjTQcfxaL0LwEhaJowiX/eiw=
X-Google-Smtp-Source: ABdhPJyilmo5xJ3ryeQb1hDSfMNJ6g9UEiWKYjSioLwKiFVpAG+2I7g0hvodsspIy0sK9ApNIQWpYBymBEszsmTSPio=
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr4084205lfr.408.1616660542638;
 Thu, 25 Mar 2021 01:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <1608217244-314-1-git-send-email-u0084500@gmail.com> <1608217244-314-5-git-send-email-u0084500@gmail.com>
In-Reply-To: <1608217244-314-5-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 25 Mar 2021 16:22:11 +0800
Message-ID: <CADiBU38aafx9H1Skz_hHmmkQgCGJSssE1VYBC6WddnGfR3ux1w@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] backlight: rt4831: Adds support for Richtek RT4831 backlight
To:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Dear reviewers:

           Didn't get any response about this backlight patch.
Is there any part need to be refined?

cy_huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=8817=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Adds support for Richtek RT4831 backlight.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/video/backlight/Kconfig            |   8 ++
>  drivers/video/backlight/Makefile           |   1 +
>  drivers/video/backlight/rt4831-backlight.c | 219 +++++++++++++++++++++++=
++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/video/backlight/rt4831-backlight.c
>
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index d83c87b..666bdb0 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -289,6 +289,14 @@ config BACKLIGHT_QCOM_WLED
>           If you have the Qualcomm PMIC, say Y to enable a driver for the
>           WLED block. Currently it supports PM8941 and PMI8998.
>
> +config BACKLIGHT_RT4831
> +       tristate "Richtek RT4831 Backlight Driver"
> +       depends on MFD_RT4831
> +       help
> +         This enables support for Richtek RT4831 Backlight driver.
> +         It's commont used to drive the display WLED. There're four chan=
nels
> +         inisde, and each channel can provide up to 30mA current.
> +
>  config BACKLIGHT_SAHARA
>         tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
>         depends on X86
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index 685f3f1..cae2c83 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_BACKLIGHT_PANDORA)               +=3D pand=
ora_bl.o
>  obj-$(CONFIG_BACKLIGHT_PCF50633)       +=3D pcf50633-backlight.o
>  obj-$(CONFIG_BACKLIGHT_PWM)            +=3D pwm_bl.o
>  obj-$(CONFIG_BACKLIGHT_QCOM_WLED)      +=3D qcom-wled.o
> +obj-$(CONFIG_BACKLIGHT_RT4831)         +=3D rt4831-backlight.o
>  obj-$(CONFIG_BACKLIGHT_SAHARA)         +=3D kb3886_bl.o
>  obj-$(CONFIG_BACKLIGHT_SKY81452)       +=3D sky81452-backlight.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)           +=3D tosa_bl.o
> diff --git a/drivers/video/backlight/rt4831-backlight.c b/drivers/video/b=
acklight/rt4831-backlight.c
> new file mode 100644
> index 00000000..816c4d6
> --- /dev/null
> +++ b/drivers/video/backlight/rt4831-backlight.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <dt-bindings/leds/rt4831-backlight.h>
> +#include <linux/backlight.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#define RT4831_REG_BLCFG       0x02
> +#define RT4831_REG_BLDIML      0x04
> +#define RT4831_REG_ENABLE      0x08
> +
> +#define BL_MAX_BRIGHTNESS      2048
> +
> +#define RT4831_BLOVP_MASK      GENMASK(7, 5)
> +#define RT4831_BLOVP_SHIFT     5
> +#define RT4831_BLPWMEN_MASK    BIT(0)
> +#define RT4831_BLEN_MASK       BIT(4)
> +#define RT4831_BLCH_MASK       GENMASK(3, 0)
> +#define RT4831_BLDIML_MASK     GENMASK(2, 0)
> +#define RT4831_BLDIMH_MASK     GENMASK(10, 3)
> +#define RT4831_BLDIMH_SHIFT    3
> +
> +struct rt4831_priv {
> +       struct regmap *regmap;
> +       struct mutex lock;
> +       struct backlight_device *bl;
> +};
> +
> +static int rt4831_bl_update_status(struct backlight_device *bl_dev)
> +{
> +       struct rt4831_priv *priv =3D bl_get_data(bl_dev);
> +       int brightness =3D backlight_get_brightness(bl_dev);
> +       unsigned int enable =3D brightness ? RT4831_BLEN_MASK : 0;
> +       u8 v[2];
> +       int ret;
> +
> +       mutex_lock(&priv->lock);
> +
> +       if (brightness) {
> +               v[0] =3D (brightness - 1) & RT4831_BLDIML_MASK;
> +               v[1] =3D ((brightness - 1) & RT4831_BLDIMH_MASK) >> RT483=
1_BLDIMH_SHIFT;
> +
> +               ret =3D regmap_raw_write(priv->regmap, RT4831_REG_BLDIML,=
 v, sizeof(v));
> +               if (ret)
> +                       goto unlock;
> +       }
> +
> +       ret =3D regmap_update_bits(priv->regmap, RT4831_REG_ENABLE, RT483=
1_BLEN_MASK, enable);
> +
> +unlock:
> +       mutex_unlock(&priv->lock);
> +       return ret;
> +}
> +
> +static int rt4831_bl_get_brightness(struct backlight_device *bl_dev)
> +{
> +       struct rt4831_priv *priv =3D bl_get_data(bl_dev);
> +       unsigned int val;
> +       u8 v[2];
> +       int ret;
> +
> +       mutex_lock(&priv->lock);
> +
> +       ret =3D regmap_read(priv->regmap, RT4831_REG_ENABLE, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (!(val & RT4831_BLEN_MASK)) {
> +               ret =3D 0;
> +               goto unlock;
> +       }
> +
> +       ret =3D regmap_raw_read(priv->regmap, RT4831_REG_BLDIML, v, sizeo=
f(v));
> +       if (ret)
> +               goto unlock;
> +
> +       ret =3D (v[1] << RT4831_BLDIMH_SHIFT) + (v[0] & RT4831_BLDIML_MAS=
K) + 1;
> +
> +unlock:
> +       mutex_unlock(&priv->lock);
> +       return ret;
> +}
> +
> +static const struct backlight_ops rt4831_bl_ops =3D {
> +       .options =3D BL_CORE_SUSPENDRESUME,
> +       .update_status =3D rt4831_bl_update_status,
> +       .get_brightness =3D rt4831_bl_get_brightness,
> +};
> +
> +static int rt4831_init_device_properties(struct rt4831_priv *priv, struc=
t device *dev,
> +                                         struct backlight_properties *bl=
_props)
> +{
> +       u8 propval;
> +       u32 brightness;
> +       unsigned int val =3D 0;
> +       int ret;
> +
> +       /* common properties */
> +       ret =3D device_property_read_u32(dev, "max-brightness", &brightne=
ss);
> +       if (ret) {
> +               dev_warn(dev, "max-brightness DT property missing, use HW=
 max as default\n");
> +               brightness =3D BL_MAX_BRIGHTNESS;
> +       }
> +
> +       bl_props->max_brightness =3D min_t(u32, brightness, BL_MAX_BRIGHT=
NESS);
> +
> +       ret =3D device_property_read_u32(dev, "default-brightness", &brig=
htness);
> +       if (ret) {
> +               dev_warn(dev, "default-brightness DT property missing, us=
e max limit as default\n");
> +               brightness =3D bl_props->max_brightness;
> +       }
> +
> +       bl_props->brightness =3D min_t(u32, brightness, bl_props->max_bri=
ghtness);
> +
> +       /* vendor properties */
> +       if (device_property_read_bool(dev, "richtek,pwm-enable"))
> +               val =3D RT4831_BLPWMEN_MASK;
> +
> +       ret =3D regmap_update_bits(priv->regmap, RT4831_REG_BLCFG, RT4831=
_BLPWMEN_MASK, val);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D device_property_read_u8(dev, "richtek,bled-ovp-sel", &pro=
pval);
> +       if (ret) {
> +               dev_warn(dev, "richtek,bled-ovp-sel DT property missing, =
use default 21V\n");
> +               propval =3D RT4831_BLOVPLVL_21V;
> +       }
> +
> +       propval =3D min_t(u8, propval, RT4831_BLOVPLVL_29V);
> +       ret =3D regmap_update_bits(priv->regmap, RT4831_REG_BLCFG, RT4831=
_BLOVP_MASK,
> +                                propval << RT4831_BLOVP_SHIFT);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D device_property_read_u8(dev, "richtek,channel-use", &prop=
val);
> +       if (ret) {
> +               dev_err(dev, "richtek,channel-use DT property missing\n")=
;
> +               return ret;
> +       }
> +
> +       if (!(propval & RT4831_BLCH_MASK)) {
> +               dev_err(dev, "No channel specified\n");
> +               return -EINVAL;
> +       }
> +
> +       return regmap_update_bits(priv->regmap, RT4831_REG_ENABLE, RT4831=
_BLCH_MASK, propval);
> +}
> +
> +static int rt4831_bl_probe(struct platform_device *pdev)
> +{
> +       struct rt4831_priv *priv;
> +       struct backlight_properties bl_props =3D { .type =3D BACKLIGHT_RA=
W, };
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       mutex_init(&priv->lock);
> +
> +       priv->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +       if (IS_ERR(priv->regmap)) {
> +               dev_err(&pdev->dev, "Failed to init regmap\n");
> +               return PTR_ERR(priv->regmap);
> +       }
> +
> +       ret =3D rt4831_init_device_properties(priv, &pdev->dev, &bl_props=
);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to init device properties\n")=
;
> +               return ret;
> +       }
> +
> +       priv->bl =3D devm_backlight_device_register(&pdev->dev, pdev->nam=
e, &pdev->dev, priv,
> +                                                 &rt4831_bl_ops, &bl_pro=
ps);
> +       if (IS_ERR(priv->bl)) {
> +               dev_err(&pdev->dev, "Failed to register backlight\n");
> +               return PTR_ERR(priv->bl);
> +       }
> +
> +       backlight_update_status(priv->bl);
> +       platform_set_drvdata(pdev, priv);
> +
> +       return 0;
> +}
> +
> +static int rt4831_bl_remove(struct platform_device *pdev)
> +{
> +       struct rt4831_priv *priv =3D platform_get_drvdata(pdev);
> +       struct backlight_device *bl_dev =3D priv->bl;
> +
> +       bl_dev->props.brightness =3D 0;
> +       backlight_update_status(priv->bl);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused rt4831_bl_of_match[] =3D=
 {
> +       { .compatible =3D "richtek,rt4831-backlight", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rt4831_bl_of_match);
> +
> +static struct platform_driver rt4831_bl_driver =3D {
> +       .driver =3D {
> +               .name =3D "rt4831-backlight",
> +               .of_match_table =3D rt4831_bl_of_match,
> +       },
> +       .probe =3D rt4831_bl_probe,
> +       .remove =3D rt4831_bl_remove,
> +};
> +module_platform_driver(rt4831_bl_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
