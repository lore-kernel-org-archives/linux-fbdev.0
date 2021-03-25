Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CCC433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 14:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B498619B6
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 14:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCYOcW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 Mar 2021 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhCYObv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 Mar 2021 10:31:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26184C06174A
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Mar 2021 07:31:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k10so3329626ejg.0
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Mar 2021 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kHK6PWPxNxHguzJerjyPzF4M6DDOJtTvhOkFYlg9BNU=;
        b=pTrkks5srT7wZQZ6P9pcxINfvs19xLEyET94gPzo/5XBgxaeBczPLXNvL1zmt8vQM2
         MH8JEQWfQOyPcO9udQDi93aQqlLCPmru57XQNOuybi0lXQLcwb6hzyfhD5L9YDbTFZIW
         MTCh/BAqhue+ExQoKzBDvF0vMp7fGu0hp4s7u7acuF4+2VU4kWsSh8XxzzqIr+OHWi4E
         C+YJV2FwhuboHDfFoWhv6xzYNnKYMg9bJ/A9EqmsJPzVp/aLuQn4BFx3gke9kx+6O15O
         sUamHFsDkQKYIQgB8W2FsFhobvwSpvPG9df5iOJAylaGucVFtWJ6jYuuLfoIZX73fUoP
         GqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kHK6PWPxNxHguzJerjyPzF4M6DDOJtTvhOkFYlg9BNU=;
        b=qJ6pPd7iBhxVm3KhfW563iYg8u3EknsI3G1jCnVuk8xIOP/hwGv0hKrooeZIm3HZSO
         Mms7KhI+hgHoKcaymQ3mEvgXqaU34y0qJZfCOBLbTk2vOPAfdVQVmwY2srZXSav3qpLF
         YuwqM7vCm7vmwhmvlI+jnAALSVAI0no1XPEtUjQPdt9O5dQsCwx10IXIlwSBcr8w2Ita
         xeFfvi+pQkctsEmlcf5ma+SOTgFj37OUjd+S4DLcAlm+mjm/bMAq6LFklKwUd4QrjziJ
         69vemY63wBsqnsyBw02K9Q+JuU5TGCPsKsFoO4CMvd81Uvqum3JwUz0WGPqRAC4k1agb
         Il7Q==
X-Gm-Message-State: AOAM533ICyUy/W5gezb1z8UBlDlQJZioJbTLZ706/gcRWH3DwH2aTqPC
        euxxrzOrM3x6WKh5dhGuyfSzcw==
X-Google-Smtp-Source: ABdhPJzaqYjQtib8l3FnsGT3ScixkR3VzuVIpRxpkheMzajf7HSOar/R8viyQye9Pcm6cNmlmKSp7Q==
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr9577897ejr.525.1616682697710;
        Thu, 25 Mar 2021 07:31:37 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id v24sm2515180ejw.17.2021.03.25.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:31:37 -0700 (PDT)
Date:   Thu, 25 Mar 2021 14:31:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v5 1/6] mfd: rt4831: Adds support for Richtek RT4831 core
Message-ID: <20210325143135.GT2916463@dell>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
 <20210113122133.GC3975472@dell>
 <CADiBU39drqcQYgwp9p6XJuFfwFPGL2OCzm33n1dX-O1R8c4NrA@mail.gmail.com>
 <CADiBU3_p3dk1YMdwMG2EjFX1SrM=e5BVLS4kVvfAqPpdGcMq=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3_p3dk1YMdwMG2EjFX1SrM=e5BVLS4kVvfAqPpdGcMq=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 25 Mar 2021, ChiYuan Huang wrote:

