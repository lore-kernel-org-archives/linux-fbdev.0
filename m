From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 25 Apr 2016 19:03:15 +0000
Subject: Re: [PATCH v2 1/8] drm/rect: Add some drm_clip_rect utility functions
Message-Id: <20160425190315.GX2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <1461530942-22485-2-git-send-email-noralf@tronnes.org>
 <20160425123907.GY4329@intel.com> <571E13D8.4060100@tronnes.org>
 <20160425130229.GZ4329@intel.com> <571E23A1.2040100@tronnes.org>
 <20160425150944.GB4329@intel.com>
 <20160425160520.GV2510@phenom.ffwll.local>
 <20160425163816.GF4329@intel.com> <571E6366.20504@tronnes.org>
In-Reply-To: <571E6366.20504@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Mon, Apr 25, 2016 at 08:35:18PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 25.04.2016 18:38, skrev Ville Syrj=E4l=E4:
> >On Mon, Apr 25, 2016 at 06:05:20PM +0200, Daniel Vetter wrote:
> >>On Mon, Apr 25, 2016 at 06:09:44PM +0300, Ville Syrj=E4l=E4 wrote:
> >>>On Mon, Apr 25, 2016 at 04:03:13PM +0200, Noralf Tr=F8nnes wrote:
> >>>>Den 25.04.2016 15:02, skrev Ville Syrj=E4l=E4:
> >>>>>On Mon, Apr 25, 2016 at 02:55:52PM +0200, Noralf Tr=F8nnes wrote:
> >>>>>>Den 25.04.2016 14:39, skrev Ville Syrj=E4l=E4:
> >>>>>>>On Sun, Apr 24, 2016 at 10:48:55PM +0200, Noralf Tr=F8nnes wrote:
> >>>>>>>>Add some utility functions for struct drm_clip_rect.
> >>>>>>>Looks like mostly you're just duplicating the drm_rect stuff. Why =
can't
> >>>>>>>you use what's there already?
> >>>>>>That's because the framebuffer flushing uses drm_clip_rect and not =
drm_rect:
> >>>>>Converting to drm_rect is not an option?
> >>>>That's difficult or at least verbose to do because clips is an array.
> >>>>I could use drm_rect on the calling side (fbdev) since it's only one =
clip
> >>>>which the changes are merged into, and then convert it when I call di=
rty().
> >>>>But the driver can get zero or more clips from the dirty ioctl so I d=
on't
> >>>>see a clean way to convert this array to drm_rect without more code t=
han
> >>>>this proposal has.
> >>>Just some kind of simple drm_clip_rect_to_rect() thing should be enoug=
h AFAICS.
> >>Yeah, drm_clip_rect is the uapi struct, drm_rect is the internal one.
> >>Similar case is drm_display_mode vs. drm_mode_modeinfo. We have
> >>umode_to_mode and mode_to_umode helpers to deal with that. I do agree t=
hat
> >>it would make sense to switch the internal ->dirty callback over to the
> >>internal drm_struct. Would need a kmalloc+copy in the dirtyfb ioctl, but
> >>since the structs actually match in their member names (just not the
> >>size/signedness, sigh) there shouldn't be any need for driver changes. =
So
> >>fairly simple patch.
> >Or if we want to avoid the malloc, then the merge() thing could just
> >internally convert one at a time on stack when going through them.
> >Though then someone might want to do a merge() with internal drm_rects,
> >and we'd be right where we started. But I'm not sure that will happen,
> >so perhaps it's just too much future proofing.
> >
> >>Ofc you need to compile-test all the drivers (at least those using ->di=
rty
> >>hook) to make sure gcc is still happy with all the signed vs. unsigned
> >>stuff. Maybe that turns up something, but hopefully not.
> >>
> >>Sorry for that late request, but I really didn't realize what's going on
> >>here :(
> >>-Daniel
>=20
> How about we just drop this patch?
> I couldn't find anyone else that merge these clips, they just loop and
> handle them individually.
>=20
> The relevant part in drm_fb_helper would become:
>=20
> static void drm_fb_helper_dirty_work(struct work_struct *work)
> {
>     struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_hel=
per,
>                             dirty_work);
>     struct drm_clip_rect *clip =3D &helper->dirty_clip;
>     struct drm_clip_rect clip_copy;
>     unsigned long flags;
>=20
>     spin_lock_irqsave(&helper->dirty_lock, flags);
>     clip_copy =3D *clip;
>     clip->x1 =3D clip->y1 =3D ~0;
>     clip->x2 =3D clip->y2 =3D 0;
>     spin_unlock_irqrestore(&helper->dirty_lock, flags);
>=20
>     helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
> }
>=20
> static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper)
> {
>     spin_lock_init(&helper->dirty_lock);
>     INIT_WORK(&helper->dirty_work, drm_fb_helper_dirty_work);
>     helper->dirty_clip.x1 =3D helper->dirty_clip.y1 =3D ~0;
> }
>=20
> static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
>                 u32 width, u32 height)
> {
>     struct drm_fb_helper *helper =3D info->par;
>     struct drm_clip_rect *clip =3D &helper->dirty_clip;
>     unsigned long flags;
>=20
>     if (!helper->fb->funcs->dirty)
>         return;
>=20
>     spin_lock_irqsave(&helper->dirty_lock, flags);
>     clip->x1 =3D min(clip->x1, x);
>     clip->y1 =3D min(clip->y1, y);
>     clip->x2 =3D max(clip->x2, x + width);
>     clip->y2 =3D max(clip->y2, y + height);
>     spin_unlock_irqrestore(&helper->dirty_lock, flags);
>=20
>     schedule_work(&helper->dirty_work);
> }
>=20
>=20
> And the driver would use this tinydrm function:
>=20
> void tinydrm_merge_clips(struct drm_clip_rect *dst,
>              struct drm_clip_rect *src, unsigned num_clips,
>              unsigned flags, u32 width, u32 height)
> {
>     int i;
>=20
>     if (!src || !num_clips) {
>         dst->x1 =3D 0;
>         dst->x2 =3D width;
>         dst->y1 =3D 0;
>         dst->y2 =3D height;
>         return;
>     }
>=20
>     dst->x1 =3D dst->y1 =3D ~0;
>     dst->x2 =3D dst->y2 =3D 0;
>=20
>     for (i =3D 0; i < num_clips; i++) {
>         if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
>             i++;
>         dst->x1 =3D min(dst->x1, src[i].x1);
>         dst->x2 =3D max(dst->x2, src[i].x2);
>         dst->y1 =3D min(dst->y1, src[i].y1);
>         dst->y2 =3D max(dst->y2, src[i].y2);
>     }
>=20
>     if (dst->x2 > width || dst->y2 > height ||
>         dst->x1 >=3D dst->x2 || dst->y1 >=3D dst->y2) {
>         DRM_DEBUG_KMS("Illegal clip: x1=3D%u, x2=3D%u, y1=3D%u, y2=3D%u\n=
",
>                   dst->x1, dst->x2, dst->y1, dst->y2);
>         dst->x1 =3D dst->y1 =3D 0;
>         dst->x2 =3D width;
>         dst->y2 =3D height;
>     }
> }
>=20
> static int mipi_dbi_dirtyfb(struct drm_framebuffer *fb, void *vmem,
>                 unsigned flags, unsigned color,
>                 struct drm_clip_rect *clips, unsigned num_clips)
> {
>     struct drm_clip_rect clip;
>=20
>     tinydrm_merge_clips(&clip, clips, num_clips, flags,
>                 fb->width, fb->height);

Seems ok too, and I'm starting to get a guilty feeling with signing you up
for everything. I guess nuking drm_clip_rect from internal kms apis is
something for the next person to show up ;-)
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
