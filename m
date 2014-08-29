From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 29 Aug 2014 06:29:33 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140829062932.GB13106@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826080432.GD17263@ulmo> <20140826135341.GM15297@lukather>
 <20140826143550.GB3027@ulmo> <20140826210248.GO15297@lukather>
 <20140827065440.GG15640@ulmo> <20140827084526.GR15297@lukather>
 <20140827095241.GC23186@ulmo> <20140827154221.GX15297@lukather>
 <20140828101140.GB14388@ulmo> <20140828204603.GB15297@lukather>
In-Reply-To: <20140828204603.GB15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2014 at 10:46:03PM +0200, Maxime Ripard wrote:
> On Thu, Aug 28, 2014 at 12:11:41PM +0200, Thierry Reding wrote:
[...]
> > Then since firmware already knows what it set up it can tell the
> > kernel to not touch those.
>=20
> Somehow, I've been raised kernel-wise into thinking that you can never
> fully trust your firmware. Or at least that you should have a way to
> recover from any bug/bad behaviour from it.

If you don't trust your firmware then you shouldn't be taking over a
device that it's set up for you. Rather you should write a proper driver
that sets things up from the start.

This whole "we don't trust firmware" isn't going to work if we want to
have hand-off from firmware to kernel. And it's already been decided in
other threads that moving more code out of the kernel and into firmware
is a requirement (c.f. ARM64).

Also in this case you wrote the firmware, so why wouldn't you trust it?

> Moreover, the way I see it, there's a major flaw in having an
> attribute in the clock node: you don't even know if the clock is ever
> going to be used.
>=20
> If simplefb is not compiled in, you won't claim the clocks, and they
> will be disabled, which is imho a good thing. This case wouldn't be
> covered with an attribute at the clock node, because you don't have a
> link to what device/feature actually uses it in the system, and so you
> have to make the assumption that it will be used. And you will end up
> with clocks with a rather high rate running for nothing.

That's completely hypothetical. If simplefb isn't enabled and the clock
isn't claimed there's probably still going to be some other driver
taking over eventually. If there isn't, what's the point of firmware
setting up display in the first case?

Thierry

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAB3MAAoJEN0jrNd/PrOhfBwP+wfFd6hYpRzGb9NxODXf6CYl
8WXciA20B9R1OpKeJdvi5duyJnIqX90SpxQ+4YBy7whzuy8SZjIzch3igKIDw6r/
9fPJ8tgrbpnC+EW42KG7A8vQgpJ+ILI0tZENjFXD2G3vcna64BJFuQiWE2GtnkWD
ggW0/uepwZ7eAr/vmBxc+e6RczBmf5E2lwaoeKmkYPV3hOXgG0mZ1ZuuKwa26TBD
/giNxLiq1NUB+cgenDr8Gcirz3Zn2mZEvDJym3cSK3p1bW9Ao/4/FuBKbb/7G7t1
NYd4yzoabyIS++m3dtxOS/GIMVIRf1l+r+scu6z0UVS2XoDUdYyppC7hCBfqGv/l
nI5dg4ZA6quF9yw4WPYnyRA0YwWeauFDFScHNrbugLpNAyiV1o0ifNTZjC15x0L8
FudKH1bILRj7rxSvzhMq3vREAFg4CGhVtGrEaYnU6rhL5Og5LRs/zyPze5dDLE0x
aaMCQYDYz3GBiINUQgbQDJKsPNP/2p4fJiQq8tf5Dfi6Stcinu77SUUKBT7m0dhD
OC4ATW25cyTfy+KBGB43ahRkUsBgofyp50QtcLpGfxK1z5bs7YkkVvGpT3Dz+eZL
snjW0JLTJ9Fs7uoCP7cC5Oa/slG+axrlKBMvHgr0vLfq/OHKy8E63KO46I0nKn6B
lAYAM5Mf6736fWOtGpRr
=bKIH
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
