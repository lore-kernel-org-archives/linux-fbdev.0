Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9CBC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144F2233F8
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbhAMOKC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAMOKC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:10:02 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF656C061794;
        Wed, 13 Jan 2021 06:09:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b26so2923437lff.9;
        Wed, 13 Jan 2021 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YTBMAks+8Eoq/W84U+o1JauA0LtRhSDDqX1jGqiCKGc=;
        b=O9yJ9XFeYDlQI6Ix0tZw1Eeu1vLa1auz6dm59qYOFrus/Z9ydqd764NZv6qqVzwnfh
         aO2ZHxv+bNDb6sqhv+ikw0qknkB95WWdorZ34jB58P80SBrA4XSZFag13tnXtPBspquy
         OOBCfaMBruZUtRqkx8udG1iv6nJWJr3FvDetSZKjibReIreYBfT8uuI/sWbDcJOHYODw
         j4UXs+VsTh0sQNuVYHoljkcu57fqUA0OcrR7rLeTtGaMYKWbj7MJ11Wh0uq6EGFqSppc
         39PrfsADVGgcTyHzG1U2qcDpir+hq3AFH4sPNXd9XUhVXLkld3QkeO1ajgRR7b/VlzUL
         QkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YTBMAks+8Eoq/W84U+o1JauA0LtRhSDDqX1jGqiCKGc=;
        b=B/VaKORCzWSYM9r34i8T1vTZ1nNt6PL0kCJdfJHgWS9vP6tjdDpwrFm26lvUo0QGYy
         fAJavNRBGYFJ1MTuTkZSVc2/DoIqCTOA7z+S1NsycqZqZ6rmoHcHL31kewsMdBucjgjS
         dDBvSvi2Jc12465Ws7v24CtRT7vS/wwbBwnWFEbLbWkpOOw0AZfHiJMMWTl6CRmKedb8
         O7C1tfs+EXEbvgIZorrTj64K3HaRt81nJEUilBxgIaH+sYgmCgubEqqHUeg3bZGG6Atj
         tnu/bV3tCpVExX6M8+PYMGH/CjIwag02MYMjSgTAAxAI1vhoSX+gEB8Rsy2e8HuX2rAS
         Nz9A==
X-Gm-Message-State: AOAM531w/37acGwTMzIGuayiBFJo5488F1w+4uaTF2GP7CRojL3zitGU
        O7vSQiYQXTcAiFLLkzgWguw4hBd4Rc+fG+EmqME=
X-Google-Smtp-Source: ABdhPJy6O03GTrwp5YpY9cwawyraXh/FE4I5PQhaffA8ZDh4kQjaM+4QMQnZAhud3/+5bRDsSdrUGXOpKTaF7gLctbE=
X-Received: by 2002:a19:ca5a:: with SMTP id h26mr971451lfj.612.1610546960244;
 Wed, 13 Jan 2021 06:09:20 -0800 (PST)
