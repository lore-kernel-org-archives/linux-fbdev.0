From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 13/15] amba-clcd: fix cmap memory
 leaks
Date: Mon, 9 Feb 2009 21:16:14 +0100
Message-ID: <20090209211614.44459a12.krzysztof.h1@wp.pl>
References: <20090207121848.536b136d@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756127AbZBIUMT@vger.kernel.org>
In-Reply-To: <20090207121848.536b136d@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:18:48 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
>  - fix cmap leak in removal path
>  - fix cmap leak when register_framebuffer fails
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

One comment (see below).

>  drivers/video/amba-clcd.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
> index 4e046fe..61050ab 100644
> --- a/drivers/video/amba-clcd.c
> +++ b/drivers/video/amba-clcd.c
> @@ -408,7 +408,9 @@ static int clcdfb_register(struct clcd_fb *fb)
>  	/*
>  	 * Allocate colourmap.
>  	 */
> -	fb_alloc_cmap(&fb->fb.cmap, 256, 0);
> +	ret = fb_alloc_cmap(&fb->fb.cmap, 256, 0);
> +	if (ret)
> +		goto unmap;
>  
>  	/*
>  	 * Ensure interrupts are disabled.
> @@ -426,6 +428,8 @@ static int clcdfb_register(struct clcd_fb *fb)
>  
>  	printk(KERN_ERR "CLCD: cannot register framebuffer (%d)\n", ret);
>  
> +	fb_dealloc_cmap(&fb->fb.cmap);
> + unmap:
>  	iounmap(fb->regs);
>   free_clk:
>  	clk_put(fb->clk);
> @@ -485,6 +489,8 @@ static int clcdfb_remove(struct amba_device *dev)
>  
>  	clcdfb_disable(fb);
>  	unregister_framebuffer(&fb->fb);
> +	if (fb->fb.cmap.len)
> +		fb_dealloc_cmap(&fb->fb.cmap);

Is this if() needed? Is this function called twice (or more) or
can it be called without the cmap allocated?

>  	iounmap(fb->regs);
>  	clk_put(fb->clk);
>  
> -- 
> 1.5.6.5
> 
