From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Mon, 25 Apr 2016 18:35:18 +0000
Subject: Re: [PATCH v2 1/8] drm/rect: Add some drm_clip_rect utility functions
Message-Id: <571E6366.20504@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-2-git-send-email-noralf@tronnes.org>
 <20160425123907.GY4329@intel.com> <571E13D8.4060100@tronnes.org>
 <20160425130229.GZ4329@intel.com> <571E23A1.2040100@tronnes.org>
 <20160425150944.GB4329@intel.com> <20160425160520.GV2510@phenom.ffwll.local>
 <20160425163816.GF4329@intel.com>
In-Reply-To: <20160425163816.GF4329@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Den 25.04.2016 18:38, skrev Ville Syrj=E4l=E4:
> On Mon, Apr 25, 2016 at 06:05:20PM +0200, Daniel Vetter wrote:
>> On Mon, Apr 25, 2016 at 06:09:44PM +0300, Ville Syrj=E4l=E4 wrote:
>>> On Mon, Apr 25, 2016 at 04:03:13PM +0200, Noralf Tr=F8nnes wrote:
>>>> Den 25.04.2016 15:02, skrev Ville Syrj=E4l=E4:
>>>>> On Mon, Apr 25, 2016 at 02:55:52PM +0200, Noralf Tr=F8nnes wrote:
>>>>>> Den 25.04.2016 14:39, skrev Ville Syrj=E4l=E4:
>>>>>>> On Sun, Apr 24, 2016 at 10:48:55PM +0200, Noralf Tr=F8nnes wrote:
>>>>>>>> Add some utility functions for struct drm_clip_rect.
>>>>>>> Looks like mostly you're just duplicating the drm_rect stuff. Why c=
an't
>>>>>>> you use what's there already?
>>>>>> That's because the framebuffer flushing uses drm_clip_rect and not d=
rm_rect:
>>>>> Converting to drm_rect is not an option?
>>>> That's difficult or at least verbose to do because clips is an array.
>>>> I could use drm_rect on the calling side (fbdev) since it's only one c=
lip
>>>> which the changes are merged into, and then convert it when I call dir=
ty().
>>>> But the driver can get zero or more clips from the dirty ioctl so I do=
n't
>>>> see a clean way to convert this array to drm_rect without more code th=
an
>>>> this proposal has.
>>> Just some kind of simple drm_clip_rect_to_rect() thing should be enough=
 AFAICS.
>> Yeah, drm_clip_rect is the uapi struct, drm_rect is the internal one.
>> Similar case is drm_display_mode vs. drm_mode_modeinfo. We have
>> umode_to_mode and mode_to_umode helpers to deal with that. I do agree th=
at
>> it would make sense to switch the internal ->dirty callback over to the
>> internal drm_struct. Would need a kmalloc+copy in the dirtyfb ioctl, but
>> since the structs actually match in their member names (just not the
>> size/signedness, sigh) there shouldn't be any need for driver changes. So
>> fairly simple patch.
> Or if we want to avoid the malloc, then the merge() thing could just
> internally convert one at a time on stack when going through them.
> Though then someone might want to do a merge() with internal drm_rects,
> and we'd be right where we started. But I'm not sure that will happen,
> so perhaps it's just too much future proofing.
>
>> Ofc you need to compile-test all the drivers (at least those using ->dir=
ty
>> hook) to make sure gcc is still happy with all the signed vs. unsigned
>> stuff. Maybe that turns up something, but hopefully not.
>>
>> Sorry for that late request, but I really didn't realize what's going on
>> here :(
>> -Daniel

How about we just drop this patch?
I couldn't find anyone else that merge these clips, they just loop and
handle them individually.

The relevant part in drm_fb_helper would become:

static void drm_fb_helper_dirty_work(struct work_struct *work)
{
     struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_help=
er,
                             dirty_work);
     struct drm_clip_rect *clip =3D &helper->dirty_clip;
     struct drm_clip_rect clip_copy;
     unsigned long flags;

     spin_lock_irqsave(&helper->dirty_lock, flags);
     clip_copy =3D *clip;
     clip->x1 =3D clip->y1 =3D ~0;
     clip->x2 =3D clip->y2 =3D 0;
     spin_unlock_irqrestore(&helper->dirty_lock, flags);

     helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
}

