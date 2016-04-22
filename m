From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 22 Apr 2016 08:24:15 +0000
Subject: Re: [PATCH 2/8] drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <20160422082415.GG2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-3-git-send-email-noralf@tronnes.org>
 <20160420174241.GP2510@phenom.ffwll.local>
 <5717C742.7080807@tronnes.org>
 <20160421072847.GW2510@phenom.ffwll.local>
 <57191988.3020904@tronnes.org>
In-Reply-To: <57191988.3020904@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Thu, Apr 21, 2016 at 08:18:48PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 21.04.2016 09:28, skrev Daniel Vetter:
> >On Wed, Apr 20, 2016 at 08:15:30PM +0200, Noralf Tr=F8nnes wrote:
> >>Den 20.04.2016 19:42, skrev Daniel Vetter:
> >>>On Wed, Apr 20, 2016 at 05:25:23PM +0200, Noralf Tr=F8nnes wrote:
> >>>>Now that drm_fb_helper gets deferred io support, the
> >>>>drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedu=
le
> >>>>the worker that calls the deferred_io callback. This will break this
> >>>>driver so use the sys_{fillrect,copyarea,imageblit} functions directl=
y.
> >>>>
> >>>>Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> >>>I think this intermediately breaks the build, if you disable fbdev
> >>>support. That's now supported in the fbdev helpers core generically ac=
ross
> >>>all drivers.
> >>>
> >>>Not sure how to best fix this up, since the only way would be to squash
> >>>these patches, plus generic deferred io plus the conversion patches for
> >>>udl/qxl all into one. Tricky.
> >>Yes you're right, I missed that.
> >>How about this:
> >>#ifdef CONFIG_FB
> >>         sys_fillrect(info, rect);
> >>#endif
> >>
> >>The later patch will then remove this ugliness...
> >Yeah I think we have to bite the bullet and take this temporary ugliness
> >:(
>=20
> Turns out the #ifdef isn't necessary since FB is always selected.
>=20
> Both udl and qxl have this:
>         select DRM_KMS_HELPER
>         select DRM_KMS_FB_HELPER
>=20
> And then we have:
>=20
> config DRM_KMS_HELPER
>         tristate
>         depends on DRM
>=20
> config DRM_KMS_FB_HELPER
>         bool
>         depends on DRM_KMS_HELPER
>         select FB
>         ...
>         select FB_SYS_FILLRECT
>         select FB_SYS_COPYAREA
>         select FB_SYS_IMAGEBLIT

Hm ... the thing that actually builds fbdev emulation is
DRM_FBDEV_EMULATION, and you can disable that. Otoh the select FB stuff
seems to be at the wrong level and probably should be moved.

But indeed I tried doing this and it's an impossible config. I guess I
need to type a patch to ditch all these selects from drivers ;-)
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
