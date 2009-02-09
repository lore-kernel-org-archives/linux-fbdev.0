From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 5/15] skeletonfb: check
 fb_alloc_cmap return value and handle failure properly
Date: Mon, 9 Feb 2009 07:29:29 +0100
Message-ID: <20090209072929.29589e5d.krzysztof.h1@poczta.fm>
References: <20090207121302.55db6a87@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754573AbZBIGZg@vger.kernel.org>
In-Reply-To: <20090207121302.55db6a87@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:13:02 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> Bad example code, no cookie!
> 

It is even worse than you thought.

> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---
>  drivers/video/skeletonfb.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
> index df53365..a439159 100644
> --- a/drivers/video/skeletonfb.c
> +++ b/drivers/video/skeletonfb.c
> @@ -795,8 +795,9 @@ static int __devinit xxxfb_probe(struct pci_dev *dev,
>      if (!retval || retval == 4)
>  	return -EINVAL;			
>  
> -    /* This has to been done !!! */	
> -    fb_alloc_cmap(&info->cmap, cmap_len, 0);
> +    /* This has to be done! */
> +    if (fb_alloc_cmap(&info->cmap, cmap_len, 0))
> +	return -ENOMEM;
>  	

The info pointer should be freed before the return here ...

>      /* 
>       * The following is done in the case of having hardware with a static 
> @@ -820,8 +821,10 @@ static int __devinit xxxfb_probe(struct pci_dev *dev,
>       */
>      /* xxxfb_set_par(info); */
>  
> -    if (register_framebuffer(info) < 0)
> +    if (register_framebuffer(info) < 0) {
> +	fb_dealloc_cmap(&info->cmap);

... and here.

>  	return -EINVAL;
> +    }
>      printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
>  	   info->fix.id);
>      pci_set_drvdata(dev, info); /* or platform_set_drvdata(pdev, info) */
> -- 


Kind regards,
Krzysztof


----------------------------------------------------------------------
Zostan mistrzem parkowania w Bombaju!
Zagraj >> http://link.interia.pl/f204e 
