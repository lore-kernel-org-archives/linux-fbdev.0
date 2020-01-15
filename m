From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 14:50:16 +0000
Subject: Re: [PATCH v2] video: fbdev: vesafb: add missed release_region
Message-Id: <69c018bc-b51b-0eab-39bc-6cd14a0245e5@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191205160725eucas1p226595a8d3043f48183a0a646bda61b4c@eucas1p2.samsung.com>
 <20191205160712.32245-1-hslester96@gmail.com>
In-Reply-To: <20191205160712.32245-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 12/5/19 5:07 PM, Chuhong Yuan wrote:
> The driver forgets to free the requested irq in remove and probe
> failure.

This is I/O region not IRQ.

> Add the missed calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Modify commit message.
> 
>  drivers/video/fbdev/vesafb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index d9c08f6c2155..fbb196a8bbf6 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -468,6 +468,7 @@ static int vesafb_probe(struct platform_device *dev)
>  	fb_info(info, "%s frame buffer device\n", info->fix.id);
>  	return 0;
>  err:
> +	release_region(0x3c0, 32);

There is one 'goto err;' instance before request_region() which
needs to be taken care of first.

>  	arch_phys_wc_del(par->wc_cookie);
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
> @@ -480,6 +481,7 @@ static int vesafb_remove(struct platform_device *pdev)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  
> +	release_region(0x3c0, 32);
>  	unregister_framebuffer(info);

The order of operations on remove should be the reverse of
order of operations on probe.

[ We cannot release I/O region while framebuffer is active. ]

>  	framebuffer_release(info);

Please fix the patch and re-submit.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
