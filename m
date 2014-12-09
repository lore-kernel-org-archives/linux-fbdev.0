From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 09 Dec 2014 01:26:54 +0000
Subject: Re: [PATCH v2 2/4] backlight/lp855x: Remove platform_data header
Message-Id: <000801d0134f$37ae5360$a70afa20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418077278-14144-2-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1418077278-14144-2-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, December 09, 2014 7:21 AM, Sean Paul wrote:
> 
> No one uses lp855x platform data any longer, remove the header
> and move its contents into the driver.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> Changes in v2:
> 	- Removed platform data description from Documentation
> 
>  Documentation/backlight/lp855x-driver.txt | 38 -----------------------
>  MAINTAINERS                               |  1 -
>  drivers/video/backlight/lp855x_bl.c       | 37 +++++++++++++++++++++-
>  include/linux/platform_data/lp855x.h      | 51 -------------------------------
>  4 files changed, 36 insertions(+), 91 deletions(-)
>  delete mode 100644 include/linux/platform_data/lp855x.h
> 
> diff --git a/Documentation/backlight/lp855x-driver.txt b/Documentation/backlight/lp855x-driver.txt
> index 01bce24..33b83d9 100644
> --- a/Documentation/backlight/lp855x-driver.txt
> +++ b/Documentation/backlight/lp855x-driver.txt
> @@ -26,41 +26,3 @@ Value : pwm based or register based
>  2) chip_id
>  The lp855x chip id.
>  Value : lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
> -
> -Platform data for lp855x
> -------------------------
> -
> -For supporting platform specific data, the lp855x platform data can be used.
> -
> -* name : Backlight driver name. If it is not defined, default name is set.
> -* device_control : Value of DEVICE CONTROL register.
> -* initial_brightness : Initial value of backlight brightness.
> -* period_ns : Platform specific PWM period value. unit is nano.
> -	     Only valid when brightness is pwm input mode.
> -* size_program : Total size of lp855x_rom_data.
> -* rom_data : List of new eeprom/eprom registers.
> -
> -example 1) lp8552 platform data : i2c register mode with new eeprom data
> -
> -#define EEPROM_A5_ADDR	0xA5
> -#define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
> -
> -static struct lp855x_rom_data lp8552_eeprom_arr[] = {
> -	{EEPROM_A5_ADDR, EEPROM_A5_VAL},
> -};
> -
> -static struct lp855x_platform_data lp8552_pdata = {
> -	.name = "lcd-bl",
> -	.device_control = I2C_CONFIG(LP8552),
> -	.initial_brightness = INITIAL_BRT,
> -	.size_program = ARRAY_SIZE(lp8552_eeprom_arr),
> -	.rom_data = lp8552_eeprom_arr,
> -};
> -
> -example 2) lp8556 platform data : pwm input mode with default rom data
> -
> -static struct lp855x_platform_data lp8556_pdata = {
> -	.device_control = PWM_CONFIG(LP8556),
> -	.initial_brightness = INITIAL_BRT,
> -	.period_ns = 1000000,
> -};
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
> 2.1.1

