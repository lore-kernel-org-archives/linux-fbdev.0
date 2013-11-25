From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Mon, 25 Nov 2013 14:15:20 +0000
Subject: Re: [Intel-gfx] [Mesa-dev] [PATCH] dri3, i915, i965: Add __DRI_IMAGE_FOURCC_SARGB8888
Message-Id: <20131125141520.GP10036@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385093524-22276-1-git-send-email-keithp@keithp.com>
	<20131122102632.GQ27344@phenom.ffwll.local>
	<86d2lsem3m.fsf@miki.keithp.com>
	<CAKMK7uEqHKOmMFXZLKno1q08X1B=U7XcJiExHaHbO9VdMeCihQ@mail.gmail.com>
	<20131122221213.GA3234@tokamak.local>
	<20131125085723.GW27344@phenom.ffwll.local>
In-Reply-To: <20131125085723.GW27344@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Kristian =?iso-8859-1?Q?H=F8gsberg?= <hoegsberg@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Mesa Dev <mesa-dev@lists.freedesktop.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Mon, Nov 25, 2013 at 09:57:23AM +0100, Daniel Vetter wrote:
> On Fri, Nov 22, 2013 at 02:12:13PM -0800, Kristian H=F8gsberg wrote:
> > I don't know what else you'd propose?  Pass an X visual in the ioctl?
> > An EGL config?  This is our name space, we can add stuff as we need
> > (as Keith is doing here). include/uapi/drm/drm_fourcc.h is the
> > canonical source for these values and we should add
> > DRM_FORMAT_SARGB8888 there to make sure we don't clash.
>=20
> Well that's kinda the problem. If you don't expect the kernel to clash
> with whatever mesa is using internally then we should add it to the
> kernel, first. That's kinda what Dave's recent rant has all been about.
>=20
> The other issue was that originally the idea behind fourcc was to have one
> formate namespace shared between drm, v4l and whomever else cares. If
> people are happy to drop that idea on the floor I won't shed a single
> tear.

I broke that idea alredy when I cooked up the current drm fourccs.
I didn't cross check them with any other fourcc source, so I'm 100%
sure most of them don't match anything else.

--=20
Ville Syrj=E4l=E4
Intel OTC
