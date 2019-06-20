From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 20 Jun 2019 13:31:58 +0000
Subject: Re: [PATCH v1] backlight: Don't build support by default
Message-Id: <7958bf6a-5c2e-1330-1800-f9dbce3c01c6@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <70bd61f9-8fc5-75b1-9f32-7a5826ce6b48@free.fr>
In-Reply-To: <70bd61f9-8fc5-75b1-9f32-7a5826ce6b48@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>

On 12/06/2019 14:27, Marc Gonzalez wrote:
> b20c5249aa6a ("backlight: Fix compile error if CONFIG_FB is unset")
> added 'default m' for BACKLIGHT_CLASS_DEVICE and LCD_CLASS_DEVICE.

It took me some little while until I realized this patch is from 2005 
which explains why I couldn't find it in the modern git repo!


> Let's go back to not building support by default.

At first glance disabling this by default looks like it would cause some 
existing defconfig files to disable useful drivers.

For backlight I think this isn't true (because both DRM and FB_BACKLIGHT 
have a "select" on BACKLIGHT_CLASS_DEVICE).

However for LCD it is not nearly as clear cut. Commit message needs to 
explain why this won't cause unacceptable problems for existinng 
defconfig files.


Daniel.




> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>   drivers/video/backlight/Kconfig | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8b081d61773e..40676be2e46a 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -10,7 +10,6 @@ menu "Backlight & LCD device support"
>   #
>   config LCD_CLASS_DEVICE
>           tristate "Lowlevel LCD controls"
> -	default m
>   	help
>   	  This framework adds support for low-level control of LCD.
>   	  Some framebuffer devices connect to platform-specific LCD modules
> @@ -143,7 +142,6 @@ endif # LCD_CLASS_DEVICE
>   #
>   config BACKLIGHT_CLASS_DEVICE
>           tristate "Lowlevel Backlight controls"
> -	default m
>   	help
>   	  This framework adds support for low-level control of the LCD
>             backlight. This includes support for brightness and power.
> 
