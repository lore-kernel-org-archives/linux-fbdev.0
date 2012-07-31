From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 31 Jul 2012 14:32:35 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
In-Reply-To: <20120731142607.GV4468-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 03:26:07PM +0100, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 04:22:17PM +0200, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 03:13:29PM +0100, Mark Brown wrote:
>=20
> > > __devinit can be discarded if you disable enough kernel features,
> > > HOTPLUG is the main one IIRC, modules might also need to go - drivers
> > > really ought to take a copy of platform data they plan to use at
> > > runtime, though practically speaking you have to try to trigger any
> > > problems.
>=20
> > HOTPLUG is marked EXPERT and explicitly states that it should only be
> > disabled if you're not using modules or dynamic device discovery. I
> > think if you've ignored all of that you're no longer entitled to
> > complain.
>=20
> This is framework code - it doesn't have much option.  Disabling HOTPLUG
> is totally reasonable on space constrained systems, there's no reason
> for the code to break things for people.

Still if you use this code and disable HOTPLUG, then you shouldn't be
using modules either. I mean there is no way you can write a driver that
can gracefully handle its platform data being discarded.

Thierry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQF+yDAAoJEN0jrNd/PrOhIpYP/RGtCYPGFbjPsFEOram+N7vC
XSZsdrYm+dm32kQwmsRzysngMX6O/NkQmHupgEIxzlIK5nQIcFTqS55GJqigzRcJ
RKP9K1BxwmqDGH64nVb55K5V1HFvZJ3g1l0+gi8yUgqll11htwpdz3l6bJXBDS/P
xLg7z5HuaCsU6fbbz/XYVhuvWUKVLNAoaJE7/p6pLKUINu2ePp1Vxd0lcwh9Sdyt
xrYOZ6tIKkKwq1+dJ8VmC1ejNfvJeNmvKzLPjF2yxlbQ8ZaaEGywRUuCoRAanAyJ
D4Q5oB4ATCNBqH6ecc+iMawnJEvowLvzm/xJ6Agg1n5mFTyVmCzPhxjoAn9CY2Km
ALofyf1zK+b6tSoXWYyGLv4667HjiaL/pLsn4wKlb/6Bqc/n6lcYoqTM9dHxwyTw
W7a3NqR5dGhMgcRS/Yf6tcyFsVEGMyJlO99fiTMpZvStTDwrWK0LnC5KS5qTvrru
tnJdVZbM6SHNNKW/cjVewrwbDjoB1oMu98UmbiqKrasg8FGjE50YO74XspeOU0mW
62wczDzfv7tLIBw4qC4eFjrW+v4bkO6kvGeFWEPL74kwAKkrllnMEFB678RVGCDS
E3FwCBXootTMR7Zzw8R7RCbh3oA8UB5Z4u/H8Wm3a2+ctiN91jlydcMaOM1CQez7
3V2DaRg8eVUQwmXbGUn4
=mK8S
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
