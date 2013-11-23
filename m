From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Sat, 23 Nov 2013 01:10:37 +0000
Subject: Re: [Intel-gfx] [Mesa-dev] [PATCH] dri3, i915, i965: Add __DRI_IMAGE_FOURCC_SARGB8888
Message-Id: <20131123011037.GO10036@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385093524-22276-1-git-send-email-keithp@keithp.com>
 <20131122102632.GQ27344@phenom.ffwll.local>
 <86d2lsem3m.fsf@miki.keithp.com>
 <CAKMK7uEqHKOmMFXZLKno1q08X1B=U7XcJiExHaHbO9VdMeCihQ@mail.gmail.com>
 <20131122221213.GA3234@tokamak.local>
 <20131122230504.GK10036@intel.com>
 <86pppsvw8e.fsf@miki.keithp.com>
In-Reply-To: <86pppsvw8e.fsf@miki.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Keith Packard <keithp@keithp.com>
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <hoegsberg@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Mesa Dev <mesa-dev@lists.freedesktop.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Fri, Nov 22, 2013 at 03:43:13PM -0800, Keith Packard wrote:
> Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com> writes:
>=20
> > What is this format anyway? -ENODOCS
>=20
> Same as MESA_FORMAT_SARGB8 and __DRI_IMAGE_FORMAT_SARGB8 :-)
>=20
> > If its just an srgb version of ARGB8888, then I wouldn't really want it
> > in drm_fourcc.h. I expect colorspacy stuff will be handled by various
> > crtc/plane properties in the kernel so we don't need to encode that
> > stuff into the fb format.
>=20
> It's not any different from splitting YUV codes from RGB codes;

Not really. Saying something is YUV (or rather Y'CbCr) doesn't
actually tell you the color space. It just tells you whether the
information is encoded as R+G+B or Y+Cb+Cr. How you convert between
them is another matter. You need to know the gamma, color primaries,
chroma siting for sub-sampled YCbCr formats, etc.

--=20
Ville Syrj=E4l=E4
Intel OTC
