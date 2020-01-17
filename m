From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Jan 2020 19:13:35 +0000
Subject: Re: [PATCH 1/6] video: fbdev: controlfb: fix sparse warning about using incorrect type
Message-Id: <20200117191335.GB24812@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200116140900.26363-1-b.zolnierkie@samsung.com>
 <CGME20200116140915eucas1p2d6a2c654a66a78b6c3c1fc710f8a65b8@eucas1p2.samsung.com>
 <20200116140900.26363-2-b.zolnierkie@samsung.com>
In-Reply-To: <20200116140900.26363-2-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej

On Thu, Jan 16, 2020 at 03:08:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Force le32_to_cpup() argument to be of proper type (const __le32 *).
> 
> Also add missing inline keyword to control_par_to_var() definition
> (to match function prototype).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/controlfb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 38b61cdb5ca4..d7e53520a24c 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -313,7 +313,7 @@ static int controlfb_blank(int blank_mode, struct fb_info *info)
>  		container_of(info, struct fb_info_control, info);
>  	unsigned ctrl;
>  
> -	ctrl = le32_to_cpup(CNTRL_REG(p,ctrl));
> +	ctrl = le32_to_cpup((const __force __le32 *)CNTRL_REG(p, ctrl));

Only judging from the other code in the same driver,
I think a better fix would be to use:

	ctrl = in_le32(CNTRL_REG(p,ctrl));

?

	Sam

>  	if (blank_mode > 0)
>  		switch (blank_mode) {
>  		case FB_BLANK_VSYNC_SUSPEND:
> @@ -952,7 +952,8 @@ static int control_var_to_par(struct fb_var_screeninfo *var,
>   * Convert hardware data in par to an fb_var_screeninfo
>   */
>  
> -static void control_par_to_var(struct fb_par_control *par, struct fb_var_screeninfo *var)
> +static inline void control_par_to_var(struct fb_par_control *par,
> +	struct fb_var_screeninfo *var)
>  {
>  	struct control_regints *rv;
>  	
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
