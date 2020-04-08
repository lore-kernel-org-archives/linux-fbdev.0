From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 08 Apr 2020 10:19:27 +0000
Subject: Re: [PATCH] video: fbdev: mb862xx: remove set but not used variable 'mdr'
Message-Id: <20200408101927.GD20795@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200403022553.33320-1-yanaijie@huawei.com>
In-Reply-To: <20200403022553.33320-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jason Yan <yanaijie@huawei.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

Hi Jason.

On Fri, Apr 03, 2020 at 10:25:53AM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/video/fbdev/mb862xx/mb862xxfb_accel.c:187:6: warning: variable
> ‘mdr’ set but not used [-Wunused-but-set-variable]
>   int mdr;
>       ^~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks, committed to drm-misc-next.
The fix will show up durign the next merge window.

	Sam

> ---
>  drivers/video/fbdev/mb862xx/mb862xxfb_accel.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
> index 42569264801f..d40b806461ca 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
> @@ -184,7 +184,6 @@ static void mb86290fb_imageblit16(u32 *cmd, u16 step, u16 dx, u16 dy,
>  static void mb86290fb_imageblit(struct fb_info *info,
>  				const struct fb_image *image)
>  {
> -	int mdr;
>  	u32 *cmd = NULL;
>  	void (*cmdfn) (u32 *, u16, u16, u16, u16, u16, u32, u32,
>  		       const struct fb_image *, struct fb_info *) = NULL;
> @@ -196,7 +195,6 @@ static void mb86290fb_imageblit(struct fb_info *info,
>  	u16 dx = image->dx, dy = image->dy;
>  	int x2, y2, vxres, vyres;
>  
> -	mdr = (GDC_ROP_COPY << 9);
>  	x2 = image->dx + image->width;
>  	y2 = image->dy + image->height;
>  	vxres = info->var.xres_virtual;
> -- 
> 2.17.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
