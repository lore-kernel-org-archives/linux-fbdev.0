From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 26 Sep 2018 15:27:11 +0000
Subject: Re: [PATCH] pxa168fb: prepare the clock
Message-Id: <20180926152712eucas1p1c5f74a24ad299f43f473c662e994a522~X-LBvedqK1624116241eucas1p1X@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180910120403epcas1p25706c846d95df1e47092ebb040f70a7f@epcas1p2.samsung.com>
        <20180910120351.164257-1-lkundrak@v3.sk>
In-Reply-To: <20180910120351.164257-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


[ added dri-devel@lists.freedesktop.org to Cc: ]

On 09/10/2018 02:03 PM, Lubomir Rintel wrote:

Some description (besides kernel warning itself) saying what the patch is
actually doing would be nice so I've updated the patch with:

	Add missing prepare/unprepare operations for fbi->clk,
	this fixes following kernel warning:

while merging it.

>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:874 clk_core_enable+0x2c/0x1b0
>   Enabling unprepared disp0_clk
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc8-00032-g02b43ddd4f21-dirty #25
>   Hardware name: Marvell MMP2 (Device Tree Support)
>   [<c010f7cc>] (unwind_backtrace) from [<c010cc6c>] (show_stack+0x10/0x14)
>   [<c010cc6c>] (show_stack) from [<c011dab4>] (__warn+0xd8/0xf0)
>   [<c011dab4>] (__warn) from [<c011db10>] (warn_slowpath_fmt+0x44/0x6c)
>   [<c011db10>] (warn_slowpath_fmt) from [<c043898c>] (clk_core_enable+0x2c/0x1b0)
>   [<c043898c>] (clk_core_enable) from [<c0439ec8>] (clk_core_enable_lock+0x18/0x2c)
>   [<c0439ec8>] (clk_core_enable_lock) from [<c0436698>] (pxa168fb_probe+0x464/0x6ac)
>   [<c0436698>] (pxa168fb_probe) from [<c04779a0>] (platform_drv_probe+0x48/0x94)
>   [<c04779a0>] (platform_drv_probe) from [<c0475bec>] (driver_probe_device+0x328/0x470)
>   [<c0475bec>] (driver_probe_device) from [<c0475de4>] (__driver_attach+0xb0/0x124)
>   [<c0475de4>] (__driver_attach) from [<c0473c38>] (bus_for_each_dev+0x64/0xa0)
>   [<c0473c38>] (bus_for_each_dev) from [<c0474ee0>] (bus_add_driver+0x1b8/0x230)
>   [<c0474ee0>] (bus_add_driver) from [<c0476a20>] (driver_register+0xac/0xf0)
>   [<c0476a20>] (driver_register) from [<c0102dd4>] (do_one_initcall+0xb8/0x1f0)
>   [<c0102dd4>] (do_one_initcall) from [<c0b010a0>] (kernel_init_freeable+0x294/0x2e0)
>   [<c0b010a0>] (kernel_init_freeable) from [<c07e9eb8>] (kernel_init+0x8/0x10c)
>   [<c07e9eb8>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>   Exception stack(0xd008bfb0 to 0xd008bff8)
>   bfa0:                                     00000000 00000000 00000000 00000000
>   bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>   bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>   ---[ end trace c0af40f9e2ed7cb4 ]---
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Patch queued for 4.19, thanks.

> ---
>  drivers/video/fbdev/pxa168fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index def3a501acd6..d059d04c63ac 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -712,7 +712,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  	/*
>  	 * enable controller clock
>  	 */
> -	clk_enable(fbi->clk);
> +	clk_prepare_enable(fbi->clk);
>  
>  	pxa168fb_set_par(info);
>  
> @@ -767,7 +767,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  failed_free_cmap:
>  	fb_dealloc_cmap(&info->cmap);
>  failed_free_clk:
> -	clk_disable(fbi->clk);
> +	clk_disable_unprepare(fbi->clk);
>  failed_free_fbmem:
>  	dma_free_coherent(fbi->dev, info->fix.smem_len,
>  			info->screen_base, fbi->fb_start_dma);
> @@ -807,7 +807,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
>  	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
>  		    info->screen_base, info->fix.smem_start);
>  
> -	clk_disable(fbi->clk);
> +	clk_disable_unprepare(fbi->clk);
>  
>  	framebuffer_release(info);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
