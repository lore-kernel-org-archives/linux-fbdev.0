From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 08:22:08 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827082208.GQ15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ogqL7AgPWhApULZI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
In-Reply-To: <20140827074057.GS17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--ogqL7AgPWhApULZI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr=F6m wrote:
>=20
> > It is not clear to me where the hardware resources should be listed in
> > DT, being it a simplefb node or part of the actual hardware device node
> > properly marked as dynamic boot defaults or something else? It's
> > somewhere inbetween hardware and virtual device, and somewhat volatile.
> > As far as simplefb is concerned it is a hardware desription of the
> > framebuffer, but for a kms driver it's no more than firmware handover of
> > boottime settings and ceases to exists once the kms driver have
> > reconfigured the hardware.
>=20
> Is simplefb something that should be in the device tree distinctly in
> the first place - shouldn't it be a subset of the functionality of the
> video nodes?  It's the same hardware being driven differently.

Therorically, yes, but that would mean knowing beforehand what the
final binding will look like, even before submitting the driver. Since
the bindings are always reviewed, and most of the time changed
slightly, that wouldn't work very well with the DT as a stable ABI
policy I guess.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ogqL7AgPWhApULZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/ZUwAAoJEBx+YmzsjxAgWhwP/0NYnLbqs8WoE+PnxubNpayr
k+XAhsm6wuaia2Gjp4tuXNy1yewmS0ji9evTL0tsuIlaPwKoe92CzKTjsjvzmA7J
Xb84JpRUJKOGUgQgN3F6L2pKBx4zrpWkpGlbL6mFESWvVr4yN+wz/zJnSfxn5bii
DjZF0jxeGmvdSb/vfDEbtvAEn8guZUlKPGeLfQwU4pnOIkV6sxCTwyPiv05BJbh/
TFfAEofUtYGQ1Op7V7H/HZfMC8R4BJ8/DAC3ir5UUBwDYYM0jr01jI32+f9OI7J7
dYRKs9U3jhbS86R73S4bAU1EclizMZw/wzkhGpzWVfIJ78nw9ojY67EhkcPps0RB
8wFik8WoyDBgSOYoN0cylmFJmKuhZZKd/fAm9qu45Hm/82udnulbrCVuqE5j8sBB
8aGwOj2VO70i9/aGL0W/crO5I5VtwgQUp+5xNN9i2gjl0B9Uy9mfpctA2hMYgl2r
J1b61EPIfz6w9MiKo0BlA/cT+EEDPobm+G8Rf4Jv+kcn1x1XhMQobT16eG5dlUJz
PLdR/+cZy7FbmPbh2Il41ixPRX1iAvPnu3lZQ0/6JZbKaD3zCcZChjaLy3OEdJcT
DbKMmpicDp6ZjjAOUrXYLmZdr3fbVFCvUpurbT71BgvmdCrUFtFrp4mhokETim7c
bw9pBwDVCd6JzPtFp/ra
=5bHy
-----END PGP SIGNATURE-----

--ogqL7AgPWhApULZI--
