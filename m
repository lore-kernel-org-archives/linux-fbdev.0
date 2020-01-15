From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 15:42:40 +0000
Subject: Re: [PATCH] OMAP: DSS2: remove non-zero check on variable r
Message-Id: <6a3951c7-4b17-6371-24ab-17742aeaa464@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191204152851epcas5p413006712eafa500de3013c2ce8a3bc02@epcas5p4.samsung.com>
 <20191204152847.1435188-1-colin.king@canonical.com>
In-Reply-To: <20191204152847.1435188-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org


On 12/4/19 4:28 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable r is being initialized to zero, so the check of a non-zero
> rv is redundant and can be removed.
> 
> It appears that the previous case statements set r to be -EINVAL
> and the "Fallthrough" comment afterwards suggested it was going
> to fall through to this non-zero check but won't because of the
> break statement. Remove the confusion by removing the Fallthrough
> comment too.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> index 858c2c011d19..a2a2c1b205d9 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> @@ -1154,16 +1154,12 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
>  		   r = fbdev->ctrl->setcolreg(regno, red, green, blue,
>  		   transp, update_hw_pal);
>  		   */
> -		/* Fallthrough */
>  		r = -EINVAL;
>  		break;
>  	case OMAPFB_COLOR_RGB565:
>  	case OMAPFB_COLOR_RGB444:
>  	case OMAPFB_COLOR_RGB24P:
>  	case OMAPFB_COLOR_RGB24U:
> -		if (r != 0)
> -			break;
> -
>  		if (regno < 16) {
>  			u32 pal;
>  			pal = ((red >> (16 - var->red.length)) <<
> 
