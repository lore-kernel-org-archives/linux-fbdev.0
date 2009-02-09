From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 7/15] sstfb: check fb_alloc_cmap
 return value and handle failure properly
Date: Mon, 9 Feb 2009 17:59:54 +0100
Message-ID: <20090209175954.fa9e611b.krzysztof.h1@wp.pl>
References: <20090207121457.28550bdd@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755915AbZBIQzy@vger.kernel.org>
In-Reply-To: <20090207121457.28550bdd@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:14:57 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/sstfb.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
> index 5b11a00..609d0a5 100644
> --- a/drivers/video/sstfb.c
> +++ b/drivers/video/sstfb.c
> @@ -1421,13 +1421,16 @@ static int __devinit sstfb_probe(struct pci_dev *pdev,
>  		goto fail;
>  	}
>  	
> -	fb_alloc_cmap(&info->cmap, 256, 0);
> +	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
> +		printk(KERN_ERR "sstfb: can't alloc cmap memory.\n");
> +		goto fail;
> +	}
>  
>  	/* register fb */
>  	info->device = &pdev->dev;
>  	if (register_framebuffer(info) < 0) {
>  		printk(KERN_ERR "sstfb: can't register framebuffer.\n");
> -		goto fail;
> +		goto fail_register;
>  	}
>  
>  	sstfb_clear_screen(info);
> @@ -1441,8 +1444,9 @@ static int __devinit sstfb_probe(struct pci_dev *pdev,
>  
>  	return 0;
>  
> -fail:
> +fail_register:
>  	fb_dealloc_cmap(&info->cmap);
> +fail:
>  	iounmap(info->screen_base);
>  fail_fb_remap:
>  	iounmap(par->mmio_vbase);
> -- 
> 1.5.6.5
> 
> 
> ------------------------------------------------------------------------------
> Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
> software. With Adobe AIR, Ajax developers can use existing skills and code to
> build responsive, highly engaging applications that combine the power of local
> resources and data with the reach of the web. Download the Adobe AIR SDK and
> Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
