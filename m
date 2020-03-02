From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:43:00 +0000
Subject: Re: [PATCH] video: Replace zero-length array with flexible-array member
Message-Id: <98cf9000-7ba4-afa6-345e-f170216c6847@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200221155727eucas1p13764b85076c6fc29eccaf27ab6dc4967@eucas1p1.samsung.com>
 <20200221160005.GA13552@embeddedor>
In-Reply-To: <20200221160005.GA13552@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 2/21/20 5:00 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://protect2.fireeye.com/url?k91e8f4-53f6acd2-0e9063bb-0cc47a31384a-8666d8e5380b9caf&u=https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for v5.7, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.h | 2 +-
>  drivers/video/fbdev/ssd1307fb.c       | 2 +-
>  include/video/mmp_disp.h              | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> index 335d4983dc52..167585a889d3 100644
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> @@ -1406,7 +1406,7 @@ struct mmphw_ctrl {
>  
>  	/*pathes*/
>  	int path_num;
> -	struct mmphw_path_plat path_plats[0];
> +	struct mmphw_path_plat path_plats[];
>  };
>  
>  static inline int overlay_is_vid(struct mmp_overlay *overlay)
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 142535267fec..fb2640fe575a 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -89,7 +89,7 @@ struct ssd1307fb_par {
>  
>  struct ssd1307fb_array {
>  	u8	type;
> -	u8	data[0];
> +	u8	data[];
>  };
>  
>  static const struct fb_fix_screeninfo ssd1307fb_fix = {
> diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
> index 1f9bc133e230..77252cb46361 100644
> --- a/include/video/mmp_disp.h
> +++ b/include/video/mmp_disp.h
> @@ -231,7 +231,7 @@ struct mmp_path {
>  
>  	/* layers */
>  	int overlay_num;
> -	struct mmp_overlay overlays[0];
> +	struct mmp_overlay overlays[];
>  };
>  
>  extern struct mmp_path *mmp_get_path(const char *name);
> 
