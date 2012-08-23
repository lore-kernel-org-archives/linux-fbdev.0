From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:36:48 +0000
Subject: Re: [PATCH 1/5] drivers/video/bf537-lq035.c: use devm_ functions
Message-Id: <50369460.7010303@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr> <1343742860-16213-6-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343742860-16213-6-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/31/2012 01:54 PM, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/bf537-lq035.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
> index befbc80..7347aa1 100644
> --- a/drivers/video/bf537-lq035.c
> +++ b/drivers/video/bf537-lq035.c
> @@ -760,18 +760,20 @@ static int __devinit bfin_lq035_probe(struct platform_device *pdev)
>  	bfin_lq035_fb.flags = FBINFO_DEFAULT;
>  
>  
> -	bfin_lq035_fb.pseudo_palette = kzalloc(sizeof(u32) * 16, GFP_KERNEL);
> +	bfin_lq035_fb.pseudo_palette = devm_kzalloc(&pdev->dev,
> +						    sizeof(u32) * 16,
> +						    GFP_KERNEL);
>  	if (bfin_lq035_fb.pseudo_palette = NULL) {
>  		pr_err("failed to allocate pseudo_palette\n");
>  		ret = -ENOMEM;
> -		goto out_palette;
> +		goto out_table;
>  	}
>  
>  	if (fb_alloc_cmap(&bfin_lq035_fb.cmap, NBR_PALETTE, 0) < 0) {
>  		pr_err("failed to allocate colormap (%d entries)\n",
>  			NBR_PALETTE);
>  		ret = -EFAULT;
> -		goto out_cmap;
> +		goto out_table;
>  	}
>  
>  	if (register_framebuffer(&bfin_lq035_fb) < 0) {
> @@ -804,9 +806,6 @@ out_lcd:
>  	unregister_framebuffer(&bfin_lq035_fb);
>  out_reg:
>  	fb_dealloc_cmap(&bfin_lq035_fb.cmap);
> -out_cmap:
> -	kfree(bfin_lq035_fb.pseudo_palette);
> -out_palette:
>  out_table:
>  	dma_free_coherent(NULL, TOTAL_VIDEO_MEM_SIZE, fb_buffer, 0);
>  	fb_buffer = NULL;
> @@ -834,7 +833,6 @@ static int __devexit bfin_lq035_remove(struct platform_device *pdev)
>  	free_dma(CH_PPI);
>  
>  
> -	kfree(bfin_lq035_fb.pseudo_palette);
>  	fb_dealloc_cmap(&bfin_lq035_fb.cmap);
>  
>  
> 
> 

