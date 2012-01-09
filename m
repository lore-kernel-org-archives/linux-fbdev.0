From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 09 Jan 2012 02:33:01 +0000
Subject: Re: [PATCH 1/5] drivers/video: fsl-diu-fb: merge init_fbinfo() into
Message-Id: <4F0A51DD.6020107@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12/19/2011 10:26 PM, Timur Tabi wrote:
> Function init_fbinfo() is called only from install_fb(), and it's only a few
> lines long.  Plus, it ignores the return code from fb_alloc_cmap().  Merge
> its contents into install_fb() and handle errors properly.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied all 5 patches of this series.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/fsl-diu-fb.c |   25 ++++++++-----------------
>  1 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 408272c..411a7b3 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1220,21 +1220,6 @@ static struct fb_ops fsl_diu_ops = {
>  	.fb_release = fsl_diu_release,
>  };
>  
> -static int init_fbinfo(struct fb_info *info)
> -{
> -	struct mfb_info *mfbi = info->par;
> -
> -	info->device = NULL;
> -	info->var.activate = FB_ACTIVATE_NOW;
> -	info->fbops = &fsl_diu_ops;
> -	info->flags = FBINFO_FLAG_DEFAULT;
> -	info->pseudo_palette = &mfbi->pseudo_palette;
> -
> -	/* Allocate colormap */
> -	fb_alloc_cmap(&info->cmap, 16, 0);
> -	return 0;
> -}
> -
>  static int __devinit install_fb(struct fb_info *info)
>  {
>  	int rc;
> @@ -1244,8 +1229,14 @@ static int __devinit install_fb(struct fb_info *info)
>  	unsigned int dbsize = ARRAY_SIZE(fsl_diu_mode_db);
>  	int has_default_mode = 1;
>  
> -	if (init_fbinfo(info))
> -		return -EINVAL;
> +	info->var.activate = FB_ACTIVATE_NOW;
> +	info->fbops = &fsl_diu_ops;
> +	info->flags = FBINFO_DEFAULT;
> +	info->pseudo_palette = mfbi->pseudo_palette;
> +
> +	rc = fb_alloc_cmap(&info->cmap, 16, 0);
> +	if (rc)
> +		return rc;
>  
>  	if (mfbi->index = PLANE0) {
>  		if (mfbi->edid_data) {

