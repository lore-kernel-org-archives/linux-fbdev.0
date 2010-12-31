From: Kukjin Kim <kgene.kim@samsung.com>
Date: Fri, 31 Dec 2010 06:57:41 +0000
Subject: RE: [PATCH 5/5] S5PC110: add MIPI-DSI based sample lcd panel driver.
Message-Id: <014101cba8b8$06318ab0$1294a010$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535595-24861-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1293535595-24861-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Inki Dae wrote:
> 
> this patch addes MIPI-DSI based sample panel driver.
> to write MIPI-DSI based lcd panel driver, you can refer to
> this sample driver.
> 
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> ---
>  drivers/video/Kconfig           |    7 ++
>  drivers/video/Makefile          |    1 +
>  drivers/video/s5p_mipi_sample.c |  220
> +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/s5p_mipi_sample.c
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index aa305c5..325ce86 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2003,6 +2003,13 @@ config S5P_MIPI_DSI
>  	---help---
>  	  This enables support for MIPI-DSI device.
> 
> +config S5P_MIPI_SAMPLE
> +	tristate "Samsung SoC MIPI-DSI based sample driver."
> +	depends on S5P_MIPI_DSI && BACKLIGHT_LCD_SUPPORT

Do we really need SAMPLE driver?...
And is this MIPI SAMPLE not MIPI DSIM sample?

> +	default n
> +	---help---
> +	  This enables support for MIPI-DSI based sample driver.
> +
>  config FB_NUC900
>          bool "NUC900 LCD framebuffer support"
>          depends on FB && ARCH_W90X900
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index f4baed6..c8ac591 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -117,6 +117,7 @@ obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
>  obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
>  obj-$(CONFIG_S5P_MIPI_DSI)	  += s5p_mipi_dsi.o s5p_mipi_dsi_common.o \
>      					s5p_mipi_dsi_lowlevel.o
> +obj-$(CONFIG_S5P_MIPI_SAMPLE)		+= s5p_mipi_sample.o
>  obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
>  obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
>  obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/

(snip)

Happy New Year!
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

