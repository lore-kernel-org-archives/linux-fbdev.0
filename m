From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] fbdev: make fb_find_mode look for a mode with the
 highest refresh rate
Date: Sat, 23 Jun 2007 11:04:24 -0700
Message-ID: <20070623110424.9a68d82d.akpm@linux-foundation.org>
References: <20070623105046.GB12623@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759417AbXFWSF3@vger.kernel.org>
In-Reply-To: <20070623105046.GB12623@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: spock@gentoo.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 23 Jun 2007 12:50:46 +0200 Michal Januszewski <spock@gentoo.org> wrote:

> If the refresh rate hasn't been explicitly specified, fd_find_mode
> currently returns the first mode with the requested resolution. Change
> it so that it returns a mode with the requested resolution and the
> highest refresh rate.
> 
> Also export fb_destroy_modelist, which is used in uvesafb.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> drivers/video/modedb.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
> index 3741ad7..98ee77b 100644
> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -606,16 +606,18 @@ done:
>  	DPRINTK("Trying specified video mode%s %ix%i\n",
>  	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
>  
> +	if (!refresh_specified)
> +		refresh = 200;
>  	diff = refresh;
>  	best = -1;
>  	for (i = 0; i < dbsize; i++) {
>  		if (name_matches(db[i], name, namelen) ||
>  		    (res_specified && res_matches(db[i], xres, yres))) {
>  			if(!fb_try_mode(var, info, &db[i], bpp)) {
> -				if(!refresh_specified || db[i].refresh == refresh)
> +				if (refresh_specified && db[i].refresh == refresh)
>  					return 1;
>  				else {
> -					if(diff > abs(db[i].refresh - refresh)) {
> +					if (diff > abs(db[i].refresh - refresh)) {
>  						diff = abs(db[i].refresh - refresh);
>  						best = i;
>  					}
> @@ -938,6 +940,7 @@ void fb_destroy_modelist(struct list_head *head)
>  		kfree(pos);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fb_destroy_modelist);
>  

fbdev ignoramus asks: isn't this pretty risky?  People who were previously
relying upon (or at least using) the kernel's default resolution will find
their displays coming up in a quite different resolution.

This change seems to be quite unrelated to the uvesafb stuff and should be
in a separate patch from the export, which _is_ uvesafb-related.  I think. 
If that's wrong then the changelog could do with some attention.
