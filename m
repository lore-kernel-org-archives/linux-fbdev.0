From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 29 Feb 2012 10:03:45 +0000
Subject: Re: [PATCH 1/2] OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
Message-Id: <4F4DF801.3000905@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com> <1330505302-8258-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330505302-8258-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
> panel-dvi uses i2c, but the Kconfig didn't have dependency on I2C. Add
> it.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/displays/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index 74d29b5..408a992 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -12,7 +12,7 @@ config PANEL_GENERIC_DPI
>  
>  config PANEL_DVI
>  	tristate "DVI output"
> -	depends on OMAP2_DSS_DPI
> +	depends on OMAP2_DSS_DPI && I2C

It's just a matter of taste, but are you sure you want to "depend" on it and not
"select" it? Other drivers tend to use select for I2C, for me it doesn't really
matter.


Best regards,

Florian Tobias Schandinat

>  	help
>  	  Driver for external monitors, connected via DVI. The driver uses i2c
>  	  to read EDID information from the monitor.

