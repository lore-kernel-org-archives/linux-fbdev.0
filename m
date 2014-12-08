From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 08 Dec 2014 11:41:29 +0000
Subject: Re: [PATCH 2/4] backlight/lp855x: Remove platform_data header
Message-Id: <000b01d012db$e836d5f0$b8a481d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417805069-20441-2-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417805069-20441-2-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Saturday, December 06, 2014 3:44 AM, Sean Paul wrote:
> 
> No one uses lp855x platform data any longer, remove the header
> and move its contents into the driver.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  MAINTAINERS                          |  1 -
>  drivers/video/backlight/lp855x_bl.c  | 37 +++++++++++++++++++++++++-
>  include/linux/platform_data/lp855x.h | 51 ------------------------------------
>  3 files changed, 36 insertions(+), 53 deletions(-)
>  delete mode 100644 include/linux/platform_data/lp855x.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c64271..4896edb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9318,7 +9318,6 @@ M:	Milo Kim <milo.kim@ti.com>
>  S:	Maintained
>  F:	Documentation/backlight/lp855x-driver.txt
>  F:	drivers/video/backlight/lp855x_bl.c
> -F:	include/linux/platform_data/lp855x.h
> 
>  TI LP8727 CHARGER DRIVER
>  M:	Milo Kim <milo.kim@ti.com>
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index a26d3bb..d19b61c 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -15,7 +15,6 @@
>  #include <linux/backlight.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -#include <linux/platform_data/lp855x.h>
>  #include <linux/pwm.h>
>  #include <linux/regulator/consumer.h>
> 
> @@ -63,6 +62,42 @@ struct lp855x_device_config {
>  	int (*post_init_device)(struct lp855x *);
>  };
> 
> +enum lp855x_chip_id {
> +	LP8550,
> +	LP8551,
> +	LP8552,
> +	LP8553,
> +	LP8555,
> +	LP8556,
> +	LP8557,
> +};
> +
> +struct lp855x_rom_data {
> +	u8 addr;
> +	u8 val;
> +};
> +
> +/**
> + * struct lp855x_platform_data
> + * @name : Backlight driver name. If it is not defined, default name is set.
> + * @device_control : value of DEVICE CONTROL register
> + * @initial_brightness : initial value of backlight brightness
> + * @period_ns : platform specific pwm period value. unit is nano.
> +		Only valid when mode is PWM_BASED.
> + * @size_program : total size of lp855x_rom_data
> + * @rom_data : list of new eeprom/eprom registers
> + * @supply : regulator that supplies 3V input
> + */
> +struct lp855x_platform_data {
> +	const char *name;
> +	u8 device_control;
> +	u8 initial_brightness;
> +	unsigned int period_ns;
> +	int size_program;
> +	struct lp855x_rom_data *rom_data;
> +	struct regulator *supply;
> +};
> +
>  struct lp855x {
>  	const char *chipname;
>  	enum lp855x_chip_id chip_id;
> diff --git a/include/linux/platform_data/lp855x.h b/include/linux/platform_data/lp855x.h
> deleted file mode 100644
> index 9e3ac3c..0000000
> --- a/include/linux/platform_data/lp855x.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/*
> - * LP855x Backlight Driver
> - *
> - *			Copyright (C) 2011 Texas Instruments
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - */
> -
> -#ifndef _LP855X_H
> -#define _LP855X_H
> -
> -enum lp855x_chip_id {
> -	LP8550,
> -	LP8551,
> -	LP8552,
> -	LP8553,
> -	LP8555,
> -	LP8556,
> -	LP8557,
> -};
> -
> -struct lp855x_rom_data {
> -	u8 addr;
> -	u8 val;
> -};
> -
> -/**
> - * struct lp855x_platform_data
> - * @name : Backlight driver name. If it is not defined, default name is set.
> - * @device_control : value of DEVICE CONTROL register
> - * @initial_brightness : initial value of backlight brightness
> - * @period_ns : platform specific pwm period value. unit is nano.
> -		Only valid when mode is PWM_BASED.
> - * @size_program : total size of lp855x_rom_data
> - * @rom_data : list of new eeprom/eprom registers
> - * @supply : regulator that supplies 3V input
> - */
> -struct lp855x_platform_data {
> -	const char *name;
> -	u8 device_control;
> -	u8 initial_brightness;
> -	unsigned int period_ns;
> -	int size_program;
> -	struct lp855x_rom_data *rom_data;
> -	struct regulator *supply;
> -};
> -
> -#endif
> --
> 2.2.0.rc0.207.ga3a616c

