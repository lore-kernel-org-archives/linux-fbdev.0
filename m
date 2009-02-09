From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 14/15] amifb: check fb_alloc_cmap
 return value and handle failure properly
Date: Mon, 9 Feb 2009 21:26:29 +0100
Message-ID: <20090209212629.611bd99d.krzysztof.h1@wp.pl>
References: <20090207121857.6bc5d5bc@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754386AbZBIUWb@vger.kernel.org>
In-Reply-To: <20090207121857.6bc5d5bc@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:18:57 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

One comment below.

>  drivers/video/amifb.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
> index 100f236..82bedd7 100644
> --- a/drivers/video/amifb.c
> +++ b/drivers/video/amifb.c
> @@ -2437,7 +2437,9 @@ default_chipset:
>  		goto amifb_error;
>  	}
>  
> -	fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
> +	err = fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
> +	if (err)
> +		goto amifb_error;
>  
>  	if (register_framebuffer(&fb_info) < 0) {
>  		err = -EINVAL;
> @@ -2456,7 +2458,8 @@ amifb_error:
>  
>  static void amifb_deinit(void)
>  {
> -	fb_dealloc_cmap(&fb_info.cmap);
> +	if (fb_info.cmap.len)
> +		fb_dealloc_cmap(&fb_info.cmap);

Again, is the "if(fb_info.cmap.len)" needed here?

>  	chipfree();
>  	if (videomemory)
>  		iounmap((void*)videomemory);
> -- 
> 1.5.6.5
> 
