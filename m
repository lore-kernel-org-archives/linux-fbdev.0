From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Mon, 25 Apr 2016 13:02:29 +0000
Subject: Re: [PATCH v2 1/8] drm/rect: Add some drm_clip_rect utility functions
Message-Id: <20160425130229.GZ4329@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-2-git-send-email-noralf@tronnes.org>
 <20160425123907.GY4329@intel.com>
 <571E13D8.4060100@tronnes.org>
In-Reply-To: <571E13D8.4060100@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

On Mon, Apr 25, 2016 at 02:55:52PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 25.04.2016 14:39, skrev Ville Syrj=E4l=E4:
> > On Sun, Apr 24, 2016 at 10:48:55PM +0200, Noralf Tr=F8nnes wrote:
> >> Add some utility functions for struct drm_clip_rect.
> > Looks like mostly you're just duplicating the drm_rect stuff. Why can't
> > you use what's there already?
>=20
> That's because the framebuffer flushing uses drm_clip_rect and not drm_re=
ct:

Converting to drm_rect is not an option?

>=20
> struct drm_framebuffer_funcs {
> [...]
>          int (*dirty)(struct drm_framebuffer *framebuffer,
>                       struct drm_file *file_priv, unsigned flags,
>                       unsigned color, struct drm_clip_rect *clips,
>                       unsigned num_clips);
> };
>=20
> >> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> >> ---
> >>   drivers/gpu/drm/drm_rect.c | 67 ++++++++++++++++++++++++++++++++++++=
++++++++
> >>   include/drm/drm_rect.h     | 69 ++++++++++++++++++++++++++++++++++++=
++++++++++
> >>   2 files changed, 136 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect.c
> >> index a8e2c86..a9fb1a8 100644
> >> --- a/drivers/gpu/drm/drm_rect.c
> >> +++ b/drivers/gpu/drm/drm_rect.c
> >> @@ -434,3 +434,70 @@ void drm_rect_rotate_inv(struct drm_rect *r,
> >>   	}
> >>   }
> >>   EXPORT_SYMBOL(drm_rect_rotate_inv);
> >> +
> >> +/**
> >> + * drm_clip_rect_intersect - intersect two clip rectangles
> >> + * @r1: first clip rectangle
> >> + * @r2: second clip rectangle
> >> + *
> >> + * Calculate the intersection of clip rectangles @r1 and @r2.
> >> + * @r1 will be overwritten with the intersection.
> >> + *
> >> + * RETURNS:
> >> + * %true if rectangle @r1 is still visible after the operation,
> >> + * %false otherwise.
> >> + */
> >> +bool drm_clip_rect_intersect(struct drm_clip_rect *r1,
> >> +			     const struct drm_clip_rect *r2)
> >> +{
> >> +	r1->x1 =3D max(r1->x1, r2->x1);
> >> +	r1->y1 =3D max(r1->y1, r2->y1);
> >> +	r1->x2 =3D min(r1->x2, r2->x2);
> >> +	r1->y2 =3D min(r1->y2, r2->y2);
> >> +
> >> +	return drm_clip_rect_visible(r1);
> >> +}
> >> +EXPORT_SYMBOL(drm_clip_rect_intersect);
> >> +
> >> +/**
> >> + * drm_clip_rect_merge - Merge clip rectangles
> >> + * @dst: destination clip rectangle
> >> + * @src: source clip rectangle(s), can be NULL
> >> + * @num_clips: number of source clip rectangles
> >> + * @flags: drm_mode_fb_dirty_cmd flags (DRM_MODE_FB_DIRTY_ANNOTATE_CO=
PY)
> >> + * @width: width of clip rectangle if @src is NULL
> >> + * @height: height of clip rectangle if @src is NULL
> >> + *
> >> + * The dirtyfb ioctl allows for a NULL clip rectangle to be passed in,
> >> + * so if @src is NULL, width and height is used to set a full clip re=
ctangle.
> >> + * @dst takes part in the merge unless it is empty {0,0,0,0}.
> >> + */
> >> +void drm_clip_rect_merge(struct drm_clip_rect *dst,
> >> +			 struct drm_clip_rect *src, unsigned num_clips,
> >> +			 unsigned flags, u32 width, u32 height)
> >> +{
> >> +	int i;
> >> +
> >> +	if (!src || !num_clips) {
> >> +		dst->x1 =3D 0;
> >> +		dst->x2 =3D width;
> >> +		dst->y1 =3D 0;
> >> +		dst->y2 =3D height;
> >> +		return;
> >> +	}
> >> +
> >> +	if (drm_clip_rect_is_empty(dst)) {
> >> +		dst->x1 =3D ~0;
> >> +		dst->y1 =3D ~0;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < num_clips; i++) {
> >> +		if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
> >> +			i++;
> >> +		dst->x1 =3D min(dst->x1, src[i].x1);
> >> +		dst->x2 =3D max(dst->x2, src[i].x2);
> >> +		dst->y1 =3D min(dst->y1, src[i].y1);
> >> +		dst->y2 =3D max(dst->y2, src[i].y2);
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL(drm_clip_rect_merge);
> >> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
> >> index 83bb156..936ad8d 100644
> >> --- a/include/drm/drm_rect.h
> >> +++ b/include/drm/drm_rect.h
> >> @@ -24,6 +24,8 @@
> >>   #ifndef DRM_RECT_H
> >>   #define DRM_RECT_H
> >>  =20
> >> +#include <uapi/drm/drm.h>
> >> +
> >>   /**
> >>    * DOC: rect utils
> >>    *
> >> @@ -171,4 +173,71 @@ void drm_rect_rotate_inv(struct drm_rect *r,
> >>   			 int width, int height,
> >>   			 unsigned int rotation);
> >>  =20
> >> +/**
> >> + * drm_clip_rect_width - determine the clip rectangle width
> >> + * @r: clip rectangle whose width is returned
> >> + *
> >> + * RETURNS:
> >> + * The width of the clip rectangle.
> >> + */
> >> +static inline int drm_clip_rect_width(const struct drm_clip_rect *r)
> >> +{
> >> +	return r->x2 - r->x1;
> >> +}
> >> +
> >> +/**
> >> + * drm_clip_rect_height - determine the clip rectangle height
> >> + * @r: clip rectangle whose height is returned
> >> + *
> >> + * RETURNS:
> >> + * The height of the clip rectangle.
> >> + */
> >> +static inline int drm_clip_rect_height(const struct drm_clip_rect *r)
> >> +{
> >> +	return r->y2 - r->y1;
> >> +}
> >> +
> >> +/**
> >> + * drm_clip_rect_visible - determine if the the clip rectangle is vis=
ible
> >> + * @r: clip rectangle whose visibility is returned
> >> + *
> >> + * RETURNS:
> >> + * %true if the clip rectangle is visible, %false otherwise.
> >> + */
> >> +static inline bool drm_clip_rect_visible(const struct drm_clip_rect *=
r)
> >> +{
> >> +	return drm_clip_rect_width(r) > 0 && drm_clip_rect_height(r) > 0;
> >> +}
> >> +
> >> +/**
> >> + * drm_clip_rect_reset - Reset clip rectangle
> >> + * @clip: clip rectangle
> >> + *
> >> + * Sets clip rectangle to {0,0,0,0}.
> >> + */
> >> +static inline void drm_clip_rect_reset(struct drm_clip_rect *clip)
> >> +{
> >> +	clip->x1 =3D 0;
> >> +	clip->x2 =3D 0;
> >> +	clip->y1 =3D 0;
> >> +	clip->y2 =3D 0;
> >> +}
> >> +
> >> +/**
> >> + * drm_clip_rect_is_empty - Is clip rectangle empty?
> >> + * @clip: clip rectangle
> >> + *
> >> + * Returns true if clip rectangle is {0,0,0,0}.
> >> + */
> >> +static inline bool drm_clip_rect_is_empty(struct drm_clip_rect *clip)
> >> +{
> >> +	return (!clip->x1 && !clip->x2 && !clip->y1 && !clip->y2);
> >> +}
> >> +
> >> +bool drm_clip_rect_intersect(struct drm_clip_rect *r1,
> >> +			     const struct drm_clip_rect *r2);
> >> +void drm_clip_rect_merge(struct drm_clip_rect *dst,
> >> +			 struct drm_clip_rect *src, unsigned num_clips,
> >> +			 unsigned flags, u32 width, u32 height);
> >> +
> >>   #endif
> >> --=20
> >> 2.2.2
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
Intel OTC
