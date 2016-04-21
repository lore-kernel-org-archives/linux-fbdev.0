From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 21 Apr 2016 07:28:47 +0000
Subject: Re: [PATCH 2/8] drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <20160421072847.GW2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-3-git-send-email-noralf@tronnes.org>
 <20160420174241.GP2510@phenom.ffwll.local>
 <5717C742.7080807@tronnes.org>
In-Reply-To: <5717C742.7080807@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, Apr 20, 2016 at 08:15:30PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 20.04.2016 19:42, skrev Daniel Vetter:
> >On Wed, Apr 20, 2016 at 05:25:23PM +0200, Noralf Tr=F8nnes wrote:
> >>Now that drm_fb_helper gets deferred io support, the
> >>drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
> >>the worker that calls the deferred_io callback. This will break this
> >>driver so use the sys_{fillrect,copyarea,imageblit} functions directly.
> >>
> >>Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> >I think this intermediately breaks the build, if you disable fbdev
> >support. That's now supported in the fbdev helpers core generically acro=
ss
> >all drivers.
> >
> >Not sure how to best fix this up, since the only way would be to squash
> >these patches, plus generic deferred io plus the conversion patches for
> >udl/qxl all into one. Tricky.
>=20
> Yes you're right, I missed that.
> How about this:
> #ifdef CONFIG_FB
>         sys_fillrect(info, rect);
> #endif
>=20
> The later patch will then remove this ugliness...

Yeah I think we have to bite the bullet and take this temporary ugliness
:(

-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
