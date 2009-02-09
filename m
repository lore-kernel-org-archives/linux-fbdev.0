From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/15] fix memory leaks in removal
 path
Date: Mon, 9 Feb 2009 17:51:08 +0100
Message-ID: <20090209175108.1c6c4197.krzysztof.h1@wp.pl>
References: <20090207121215.77e45acf@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754615AbZBIQrS@vger.kernel.org>
In-Reply-To: <20090207121215.77e45acf@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:12:15 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> We were leaking both the cmap memory and the info struct memory.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/sgivwfb.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
> index f5252c2..bba5371 100644
> --- a/drivers/video/sgivwfb.c
> +++ b/drivers/video/sgivwfb.c
> @@ -837,6 +837,8 @@ static int sgivwfb_remove(struct platform_device *dev)
>  		iounmap(par->regs);
>  		iounmap(info->screen_base);
>  		release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
> +		fb_dealloc_cmap(&info->cmap);
> +		framebuffer_release(info);
>  	}
>  	return 0;
>  }
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
