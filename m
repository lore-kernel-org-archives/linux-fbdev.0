From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:41:33 +0000
Subject: Re: [PATCH -next] video: fbdev: pxa168fb: remove unnecessary platform_get_irq
Message-Id: <a5c01548-9d80-f586-7d74-bd80458446ce@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200117032301eucas1p29817dfa06b4140d9e30634cf0052a5dd@eucas1p2.samsung.com>
 <20200117032241.59148-1-yuehaibing@huawei.com>
In-Reply-To: <20200117032241.59148-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, arnd@arndb.de, jani.nikula@intel.com, daniel.vetter@ffwll.ch, hslester96@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, christophe.jaillet@wanadoo.fr


On 1/17/20 4:22 AM, YueHaibing wrote:
> commit 640ba2444fa9 ("drivers/video/pxa168fb.c: use devm_ functions")
> left behind this, it can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for v5.7, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxa168fb.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index 706c6943..aef8a30 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -779,7 +779,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
>  {
>  	struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
>  	struct fb_info *info;
> -	int irq;
>  	unsigned int data;
>  
>  	if (!fbi)
> @@ -799,8 +798,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
>  	if (info->cmap.len)
>  		fb_dealloc_cmap(&info->cmap);
>  
> -	irq = platform_get_irq(pdev, 0);
> -
>  	dma_free_wc(fbi->dev, info->fix.smem_len,
>  		    info->screen_base, info->fix.smem_start);
>  
