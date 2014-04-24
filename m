From: Bryan Wu <cooloney@gmail.com>
Date: Thu, 24 Apr 2014 16:46:05 +0000
Subject: Re: [PATCH 10/13] video/pxa: LCD_CORGI needs BACKLIGHT_CLASS_DEVICE
Message-Id: <CAK5ve-JQaWd64mD9RciQsN7=id01v4vJTDezy-U3GDZXQApoQA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-11-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-11-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Griffin <peter.griffin@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, FBDEV list <linux-fbdev@vger.kernel.org>

On Thu, Apr 24, 2014 at 5:28 AM, Peter Griffin <peter.griffin@linaro.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This fixes a randconfig build error when BACKLIGHT_CLASS_DEVICE
> is disabled, by describing the dependency in Kconfig,
> as we do for the other drivers in this directory.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/backlight/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index ac6bc28..5675511 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -29,7 +29,7 @@ if LCD_CLASS_DEVICE
>
>  config LCD_CORGI
>         tristate "LCD Panel support for SHARP corgi/spitz model"
> -       depends on SPI_MASTER && PXA_SHARPSL
> +       depends on SPI_MASTER && PXA_SHARPSL && BACKLIGHT_CLASS_DEVICE

Looks good to me,
Acked-by: Bryan Wu <cooloney@gmail.com>

>         help
>           Say y here to support the LCD panels usually found on SHARP
>           corgi (C7x0) and spitz (Cxx00) models.
> --
> 1.7.9.5
>
