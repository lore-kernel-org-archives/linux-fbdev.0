From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 14:35:51 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826143550.GB3027@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather>
In-Reply-To: <20140826135341.GM15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 03:53:41PM +0200, Maxime Ripard wrote:
> On Tue, Aug 26, 2014 at 10:04:33AM +0200, Thierry Reding wrote:
> > > > No. simplefb just wants to write to some memory that hardware has b=
een
> > > > set up to scan out. The platform requires that the clocks be on. Ot=
her
> > > > platforms may not even allow turning off the clocks.
> > >=20
> > > Like what? the rpi? Come on. Just because the videocore is some black
> > > box we know nothing about doesn't mean we should use it as an example.
> >=20
> > You make it sound like the Raspberry Pi is somehow less important than
> > sunxi.
>=20
> No. What I mean is that it seems like we are somehow punished, or at
> least blamed, for having a better and more complete kernel support.

This isn't a competition. Nobody's punishing or blaming anyone. This is
about finding the best solution for the problem at hand.

> > > Any decent enough SoC, with a decent support in the kernel will have
> > > clocks for this, and I really wonder how simplefb will behave once its
> > > clocks will be turned off...
> >=20
> > There are other devices besides ARM SoCs that may want to use this
> > driver and that don't have clock support.
>=20
> And in this case, with this patch, simplefb will not claim any clock,
> nor will fail probing.
>=20
> > But you're missing my point. What I'm saying is that the simplefb driver
> > is meant to serve as a way to take over whatever framebuffer a firmware
> > set up. Therefore I think it makes the most sense to assume that nothing
> > needs to be controlled in any way since already been set up by firmware.
> > Eventually there should be a driver that takes over from simplefb that
> > knows how to properly handle the device's specifics, but that's not
> > simplefb.
>=20
> I guess such a hand over if it were to happen in the kernel would
> involve the second driver claiming the resources before the first one
> release them. How is that different in this case?

It's different in that that driver will be hardware specific and know
exactly what clock and other resources are required. It will have a
device-specific binding.

> > The goal of this patch series is to keep clocks from being turned off.
> > But that's not what it does. What it does is turn clocks on to prevent
> > them from being turned off. In my opinion that's a workaround for a
> > deficiency in the kernel (and the firmware/kernel interface) and I think
> > it should be fixed at the root. So a much better solution would be to
> > establish a way for firmware to communicate to the kernel that a given
> > resource has been enabled by firmware and shouldn't be disabled. Such a
> > solution can be implement for all types of resources and can be reused
> > by all drivers since they don't have to worry about these details.
>=20
> Mike Turquette repeatedly said that he was against such a DT property:
> https://lkml.org/lkml/2014/5/12/693

Mike says in that email that he's opposing the addition of a property
for clocks that is the equivalent of regulator-always-on. That's not
what this is about. If at all it'd be a property to mark a clock that
should not be disabled by default because it's essential.

Adding Mike on this subthread too.

Either way, Mark already suggested a different alternative in another
subthread, namely to add a new kind of checkpoint at which subsystems
can call a "disable unused" function that's called later than a late
initcall. This is not going to fix things for you immediately because
the clocks will still be switched off (only later) if you don't have
a real driver that's claiming the clocks. But you can work around that
for now by making the relevant clocks always on and remove that
workaround once a real driver is loaded that knows how to handle them
properly.

Thierry

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/JtGAAoJEN0jrNd/PrOhgPsP/jE/ta37uBHWlgZDPEHjOzPs
zb04UzjeRU/nxcI16G2J9lze16uiZ3V+eA7jJrChr4uiXRX1bm8UCNMoMHix3wyA
vSv6QK2xPRNRNONJOU0HQUPyeKBdYRh7DGP3qQD+3ek06fozfMKVVb5iqOJrQlUK
mCu5rfo90C+25JHVU2MKje5A9yjsQgXjvbPGxqIdc60IeKV5x0IRMfteHURW1qTO
6KB2fGqyPpLcZhT084CYe0f8dOBfqDIm9C2N7SiJmL2f9QMvJVkcojLhh+3fuEXe
lx0SBD5Bkf2f69DCikLvMO5FgJxKN5yZJfZY/lH+F6C3jIJFcedfPo3u952JwdD6
eoa22WeYNhZtx21nDvxSy8haHoyNYqyc6x0jyhJxTOYfW25RiPMapXcr6Y3Fkb1B
KwjUl56GuGHu5EEUAstZNi9Z7D/hRU4yhw10rstGKudd3odvB9hdaNjQMtghKzr/
T7OJAznXU2+dDPcGBUhgUQ9str8j3SgKoAjUFT2eTgDfEVtXnxN7JDtPuZ1+n4Ld
u9gObYVDkzN+J/CvLR21E8RD4iRrBsagWsLWKfMEjpsWAyNqNmbAFB7KwxBWDYfa
jVDCMs3KX/B5vFOHEBIbmEXrThS6LAdG5eBRRy4GEWcuBQhWR3nuTs4z9hgmQeJa
722hVG4Tep8faXzB5SQ1
=f++y
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
