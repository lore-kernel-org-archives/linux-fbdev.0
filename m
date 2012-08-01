From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 01 Aug 2012 07:41:13 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120801074113.GF29673@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2FkSFaIQeDFoAt0B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
 <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
 <20120731153941.GF4468@opensource.wolfsonmicro.com>
In-Reply-To: <20120731153941.GF4468@opensource.wolfsonmicro.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alex Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 04:39:41PM +0100, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 04:32:35PM +0200, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 03:26:07PM +0100, Mark Brown wrote:
>=20
> > > This is framework code - it doesn't have much option.  Disabling HOTP=
LUG
> > > is totally reasonable on space constrained systems, there's no reason
> > > for the code to break things for people.
>=20
> > Still if you use this code and disable HOTPLUG, then you shouldn't be
> > using modules either. I mean there is no way you can write a driver that
>=20
> Of course.
>=20
> > can gracefully handle its platform data being discarded.
>=20
> Sure there is - take a copy of the platform data in probe().

Yes, but that will only work for built-in drivers. If you unload the
module and that causes the platform data to be discarded, reloading
won't work.

Thierry

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGN2ZAAoJEN0jrNd/PrOhwA4QALx5Ijacwp3D88JCHvWwFNe1
pheBUhSZpna/ZaT7GmlV3CzMeKSCekffp8DRHYT24aHkaCB5RCV64zLeCGoR7ECA
7ZFNeeLY+YhqP3+YlTQHJ/0BdrTGHmSVWiUOguGloQ2WEzA6Bzg/ELOqrVF4hRdm
a4TaM9E+iZrMx0tVVgZCylH5uWhFwPnOfQ1u+lg8trR3h2NYpU3V7CXJv5T9XjQx
3l5+iZUm4LnTh/vljucp6z1LBq7ALzmD1xSGDgATs4y0LnLDAqZ5lC9Nq73CGfBe
HQk0ypeYA9WUbVHL+34K/uwnq9m7j2NJFrgQ9olRdpfX3W9vBPDuER0j2b0vOdaF
s2VYFD3BZ5XPBAFciEeHngelVb433kBuBtxpptXFe5ZpyVUp6FZLTEMoFKEWHpJP
bWzarSMd/D8ekN/KxyAdm7/2tErPtf53nHNoOXYUL7dipESrxntTw+s2DSYvdnYH
iqCYmHgRONyQqjSUDOuoUmi4IuMJhAQkN2eSSQ1KAF1f78kAaYx5TUhrXHtAVR7L
uOAU8hcaUb5ZOOffslDmfAyEh83crQwK7GiZGLvcApSogUkFd6Xi4MD6L6B72L0K
AAm5/CJ+qdkkoIFlkoU8mV4w8MNeFz5eKqHxm/+RDpyRLpctvKG2YPfCas4oah5r
HXWkWxOZMAwobE6+J6Xa
=XPf8
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
