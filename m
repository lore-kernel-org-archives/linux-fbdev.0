From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 07 Jan 2014 01:42:11 +0000
Subject: Re: [PATCH 3/4] backlight: lcd: call put_device if device_register fails
Message-Id: <000001cf0b49$af5ab7f0$0e1027d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386959996-7958-1-git-send-email-levex@linux.com>
 <1386959996-7958-4-git-send-email-levex@linux.com>
In-Reply-To: <1386959996-7958-4-git-send-email-levex@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Levente Kurusa' <levex@linux.com>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>

On Saturday, December 14, 2013 3:40 AM, Levente Kurusa wrote:
> 
> Currently we kfree the container of the device which failed to register.
> This is wrong as the last reference is not given up with a put_device
> call. Also, now that we have put_device() callen, we no longer need
> the kfree as the new_ld->dev.release function will take care of kfreeing
> the associated memory.
> 
> Signed-off-by: Levente Kurusa <levex@linux.com>
> ---
>  drivers/video/backlight/lcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index 93cf15e..7de847d 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -228,7 +228,7 @@ struct lcd_device *lcd_device_register(const char *name, struct device *parent,
> 
>  	rc = device_register(&new_ld->dev);
>  	if (rc) {
> -		kfree(new_ld);
> +		put_device(&new_ld->dev);
>  		return ERR_PTR(rc);
>  	}

(+cc Andrew Morton)

Hi Levente Kurusa,

Would you fix the same thing for 'backlight.c' file?

./drivers/video/backlight/backlight.c
struct backlight_device *backlight_device_register(const char *name,
    .....
    rc = device_register(&new_bd->dev);
            if (rc) {
                    kfree(new_bd);
                    return ERR_PTR(rc);
            }

Best regards,
Jingoo Han

