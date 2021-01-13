Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BECC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F0422A83
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 12:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAMMWR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAMMWR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 07:22:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B99C061786
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 04:21:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a12so1885031wrv.8
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 04:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8cweqr2u1jR2S4d8aPK1BgoPHFtAzieEjaISmB5R/+w=;
        b=uIL+BhRPYiZV6kElq1U6y2b/gFj4HPtngXhB5I4pSjkfAsQmSh9ztksWnRCVrtDTDJ
         BMK8/HPOQXE7ks2Bmqjo0rhjkTsqIaYolAFbDtU2BgZNLZXDm9rc3A/eOtlRdRu/k2r6
         G3ZrYgJ8WirhF7wUupkOG07L/tdGsXko6Ks2oD+8X6MZKwn4F6IFjFP6i6QfJbK9pzZC
         wx2xcv1lPzHwwxFsvdlUc+SSCWwYqxkKEpXFj4NvAmG/knPCPyugkP5fOdpfzJA4osgP
         FJqZomg+nne1PmW2d0BZKTMKqnjXO0JOXbd5uUYqJaDShv9kdHMBDWYAmiygEvYp5ctR
         sLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8cweqr2u1jR2S4d8aPK1BgoPHFtAzieEjaISmB5R/+w=;
        b=UJAziuiWcib1dIcNQAY760s3aHcdchsvJFMHz3LrypNoahgvYyNjG/Vt46xdz+4wRA
         v1919jasrpQBJtwIdxYM1Fzunf+a9B7lQHLt4roPiasF5WdTr5gxFDavOvUkrf6ZaK9B
         zhMRBBHZXh/BGC8uOhgdrSGw0E7oV+y64heDNfT+yrx26sxyHmSXOrY8S2dnZP5dcVHg
         R2XEG8uRKGK5efz9+Ys9+nQkRm8T3RHMEXj3A/wmoNYdzbMOlhksqUWJcvdebvW4iYhy
         JGiaZgp4tRfGovC8JTY3d5VXswPzAkRD8ND8oBzJ6EWQrbcCvQlFiJRul1IUsRkDHHLf
         5mdg==
X-Gm-Message-State: AOAM532B1/A/K9gj3LbO+ZgDuuNZB48abooOodXMWLYg3Xf3hdWKtZGb
        VUuR+SVRAUftcrCDqB2NcMdaNw==
X-Google-Smtp-Source: ABdhPJwI3ljFeHcNJZXE3Sc+lkxm+uIGbNtwwFbeOSf0wbDaK1pBaMREYnuzG85HUfzOCOZpkL/pKg==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr2412998wru.118.1610540495627;
        Wed, 13 Jan 2021 04:21:35 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id b7sm2755408wru.33.2021.01.13.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:21:34 -0800 (PST)
Date:   Wed, 13 Jan 2021 12:21:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v5 1/6] mfd: rt4831: Adds support for Richtek RT4831 core
Message-ID: <20210113122133.GC3975472@dell>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1608217244-314-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 17 Dec 2020, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This adds support Richtek RT4831 core. It includes four channel WLED driver
> and Display Bias Voltage outputs.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
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
>  drivers/mfd/rt4831.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 drivers/mfd/rt4831.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13..dfb2640 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1088,6 +1088,16 @@ config MFD_RDC321X
>  	  southbridge which provides access to GPIOs and Watchdog using the
>  	  southbridge PCI device configuration space.
>  
> +config MFD_RT4831
> +	tristate "Richtek RT4831 four channel WLED and Display Bias Voltage"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This enables support for the Richtek RT4831 that includes 4 channel
> +	  WLED driving and Display Bias Voltage. It's commonly used to provide
> +	  power to the LCD display and LCD backlight.
> +
>  config MFD_RT5033
>  	tristate "Richtek RT5033 Power Management IC"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 1780019..28d247b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
> +obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
> diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
> new file mode 100644
> index 00000000..2bf8364
> --- /dev/null
> +++ b/drivers/mfd/rt4831.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2020 Richtek Technology Corp.

Nit: If you respin this, please bump the date.

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
> +#define RT4831_REG_REVISION	0x01
> +#define RT4831_REG_ENABLE	0x08
> +#define RT4831_REG_I2CPROT	0x15
> +
> +#define RICHTEK_VENDOR_ID	0x03
> +#define RT4831_VID_MASK		GENMASK(1, 0)
> +#define RT4831_RESET_MASK	BIT(7)
> +#define RT4831_I2CSAFETMR_MASK	BIT(0)
> +
> +static const struct mfd_cell rt4831_subdevs[] = {
> +	OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831-backlight"),
> +	MFD_CELL_NAME("rt4831-regulator")
> +};
> +
> +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int reg)
> +{
> +	if (reg >= RT4831_REG_REVISION && reg <= RT4831_REG_I2CPROT)
> +		return true;
> +	return false;
> +}
> +
> +static const struct regmap_config rt4831_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RT4831_REG_I2CPROT,
> +
> +	.readable_reg = rt4831_is_accessible_reg,
> +	.writeable_reg = rt4831_is_accessible_reg,
> +};
> +
> +static int rt4831_probe(struct i2c_client *client)
> +{
> +	struct gpio_desc *enable_gpio;
> +	struct regmap *regmap;
> +	unsigned int chip_id;
> +	int ret;
> +
> +	enable_gpio = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(enable_gpio)) {
> +		dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> +		return PTR_ERR(enable_gpio);
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	ret = regmap_read(regmap, RT4831_REG_REVISION, &chip_id);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get H/W revision\n");
> +		return ret;
> +	}
> +
> +	if ((chip_id & RT4831_VID_MASK) != RICHTEK_VENDOR_ID) {
> +		dev_err(&client->dev, "Chip vendor ID 0x%02x not matched\n", chip_id);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Used to prevent the abnormal shutdown.
> +	 * If SCL/SDA both keep low for one second to reset HW.
> +	 */
> +	ret = regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2CSAFETMR_MASK,
> +				 RT4831_I2CSAFETMR_MASK);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to enable I2C safety timer\n");
> +		return ret;
> +	}
> +
> +	return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt4831_subdevs,
> +				    ARRAY_SIZE(rt4831_subdevs), NULL, 0, NULL);
> +}
> +
> +static int rt4831_remove(struct i2c_client *client)
> +{
> +	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> +
> +	/* Disable WLED and DSV outputs */
> +	return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> +}
> +
> +static void rt4831_shutdown(struct i2c_client *client)
> +{
> +	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> +
> +	/* Disable WLED and DSV outputs */
> +	regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> +}

What is your reason for providing a .shutdown() routine?

> +static const struct of_device_id __maybe_unused rt4831_of_match[] = {
> +	{ .compatible = "richtek,rt4831", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> +
> +static struct i2c_driver rt4831_driver = {
> +	.driver = {
> +		.name = "rt4831",
> +		.of_match_table = rt4831_of_match,
> +	},
> +	.probe_new = rt4831_probe,
> +	.remove = rt4831_remove,
> +	.shutdown = rt4831_shutdown,
> +};
> +module_i2c_driver(rt4831_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
