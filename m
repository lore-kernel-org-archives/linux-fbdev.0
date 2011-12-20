From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 20 Dec 2011 22:44:08 +0000
Subject: Re: [PATCH] video: backlight: support MIPI DSI based s6e8ax0 amoled
Message-Id: <20111220144408.8617af2c.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EF04096.30903@samsung.com>
In-Reply-To: <4EF04096.30903@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 20 Dec 2011 17:00:22 +0900
Donghwa Lee <dh09.lee@samsung.com> wrote:

> 
> This patch is amoled panel driver based MIPI DSI interface.
> S6E8AX0 means it may includes many other ldi controllers, for example,
> S6E8AA0, S6E8AB0, and so on.
> It can be modified depending on each panel properites.
> 
> This patch is based on Samsung Soc MIPI DSI Driver.
> Please refer to the "[PATCH v3] video: support MIPI-DSI controller driver".
> 
> http://marc.info/?l=linux-fbdev&m2435297125837&w=2
> 

It's difficult when interdependent patches are spread around different
mailing lists, different patch series and even different maintainers.

I suggest that you send *all* the patches as a single patch series,
cc'ing all relevant individuals and mailing lists on all patches.  That
way, a single person (perhaps me) can merge all the patches in a single
unit.

> +config LCD_S6E8AX0
> +	tristate "S6E8AX0 MIPI AMOLED LCD Driver"
> +	depends on S5P_MIPI_DSI && BACKLIGHT_CLASS_DEVICE

See, I don't have S5P_MIPI_DSI so I can't even compile-test this.

