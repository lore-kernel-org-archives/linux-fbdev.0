From: Bryan Wu <cooloney@gmail.com>
Date: Thu, 24 Apr 2014 16:48:18 +0000
Subject: Re: [PATCH 12/13] video/backlight: LP855X needs PWM
Message-Id: <CAK5ve-L5bDo05BjVJhF6M8kzrUUC=fCcZwZpM-PU2eQnsryOxA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-13-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-13-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Griffin <peter.griffin@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>, Milo Kim <milo.kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, FBDEV list <linux-fbdev@vger.kernel.org>

On Thu, Apr 24, 2014 at 5:28 AM, Peter Griffin <peter.griffin@linaro.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The LP855X driver cannot be successfully built if we don't
> enable the PWM subsystem. This patch makes that dependency
> explicit in Kconfig and prevents broken randconfig builds.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Milo Kim <milo.kim@ti.com>
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
> index 5675511..5d44905 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -386,7 +386,7 @@ config BACKLIGHT_LM3639
>
>  config BACKLIGHT_LP855X
>         tristate "Backlight driver for TI LP855X"
> -       depends on BACKLIGHT_CLASS_DEVICE && I2C
> +       depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM

Looks good to me,
Acked-by: Bryan Wu <cooloney@gmail.com>

>         help
>           This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
>           LP8557 backlight driver.
> --
> 1.7.9.5
>
