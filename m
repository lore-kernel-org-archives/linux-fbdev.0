From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 14 Feb 2015 15:54:15 +0000
Subject: Re: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <20150214155415.GC25269@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4jXrM3lyYWu4nBt5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de>
 <20150207112043.GO2079@lukather>
 <20150207170503.045490aa@maestro.intranet>
In-Reply-To: <20150207170503.045490aa@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 05:05:03PM +0100, Thomas Niederpr=FCm wrote:
> Am Sat, 7 Feb 2015 12:20:43 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
> > On Fri, Feb 06, 2015 at 11:28:11PM +0100, niederp@physik.uni-kl.de
> > wrote:
> > > From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > >=20
> > > This patch adds a module parameter 'bitsperpixel' to adjust the
> > > colordepth of the framebuffer. All values >1 will result in memory
> > > map of the requested color depth. However only the MSB of each
> > > pixel will be sent to the device. The framebuffer identifies itself
> > > as a grayscale display with the specified depth.
> >=20
> > I'm not sure this is the right thing to do.
> >=20
> > The bits per pixel for this display is rightfully defined, used and
> > reported to the userspace, why would you want to change that?
>=20
> You are right of course. The display is 1bpp and it reports to be 1
> bpp. The problem is that there is almost no userspace library that can
> handle 1 bit framebuffers correctly. So it is nice if the framebuffer
> (optionally) can expose itself as 8 bits per pixel grayscale to the
> userspace program. As an example this allows to run DirectFB on the
> framebuffer, which is not possible out of the box for 1bpp.
>=20
> Also note that if do not set the module parameter at load time
> the framebuffer will be 1bpp. So you have to actively set that module
> parameter to make the framebuffer pretend to be more than 1bpp.
>=20
> In any case I don't cling to that patch, I just thought it was a nice
> feature.

I'd say that the right fix would be to patch DirectFB, instead of
faking that in the kernel.

But again, that's probably Tomi's call, not mine.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU32+nAAoJEBx+YmzsjxAgQnMQAJG03RVwWpTdr5Y1gC+f1iPO
LDPZlpzBZp7Y9Fqu2X2ppW4QwziKh/5wGL4Kc205zhbhGjKwGh8bdAopNRZk6WcM
xVjbWB73u9uzim4eLEM02DR/p9mHi04tA4CYVpDEKO658WnaPtrvf+ygnIJP8OpF
PRuIoBqSKZ1n5CFxnr+J1jWTVO91ksmDickNaoW9bfmZFBDtYat6yFYFNarGrqFT
yPiHt5xUe23l34UTQXuimaDY8e6t2r8KLPQg4qnABM4OI22CiItCEbKEDnsxe+0y
IvycMSW2tzQEoQ8TdCrdcWfrDTmnpcPwG4M6ZbiAXHpdIjTu4IqCoOMYkE8PlVDW
rwFDUwds79vrYvDuXtJTcw9AlXZzNAPBRY0KQC/oCLCAYiZfnCA5fOA3woFRdy6X
8gLqJfOTqgsxzTFw72pXT9hZs+1+7+YKr3w9sh+ImfJgkyRIbH13PV3xIMHtTsMm
SuajZcKEcgI4whgxBsQuxshVj4kfw+CgPq1fEaU0DvxGLepAXU0Af0bZ1MGDsWGr
DnsPkiFUnA+CUQXeapYG+BVPINadO8GA7D0N6bSX/Ln7O9/XDl9OmQ9LJxbPSu47
SkGt3AGPtxR6Pl6KVbIdppVlyOqmZnOXuRSMSvhLirBnbIhD5cl4SaafvkS99bdf
9BZBlDt3k0RX+JZ/hDv5
=mlyP
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
