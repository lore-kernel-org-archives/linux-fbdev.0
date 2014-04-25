From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 25 Apr 2014 09:00:38 +0000
Subject: Re: [PATCH 08/13] video/backlight: LM3630A needs PWM
Message-Id: <000801cf6064$d3db1460$7b913d20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
 <1398342509-10243-9-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-9-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Peter Griffin' <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, 'Arnd Bergmann' <arnd@arndb.de>, 'Bryan Wu' <cooloney@gmail.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, April 24, 2014 9:28 PM, Peter Griffin wrote:
> 
> The LM3630A driver cannot be successfully built if we don't
> enable the PWM subsystem. This patch makes that dependency
> explicit in Kconfig and prevents broken randconfig builds.
> 
> Based on Arnd Bergmann patch but split out into seperate
> commits per driver based on feedback.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: Jingoo Han <jg1.han@samsung.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

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
> index 5a3eb2e..4791af7 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -370,7 +370,7 @@ config BACKLIGHT_AAT2870
> 
>  config BACKLIGHT_LM3630A
>  	tristate "Backlight Driver for LM3630A"
> -	depends on BACKLIGHT_CLASS_DEVICE && I2C
> +	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM
>  	select REGMAP_I2C
>  	help
>  	  This supports TI LM3630A Backlight Driver
> --
> 1.7.9.5

