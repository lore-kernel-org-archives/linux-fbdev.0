From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 16:04:08 +0000
Subject: Re: [PATCH 07/16] video: sa1100fb: constify copied structure
Message-Id: <84714bc2-1c5b-7428-a8ae-102f43605f67@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
 <CGME20200101082012epcas5p2b0169522e476fa40aba6bbdd569ca0f0@epcas5p2.samsung.com>
 <1577864614-5543-8-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1577864614-5543-8-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 1/1/20 8:43 AM, Julia Lawall wrote:
> The monspecs structure is only copied into another structure,
> so make it const.
> 
> The opportunity for this change was found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sa1100fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index 4680cc3efb81..c77b43dbc256 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -1053,7 +1053,7 @@ static int sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
>  }
>  
>  /* Fake monspecs to fill in fbinfo structure */
> -static struct fb_monspecs monspecs = {
> +static const struct fb_monspecs monspecs = {
>  	.hfmin	= 30000,
>  	.hfmax	= 70000,
>  	.vfmin	= 50,
> 
