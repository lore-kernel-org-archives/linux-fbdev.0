From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 16 Dec 2013 11:34:10 +0000
Subject: Re: [PATCH] drivers: video: Remove unused function genericbl_limit_intensity() in generic_bl.c
Message-Id: <001201cefa52$bd3dcf90$37b96eb0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131216112110.GA4849@rashika>
In-Reply-To: <20131216112110.GA4849@rashika>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 'Eric Miao' <eric.y.miao@gmail.com>
Cc: 'Rashika Kheria' <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, 'Josh Triplett' <josh@joshtriplett.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, December 16, 2013 8:21 PM, Rashika Kheria wrote:
> 
> Removes unused function genericbl_limit_intensity() in
> backlight/generic_bl.c.
> 
> This eliminates the following warning in backlight/generic_bl.c:
> drivers/video/backlight/generic_bl.c:59:6: warning: no previous prototype for
> ‘genericbl_limit_intensity’ [-Wmissing-prototypes]

Hi Eric,

Originally, genericbl_limit_intensity() was added by you.
(commit: bfdcaa3 "lcd: add corgibl_limit_intensity() to corgi_lcd")

Currently, genericbl_limit_intensity() is not called anywhere
in mainline kernel. Can we remove this genericbl_limit_intensity()?


Best regards,
Jingoo Han

> 
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
> ---
>  drivers/video/backlight/generic_bl.c |   18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlight/generic_bl.c
> index 5d8d652..67dfb93 100644
> --- a/drivers/video/backlight/generic_bl.c
> +++ b/drivers/video/backlight/generic_bl.c
> @@ -52,24 +52,6 @@ static int genericbl_get_intensity(struct backlight_device *bd)
>  	return genericbl_intensity;
>  }
> 
> -/*
> - * Called when the battery is low to limit the backlight intensity.
> - * If limit=0 clear any limit, otherwise limit the intensity
> - */
> -void genericbl_limit_intensity(int limit)
> -{
> -	struct backlight_device *bd = generic_backlight_device;
> -
> -	mutex_lock(&bd->ops_lock);
> -	if (limit)
> -		bd->props.state |= GENERICBL_BATTLOW;
> -	else
> -		bd->props.state &= ~GENERICBL_BATTLOW;
> -	backlight_update_status(generic_backlight_device);
> -	mutex_unlock(&bd->ops_lock);
> -}
> -EXPORT_SYMBOL(genericbl_limit_intensity);
> -
>  static const struct backlight_ops genericbl_ops = {
>  	.options = BL_CORE_SUSPENDRESUME,
>  	.get_brightness = genericbl_get_intensity,
> --
> 1.7.9.5

