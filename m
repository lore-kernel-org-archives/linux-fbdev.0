From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Jun 2020 08:13:54 +0000
Subject: Re: [PATCH v2] video: fbdev: uvesafb: fix "noblank" option handling
Message-Id: <20200621081354.GI74146@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200422071952eucas1p219bc9ef0a74220149966ecb03688681c@eucas1p2.samsung.com>
 <20200422071845.403-1-yanaijie@huawei.com>
 <81c9f140-d6fb-803a-18c8-04dae1007ab3@samsung.com>
In-Reply-To: <81c9f140-d6fb-803a-18c8-04dae1007ab3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jason Yan <yanaijie@huawei.com>

On Tue, Jun 09, 2020 at 11:29:43AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Fix the recent regression.
> 
> Fixes: dbc7ece12a38 ("video: uvesafb: use true,false for bool variables")
> Cc: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Bartlomiej

I was processing drm-misc-fixes patches so I went ahead and applied
this.
Thanks for fixing this up.

	Sam

> ---
> v2:
> - added Reviewed-by tag from Sam
> - removed no longer working Michal's email address from Cc:
> 
>  drivers/video/fbdev/uvesafb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/uvesafb.c
> =================================> --- a/drivers/video/fbdev/uvesafb.c
> +++ b/drivers/video/fbdev/uvesafb.c
> @@ -1836,7 +1836,7 @@ static int uvesafb_setup(char *options)
>  		else if (!strcmp(this_opt, "noedid"))
>  			noedid = true;
>  		else if (!strcmp(this_opt, "noblank"))
> -			blank = true;
> +			blank = false;
>  		else if (!strncmp(this_opt, "vtotal:", 7))
>  			vram_total = simple_strtoul(this_opt + 7, NULL, 0);
>  		else if (!strncmp(this_opt, "vremap:", 7))
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
