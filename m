From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 29 Mar 2011 04:37:12 +0000
Subject: Re: [patch] backlight/ld9040.c: testing the wrong variable in
Message-Id: <4D9161F8.3050004@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110329031909.GC9856@bicker>
In-Reply-To: <20110329031909.GC9856@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

 On 2011-03-29, Dan Carpenter wrote:
> We should be testing "bd" here instead of "ld".  It's a copy and
> paste bug.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
>
> diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
> index 7281b25..9e81d69 100644
> --- a/drivers/video/backlight/ld9040.c
> +++ b/drivers/video/backlight/ld9040.c
> @@ -701,8 +701,8 @@ static int ld9040_probe(struct spi_device *spi)
>  
>  	bd = backlight_device_register("ld9040-bl", &spi->dev,
>  		lcd, &ld9040_backlight_ops, NULL);
> -	if (IS_ERR(ld)) {
> -		ret = PTR_ERR(ld);
> +	if (IS_ERR(bd)) {
> +		ret = PTR_ERR(bd);
>  		goto out_free_lcd;
>  	}
>  
>

Yes, It's my mistake. It has to be changed as you said.

Thank you,

