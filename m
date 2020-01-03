From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:17:36 +0000
Subject: Re: [PATCH -next] fbdev/sa1100fb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <de1f8697-3b8a-20f1-e3fe-73a889b0e68a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190904120019epcas2p2d20e3e922d6a51ebd51c226440bc5df9@epcas2p2.samsung.com>
 <20190904115754.21612-1-yuehaibing@huawei.com>
In-Reply-To: <20190904115754.21612-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, viresh.kumar@linaro.org


On 9/4/19 1:57 PM, YueHaibing wrote:
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
>  drivers/video/fbdev/sa1100fb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index ae2bcfe..4428cef 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -1156,7 +1156,6 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
>  static int sa1100fb_probe(struct platform_device *pdev)
>  {
>  	struct sa1100fb_info *fbi;
> -	struct resource *res;
>  	int ret, irq;
>  
>  	if (!dev_get_platdata(&pdev->dev)) {
> @@ -1172,8 +1171,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
>  	if (!fbi)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	fbi->base = devm_ioremap_resource(&pdev->dev, res);
> +	fbi->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(fbi->base))
>  		return PTR_ERR(fbi->base);
>  
