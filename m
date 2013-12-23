From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 23 Dec 2013 08:15:22 +0000
Subject: Re: [PATCH] ARM: i.MX: Remove IMX_HAVE_PLATFORM_IMX_FB symbol
Message-Id: <20131223081520.GE26070@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387612703-18512-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1387612703-18512-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Dec 21, 2013 at 11:58:23AM +0400, Alexander Shiyan wrote:
<snip>
> @@ -9,8 +9,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX27_CODA) += platform-imx27-coda.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
> -obj-y += platform-imx-dma.o
> -obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
> +obj-y += platform-imx-dma.o platform-imx-fb.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_KEYPAD) += platform-imx-keypad.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_PATA_IMX) += platform-pata_imx.o
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 4f2e1b3..e7d8d88 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -363,7 +363,7 @@ config FB_SA1100
>  
>  config FB_IMX
>  	tristate "Freescale i.MX1/21/25/27 LCD support"
> -	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> +	depends on FB && (SOC_IMX1 || SOC_IMX21 || SOC_IMX25 || SOC_IMX27)

Denis had a patch below to address the same problem.

http://thread.gmane.org/gmane.linux.drivers.devicetree/49472

In this way, we can still have IMX_HAVE_PLATFORM_IMX_FB to control the
build of platform-imx-fb.o.

Shawn 

>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 1.8.3.2
> 

