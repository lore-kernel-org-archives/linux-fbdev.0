From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 26 Sep 2013 00:59:04 +0000
Subject: Re: [PATCH] OMAPDSS: Add missing dependency on backlight for DSI-CM panel drier
Message-Id: <000101ceba53$985740b0$c905c210$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380108661-22702-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1380108661-22702-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Mark Brown' <broonie@kernel.org>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, 'Mark Brown' <broonie@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, September 25, 2013 8:31 PM, Mark Brown wrote:
> 
> From: Mark Brown <broonie@linaro.org>
> 
> The DSI-CM driver uses the backlight class so needs to build depend on it.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

I checked that the following build errors are removed.
drivers/video/omap2/displays-new/panel-dsi-cm.c:1257: undefined reference to `backlight_device_register'
drivers/video/omap2/displays-new/panel-dsi-cm.c:1283: undefined reference to `backlight_device_unregister'
drivers/built-in.o: In function `dsicm_remove':
drivers/video/omap2/displays-new/panel-dsi-cm.c:1309: undefined reference to `backlight_device_unregister'

Thank you.

Best regards,
Jingoo Han

> ---
>  drivers/video/omap2/displays-new/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/omap2/displays-new/Kconfig
> index 6c90885..10b25e7 100644
> --- a/drivers/video/omap2/displays-new/Kconfig
> +++ b/drivers/video/omap2/displays-new/Kconfig
> @@ -35,6 +35,7 @@ config DISPLAY_PANEL_DPI
> 
>  config DISPLAY_PANEL_DSI_CM
>  	tristate "Generic DSI Command Mode Panel"
> +	depends on BACKLIGHT_CLASS_DEVICE
>  	help
>  	  Driver for generic DSI command mode panels.
> 
> --
> 1.8.4.rc3

