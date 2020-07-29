From: daniel@ffwll.ch
Date: Wed, 29 Jul 2020 13:47:46 +0000
Subject: Re: [PATCH 1/5] fbdev: Remove trailing whitespace
Message-Id: <20200729134746.GO6419@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200729134148.6855-1-tzimmermann@suse.de>
 <20200729134148.6855-2-tzimmermann@suse.de>
In-Reply-To: <20200729134148.6855-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, kraxel@redhat.com, airlied@redhat.com, natechancellor@gmail.com, sam@ravnborg.org, peda@axentia.se, dan.carpenter@oracle.com

On Wed, Jul 29, 2020 at 03:41:44PM +0200, Thomas Zimmermann wrote:
> Removes trailing whitespaces in several places.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

checkpatch patch for fbdev, I'm blown :-)

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbmem.c | 10 +++++-----
>  include/linux/fb.h               | 18 +++++++++---------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 30e73ec4ad5c..dd0ccf35f7b7 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -777,7 +777,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  
>  	if (info->fbops->fb_read)
>  		return info->fbops->fb_read(info, buf, count, ppos);
> -	
> +
>  	total_size = info->screen_size;
>  
>  	if (total_size = 0)
> @@ -842,7 +842,7 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>  
>  	if (info->fbops->fb_write)
>  		return info->fbops->fb_write(info, buf, count, ppos);
> -	
> +
>  	total_size = info->screen_size;
>  
>  	if (total_size = 0)
> @@ -1061,7 +1061,7 @@ EXPORT_SYMBOL(fb_set_var);
>  
>  int
>  fb_blank(struct fb_info *info, int blank)
> -{	
> +{
>  	struct fb_event event;
>  	int ret = -EINVAL;
>  
> @@ -1437,7 +1437,7 @@ __releases(&info->lock)
>  	return res;
>  }
>  
> -static int 
> +static int
>  fb_release(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
>  __releases(&info->lock)
> @@ -1627,7 +1627,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>  			fb_info->pixmap.access_align = 32;
>  			fb_info->pixmap.flags = FB_PIXMAP_DEFAULT;
>  		}
> -	}	
> +	}
>  	fb_info->pixmap.offset = 0;
>  
>  	if (!fb_info->pixmap.blit_x)
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 2b530e6d86e4..714187bc13ac 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -124,7 +124,7 @@ struct fb_cursor_user {
>   * Register/unregister for framebuffer events
>   */
>  
> -/*	The resolution of the passed in fb_info about to change */ 
> +/*	The resolution of the passed in fb_info about to change */
>  #define FB_EVENT_MODE_CHANGE		0x01
>  
>  #ifdef CONFIG_GUMSTIX_AM200EPD
> @@ -459,12 +459,12 @@ struct fb_info {
>  
>  #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>  	/* assigned backlight device */
> -	/* set before framebuffer registration, 
> +	/* set before framebuffer registration,
>  	   remove after unregister */
>  	struct backlight_device *bl_dev;
>  
>  	/* Backlight level curve */
> -	struct mutex bl_curve_mutex;	
> +	struct mutex bl_curve_mutex;
>  	u8 bl_curve[FB_BACKLIGHT_LEVELS];
>  #endif
>  #ifdef CONFIG_FB_DEFERRED_IO
> @@ -483,8 +483,8 @@ struct fb_info {
>  		char __iomem *screen_base;	/* Virtual address */
>  		char *screen_buffer;
>  	};
> -	unsigned long screen_size;	/* Amount of ioremapped VRAM or 0 */ 
> -	void *pseudo_palette;		/* Fake palette of 16 colors */ 
> +	unsigned long screen_size;	/* Amount of ioremapped VRAM or 0 */
> +	void *pseudo_palette;		/* Fake palette of 16 colors */
>  #define FBINFO_STATE_RUNNING	0
>  #define FBINFO_STATE_SUSPENDED	1
>  	u32 state;			/* Hardware state i.e suspend */
> @@ -587,11 +587,11 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
>       *  `Generic' versions of the frame buffer device operations
>       */
>  
> -extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var); 
> -extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var); 
> +extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var);
> +extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var);
>  extern int fb_blank(struct fb_info *info, int blank);
> -extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect); 
> -extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area); 
> +extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
> +extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
>  extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
>  /*
>   * Drawing operations where framebuffer is in system RAM
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
