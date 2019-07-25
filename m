From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 25 Jul 2019 09:49:31 +0000
Subject: Re: [PATCH] backlight: lms283gf05: Fix a typo in the description passed to 'devm_gpio_request_one()'
Message-Id: <20190725094931.biqd3pkt4kuaujaq@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Jul 24, 2019 at 11:38:28PM +0200, Christophe JAILLET wrote:
> The description passed to 'devm_gpio_request_one()' should be related to
> LMS283GF05, not LMS285GF05.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/lms283gf05.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
> index 4237aaa7f269..4b62ed7e58c0 100644
> --- a/drivers/video/backlight/lms283gf05.c
> +++ b/drivers/video/backlight/lms283gf05.c
> @@ -161,7 +161,7 @@ static int lms283gf05_probe(struct spi_device *spi)
>  		ret = devm_gpio_request_one(&spi->dev, pdata->reset_gpio,
>  				GPIOF_DIR_OUT | (!pdata->reset_inverted ?
>  				GPIOF_INIT_HIGH : GPIOF_INIT_LOW),
> -				"LMS285GF05 RESET");
> +				"LMS283GF05 RESET");
>  		if (ret)
>  			return ret;
>  	}
> -- 
> 2.20.1
> 
