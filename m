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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1402CC433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 08:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC23061A26
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 08:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCYI0Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYI0C (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 Mar 2021 04:26:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF1C06174A;
        Thu, 25 Mar 2021 01:26:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z25so2056766lja.3;
        Thu, 25 Mar 2021 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YZ1kwpKBXbBYawzQ08p8cS23ZbN4Xx0sNP97wiSQUVo=;
        b=XcTo9YWysSPSsH/DdCWOt4Mdp8KbbkAe2G/h8BfOstWs3VoSggWOaOhMxFaVrSeA0w
         G54jcdkl1bZRziP4JI5wrjgRyqlXuh98hrhBh/l5FnwfZ1xQSdlmPVLQpo0TGkt/EsJj
         C87YNNPVZQooEYG3K09wuX03/AN3LIba+qIecyhY/5WD4XYWXMpGn2XzgZenBauhJ6ny
         /DCwy8QR0CgUD0lD91TTQ4ybLOGqQUnx1HwKVoo6hLcGXngZiAh6iKVLZX19UziE8eSW
         0FAjSl86cNmVVrnyT9g48ZwYdCIXvYeX2gtoslchMR90Ho8z8D3CkZCcx8Murf6lunq9
         yieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YZ1kwpKBXbBYawzQ08p8cS23ZbN4Xx0sNP97wiSQUVo=;
        b=UP6D4DAIIYRreo0aW2K5STOnfSskbgToJ/POMGiTASr45rfQ83GFy9YoONIQpw2XE3
         SF41KSl/WIJA74l9FTJxSpDN95+8qSEwK6Hp4htUdfM2kTlSW8XnjmJ80JyQmPRXPZ/f
         OrJkPFpMTzIiQWiD4cvt5SDfhoc3/5H1A2ags0HIX/DzXQqUzyE7ZWQfwNLN4F+MvVmU
         XmxxEmIilsLi+Ro7aYdB3eYU7qMz4oo0AndluWJFN9JkPhGhMnQC4kOlXtRe5Iv1i44h
         +TqmzWDCd5EhQevI79UI7uS1b2GkF8lief/cPfSCdlGvatBnLdclb1JnXt2UjsJ+U+xw
         qNVQ==
X-Gm-Message-State: AOAM5332aYTjb0J4O/lhn/kX9uWv5iqJbaX2EVcQcBU8zza6dxl6wdil
        /RzQmILSpjULlbZxjNCnnB5dbFVaD6CIS2MnFk0=
X-Google-Smtp-Source: ABdhPJzef8u1yJme1lhwL7KdNMBln/T/A61jVOHvPmYCQlNJWJ5jklxv29ZU3rfwUqRLLB4K7p45/dIhm21TnyQal4o=
X-Received: by 2002:a2e:9591:: with SMTP id w17mr4868498ljh.141.1616660759738;
 Thu, 25 Mar 2021 01:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
 <20210113122133.GC3975472@dell> <CADiBU39drqcQYgwp9p6XJuFfwFPGL2OCzm33n1dX-O1R8c4NrA@mail.gmail.com>
In-Reply-To: <CADiBU39drqcQYgwp9p6XJuFfwFPGL2OCzm33n1dX-O1R8c4NrA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 25 Mar 2021 16:25:48 +0800
Message-ID: <CADiBU3_p3dk1YMdwMG2EjFX1SrM=e5BVLS4kVvfAqPpdGcMq=w@mail.gmail.com>
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

HI, Lee:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:09=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, 17 Dec 2020, cy_huang wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > This adds support Richtek RT4831 core. It includes four channel WLED =
driver
> > > and Display Bias Voltage outputs.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > > since v5
> > > - Rename file name from rt4831-core.c to rt4831.c
> > > - Change RICHTEK_VID to RICHTEK_VENDOR_ID.
> > > - Change gpio_desc nameing from 'enable' to 'enable_gpio' in probe.
> > > - Change variable 'val' to the meaningful name 'chip_id'.
> > > - Refine the error log when vendor id is not matched.
> > > - Remove of_match_ptr.
> > >
> > > since v2
> > > - Refine Kconfig descriptions.
> > > - Add copyright.
> > > - Refine error logs in probe.
> > > - Refine comment lines in remove and shutdown.
> > > ---
> > >  drivers/mfd/Kconfig  |  10 +++++
> > >  drivers/mfd/Makefile |   1 +
> > >  drivers/mfd/rt4831.c | 124 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 135 insertions(+)
> > >  create mode 100644 drivers/mfd/rt4831.c
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 8b99a13..dfb2640 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1088,6 +1088,16 @@ config MFD_RDC321X
> > >         southbridge which provides access to GPIOs and Watchdog using=
 the
> > >         southbridge PCI device configuration space.
> > >
> > > +config MFD_RT4831
> > > +     tristate "Richtek RT4831 four channel WLED and Display Bias Vol=
tage"
> > > +     depends on I2C
> > > +     select MFD_CORE
> > > +     select REGMAP_I2C
> > > +     help
> > > +       This enables support for the Richtek RT4831 that includes 4 c=
hannel
> > > +       WLED driving and Display Bias Voltage. It's commonly used to =
provide
> > > +       power to the LCD display and LCD backlight.
> > > +
> > >  config MFD_RT5033
> > >       tristate "Richtek RT5033 Power Management IC"
> > >       depends on I2C
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 1780019..28d247b 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)       +=3D menf21bmc.=
o
> > >  obj-$(CONFIG_MFD_HI6421_PMIC)        +=3D hi6421-pmic-core.o
> > >  obj-$(CONFIG_MFD_HI655X_PMIC)   +=3D hi655x-pmic.o
> > >  obj-$(CONFIG_MFD_DLN2)               +=3D dln2.o
> > > +obj-$(CONFIG_MFD_RT4831)     +=3D rt4831.o
> > >  obj-$(CONFIG_MFD_RT5033)     +=3D rt5033.o
> > >  obj-$(CONFIG_MFD_SKY81452)   +=3D sky81452.o
> > >
> > > diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
> > > new file mode 100644
> > > index 00000000..2bf8364
> > > --- /dev/null
> > > +++ b/drivers/mfd/rt4831.c
> > > @@ -0,0 +1,124 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (c) 2020 Richtek Technology Corp.
> >
> > Nit: If you respin this, please bump the date.
> >
> Okay.
> > > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > > + */
> > > +
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define RT4831_REG_REVISION  0x01
> > > +#define RT4831_REG_ENABLE    0x08
> > > +#define RT4831_REG_I2CPROT   0x15
> > > +
> > > +#define RICHTEK_VENDOR_ID    0x03
> > > +#define RT4831_VID_MASK              GENMASK(1, 0)
> > > +#define RT4831_RESET_MASK    BIT(7)
> > > +#define RT4831_I2CSAFETMR_MASK       BIT(0)
> > > +
> > > +static const struct mfd_cell rt4831_subdevs[] =3D {
> > > +     OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt48=
31-backlight"),
> > > +     MFD_CELL_NAME("rt4831-regulator")
> > > +};
> > > +
> > > +static bool rt4831_is_accessible_reg(struct device *dev, unsigned in=
t reg)
> > > +{
> > > +     if (reg >=3D RT4831_REG_REVISION && reg <=3D RT4831_REG_I2CPROT=
)
> > > +             return true;
> > > +     return false;
> > > +}
> > > +
> > > +static const struct regmap_config rt4831_regmap_config =3D {
> > > +     .reg_bits =3D 8,
> > > +     .val_bits =3D 8,
> > > +     .max_register =3D RT4831_REG_I2CPROT,
> > > +
> > > +     .readable_reg =3D rt4831_is_accessible_reg,
> > > +     .writeable_reg =3D rt4831_is_accessible_reg,
> > > +};
> > > +
> > > +static int rt4831_probe(struct i2c_client *client)
> > > +{
> > > +     struct gpio_desc *enable_gpio;
> > > +     struct regmap *regmap;
> > > +     unsigned int chip_id;
> > > +     int ret;
> > > +
> > > +     enable_gpio =3D devm_gpiod_get_optional(&client->dev, "enable",=
 GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(enable_gpio)) {
> > > +             dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> > > +             return PTR_ERR(enable_gpio);
> > > +     }
> > > +
> > > +     regmap =3D devm_regmap_init_i2c(client, &rt4831_regmap_config);
> > > +     if (IS_ERR(regmap)) {
> > > +             dev_err(&client->dev, "Failed to initialize regmap\n");
> > > +             return PTR_ERR(regmap);
> > > +     }
> > > +
> > > +     ret =3D regmap_read(regmap, RT4831_REG_REVISION, &chip_id);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "Failed to get H/W revision\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     if ((chip_id & RT4831_VID_MASK) !=3D RICHTEK_VENDOR_ID) {
> > > +             dev_err(&client->dev, "Chip vendor ID 0x%02x not matche=
d\n", chip_id);
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     /*
> > > +      * Used to prevent the abnormal shutdown.
> > > +      * If SCL/SDA both keep low for one second to reset HW.
> > > +      */
> > > +     ret =3D regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I=
2CSAFETMR_MASK,
> > > +                              RT4831_I2CSAFETMR_MASK);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "Failed to enable I2C safety time=
r\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, =
rt4831_subdevs,
> > > +                                 ARRAY_SIZE(rt4831_subdevs), NULL, 0=
, NULL);
> > > +}
> > > +
> > > +static int rt4831_remove(struct i2c_client *client)
> > > +{
> > > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > > +
> > > +     /* Disable WLED and DSV outputs */
> > > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RES=
ET_MASK, RT4831_RESET_MASK);
> > > +}
> > > +
> > > +static void rt4831_shutdown(struct i2c_client *client)
> > > +{
> > > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > > +
> > > +     /* Disable WLED and DSV outputs */
> > > +     regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK=
, RT4831_RESET_MASK);
> > > +}
> >
> > What is your reason for providing a .shutdown() routine?
> >
> Just like as remove routine to make sure all output are off for the safet=
y.
> This chip only have one 'enable' pin and I2C as the control signal.
> As normal shutdown, it can be make sure 'enable' will be pull low.
> But for some case, if 'enable' always tied to high, like as ARM reset,
> chip reset only triggered during next booting phase.
> The period from arm  reset to next probe, if user doesn't call DSV and
> WLED off before machine shutdown/reboot, the WLED/DSV voltage boost
> circuit will be kept as on.
> That's why I also put shutdown routine in the driver to reset the whole c=
hip.

If the shutdown routine is not suitable, I think it can be removed.
There's the HWEN pin inside this IC to make sure all function will be disab=
led.

There're changed part in my note
1. respin the header date.
2. Remove the shutdown routine

Anything else?


> > > +static const struct of_device_id __maybe_unused rt4831_of_match[] =
=3D {
> > > +     { .compatible =3D "richtek,rt4831", },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> > > +
> > > +static struct i2c_driver rt4831_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "rt4831",
> > > +             .of_match_table =3D rt4831_of_match,
> > > +     },
> > > +     .probe_new =3D rt4831_probe,
> > > +     .remove =3D rt4831_remove,
> > > +     .shutdown =3D rt4831_shutdown,
> > > +};
> > > +module_i2c_driver(rt4831_driver);
> > > +
> > > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > > +MODULE_LICENSE("GPL v2");
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Senior Technical Lead - Developer Services
> > Linaro.org =E2=94=82 Open source software for Arm SoCs
> > Follow Linaro: Facebook | Twitter | Blog