static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper)
{
     spin_lock_init(&helper->dirty_lock);
     INIT_WORK(&helper->dirty_work, drm_fb_helper_dirty_work);
     helper->dirty_clip.x1 =3D helper->dirty_clip.y1 =3D ~0;
}

static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
                 u32 width, u32 height)
{
     struct drm_fb_helper *helper =3D info->par;
     struct drm_clip_rect *clip =3D &helper->dirty_clip;
     unsigned long flags;

     if (!helper->fb->funcs->dirty)
         return;

     spin_lock_irqsave(&helper->dirty_lock, flags);
     clip->x1 =3D min(clip->x1, x);
     clip->y1 =3D min(clip->y1, y);
     clip->x2 =3D max(clip->x2, x + width);
     clip->y2 =3D max(clip->y2, y + height);
     spin_unlock_irqrestore(&helper->dirty_lock, flags);

     schedule_work(&helper->dirty_work);
}


And the driver would use this tinydrm function:

void tinydrm_merge_clips(struct drm_clip_rect *dst,
              struct drm_clip_rect *src, unsigned num_clips,
              unsigned flags, u32 width, u32 height)
{
     int i;

     if (!src || !num_clips) {
         dst->x1 =3D 0;
         dst->x2 =3D width;
         dst->y1 =3D 0;
         dst->y2 =3D height;
         return;
     }

     dst->x1 =3D dst->y1 =3D ~0;
     dst->x2 =3D dst->y2 =3D 0;

     for (i =3D 0; i < num_clips; i++) {
         if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
             i++;
         dst->x1 =3D min(dst->x1, src[i].x1);
         dst->x2 =3D max(dst->x2, src[i].x2);
         dst->y1 =3D min(dst->y1, src[i].y1);
         dst->y2 =3D max(dst->y2, src[i].y2);
     }

     if (dst->x2 > width || dst->y2 > height ||
         dst->x1 >=3D dst->x2 || dst->y1 >=3D dst->y2) {
         DRM_DEBUG_KMS("Illegal clip: x1=3D%u, x2=3D%u, y1=3D%u, y2=3D%u\n",
                   dst->x1, dst->x2, dst->y1, dst->y2);
         dst->x1 =3D dst->y1 =3D 0;
         dst->x2 =3D width;
         dst->y2 =3D height;
     }
}

static int mipi_dbi_dirtyfb(struct drm_framebuffer *fb, void *vmem,
                 unsigned flags, unsigned color,
                 struct drm_clip_rect *clips, unsigned num_clips)
{
     struct drm_clip_rect clip;

