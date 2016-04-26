From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Tue, 26 Apr 2016 16:24:54 +0000
Subject: Re: [PATCH v2 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <571F9656.1090506@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-5-git-send-email-noralf@tronnes.org>
 <20160425090957.GQ2510@phenom.ffwll.local>
In-Reply-To: <20160425090957.GQ2510@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


Den 25.04.2016 11:09, skrev Daniel Vetter:
> On Sun, Apr 24, 2016 at 10:48:58PM +0200, Noralf Tr=F8nnes wrote:
>> This adds deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
>> The fbdev framebuffer changes are flushed using the callback
>> (struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
>> ensuring that it always runs in process context.
>>
>> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
>> ---
>>
>> Changes since v1:
>> - Use a dedicated worker to run the framebuffer flushing like qxl does
>> - Add parameter descriptions to drm_fb_helper_deferred_io
>>
>>   drivers/gpu/drm/drm_fb_helper.c | 127 ++++++++++++++++++++++++++++++++=
+++++++-
>>   include/drm/drm_fb_helper.h     |  17 ++++++
>>   2 files changed, 143 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_he=
lper.c
>> index 855108e..46ee6f8 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -40,6 +40,7 @@
>>   #include <drm/drm_crtc_helper.h>
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_rect.h>
>>
>>   static bool drm_fbdev_emulation =3D true;
>>   module_param_named(fbdev_emulation, drm_fbdev_emulation, bool, 0600);
>> @@ -48,6 +49,10 @@ MODULE_PARM_DESC(fbdev_emulation,
>>
>>   static LIST_HEAD(kernel_fb_helper_list);
>>
>> +static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper);
>> +static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
>> +				u32 width, u32 height);
>> +
>>   /**
>>    * DOC: fbdev helpers
>>    *
>> @@ -84,6 +89,16 @@ static LIST_HEAD(kernel_fb_helper_list);
>>    * and set up an initial configuration using the detected hardware, dr=
ivers
>>    * should call drm_fb_helper_single_add_all_connectors() followed by
>>    * drm_fb_helper_initial_config().
>> + *
>> + * If CONFIG_FB_DEFERRED_IO is enabled and
>> + * (struct drm_framebuffer *)->funcs->dirty is set, the
>> + * drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit} functions
>> + * will accumulate changes and schedule (struct fb_helper).dirty_work t=
o run
>> + * right away. This worker then calls the dirty() function ensuring tha=
t it
>> + * will always run in process context since the fb_*() function could be
>> + * running in atomic context. If drm_fb_helper_deferred_io() is used as=
 the
>> + * deferred_io callback it will also schedule dirty_work with the damage
>> + * collected from the mmap page writes.
> One thing to consider (and personally I don't care either way) is whether
> we shouldn't just select CONFIG_FB_DEFERRED_IO if the fbdev helpers are
> enabled. Pushing that out to drivers is imo a bit fragile.
>
> But like I said I'm ok with either way.

My concern was adding code and data that only a few drivers would
actually use. But of course there's the tradeoff with complexity.
I use this to enable it:
         select FB_DEFERRED_IO if DRM_KMS_FB_HELPER

I guess the maintainer has to make this choice between size and=20
complexity :-)
I can enable it by default if you want, drm is both huge and complex so I
don't know what's best.

As a sidenote, I have also put all the fbdev code in a file of it's own to
make it simple with regards to the DRM_FBDEV_EMULATION user option:
tinydrm-$(CONFIG_DRM_KMS_FB_HELPER)     +=3D tinydrm-fbdev.o

>>    */
>>
>>   /**
>> @@ -401,11 +416,14 @@ backoff:
>>   static int restore_fbdev_mode(struct drm_fb_helper *fb_helper)
>>   {
>>   	struct drm_device *dev =3D fb_helper->dev;
>> +	struct fb_info *info =3D fb_helper->fbdev;
>>   	struct drm_plane *plane;
>>   	int i;
>>
>>   	drm_warn_on_modeset_not_all_locked(dev);
>>
>> +	drm_fb_helper_dirty(info, 0, 0, info->var.xres, info->var.yres);
> Why is this needed? If you do a modeset (or pageflip or whatever) drivers
> are supposed to re-upload the entire screen. We've talked about adding a
> dirty rectangle to atomic to allow userspace to optimize this, but there
> should _never_ be a need to do a dirtyfb call around a modeset. Probably
> just a driver bug in your panel drm drivers?

Ok, in tinydrm I now set a flag in &drm_simple_display_pipe_funcs
->plane_update to indicate that the next dirty() should do the whole
framebuffer which seems to work fine.
Should I actually perform the update as well?
If so I would need to add a worker in tinydrm to do that.


Noralf.

> With the above line removed:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
>> +
>>   	if (fb_helper->atomic)
>>   		return restore_fbdev_mode_atomic(fb_helper);
>>
>> @@ -650,6 +668,7 @@ void drm_fb_helper_prepare(struct drm_device *dev, s=
truct drm_fb_helper *helper,
>>   			   const struct drm_fb_helper_funcs *funcs)
>>   {
>>   	INIT_LIST_HEAD(&helper->kernel_fb_list);
>> +	drm_fb_helper_dirty_init(helper);
>>   	helper->funcs =3D funcs;
>>   	helper->dev =3D dev;
>>   }
>> @@ -834,6 +853,93 @@ void drm_fb_helper_unlink_fbi(struct drm_fb_helper =
*fb_helper)
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_unlink_fbi);
>>
>> +#ifdef CONFIG_FB_DEFERRED_IO
>> +static void drm_fb_helper_dirty_work(struct work_struct *work)
>> +{
>> +	struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_help=
er,
>> +						    dirty_work);
>> +	struct drm_clip_rect clip;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&helper->dirty_lock, flags);
>> +	clip =3D helper->dirty_clip;
>> +	drm_clip_rect_reset(&helper->dirty_clip);
>> +	spin_unlock_irqrestore(&helper->dirty_lock, flags);
>> +
>> +	helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip, 1);
>> +}
>> +
>> +static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper)
>> +{
>> +	spin_lock_init(&helper->dirty_lock);
>> +	INIT_WORK(&helper->dirty_work, drm_fb_helper_dirty_work);
>> +}
>> +
>> +static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
>> +				u32 width, u32 height)
>> +{
>> +	struct drm_fb_helper *helper =3D info->par;
>> +	struct drm_clip_rect clip;
>> +	unsigned long flags;
>> +
>> +	if (!helper->fb->funcs->dirty)
>> +		return;
>> +
>> +	clip.x1 =3D x;
>> +	clip.x2 =3D x + width;
>> +	clip.y1 =3D y;
>> +	clip.y2 =3D y + height;
>> +
>> +	spin_lock_irqsave(&helper->dirty_lock, flags);
>> +	drm_clip_rect_merge(&helper->dirty_clip, &clip, 1, 0, 0, 0);
>> +	spin_unlock_irqrestore(&helper->dirty_lock, flags);
>> +
>> +	schedule_work(&helper->dirty_work);
>> +}
>> +
>> +/**
>> + * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
>> + * @info: fb_info struct pointer
>> + * @pagelist: list of dirty mmap framebuffer pages
>> + *
>> + * This function is used as the (struct fb_deferred_io *)->deferred_io
>> + * callback function for flushing the fbdev mmap writes.
>> + */
>> +void drm_fb_helper_deferred_io(struct fb_info *info,
>> +			       struct list_head *pagelist)
>> +{
>> +	unsigned long start, end, min, max;
>> +	struct page *page;
>> +	u32 y1, y2;
>> +
>> +	min =3D ULONG_MAX;
>> +	max =3D 0;
>> +	list_for_each_entry(page, pagelist, lru) {
>> +		start =3D page->index << PAGE_SHIFT;
>> +		end =3D start + PAGE_SIZE - 1;
>> +		min =3D min(min, start);
>> +		max =3D max(max, end);
>> +	}
>> +
>> +	if (min < max) {
>> +		y1 =3D min / info->fix.line_length;
>> +		y2 =3D min_t(u32, max / info->fix.line_length, info->var.yres);
>> +		drm_fb_helper_dirty(info, 0, y1, info->var.xres, y2 - y1);
>> +	}
>> +}
>> +EXPORT_SYMBOL(drm_fb_helper_deferred_io);
>> +
>> +#else
>> +static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper)
>> +{
>> +}
>> +
>> +static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
>> +				u32 width, u32 height)
>> +{
>> +}
>> +#endif /* CONFIG_FB_DEFERRED_IO */
>> +
>>   /**
>>    * drm_fb_helper_sys_read - wrapper around fb_sys_read
>>    * @info: fb_info struct pointer
>> @@ -862,7 +968,14 @@ EXPORT_SYMBOL(drm_fb_helper_sys_read);
>>   ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __use=
r *buf,
>>   				size_t count, loff_t *ppos)
>>   {
>> -	return fb_sys_write(info, buf, count, ppos);
>> +	ssize_t ret;
>> +
>> +	ret =3D fb_sys_write(info, buf, count, ppos);
>> +	if (ret > 0)
>> +		drm_fb_helper_dirty(info, 0, 0, info->var.xres,
>> +				    info->var.yres);
>> +
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_sys_write);
>>
>> @@ -877,6 +990,8 @@ void drm_fb_helper_sys_fillrect(struct fb_info *info,
>>   				const struct fb_fillrect *rect)
>>   {
>>   	sys_fillrect(info, rect);
>> +	drm_fb_helper_dirty(info, rect->dx, rect->dy,
>> +			    rect->width, rect->height);
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_sys_fillrect);
>>
>> @@ -891,6 +1006,8 @@ void drm_fb_helper_sys_copyarea(struct fb_info *inf=
o,
>>   				const struct fb_copyarea *area)
>>   {
>>   	sys_copyarea(info, area);
>> +	drm_fb_helper_dirty(info, area->dx, area->dy,
>> +			    area->width, area->height);
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_sys_copyarea);
>>
>> @@ -905,6 +1022,8 @@ void drm_fb_helper_sys_imageblit(struct fb_info *in=
fo,
>>   				 const struct fb_image *image)
>>   {
>>   	sys_imageblit(info, image);
>> +	drm_fb_helper_dirty(info, image->dx, image->dy,
>> +			    image->width, image->height);
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_sys_imageblit);
>>
>> @@ -919,6 +1038,8 @@ void drm_fb_helper_cfb_fillrect(struct fb_info *inf=
o,
>>   				const struct fb_fillrect *rect)
>>   {
>>   	cfb_fillrect(info, rect);
>> +	drm_fb_helper_dirty(info, rect->dx, rect->dy,
>> +			    rect->width, rect->height);
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_cfb_fillrect);
>>
>> @@ -933,6 +1054,8 @@ void drm_fb_helper_cfb_copyarea(struct fb_info *inf=
o,
>>   				const struct fb_copyarea *area)
>>   {
>>   	cfb_copyarea(info, area);
>> +	drm_fb_helper_dirty(info, area->dx, area->dy,
>> +			    area->width, area->height);
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_cfb_copyarea);
>>
>> @@ -947,6 +1070,8 @@ void drm_fb_helper_cfb_imageblit(struct fb_info *in=
fo,
>>   				 const struct fb_image *image)
>>   {
>>   	cfb_imageblit(info, image);
>> +	drm_fb_helper_dirty(info, image->dx, image->dy,
>> +			    image->width, image->height);
>>   }
>>   EXPORT_SYMBOL(drm_fb_helper_cfb_imageblit);
>>
>> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
>> index 062723b..dde825c 100644
>> --- a/include/drm/drm_fb_helper.h
>> +++ b/include/drm/drm_fb_helper.h
>> @@ -172,6 +172,10 @@ struct drm_fb_helper_connector {
>>    * @funcs: driver callbacks for fb helper
>>    * @fbdev: emulated fbdev device info struct
>>    * @pseudo_palette: fake palette of 16 colors
>> + * @dirty_clip: clip rectangle used with deferred_io to accumulate dama=
ge to
>> + *              the screen buffer
>> + * @dirty_lock: spinlock protecting @dirty_clip
>> + * @dirty_work: worker used to flush the framebuffer
>>    *
>>    * This is the main structure used by the fbdev helpers. Drivers suppo=
rting
>>    * fbdev emulation should embedded this into their overall driver stru=
cture.
>> @@ -189,6 +193,11 @@ struct drm_fb_helper {
>>   	const struct drm_fb_helper_funcs *funcs;
>>   	struct fb_info *fbdev;
>>   	u32 pseudo_palette[17];
>> +#ifdef CONFIG_FB_DEFERRED_IO
>> +	struct drm_clip_rect dirty_clip;
>> +	spinlock_t dirty_lock;
>> +	struct work_struct dirty_work;
>> +#endif
>>
>>   	/**
>>   	 * @kernel_fb_list:
>> @@ -245,6 +254,9 @@ void drm_fb_helper_fill_fix(struct fb_info *info, ui=
nt32_t pitch,
>>
>>   void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb_helper);
>>
>> +void drm_fb_helper_deferred_io(struct fb_info *info,
>> +			       struct list_head *pagelist);
>> +
>>   ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
>>   			       size_t count, loff_t *ppos);
>>   ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __use=
r *buf,
>> @@ -368,6 +380,11 @@ static inline void drm_fb_helper_unlink_fbi(struct =
drm_fb_helper *fb_helper)
>>   {
>>   }
>>
>> +static inline void drm_fb_helper_deferred_io(struct fb_info *info,
>> +					     struct list_head *pagelist)
>> +{
>> +}
>> +
>>   static inline ssize_t drm_fb_helper_sys_read(struct fb_info *info,
>>   					     char __user *buf, size_t count,
>>   					     loff_t *ppos)
>> --
>> 2.2.2
>>