> +	default n
> +	help
> +	  If you have an S6E8AX0 MIPI AMOLED LCD Panel, say Y to enable its
> +	  LCD control driver.
>  endif # LCD_CLASS_DEVICE
>  
>  #
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index fdd1fc4..6adba58 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_LCD_TOSA)		   += tosa_lcd.o
>  obj-$(CONFIG_LCD_S6E63M0)	+= s6e63m0.o
>  obj-$(CONFIG_LCD_LD9040)	+= ld9040.o
>  obj-$(CONFIG_LCD_AMS369FG06)	+= ams369fg06.o
> +obj-$(CONFIG_LCD_S6E8AX0)	+= s6e8ax0.o
>  
>  obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
>  obj-$(CONFIG_BACKLIGHT_ATMEL_PWM)    += atmel-pwm-bl.o
> diff --git a/drivers/video/backlight/s6e8ax0.c b/drivers/video/backlight/s6e8ax0.c
> new file mode 100644
> index 0000000..2fb303e
> --- /dev/null
> +++ b/drivers/video/backlight/s6e8ax0.c
> @@ -0,0 +1,801 @@
> +/* linux/drivers/video/s6e8ax0.c
> + *
> + * MIPI-DSI based s6e8ax0 AMOLED lcd 4.65 inch panel driver.
> + *
> + * Inki Dae, <inki.dae@samsung.com>
> + * Donghwa Lee, <dh09.lee@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/wait.h>
> +#include <linux/ctype.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/lcd.h>
> +#include <linux/fb.h>
> +#include <linux/backlight.h>
> +#include <linux/mipi_dsim.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include "s6e8ax0_gamma.h"
> +
> +#define LDI_MTP_LENGTH		24
> +#define DSIM_PM_STABLE_TIME	(10)
> +#define MIN_BRIGHTNESS		(0)
> +#define MAX_BRIGHTNESS		(24)
> +
> +#define POWER_IS_ON(pwr)	((pwr) = FB_BLANK_UNBLANK)
> +#define POWER_IS_OFF(pwr)	((pwr) = FB_BLANK_POWERDOWN)
> +#define POWER_IS_NRM(pwr)	((pwr) = FB_BLANK_NORMAL)
> +
> +#define lcd_to_master(a)	(a->dsim_dev->master)
> +#define lcd_to_master_ops(a)	((lcd_to_master(a))->master_ops)

These two can (and hence should) be implemented as nice type-checked C
functions.

> +static void s6e8ax0_panel_cond(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +
> +	unsigned char data_to_send[] = {
> +		0xf8, 0x3d, 0x35, 0x00, 0x00, 0x00, 0x93, 0x00, 0x3c,
> +		0x7d, 0x08, 0x27, 0x7d, 0x3f, 0x00, 0x00, 0x00, 0x20,
> +		0x04, 0x08, 0x6e, 0x00, 0x00, 0x00, 0x02, 0x08, 0x08,
> +		0x23, 0x23, 0xc0, 0xc8, 0x08, 0x48, 0xc1, 0x00, 0xc1,
> +		0xff, 0xff, 0xc8
> +	};
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +		data_to_send, ARRAY_SIZE(data_to_send));
> +}

It should be possible to make data_to_send[] static const.  That will
save quite a lot of runtime overhead and space.  It will require that
mipi_dsim_master_ops.cmd_write() take a const pointer.

> +static void s6e8ax0_display_cond(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +	unsigned char data_to_send[] = {
> +		0xf2, 0x80, 0x03, 0x0d
> +	};

Ditto.

> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +		data_to_send, ARRAY_SIZE(data_to_send));
> +}
> +
> +/* Gamma 2.2 Setting (200cd, 7500K, 10MPCD) */
> +static void s6e8ax0_gamma_cond(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +	unsigned int gamma = lcd->bd->props.brightness;
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +			s6e8ax0_22_gamma_table[gamma], GAMMA_TABLE_COUNT);
> +}
> +
> +static void s6e8ax0_gamma_update(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +	unsigned char data_to_send[] = {
> +		0xf7, 0x03
> +	};

And many more.

>
> ...
>
> +static void s6e8ax0_power_on(struct mipi_dsim_lcd_device *dsim_dev, int power)
> +{
> +	struct s6e8ax0 *lcd = dev_get_drvdata(&dsim_dev->dev);
> +
> +	mdelay(lcd->ddi_pd->power_on_delay);
> +
> +	/* lcd power on */
> +	if (power)
> +		s6e8ax0_regulator_enable(lcd);
> +	else
> +		s6e8ax0_regulator_disable(lcd);
> +
> +	mdelay(lcd->ddi_pd->reset_delay);
> +
> +	/* lcd reset */
> +	if (lcd->ddi_pd->reset)
> +		lcd->ddi_pd->reset(lcd->ld);
> +	mdelay(5);
> +}

This driver uses mdelay() a lot.  It would be far better to use
msleep() where possible.  Please check all the mdelay() sites, see
which ones can be converted?

> --- /dev/null
> +++ b/drivers/video/backlight/s6e8ax0_gamma.h
> @@ -0,0 +1,217 @@
> +/* linux/drivers/video/backlight/s6e8ax0_brightness.h
> + *
> + * Brightness level definition.
> + *
> + * Copyright (c) 2011 Samsung Electronics
> + *
> + * Inki Dae, <inki.dae@samsung.com>
> + * Donghwa Lee <dh09.lee@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef _S6E8AX0_BRIGHTNESS_H
> +#define _S6E8AX0_BRIGHTNESS_H
> +
> +#define MAX_GAMMA_LEVEL		25
> +#define GAMMA_TABLE_COUNT	26
> +
> +static unsigned char s6e8ax0_22_gamma_30[] = {
> +	0xFA, 0x01, 0x60, 0x10, 0x60, 0xF5, 0x00, 0xFF, 0xAD, 0xAF,
> +	0xBA, 0xC3, 0xD8, 0xC5, 0x9F, 0xC6, 0x9E, 0xC1, 0xDC, 0xC0,
> +	0x00, 0x61, 0x00, 0x5A, 0x00, 0x74,
> +};

No, please don't define data in a header file.

See, if this header gets included by two or more .c files then the
kernel contains two or more copies of the data.  And if this header
*isn't* included in two or more header files then there was no point in
putting the data in a header file!

So either a) move this data into the .c file which uses it or b) put it
into a .c file, remove the "static" and add declarations to a header
file.

>
> ...
>
