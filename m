From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 20 Sep 2013 17:26:27 +0000
Subject: Re: [PATCH 24/51] DMA-API: dma: pl330: add dma_set_mask_and_coherent() call
Message-Id: <201309201926.29084.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1VMm5t-0007i5-V7-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvme-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, b43-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Solarflare linux maintainers <linux-net-drivers-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-crypto-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Am Donnerstag, 19. September 2013, 23:49:01 schrieb Russell King:
> The DMA API requires drivers to call the appropriate dma_set_mask()
> functions before doing any DMA mapping.  Add this required call to
> the AMBA PL08x driver.
			^--- copy and paste error - should of course be PL330


> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/pl330.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index a562d24..df8b10f 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2903,6 +2903,10 @@ pl330_probe(struct amba_device *adev, const struct
> amba_id *id)
> 
>  	pdat = dev_get_platdata(&adev->dev);
> 
> +	ret = dma_set_mask_and_coherent(&adev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
>  	/* Allocate a new DMAC and its Channels */
>  	pdmac = devm_kzalloc(&adev->dev, sizeof(*pdmac), GFP_KERNEL);
>  	if (!pdmac) {

