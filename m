From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 16 Apr 2010 07:42:13 +0000
Subject: Re: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: fix Kconfig dependency
Message-Id: <1271403733.2690.275.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271343543-14348-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1271343543-14348-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-04-15 at 16:59 +0200, ext Grazvydas Ignotas wrote:
> This panel depends on SPI, not I2C.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---

Thanks, applied into my tree.

 Tomi

>  drivers/video/omap2/displays/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index dfb57ee..a2faf8a 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -33,7 +33,7 @@ config PANEL_TOPPOLY_TDO35S
>  
>  config PANEL_TPO_TD043MTEA1
>          tristate "TPO TD043MTEA1 LCD Panel"
> -        depends on OMAP2_DSS && I2C
> +        depends on OMAP2_DSS && SPI
>          help
>            LCD Panel used in OMAP3 Pandora
>  


