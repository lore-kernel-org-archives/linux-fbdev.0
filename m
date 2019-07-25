From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Jul 2019 22:16:52 +0000
Subject: Re: [PATCH 09/11] hwmon: Drop obsolete JZ4740 driver
Message-Id: <20190725221652.GA31672@roeck-us.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-10-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-10-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Jul 25, 2019 at 06:02:13PM -0400, Paul Cercueil wrote:
> The JZ4740 boards now use the iio-hwmon driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/Kconfig        |  10 ---
>  drivers/hwmon/Makefile       |   1 -
>  drivers/hwmon/jz4740-hwmon.c | 135 -----------------------------------
>  3 files changed, 146 deletions(-)
>  delete mode 100644 drivers/hwmon/jz4740-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 650dd71f9724..2199ac1d0ba7 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -660,16 +660,6 @@ config SENSORS_IT87
>  	  This driver can also be built as a module. If so, the module
>  	  will be called it87.
>  
> -config SENSORS_JZ4740
> -	tristate "Ingenic JZ4740 SoC ADC driver"
> -	depends on MACH_JZ4740 && MFD_JZ4740_ADC
> -	help
> -	  If you say yes here you get support for reading adc values from the ADCIN
> -	  pin on Ingenic JZ4740 SoC based boards.
> -
> -	  This driver can also be built as a module. If so, the module will be
> -	  called jz4740-hwmon.
> -
>  config SENSORS_JC42
>  	tristate "JEDEC JC42.4 compliant memory module temperature sensors"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8db472ea04f0..1e82e912a5c4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -85,7 +85,6 @@ obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
>  obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
>  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
>  obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
> -obj-$(CONFIG_SENSORS_JZ4740)	+= jz4740-hwmon.o
>  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
>  obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
>  obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
> diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
> deleted file mode 100644
> index bec5befd1d8b..000000000000
> --- a/drivers/hwmon/jz4740-hwmon.c
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> - * JZ4740 SoC HWMON driver
> - */
> -
> -#include <linux/err.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
> -
> -#include <linux/completion.h>
> -#include <linux/mfd/core.h>
> -
> -#include <linux/hwmon.h>
> -
> -struct jz4740_hwmon {
> -	void __iomem *base;
> -	int irq;
> -	const struct mfd_cell *cell;
> -	struct platform_device *pdev;
> -	struct completion read_completion;
> -	struct mutex lock;
> -};
> -
> -static irqreturn_t jz4740_hwmon_irq(int irq, void *data)
> -{
> -	struct jz4740_hwmon *hwmon = data;
> -
> -	complete(&hwmon->read_completion);
> -	return IRQ_HANDLED;
> -}
> -
> -static ssize_t in0_input_show(struct device *dev,
> -			      struct device_attribute *dev_attr, char *buf)
> -{
> -	struct jz4740_hwmon *hwmon = dev_get_drvdata(dev);
> -	struct platform_device *pdev = hwmon->pdev;
> -	struct completion *completion = &hwmon->read_completion;
> -	long t;
> -	unsigned long val;
> -	int ret;
> -
> -	mutex_lock(&hwmon->lock);
> -
> -	reinit_completion(completion);
> -
> -	enable_irq(hwmon->irq);
> -	hwmon->cell->enable(pdev);
> -
> -	t = wait_for_completion_interruptible_timeout(completion, HZ);
> -
> -	if (t > 0) {
> -		val = readw(hwmon->base) & 0xfff;
> -		val = (val * 3300) >> 12;
> -		ret = sprintf(buf, "%lu\n", val);
> -	} else {
> -		ret = t ? t : -ETIMEDOUT;
> -	}
> -
> -	hwmon->cell->disable(pdev);
> -	disable_irq(hwmon->irq);
> -
> -	mutex_unlock(&hwmon->lock);
> -
> -	return ret;
> -}
> -
> -static DEVICE_ATTR_RO(in0_input);
> -
> -static struct attribute *jz4740_attrs[] = {
> -	&dev_attr_in0_input.attr,
> -	NULL
> -};
> -
> -ATTRIBUTE_GROUPS(jz4740);
> -
> -static int jz4740_hwmon_probe(struct platform_device *pdev)
> -{
> -	int ret;
> -	struct device *dev = &pdev->dev;
> -	struct jz4740_hwmon *hwmon;
> -	struct device *hwmon_dev;
> -
> -	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> -	if (!hwmon)
> -		return -ENOMEM;
> -
> -	hwmon->cell = mfd_get_cell(pdev);
> -
> -	hwmon->irq = platform_get_irq(pdev, 0);
> -	if (hwmon->irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
> -			hwmon->irq);
> -		return hwmon->irq;
> -	}
> -
> -	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(hwmon->base))
> -		return PTR_ERR(hwmon->base);
> -
> -	hwmon->pdev = pdev;
> -	init_completion(&hwmon->read_completion);
> -	mutex_init(&hwmon->lock);
> -
> -	ret = devm_request_irq(dev, hwmon->irq, jz4740_hwmon_irq, 0,
> -			       pdev->name, hwmon);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
> -		return ret;
> -	}
> -	disable_irq(hwmon->irq);
> -
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "jz4740", hwmon,
> -							   jz4740_groups);
> -	return PTR_ERR_OR_ZERO(hwmon_dev);
> -}
> -
> -static struct platform_driver jz4740_hwmon_driver = {
> -	.probe	= jz4740_hwmon_probe,
> -	.driver = {
> -		.name = "jz4740-hwmon",
> -	},
> -};
> -
> -module_platform_driver(jz4740_hwmon_driver);
> -
> -MODULE_DESCRIPTION("JZ4740 SoC HWMON driver");
> -MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:jz4740-hwmon");
> -- 
> 2.21.0.593.g511ec345e18
> 
