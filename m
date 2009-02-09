From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 6/15] sm501fb: check fb_alloc_cmap
 return value and handle failure properly
Date: Mon, 9 Feb 2009 17:57:10 +0100
Message-ID: <20090209175710.5a837ec0.krzysztof.h1@wp.pl>
References: <20090207121448.7b18c3fd@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756013AbZBIQxS@vger.kernel.org>
In-Reply-To: <20090207121448.7b18c3fd@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:14:48 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/sm501fb.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
> index dcd9879..eb5d73a 100644
> --- a/drivers/video/sm501fb.c
> +++ b/drivers/video/sm501fb.c
> @@ -1525,7 +1525,10 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  	}
>  
>  	/* initialise and set the palette */
> -	fb_alloc_cmap(&fb->cmap, NR_PALETTE, 0);
> +	if (fb_alloc_cmap(&fb->cmap, NR_PALETTE, 0)) {
> +		dev_err(info->dev, "failed to allocate cmap memory\n");
> +		return -ENOMEM;
> +	}
>  	fb_set_cmap(&fb->cmap, fb);
>  
>  	ret = (fb->fbops->fb_check_var)(&fb->var, fb);
> -- 
> 1.5.6.5
> 
