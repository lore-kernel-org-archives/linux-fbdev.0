From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Sep 2011 18:50:47 +0000
Subject: Re: [PATCH] backlight: l4f00242t03: Use gpio_request_one to simplify
Message-Id: <CAOMZO5CyfbbzdxhaQXN=yg32+i3_kCdfEmmO5NN7vpNhMW9x8Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Andrew,

Would you take this one?

Thanks,

Fabio Estevam

On Fri, Aug 19, 2011 at 12:58 AM, Estevam Fabio-R49496
<r49496@freescale.com> wrote:
> Richard,
>
> Ping?
>
> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Friday, June 24, 2011 3:26 PM
> To: linux-fbdev@vger.kernel.org
> Cc: rpurdie@rpsys.net; Fabio Estevam; Estevam Fabio-R49496
> Subject: [PATCH] backlight: l4f00242t03: Use gpio_request_one to simplify error handling
>
> Using gpio_request_one can make the error handling simpler.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/backlight/l4f00242t03.c |   17 +++++------------
>  1 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
> index 98ad3e5..d6b0812 100644
> --- a/drivers/video/backlight/l4f00242t03.c
> +++ b/drivers/video/backlight/l4f00242t03.c
> @@ -178,29 +178,22 @@ static int __devinit l4f00242t03_probe(struct spi_device *spi)
>
>        priv->spi = spi;
>
> -       ret = gpio_request(pdata->reset_gpio, "lcd l4f00242t03 reset");
> +       ret = gpio_request_one(pdata->reset_gpio, GPIOF_OUT_INIT_HIGH,
> +                                               "lcd l4f00242t03 reset");
>        if (ret) {
>                dev_err(&spi->dev,
>                        "Unable to get the lcd l4f00242t03 reset gpio.\n");
>                goto err;
>        }
>
> -       ret = gpio_direction_output(pdata->reset_gpio, 1);
> -       if (ret)
> -               goto err2;
> -
> -       ret = gpio_request(pdata->data_enable_gpio,
> -                               "lcd l4f00242t03 data enable");
> +       ret = gpio_request_one(pdata->data_enable_gpio, GPIOF_OUT_INIT_LOW,
> +                                               "lcd l4f00242t03 data enable");
>        if (ret) {
>                dev_err(&spi->dev,
>                        "Unable to get the lcd l4f00242t03 data en gpio.\n");
>                goto err2;
>        }
> -
> -       ret = gpio_direction_output(pdata->data_enable_gpio, 0);
> -       if (ret)
> -               goto err3;
> -
> +
>        if (pdata->io_supply) {
>                priv->io_reg = regulator_get(NULL, pdata->io_supply);
>
> --
> 1.7.1
>
>
>
>
