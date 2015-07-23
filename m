From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 23 Jul 2015 12:39:56 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <20150723123956.GQ5422@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This was never merged.

regards,
dan carpenter

On Thu, Jan 15, 2015 at 02:52:29PM +0200, Tomi Valkeinen wrote:
> On 15/01/15 14:43, Dan Carpenter wrote:
> > Sounds good to me.  :)  Could I get a Reported-by cookie?
> 
> Oh, sorry. I thought I had added that, but... seems I didn't. Well now it's
> there. So updated patch below.
> 
> I'll queue it for 3.20 if there are no comments.
> 
>  Tomi
> 
> 
> From 80fa3aed6f89728e9003bb0bdbd0b4bac2bc2186 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Thu, 15 Jan 2015 13:47:19 +0200
> Subject: [PATCH] fbdev: fix cea_modes array size
> 
> CEA defines 64 modes, indexed from 1 to 64. modedb has cea_modes arrays,
> which contains 64 entries. However, the code uses the CEA indices
> directly, i.e. the first mode is at cea_modes[1]. This means the array
> is one too short.
> 
> This does not cause references to uninitialized memory as the code in
> fbmon only allows indexes up to 63, and the cea_modes does not contain
> an entry for the mode 64 so it could not be used in any case.
> 
> However, the code contains a check 'if (idx > ARRAY_SIZE(cea_modes)',
> and while that check is a no-op as at that point idx cannot be >= 63, it
> upsets static checkers.
> 
> Fix this by increasing the cea_array size to be 65, and change the code
> to allow mode 64.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/video/fbdev/core/fbmon.c  | 4 ++--
>  drivers/video/fbdev/core/modedb.c | 2 +-
>  include/linux/fb.h                | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 5b0e313849bd..1829fe34a1df 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1059,9 +1059,9 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  
>  	for (i = specs->modedb_len + num; i < specs->modedb_len + num + svd_n; i++) {
>  		int idx = svd[i - specs->modedb_len - num];
> -		if (!idx || idx > 63) {
> +		if (!idx || idx >= ARRAY_SIZE(cea_modes)) {
>  			pr_warning("Reserved SVD code %d\n", idx);
> -		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
> +		} else if (!cea_modes[idx].xres) {
>  			pr_warning("Unimplemented SVD code %d\n", idx);
>  		} else {
>  			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
> index 388f7971494b..b2aba4e3150a 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -289,7 +289,7 @@ static const struct fb_videomode modedb[] = {
>  };
>  
>  #ifdef CONFIG_FB_MODE_HELPERS
> -const struct fb_videomode cea_modes[64] = {
> +const struct fb_videomode cea_modes[65] = {
>  	/* #1: 640x480p@59.94/60Hz */
>  	[1] = {
>  		NULL, 60, 640, 480, 39722, 48, 16, 33, 10, 96, 2, 0,
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 09bb7a18d287..024260687698 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -779,7 +779,7 @@ struct fb_videomode {
>  
>  extern const char *fb_mode_option;
>  extern const struct fb_videomode vesa_modes[];
> -extern const struct fb_videomode cea_modes[64];
> +extern const struct fb_videomode cea_modes[65];
>  
>  struct fb_modelist {
>  	struct list_head list;
> -- 
> 2.2.2
> 
> 
> 


