From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Fri, 22 Nov 2013 23:05:04 +0000
Subject: Re: [Intel-gfx] [Mesa-dev] [PATCH] dri3, i915, i965: Add __DRI_IMAGE_FOURCC_SARGB8888
Message-Id: <20131122230504.GK10036@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385093524-22276-1-git-send-email-keithp@keithp.com>
 <20131122102632.GQ27344@phenom.ffwll.local>
 <86d2lsem3m.fsf@miki.keithp.com>
 <CAKMK7uEqHKOmMFXZLKno1q08X1B=U7XcJiExHaHbO9VdMeCihQ@mail.gmail.com>
 <20131122221213.GA3234@tokamak.local>
In-Reply-To: <20131122221213.GA3234@tokamak.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <hoegsberg@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Mesa Dev <mesa-dev@lists.freedesktop.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Fri, Nov 22, 2013 at 02:12:13PM -0800, Kristian H=F8gsberg wrote:
> On Fri, Nov 22, 2013 at 05:17:37PM +0100, Daniel Vetter wrote:
> > On Fri, Nov 22, 2013 at 12:01 PM, Keith Packard <keithp@keithp.com> wro=
te:
> > > Daniel Vetter <daniel@ffwll.ch> writes:
> > >
> > >> Hm, where do we have the canonical source for all these fourcc codes=
? I'm
> > >> asking since we have our own copy in the kernel as drm_fourcc.h, and=
 that
> > >> one is part of the userspace ABI since we use it to pass around
> > >> framebuffer formats and format lists.
> > >
> > > I think it's the kernel? I really don't know, as the whole notion of
> > > fourcc codes seems crazy to me...
> > >
> > > Feel free to steal this code and stick it in the kernel if you like.
> >=20
> > Well, I wasn't ever in favour of using fourcc codes since they're just
> > not standardized at all, highly redundant in some cases and also miss
> > lots of stuff we actually need (like all the rgb formats).
>=20
> These drm codes are not fourcc codes in any other way than that
> they're defined by creating a 32 bit value by picking four characters.
> I don't know what PTSD triggers people have from hearing "fourcc", but
> it seems severe.  Forget all that, these codes are DRM specific
> defines that are not inteded to match anything anybody else does.  It
> doesn't matter if these match of conflict with v4l, fourcc.org,
> wikipedia.org or what the amiga did.  They're just tokens that let us
> define succintly what the pixel format of a kms framebuffer is and
> tell the kernel.
>=20
> I don't know what else you'd propose?  Pass an X visual in the ioctl?
> An EGL config?  This is our name space, we can add stuff as we need
> (as Keith is doing here). include/uapi/drm/drm_fourcc.h is the
> canonical source for these values and we should add
> DRM_FORMAT_SARGB8888 there to make sure we don't clash.

What is this format anyway? -ENODOCS

If its just an srgb version of ARGB8888, then I wouldn't really want it
in drm_fourcc.h. I expect colorspacy stuff will be handled by various
crtc/plane properties in the kernel so we don't need to encode that
stuff into the fb format.

--=20
Ville Syrj=E4l=E4
Intel OTC
