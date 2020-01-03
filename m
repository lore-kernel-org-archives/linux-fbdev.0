From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:14:08 +0000
Subject: Re: [PATCH -next] fbdev: omapfb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <3f75dae1-181f-3935-0b1d-40839392226e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190904115507epcas1p42d4d5b2f6ee58db0ccf3b1ee27063ac1@epcas1p4.samsung.com>
 <20190904115406.23880-1-yuehaibing@huawei.com>
In-Reply-To: <20190904115406.23880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alexios.zavras@intel.com, tglx@linutronix.de, linux-omap@vger.kernel.org, allison@lohutok.net


On 9/4/19 1:54 PM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/vrfb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/vrfb.c b/drivers/video/fbdev/omap2/omapfb/vrfb.c
> index 819e0bc..ee0dd4c 100644
> --- a/drivers/video/fbdev/omap2/omapfb/vrfb.c
> +++ b/drivers/video/fbdev/omap2/omapfb/vrfb.c
> @@ -339,9 +339,7 @@ static int __init vrfb_probe(struct platform_device *pdev)
>  	int i;
>  
>  	/* first resource is the register res, the rest are vrfb contexts */
> -
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	vrfb_base = devm_ioremap_resource(&pdev->dev, mem);
> +	vrfb_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(vrfb_base))
>  		return PTR_ERR(vrfb_base);
>  
