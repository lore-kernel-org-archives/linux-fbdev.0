From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 15 Dec 2017 11:53:09 +0000
Subject: Re: [PATCH v2 2/3] backlight: tdo24m: add the reset line gpio
Message-Id: <20171215115309.ez7odo7sh5zz7vge@oak.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171013194250.9001-1-robert.jarzmik@free.fr>
 <20171013194250.9001-2-robert.jarzmik@free.fr>
In-Reply-To: <20171013194250.9001-2-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 13, 2017 at 09:42:48PM +0200, Robert Jarzmik wrote:
> The Toppoly panels have a global reset line. Add an optional gpio
> control for this line, for platforms which have the ability to drive it.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/video/backlight/tdo24m.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
> index e4bd63e9db6b..e4b2dfabf192 100644
> --- a/drivers/video/backlight/tdo24m.c
> +++ b/drivers/video/backlight/tdo24m.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
> @@ -32,6 +33,7 @@ struct tdo24m {
>  	struct spi_message	msg;
>  	struct spi_transfer	xfer;
>  	uint8_t			*buf;
> +	struct gpio_desc	*xres;

Why do we need a write-only variable?


>  	int (*adj_mode)(struct tdo24m *lcd, int mode);
>  	int color_invert;
> @@ -364,6 +366,7 @@ static int tdo24m_probe(struct spi_device *spi)
>  	if (lcd->buf = NULL)
>  		return -ENOMEM;
>  
> +	lcd->xres = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);

devm_gpiod_get_optional() would be better, if only for its commenting
value.

Also, this adds a new optional property, doesn't the devicetree binding 
docs need to be update to match this?


Daniel.


>  	m = &lcd->msg;
>  	x = &lcd->xfer;
>  
> -- 
> 2.11.0
> 
