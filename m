From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 10 Feb 2014 00:22:44 +0000
Subject: Re: [PATCH] backlight: replace kfree with put_device
Message-Id: <003701cf25f6$3807c6d0$a8175470$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391762601-4560-1-git-send-email-levex@linux.com>
In-Reply-To: <1391762601-4560-1-git-send-email-levex@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Levente Kurusa' <levex@linux.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'FBDEV list' <linux-fbdev@vger.kernel.org>, 'Bryan Wu' <cooloney@gmail.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, February 07, 2014 5:43 PM, Levente Kurusa wrote:
> 
> As per the comments on device_register, we shouldn't call kfree()
> right after a device_register() failure. Instead call put_device(),
> which in turn will call bl_device_release resulting in a kfree to the
> full structure.
> 
> Signed-off-by: Levente Kurusa <levex@linux.com>

(+cc Bryan Wu, Lee Jones)

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 5d05555..20b276e 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -333,7 +333,7 @@ struct backlight_device *backlight_device_register(const char *name,
> 
>  	rc = device_register(&new_bd->dev);
>  	if (rc) {
> -		kfree(new_bd);
> +		put_device(&new_bd->dev);
>  		return ERR_PTR(rc);
>  	}
> 
> --
> 1.8.3.1

