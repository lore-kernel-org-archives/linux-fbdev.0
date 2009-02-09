From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 4/15] vfb: fix memory leaks in
 removal path
Date: Mon, 9 Feb 2009 17:52:27 +0100
Message-ID: <20090209175227.0bf4961f.krzysztof.h1@wp.pl>
References: <20090207121242.21c07e0e@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755635AbZBIQsl@vger.kernel.org>
In-Reply-To: <20090207121242.21c07e0e@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:12:42 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> We were leaking the cmap memory.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


>  drivers/video/vfb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
> index 93fe08d..cc919ae 100644
> --- a/drivers/video/vfb.c
> +++ b/drivers/video/vfb.c
> @@ -543,6 +543,7 @@ static int vfb_remove(struct platform_device *dev)
>  	if (info) {
>  		unregister_framebuffer(info);
>  		rvfree(videomemory, videomemorysize);
> +		fb_dealloc_cmap(&info->cmap);
>  		framebuffer_release(info);
>  	}
>  	return 0;
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