> HI, Lee:
> 
> ChiYuan Huang <u0084500@gmail.com> 於 2021年1月13日 週三 下午10:09寫道：
> >
> > Lee Jones <lee.jones@linaro.org> 於 2021年1月13日 週三 下午8:21寫道：
> > >
> > > On Thu, 17 Dec 2020, cy_huang wrote:
> > >
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > This adds support Richtek RT4831 core. It includes four channel WLED driver
> > > > and Display Bias Voltage outputs.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > ---
> > > > since v5
> > > > - Rename file name from rt4831-core.c to rt4831.c
> > > > - Change RICHTEK_VID to RICHTEK_VENDOR_ID.
> > > > - Change gpio_desc nameing from 'enable' to 'enable_gpio' in probe.
> > > > - Change variable 'val' to the meaningful name 'chip_id'.
> > > > - Refine the error log when vendor id is not matched.
> > > > - Remove of_match_ptr.
> > > >
> > > > since v2
> > > > - Refine Kconfig descriptions.
> > > > - Add copyright.
> > > > - Refine error logs in probe.
> > > > - Refine comment lines in remove and shutdown.
> > > > ---
> > > >  drivers/mfd/Kconfig  |  10 +++++
> > > >  drivers/mfd/Makefile |   1 +
> > > >  drivers/mfd/rt4831.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 135 insertions(+)
> > > >  create mode 100644 drivers/mfd/rt4831.c
> > > >
> > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > index 8b99a13..dfb2640 100644
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -1088,6 +1088,16 @@ config MFD_RDC321X
> > > >         southbridge which provides access to GPIOs and Watchdog using the
> > > >         southbridge PCI device configuration space.
> > > >
> > > > +config MFD_RT4831
> > > > +     tristate "Richtek RT4831 four channel WLED and Display Bias Voltage"
> > > > +     depends on I2C
> > > > +     select MFD_CORE
> > > > +     select REGMAP_I2C
> > > > +     help
> > > > +       This enables support for the Richtek RT4831 that includes 4 channel
> > > > +       WLED driving and Display Bias Voltage. It's commonly used to provide
> > > > +       power to the LCD display and LCD backlight.
> > > > +
> > > >  config MFD_RT5033
> > > >       tristate "Richtek RT5033 Power Management IC"
> > > >       depends on I2C
> > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > index 1780019..28d247b 100644
> > > > --- a/drivers/mfd/Makefile
> > > > +++ b/drivers/mfd/Makefile
> > > > @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)       += menf21bmc.o
> > > >  obj-$(CONFIG_MFD_HI6421_PMIC)        += hi6421-pmic-core.o
> > > >  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
> > > >  obj-$(CONFIG_MFD_DLN2)               += dln2.o
> > > > +obj-$(CONFIG_MFD_RT4831)     += rt4831.o
> > > >  obj-$(CONFIG_MFD_RT5033)     += rt5033.o
> > > >  obj-$(CONFIG_MFD_SKY81452)   += sky81452.o
> > > >
> > > > diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
> > > > new file mode 100644
> > > > index 00000000..2bf8364
> > > > --- /dev/null
> > > > +++ b/drivers/mfd/rt4831.c
> > > > @@ -0,0 +1,124 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright (c) 2020 Richtek Technology Corp.
> > >
> > > Nit: If you respin this, please bump the date.
> > >
> > Okay.
> > > > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > > > + */
> > > > +
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mfd/core.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#define RT4831_REG_REVISION  0x01
> > > > +#define RT4831_REG_ENABLE    0x08
> > > > +#define RT4831_REG_I2CPROT   0x15
> > > > +
> > > > +#define RICHTEK_VENDOR_ID    0x03
> > > > +#define RT4831_VID_MASK              GENMASK(1, 0)
> > > > +#define RT4831_RESET_MASK    BIT(7)
> > > > +#define RT4831_I2CSAFETMR_MASK       BIT(0)
> > > > +
> > > > +static const struct mfd_cell rt4831_subdevs[] = {
> > > > +     OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831-backlight"),
> > > > +     MFD_CELL_NAME("rt4831-regulator")
> > > > +};
> > > > +
> > > > +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int reg)
> > > > +{
> > > > +     if (reg >= RT4831_REG_REVISION && reg <= RT4831_REG_I2CPROT)
> > > > +             return true;
> > > > +     return false;
> > > > +}
> > > > +
> > > > +static const struct regmap_config rt4831_regmap_config = {
> > > > +     .reg_bits = 8,
> > > > +     .val_bits = 8,
> > > > +     .max_register = RT4831_REG_I2CPROT,
> > > > +
> > > > +     .readable_reg = rt4831_is_accessible_reg,
> > > > +     .writeable_reg = rt4831_is_accessible_reg,
> > > > +};
> > > > +
> > > > +static int rt4831_probe(struct i2c_client *client)
> > > > +{
> > > > +     struct gpio_desc *enable_gpio;
> > > > +     struct regmap *regmap;
> > > > +     unsigned int chip_id;
> > > > +     int ret;
> > > > +
> > > > +     enable_gpio = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
> > > > +     if (IS_ERR(enable_gpio)) {
> > > > +             dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> > > > +             return PTR_ERR(enable_gpio);
> > > > +     }
> > > > +
> > > > +     regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
> > > > +     if (IS_ERR(regmap)) {
> > > > +             dev_err(&client->dev, "Failed to initialize regmap\n");
> > > > +             return PTR_ERR(regmap);
> > > > +     }
> > > > +
> > > > +     ret = regmap_read(regmap, RT4831_REG_REVISION, &chip_id);
> > > > +     if (ret) {
> > > > +             dev_err(&client->dev, "Failed to get H/W revision\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     if ((chip_id & RT4831_VID_MASK) != RICHTEK_VENDOR_ID) {
> > > > +             dev_err(&client->dev, "Chip vendor ID 0x%02x not matched\n", chip_id);
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Used to prevent the abnormal shutdown.
> > > > +      * If SCL/SDA both keep low for one second to reset HW.
> > > > +      */
> > > > +     ret = regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2CSAFETMR_MASK,
> > > > +                              RT4831_I2CSAFETMR_MASK);
> > > > +     if (ret) {
> > > > +             dev_err(&client->dev, "Failed to enable I2C safety timer\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt4831_subdevs,
> > > > +                                 ARRAY_SIZE(rt4831_subdevs), NULL, 0, NULL);
> > > > +}
> > > > +
> > > > +static int rt4831_remove(struct i2c_client *client)
> > > > +{
> > > > +     struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> > > > +
> > > > +     /* Disable WLED and DSV outputs */
> > > > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> > > > +}
> > > > +
> > > > +static void rt4831_shutdown(struct i2c_client *client)
> > > > +{
> > > > +     struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> > > > +
> > > > +     /* Disable WLED and DSV outputs */
> > > > +     regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> > > > +}
> > >
> > > What is your reason for providing a .shutdown() routine?
> > >
> > Just like as remove routine to make sure all output are off for the safety.
> > This chip only have one 'enable' pin and I2C as the control signal.
> > As normal shutdown, it can be make sure 'enable' will be pull low.
> > But for some case, if 'enable' always tied to high, like as ARM reset,
> > chip reset only triggered during next booting phase.
> > The period from arm  reset to next probe, if user doesn't call DSV and
> > WLED off before machine shutdown/reboot, the WLED/DSV voltage boost
> > circuit will be kept as on.
> > That's why I also put shutdown routine in the driver to reset the whole chip.
> 
> If the shutdown routine is not suitable, I think it can be removed.
> There's the HWEN pin inside this IC to make sure all function will be disabled.
> 
> There're changed part in my note
> 1. respin the header date.
> 2. Remove the shutdown routine
> 
> Anything else?

Just respin and resend.

I will do a full review once it's back on the list.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