MIME-Version: 1.0
References: <1608217244-314-1-git-send-email-u0084500@gmail.com> <20210113122133.GC3975472@dell>
In-Reply-To: <20210113122133.GC3975472@dell>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 13 Jan 2021 22:09:08 +0800
Message-ID: <CADiBU39drqcQYgwp9p6XJuFfwFPGL2OCzm33n1dX-O1R8c4NrA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mfd: rt4831: Adds support for Richtek RT4831 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 17 Dec 2020, cy_huang wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > This adds support Richtek RT4831 core. It includes four channel WLED dr=
iver
> > and Display Bias Voltage outputs.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > since v5
> > - Rename file name from rt4831-core.c to rt4831.c
> > - Change RICHTEK_VID to RICHTEK_VENDOR_ID.
> > - Change gpio_desc nameing from 'enable' to 'enable_gpio' in probe.
> > - Change variable 'val' to the meaningful name 'chip_id'.
> > - Refine the error log when vendor id is not matched.
> > - Remove of_match_ptr.
> >
> > since v2
> > - Refine Kconfig descriptions.
> > - Add copyright.
> > - Refine error logs in probe.
> > - Refine comment lines in remove and shutdown.
> > ---
> >  drivers/mfd/Kconfig  |  10 +++++
> >  drivers/mfd/Makefile |   1 +
> >  drivers/mfd/rt4831.c | 124 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 135 insertions(+)
> >  create mode 100644 drivers/mfd/rt4831.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 8b99a13..dfb2640 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1088,6 +1088,16 @@ config MFD_RDC321X
> >         southbridge which provides access to GPIOs and Watchdog using t=
he
> >         southbridge PCI device configuration space.
> >
> > +config MFD_RT4831
> > +     tristate "Richtek RT4831 four channel WLED and Display Bias Volta=
ge"
> > +     depends on I2C
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     help
> > +       This enables support for the Richtek RT4831 that includes 4 cha=
nnel
> > +       WLED driving and Display Bias Voltage. It's commonly used to pr=
ovide
> > +       power to the LCD display and LCD backlight.
> > +
> >  config MFD_RT5033
> >       tristate "Richtek RT5033 Power Management IC"
> >       depends on I2C
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 1780019..28d247b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)       +=3D menf21bmc.o
> >  obj-$(CONFIG_MFD_HI6421_PMIC)        +=3D hi6421-pmic-core.o
> >  obj-$(CONFIG_MFD_HI655X_PMIC)   +=3D hi655x-pmic.o
> >  obj-$(CONFIG_MFD_DLN2)               +=3D dln2.o
> > +obj-$(CONFIG_MFD_RT4831)     +=3D rt4831.o
> >  obj-$(CONFIG_MFD_RT5033)     +=3D rt5033.o
> >  obj-$(CONFIG_MFD_SKY81452)   +=3D sky81452.o
> >
> > diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
> > new file mode 100644
> > index 00000000..2bf8364
> > --- /dev/null
> > +++ b/drivers/mfd/rt4831.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2020 Richtek Technology Corp.
>
> Nit: If you respin this, please bump the date.
>
Okay.
> > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > + */
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#define RT4831_REG_REVISION  0x01
> > +#define RT4831_REG_ENABLE    0x08
> > +#define RT4831_REG_I2CPROT   0x15
> > +
> > +#define RICHTEK_VENDOR_ID    0x03
> > +#define RT4831_VID_MASK              GENMASK(1, 0)
> > +#define RT4831_RESET_MASK    BIT(7)
> > +#define RT4831_I2CSAFETMR_MASK       BIT(0)
> > +
> > +static const struct mfd_cell rt4831_subdevs[] =3D {
> > +     OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831=
-backlight"),
> > +     MFD_CELL_NAME("rt4831-regulator")
> > +};
> > +
> > +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int =
reg)
> > +{
> > +     if (reg >=3D RT4831_REG_REVISION && reg <=3D RT4831_REG_I2CPROT)
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static const struct regmap_config rt4831_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D RT4831_REG_I2CPROT,
> > +
> > +     .readable_reg =3D rt4831_is_accessible_reg,
> > +     .writeable_reg =3D rt4831_is_accessible_reg,
> > +};
> > +
> > +static int rt4831_probe(struct i2c_client *client)
> > +{
> > +     struct gpio_desc *enable_gpio;
> > +     struct regmap *regmap;
> > +     unsigned int chip_id;
> > +     int ret;
> > +
> > +     enable_gpio =3D devm_gpiod_get_optional(&client->dev, "enable", G=
PIOD_OUT_HIGH);
> > +     if (IS_ERR(enable_gpio)) {
> > +             dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> > +             return PTR_ERR(enable_gpio);
> > +     }
> > +
> > +     regmap =3D devm_regmap_init_i2c(client, &rt4831_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "Failed to initialize regmap\n");
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     ret =3D regmap_read(regmap, RT4831_REG_REVISION, &chip_id);
> > +     if (ret) {
> > +             dev_err(&client->dev, "Failed to get H/W revision\n");
> > +             return ret;
> > +     }
> > +
> > +     if ((chip_id & RT4831_VID_MASK) !=3D RICHTEK_VENDOR_ID) {
> > +             dev_err(&client->dev, "Chip vendor ID 0x%02x not matched\=
n", chip_id);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /*
> > +      * Used to prevent the abnormal shutdown.
> > +      * If SCL/SDA both keep low for one second to reset HW.
> > +      */
> > +     ret =3D regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2C=
SAFETMR_MASK,
> > +                              RT4831_I2CSAFETMR_MASK);
> > +     if (ret) {
> > +             dev_err(&client->dev, "Failed to enable I2C safety timer\=
n");
> > +             return ret;
> > +     }
> > +
> > +     return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt=
4831_subdevs,
> > +                                 ARRAY_SIZE(rt4831_subdevs), NULL, 0, =
NULL);
> > +}
> > +
> > +static int rt4831_remove(struct i2c_client *client)
> > +{
> > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > +
> > +     /* Disable WLED and DSV outputs */
> > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET=
_MASK, RT4831_RESET_MASK);
> > +}
> > +
> > +static void rt4831_shutdown(struct i2c_client *client)
> > +{
> > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > +
> > +     /* Disable WLED and DSV outputs */
> > +     regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, =
RT4831_RESET_MASK);
> > +}
>
> What is your reason for providing a .shutdown() routine?
>
Just like as remove routine to make sure all output are off for the safety.
This chip only have one 'enable' pin and I2C as the control signal.
As normal shutdown, it can be make sure 'enable' will be pull low.
But for some case, if 'enable' always tied to high, like as ARM reset,
chip reset only triggered during next booting phase.
The period from arm  reset to next probe, if user doesn't call DSV and
WLED off before machine shutdown/reboot, the WLED/DSV voltage boost
circuit will be kept as on.
That's why I also put shutdown routine in the driver to reset the whole chi=
p.
> > +static const struct of_device_id __maybe_unused rt4831_of_match[] =3D =
{
> > +     { .compatible =3D "richtek,rt4831", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> > +
> > +static struct i2c_driver rt4831_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "rt4831",
> > +             .of_match_table =3D rt4831_of_match,
> > +     },
> > +     .probe_new =3D rt4831_probe,
> > +     .remove =3D rt4831_remove,
> > +     .shutdown =3D rt4831_shutdown,
> > +};
> > +module_i2c_driver(rt4831_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_LICENSE("GPL v2");
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
