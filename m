From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 07 May 2015 07:37:08 +0000
Subject: Re: [PATCH 23/27] backlight: Allow compile test of GPIO consumers if !GPIOLIB
Message-Id: <20150507073708.GA12484@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-23-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-23-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Tue, 05 May 2015, Geert Uytterhoeven wrote:

> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
>=20
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/backlight/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Looks good.  Applied, thanks.

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 2d9923a60076e380..0505b796d743250e 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -36,14 +36,16 @@ config LCD_CORGI
> =20
>  config LCD_L4F00242T03
>  	tristate "Epson L4F00242T03 LCD"
> -	depends on SPI_MASTER && GPIOLIB
> +	depends on SPI_MASTER
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  SPI driver for Epson L4F00242T03. This provides basic support
>  	  for init and powering the LCD up/down through a sysfs interface.
> =20
>  config LCD_LMS283GF05
>  	tristate "Samsung LMS283GF05 LCD"
> -	depends on SPI_MASTER && GPIOLIB
> +	depends on SPI_MASTER
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  SPI driver for Samsung LMS283GF05. This provides basic support
>  	  for powering the LCD up/down through a sysfs interface.
> @@ -434,7 +436,7 @@ config BACKLIGHT_AS3711
> =20
>  config BACKLIGHT_GPIO
>  	tristate "Generic GPIO based Backlight Driver"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  If you have a LCD backlight adjustable by GPIO, say Y to enable
>  	  this driver.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
