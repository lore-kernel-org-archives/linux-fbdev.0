Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCC1C433B4
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 05:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DC261157
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 05:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhDSF6b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Apr 2021 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDSF6a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Apr 2021 01:58:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671DC06174A;
        Sun, 18 Apr 2021 22:58:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u4so37954590ljo.6;
        Sun, 18 Apr 2021 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZGIT7xQcHKV27LMxjuEL0Rs+38I7tdx5ij/sxG4AtnQ=;
        b=T8Ti5gQdqKQsTwYWuxBFfsy8B5sUAZQwuAppSHvHUy00GpeZoWAO0zSbnN70/moUQY
         0QwmH2CU+3pLZCMlU/EZCiJlhBJtuMbq0QQC/njwftKB4xszeW4GEV/ryFTYKX+pELoH
         HVTFxPXxMl5Fmwf1YESu1VyfSgxnWXJ3pAMPRKbwpl2s6gL7Bw/XJZlod7pQbpDSkV32
         BvVRdCT4g5uNs2bTRmiPYjAQ2uwbaHW43qYDab4z2+UF3FIkaRvLSOTj2lfLrKcOu/JL
         /FpHxoemOg6dQpwZIloML1kd0V9pdjCLw2BUKgvHkziT5+Bl4VWDHLo+VNWgUMNs2MWy
         f02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZGIT7xQcHKV27LMxjuEL0Rs+38I7tdx5ij/sxG4AtnQ=;
        b=s1O2AgRMQY/Htty/hLFhZTBu26d7RVHOA/nparq5CaVoq4Wq8uBsiLp+xPTzI3b0yg
         1qmEAgdar17iSLHv1UPNDaZt5e3q+G6hDROcaaWpCirC61uvbXq4UO3O/wawkULgildL
         YcZssPjVNgBIC48bvGflazNHfBsnrAUIdVplwl8CsXRieigrILsIpT5aP890MtTnEDjU
         aDbpAFxI7uGkO5OnDQu7o8K5xPW1Ix/pkhffWzII/YtpFsavYnTDRfxX0EZcp4DizmyA
         jTBEXU/VRyow++CPx8fEpY9ucFziflv+1oDR9EVMiK/pRVJXPCB4HkNHvxMwWVuCDNaS
         0weA==
X-Gm-Message-State: AOAM530E94HbpsdRD/gazSO1c3C+fBVQ9ashrHLoS5Ax/ogsg8ZRWCkl
        UAdTaIuPwMt+coyMSlYyuSs8avX4auIvfoooTlhvlG4c
X-Google-Smtp-Source: ABdhPJyZkE4lNZoUp82VVPsnL99Yp+p1TI8S9GYMyebQ+kzy1KOW0PaQRWmdHRs1lKgj31iierK9KBdrQXCaYh3tISI=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr6536507ljj.175.1618811878964;
 Sun, 18 Apr 2021 22:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 19 Apr 2021 13:57:48 +0800
Message-ID: <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
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

Hi, Linux mfd reviewers:
   It's been three weeks not to get any response from you.
Is there something wrong about this mfd patch?
If yes, please feel free to let me know.

cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8828=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This adds support Richtek RT4831 core. It includes four channel WLED driv=
er
> and Display Bias Voltage outputs.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> The RT4831 regulator patches are already on main stream, and can be refer=
red to
> 9351ab8b0cb6 regulator: rt4831: Adds support for Richtek RT4831 DSV regul=
ator
> 934b05e81862 regulator: rt4831: Adds DT binding document for Richtek RT48=
31 DSV regulator
>
> since v6
> - Respin the date from 2020 to 2021.
> - Rmove the shutdown routine.
> - Change the macro OF_MFD_CELL to MFD_CELL_OF.
>
>
> since v5
> - Rename file name from rt4831-core.c to rt4831.c
> - Change RICHTEK_VID to RICHTEK_VENDOR_ID.
> - Change gpio_desc nameing from 'enable' to 'enable_gpio' in probe.
> - Change variable 'val' to the meaningful name 'chip_id'.
> - Refine the error log when vendor id is not matched.
> - Remove of_match_ptr.
>
> since v2
> - Refine Kconfig descriptions.
> - Add copyright.
> - Refine error logs in probe.
> - Refine comment lines in remove and shutdown.
> ---
>  drivers/mfd/Kconfig  |  10 +++++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/rt4831.c | 115 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 drivers/mfd/rt4831.c
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b74efa4..3f43834 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1065,6 +1065,16 @@ config MFD_RDC321X
>           southbridge which provides access to GPIOs and Watchdog using t=
he
>           southbridge PCI device configuration space.
>
> +config MFD_RT4831
> +       tristate "Richtek RT4831 four channel WLED and Display Bias Volta=
ge"
> +       depends on I2C
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       help
> +         This enables support for the Richtek RT4831 that includes 4 cha=
nnel
> +         WLED driving and Display Bias Voltage. It's commonly used to pr=
ovide
> +         power to the LCD display and LCD backlight.
> +
>  config MFD_RT5033
>         tristate "Richtek RT5033 Power Management IC"
>         depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 834f546..5986914 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC) +=3D menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)  +=3D hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_HI655X_PMIC)   +=3D hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)         +=3D dln2.o
> +obj-$(CONFIG_MFD_RT4831)       +=3D rt4831.o
>  obj-$(CONFIG_MFD_RT5033)       +=3D rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)     +=3D sky81452.o
>
> diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
> new file mode 100644
> index 00000000..b169781
> --- /dev/null
> +++ b/drivers/mfd/rt4831.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Richtek Technology Corp.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define RT4831_REG_REVISION    0x01
> +#define RT4831_REG_ENABLE      0x08
> +#define RT4831_REG_I2CPROT     0x15
> +
> +#define RICHTEK_VENDOR_ID      0x03
> +#define RT4831_VID_MASK                GENMASK(1, 0)
> +#define RT4831_RESET_MASK      BIT(7)
> +#define RT4831_I2CSAFETMR_MASK BIT(0)
> +
> +static const struct mfd_cell rt4831_subdevs[] =3D {
> +       MFD_CELL_OF("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831=
-backlight"),
> +       MFD_CELL_NAME("rt4831-regulator")
> +};
> +
> +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int re=
g)
> +{
> +       if (reg >=3D RT4831_REG_REVISION && reg <=3D RT4831_REG_I2CPROT)
> +               return true;
> +       return false;
> +}
> +
> +static const struct regmap_config rt4831_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .max_register =3D RT4831_REG_I2CPROT,
> +
> +       .readable_reg =3D rt4831_is_accessible_reg,
> +       .writeable_reg =3D rt4831_is_accessible_reg,
> +};
> +
> +static int rt4831_probe(struct i2c_client *client)
> +{
> +       struct gpio_desc *enable_gpio;
> +       struct regmap *regmap;
> +       unsigned int chip_id;
> +       int ret;
> +
> +       enable_gpio =3D devm_gpiod_get_optional(&client->dev, "enable", G=
PIOD_OUT_HIGH);
> +       if (IS_ERR(enable_gpio)) {
> +               dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> +               return PTR_ERR(enable_gpio);
> +       }
> +
> +       regmap =3D devm_regmap_init_i2c(client, &rt4831_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Failed to initialize regmap\n");
> +               return PTR_ERR(regmap);
> +       }
> +
> +       ret =3D regmap_read(regmap, RT4831_REG_REVISION, &chip_id);
> +       if (ret) {
> +               dev_err(&client->dev, "Failed to get H/W revision\n");
> +               return ret;
> +       }
> +
> +       if ((chip_id & RT4831_VID_MASK) !=3D RICHTEK_VENDOR_ID) {
> +               dev_err(&client->dev, "Chip vendor ID 0x%02x not matched\=
n", chip_id);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * Used to prevent the abnormal shutdown.
> +        * If SCL/SDA both keep low for one second to reset HW.
> +        */
> +       ret =3D regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2C=
SAFETMR_MASK,
> +                                RT4831_I2CSAFETMR_MASK);
> +       if (ret) {
> +               dev_err(&client->dev, "Failed to enable I2C safety timer\=
n");
> +               return ret;
> +       }
> +
> +       return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt=
4831_subdevs,
> +                                   ARRAY_SIZE(rt4831_subdevs), NULL, 0, =
NULL);
> +}
> +
> +static int rt4831_remove(struct i2c_client *client)
> +{
> +       struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> +
> +       /* Disable WLED and DSV outputs */
> +       return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET=
_MASK, RT4831_RESET_MASK);
> +}
> +
> +static const struct of_device_id __maybe_unused rt4831_of_match[] =3D {
> +       { .compatible =3D "richtek,rt4831", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> +
> +static struct i2c_driver rt4831_driver =3D {
> +       .driver =3D {
> +               .name =3D "rt4831",
> +               .of_match_table =3D rt4831_of_match,
> +       },
> +       .probe_new =3D rt4831_probe,
> +       .remove =3D rt4831_remove,
> +};
> +module_i2c_driver(rt4831_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
