From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Fri, 22 Nov 2013 17:46:53 +0000
Subject: Re: [Mesa-dev] [PATCH] dri3, i915, i965: Add __DRI_IMAGE_FOURCC_SARGB8888
Message-Id: <20131122174653.GH10036@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385093524-22276-1-git-send-email-keithp@keithp.com>
 <20131122102632.GQ27344@phenom.ffwll.local>
 <86d2lsem3m.fsf@miki.keithp.com>
 <CAKMK7uEqHKOmMFXZLKno1q08X1B=U7XcJiExHaHbO9VdMeCihQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEqHKOmMFXZLKno1q08X1B=U7XcJiExHaHbO9VdMeCihQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Keith Packard <keithp@keithp.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Mesa Dev <mesa-dev@lists.freedesktop.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Fri, Nov 22, 2013 at 05:17:37PM +0100, Daniel Vetter wrote:
> On Fri, Nov 22, 2013 at 12:01 PM, Keith Packard <keithp@keithp.com> wrote:
> > Daniel Vetter <daniel@ffwll.ch> writes:
> >
> >> Hm, where do we have the canonical source for all these fourcc codes? =
I'm
> >> asking since we have our own copy in the kernel as drm_fourcc.h, and t=
hat
> >> one is part of the userspace ABI since we use it to pass around
> >> framebuffer formats and format lists.
> >
> > I think it's the kernel? I really don't know, as the whole notion of
> > fourcc codes seems crazy to me...
> >
> > Feel free to steal this code and stick it in the kernel if you like.
>=20
> Well, I wasn't ever in favour of using fourcc codes since they're just
> not standardized at all, highly redundant in some cases and also miss
> lots of stuff we actually need (like all the rgb formats).

I also argued against them, but some people wanted them for whatever
reason. And since I didn't want to argue for several years about the
subject, I just gave in and made the drm pixel formats fourcss. But
given that I just pulled the fourccs out of my ass, we can't really
cross use them between different subsystems anyway. So if we just
consider all the different fourcc namespaces totally distinct, we're
not going to have any problems.

Personally I can promise that I will _not_ be checking Mesa/whatever
code for conflicting fourccs when I need to add a new one to drm_fourcc.h.
There, now I've given fair warning and if things explode later it won't be
my fault.

However if someone wants to emulate the drm fourcc style for whatever
reason, there is a distinct pattern how I cooked them up. Well, a few
different patterns depending whether it's RGB,YUV,packed,planar etc.

>=20
> Cc'ing the heck out of this to get kernel people to hopefully notice.
> Maybe someone takes charge of this ... Otherwise meh.
>=20
> >> Just afraid to create long-term maintainance madness here with the
> >> kernel's iron thou-shalt-not-break-userspace-ever rule ... Not likely
> >> we'll ever accept srgb for framebuffers though.
> >
> > Would suck to collide with something we do want though.
>=20
> Yeah, it'd suck. But given how fourcc works we probably have that
> already, just haven't noticed yet :(
> -Daniel
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
Intel OTC
