From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
Date: Mon, 19 Mar 2018 05:27:16 +0000
Subject: RE: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of platform dependency
Message-Id: <AM5PR04MB3267989AB6A81639F61AB165ECD40@AM5PR04MB3267.eurprd04.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
	<1521208314-4783-11-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1521208314-4783-11-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "James E . J . Bottomley" <jejb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Martin K . Petersen" <martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Herbert Xu <herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stefan Richter <stefanr-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org>, Alan Tull <atull-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Moritz Fischer <mdf-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matias Bjorling <mb-VR7NuqX4VJ8tq7phqP6ubQ@public.gmane.org>, Jassi Brar <jas>
Cc: "devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org" <devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fpga-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fpga-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWMMKQXVYFwzLw@public.gmane.org>

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Geert Uytterhoeven
> Sent: Friday, March 16, 2018 3:52 PM
> To: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <robin.murphy@arm.com>;
> Felipe Balbi <balbi@kernel.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; James E . J . Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; Andrew Morton <akpm@linux-
> foundation.org>; Mark Brown <broonie@kernel.org>; Liam Girdwood
> <lgirdwood@gmail.com>; Tejun Heo <tj@kernel.org>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S . Miller <davem@davemloft.net>;
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>; Stefan Richter
> <stefanr@s5r6.in-berlin.de>; Alan Tull <atull@kernel.org>; Moritz Fischer
> <mdf@kernel.org>; Wolfram Sang <wsa@the-dreams.de>; Jonathan Cameron
> <jic23@kernel.org>; Joerg Roedel <joro@8bytes.org>; Matias Bjorling
> <mb@lightnvm.io>; Jassi Brar <jassisinghbrar@gmail.com>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; David
> Woodhouse <dwmw2@infradead.org>; Brian Norris
> <computersforpeace@gmail.com>; Marek Vasut <marek.vasut@gmail.com>;
> Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Boris Brezillon
> <boris.brezillon@free-electrons.com>; Richard Weinberger <richard@nod.at>;
> Kalle Valo <kvalo@codeaurora.org>; Ohad Ben-Cohen <ohad@wizery.com>;
> Bjorn Andersson <bjorn.andersson@linaro.org>; Eric Anholt <eric@anholt.net>;
> Stefan Wahren <stefan.wahren@i2se.com>
> Cc: iommu@lists.linux-foundation.org; linux-usb@vger.kernel.org; linux-
> scsi@vger.kernel.org; alsa-devel@alsa-project.org; linux-ide@vger.kernel.org;
> linux-crypto@vger.kernel.org; linux-fbdev@vger.kernel.org; linux1394-
> devel@lists.sourceforge.net; linux-fpga@vger.kernel.org; linux-
> i2c@vger.kernel.org; linux-iio@vger.kernel.org; linux-block@vger.kernel.org;
> linux-media@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
> mtd@lists.infradead.org; netdev@vger.kernel.org; linux-
> remoteproc@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> spi@vger.kernel.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of
> platform dependency
> 
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on
> another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Notes:
>   - FSL_FMAN keeps its dependency on HAS_DMA, as it calls set_dma_ops(),
>     which does not exist if HAS_DMA=n (Do we need a dummy? The use of
>     set_dma_ops() in this driver is questionable),

Hi,

The set_dma_ops() is no longer required in the fsl/fman, I'll send a patch to remove it.

Thanks

>   - SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_PLATFORM loose their
>     dependency on HAS_DMA, as they are selected from
>     SND_SOC_APQ8016_SBC.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/lightnvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 10c08982185a572f..9c03f35d9df113c6 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,7 +4,7 @@
> 
>  menuconfig NVM
>  	bool "Open-Channel SSD target support"
> -	depends on BLOCK && HAS_DMA && PCI
> +	depends on BLOCK && PCI
>  	select BLK_DEV_NVME
>  	help
>  	  Say Y here to get to enable Open-channel SSDs.
> --
> 2.7.4

