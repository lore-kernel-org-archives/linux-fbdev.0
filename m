From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 7/7] metronomefb: changes
 to use separate framebuffer
Date: Sat, 7 Jun 2008 10:59:23 +0200
Message-ID: <20080607105923.281dd6de.krzysztof.h1@poczta.fm>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-8-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4uEK-00086t-RS for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:56:56 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4uEJ-0000SG-EO
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:56:56 -0700
In-Reply-To: <1212814166-10313-8-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat,  7 Jun 2008 00:49:26 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> These changes are used in order to support the use of a separate
> framebuffer provided by the platform device driver. Other changes
> are cleanup to error handling and order of release.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  drivers/video/metronomefb.c |  209 +++++++++++++++++++++++++------------------
>  include/video/metronomefb.h |   22 ++---
>  2 files changed, 130 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index 8ccd113..b32f4d2 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c

> @@ -710,14 +746,12 @@ err_cmap:
>  err_fb_rel:
>  	framebuffer_release(info);
>  err_free_irq:
> -	board->free_irq(info);
> -err_dma_free:
> -	dma_free_writecombine(&dev->dev, par->metromemsize, par->metromem,
> -				par->metromem_dma);
> +	board->cleanup(par);
>  err_csum_table:
>  	vfree(par->csum_table);
>  err_vfree:
> -	vfree(videomemory);
> +	if (videomemory)
> +		vfree(videomemory);
>  	module_put(board->owner);
>  	return retval;
>  }

One suspicious thing is that framebuffer_release(info)
is called the first in the metronomefb_probe() (in case of failure)
and as the last in the metronomefb_remove() (see below).
It seems to be an error in the _probe function, the fb_info is allocated before
the first vmalloc() so order of error labels is wrong.

Regards,
Krzysztof

> @@ -728,15 +762,15 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
>  
>  	if (info) {
>  		struct metronomefb_par *par = info->par;
> +
> +		unregister_framebuffer(info);
>  		fb_deferred_io_cleanup(info);
> -		dma_free_writecombine(&dev->dev, par->metromemsize,
> -					par->metromem, par->metromem_dma);
>  		fb_dealloc_cmap(&info->cmap);
>  		vfree(par->csum_table);
> -		unregister_framebuffer(info);
>  		vfree((void __force *)info->screen_base);
> -		par->board->free_irq(info);
> +		par->board->cleanup(par);
>  		module_put(par->board->owner);
> +		dev_dbg(&dev->dev, "calling release\n");
>  		framebuffer_release(info);
>  	}
>  	return 0;
> @@ -761,6 +795,9 @@ static void __exit metronomefb_exit(void)
>  	platform_driver_unregister(&metronomefb_driver);
>  }
>  

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e22 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