     tinydrm_merge_clips(&clip, clips, num_clips, flags,
                 fb->width, fb->height);



>>>> Here's the driver side:
>>>>
>>>> static int mipi_dbi_dirtyfb(struct drm_framebuffer *fb, void *vmem,
>>>>                   unsigned flags, unsigned color,
>>>>                   struct drm_clip_rect *clips, unsigned num_clips)
>>>> {
>>>>       struct tinydrm_device *tdev =3D fb->dev->dev_private;
>>>>       struct lcdreg *reg =3D tdev->lcdreg;
>>>>       struct drm_clip_rect full_clip =3D {
>>>>           .x1 =3D 0,
>>>>           .x2 =3D fb->width,
>>>>           .y1 =3D 0,
>>>>           .y2 =3D fb->height,
>>>>       };
>>>>       struct drm_clip_rect clip;
>>>>       int ret;
>>>>
>>>>       drm_clip_rect_reset(&clip);
>>>>       drm_clip_rect_merge(&clip, clips, num_clips, flags,
>>>>                   fb->width, fb->height);
>>>>       if (!drm_clip_rect_intersect(&clip, &full_clip)) {
>>>>           DRM_DEBUG_KMS("Empty clip\n");
>>>>           return -EINVAL;
>>>>       }
>>>> [...]
>>>>>> struct drm_framebuffer_funcs {
>>>>>> [...]
>>>>>>            int (*dirty)(struct drm_framebuffer *framebuffer,
>>>>>>                         struct drm_file *file_priv, unsigned flags,
>>>>>>                         unsigned color, struct drm_clip_rect *clips,
>>>>>>                         unsigned num_clips);
>>>>>> };
>>>>>>
>>>>>>>> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/drm_rect.c | 67 ++++++++++++++++++++++++++++++=
++++++++++++++
>>>>>>>>     include/drm/drm_rect.h     | 69 ++++++++++++++++++++++++++++++=
++++++++++++++++
>>>>>>>>     2 files changed, 136 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect=
.c
>>>>>>>> index a8e2c86..a9fb1a8 100644
>>>>>>>> --- a/drivers/gpu/drm/drm_rect.c
>>>>>>>> +++ b/drivers/gpu/drm/drm_rect.c
>>>>>>>> @@ -434,3 +434,70 @@ void drm_rect_rotate_inv(struct drm_rect *r,
>>>>>>>>     	}
>>>>>>>>     }
>>>>>>>>     EXPORT_SYMBOL(drm_rect_rotate_inv);
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_intersect - intersect two clip rectangles
>>>>>>>> + * @r1: first clip rectangle
>>>>>>>> + * @r2: second clip rectangle
>>>>>>>> + *
>>>>>>>> + * Calculate the intersection of clip rectangles @r1 and @r2.
>>>>>>>> + * @r1 will be overwritten with the intersection.
>>>>>>>> + *
>>>>>>>> + * RETURNS:
>>>>>>>> + * %true if rectangle @r1 is still visible after the operation,
>>>>>>>> + * %false otherwise.
>>>>>>>> + */
>>>>>>>> +bool drm_clip_rect_intersect(struct drm_clip_rect *r1,
>>>>>>>> +			     const struct drm_clip_rect *r2)
>>>>>>>> +{
>>>>>>>> +	r1->x1 =3D max(r1->x1, r2->x1);
>>>>>>>> +	r1->y1 =3D max(r1->y1, r2->y1);
>>>>>>>> +	r1->x2 =3D min(r1->x2, r2->x2);
>>>>>>>> +	r1->y2 =3D min(r1->y2, r2->y2);
>>>>>>>> +
>>>>>>>> +	return drm_clip_rect_visible(r1);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(drm_clip_rect_intersect);
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_merge - Merge clip rectangles
>>>>>>>> + * @dst: destination clip rectangle
>>>>>>>> + * @src: source clip rectangle(s), can be NULL
>>>>>>>> + * @num_clips: number of source clip rectangles
>>>>>>>> + * @flags: drm_mode_fb_dirty_cmd flags (DRM_MODE_FB_DIRTY_ANNOTAT=
E_COPY)
>>>>>>>> + * @width: width of clip rectangle if @src is NULL
>>>>>>>> + * @height: height of clip rectangle if @src is NULL
>>>>>>>> + *
>>>>>>>> + * The dirtyfb ioctl allows for a NULL clip rectangle to be passe=
d in,
>>>>>>>> + * so if @src is NULL, width and height is used to set a full cli=
p rectangle.
>>>>>>>> + * @dst takes part in the merge unless it is empty {0,0,0,0}.
>>>>>>>> + */
>>>>>>>> +void drm_clip_rect_merge(struct drm_clip_rect *dst,
>>>>>>>> +			 struct drm_clip_rect *src, unsigned num_clips,
>>>>>>>> +			 unsigned flags, u32 width, u32 height)
>>>>>>>> +{
>>>>>>>> +	int i;
>>>>>>>> +
>>>>>>>> +	if (!src || !num_clips) {
>>>>>>>> +		dst->x1 =3D 0;
>>>>>>>> +		dst->x2 =3D width;
>>>>>>>> +		dst->y1 =3D 0;
>>>>>>>> +		dst->y2 =3D height;
>>>>>>>> +		return;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	if (drm_clip_rect_is_empty(dst)) {
>>>>>>>> +		dst->x1 =3D ~0;
>>>>>>>> +		dst->y1 =3D ~0;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	for (i =3D 0; i < num_clips; i++) {
>>>>>>>> +		if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
>>>>>>>> +			i++;
>>>>>>>> +		dst->x1 =3D min(dst->x1, src[i].x1);
>>>>>>>> +		dst->x2 =3D max(dst->x2, src[i].x2);
>>>>>>>> +		dst->y1 =3D min(dst->y1, src[i].y1);
>>>>>>>> +		dst->y2 =3D max(dst->y2, src[i].y2);
>>>>>>>> +	}
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(drm_clip_rect_merge);
>>>>>>>> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
>>>>>>>> index 83bb156..936ad8d 100644
>>>>>>>> --- a/include/drm/drm_rect.h
>>>>>>>> +++ b/include/drm/drm_rect.h
>>>>>>>> @@ -24,6 +24,8 @@
>>>>>>>>     #ifndef DRM_RECT_H
>>>>>>>>     #define DRM_RECT_H
>>>>>>>>    =20
>>>>>>>> +#include <uapi/drm/drm.h>
>>>>>>>> +
>>>>>>>>     /**
>>>>>>>>      * DOC: rect utils
>>>>>>>>      *
>>>>>>>> @@ -171,4 +173,71 @@ void drm_rect_rotate_inv(struct drm_rect *r,
>>>>>>>>     			 int width, int height,
>>>>>>>>     			 unsigned int rotation);
>>>>>>>>    =20
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_width - determine the clip rectangle width
>>>>>>>> + * @r: clip rectangle whose width is returned
>>>>>>>> + *
>>>>>>>> + * RETURNS:
>>>>>>>> + * The width of the clip rectangle.
>>>>>>>> + */
>>>>>>>> +static inline int drm_clip_rect_width(const struct drm_clip_rect =
*r)
>>>>>>>> +{
>>>>>>>> +	return r->x2 - r->x1;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_height - determine the clip rectangle height
>>>>>>>> + * @r: clip rectangle whose height is returned
>>>>>>>> + *
>>>>>>>> + * RETURNS:
>>>>>>>> + * The height of the clip rectangle.
>>>>>>>> + */
>>>>>>>> +static inline int drm_clip_rect_height(const struct drm_clip_rect=
 *r)
>>>>>>>> +{
>>>>>>>> +	return r->y2 - r->y1;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_visible - determine if the the clip rectangle is=
 visible
>>>>>>>> + * @r: clip rectangle whose visibility is returned
>>>>>>>> + *
>>>>>>>> + * RETURNS:
>>>>>>>> + * %true if the clip rectangle is visible, %false otherwise.
>>>>>>>> + */
>>>>>>>> +static inline bool drm_clip_rect_visible(const struct drm_clip_re=
ct *r)
>>>>>>>> +{
>>>>>>>> +	return drm_clip_rect_width(r) > 0 && drm_clip_rect_height(r) > 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_reset - Reset clip rectangle
>>>>>>>> + * @clip: clip rectangle
>>>>>>>> + *
>>>>>>>> + * Sets clip rectangle to {0,0,0,0}.
>>>>>>>> + */
>>>>>>>> +static inline void drm_clip_rect_reset(struct drm_clip_rect *clip)
>>>>>>>> +{
>>>>>>>> +	clip->x1 =3D 0;
>>>>>>>> +	clip->x2 =3D 0;
>>>>>>>> +	clip->y1 =3D 0;
>>>>>>>> +	clip->y2 =3D 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * drm_clip_rect_is_empty - Is clip rectangle empty?
>>>>>>>> + * @clip: clip rectangle
>>>>>>>> + *
>>>>>>>> + * Returns true if clip rectangle is {0,0,0,0}.
>>>>>>>> + */
>>>>>>>> +static inline bool drm_clip_rect_is_empty(struct drm_clip_rect *c=
lip)
>>>>>>>> +{
>>>>>>>> +	return (!clip->x1 && !clip->x2 && !clip->y1 && !clip->y2);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +bool drm_clip_rect_intersect(struct drm_clip_rect *r1,
>>>>>>>> +			     const struct drm_clip_rect *r2);
>>>>>>>> +void drm_clip_rect_merge(struct drm_clip_rect *dst,
>>>>>>>> +			 struct drm_clip_rect *src, unsigned num_clips,
>>>>>>>> +			 unsigned flags, u32 width, u32 height);
>>>>>>>> +
>>>>>>>>     #endif
>>>>>>>> --=20
>>>>>>>> 2.2.2
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> dri-devel mailing list
>>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>> --=20
>>> Ville Syrj=E4l=E4
>>> Intel OTC
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> --=20
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch

