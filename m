From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 13 Sep 2012 07:29:20 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <20120913072920.GA11459@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1464760.6eqxJ2IzZ2@percival> <1347517377.7471.23.camel@lappyti>
 <2689722.93BQTh4lSC@percival> <1347519249.7471.42.camel@lappyti>
 <20120913070012.GC6180@pengutronix.de>
 <1347519807.7471.45.camel@lappyti>
In-Reply-To: <1347519807.7471.45.camel@lappyti>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2012 at 10:03:27AM +0300, Tomi Valkeinen wrote:
> On Thu, 2012-09-13 at 09:00 +0200, Sascha Hauer wrote:
> > On Thu, Sep 13, 2012 at 09:54:09AM +0300, Tomi Valkeinen wrote:
> > > On Thu, 2012-09-13 at 15:36 +0900, Alex Courbot wrote:
> > > > On Thursday 13 September 2012 14:22:57 Tomi Valkeinen wrote:
> > > > =20
> > > > > However, I fear these board specific things may be quite a bit an=
ything,
> > > > > so it may well be pwm, gpios and regulators are not enough for th=
em. For
> > > > > example, there could be an FPGA on the board which requires some
> > > > > configuration to accomplish the task at hand. It could be rather
> > > > > difficult to handle it with a generic power sequence.
> > > >=20
> > > > Right. Note that this framework is supposed to be extended - I woul=
d like to=20
> > > > at least add regulator voltage setting, and maybe even support for =
clocks and=20
> > > > pinmux (but that might be out of place).
> > >=20
> > > Yes, that's one concern of mine... I already can imagine someone
> > > suggesting adding conditionals to the power sequence data. Perhaps al=
so
> > > direct memory read/writes so you can twiddle registers directly. And =
so
> > > on. Where's the limit what it should contain? Can we soon write full
> > > drivers with the DT data? =3D)
> >=20
> > I have this concern aswell, that's why I'm sceptical about this patch
> > set. But what are the alternatives? Adding power code to the drivers and
> > thus adding board specific code to them is backwards.
>=20
> As was pointed out in earlier posts in this thread, these are almost
> always device specific, not board specific.
>=20
> Do you have examples of board specific power sequences or such?

It is true that most (perhaps all) power sequences can be associated
with a specific device, but if we go and implement drivers for these
kinds of devices we will probably end up with loads of variations of
the same scheme.

Lets take display panels as an example. One of the devices that we build
has gone through two generations so far and both are slightly different
in how they control the panel backlight: one has an external backlight
controller, the other has the display controller built into the panel.
However, from the board's perspective the control of the backlight
doesn't change, because both devices get the same inputs (an enable pin
and a PWM) that map to the same pins on the SoC.

This may not be a very good example because the timing isn't relevant,
but the basic point is still valid: if we provide a driver for both
panel devices, the code will be exactly the same. So we end up having to
refactor to avoid code duplication and use the same driver for a number
of backlight/panel combinations. Which in itself isn't very bad, but it
also means that we'll probably get to see a large number of "generic"
drivers which aren't very generic after all.

Another problem, which also applies to the case of power-sequences, is
that often the panel and backlight are not the same device. So you could
have the same panel with any number of different backlight controllers
or vice-versa any number of different panels with the same backlight
controller.

Thierry

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQUYtQAAoJEN0jrNd/PrOhufsQAKq100hgJokyF+Pc2QaurHpL
BYdJ4wCvW5W+wrVFv4o3Bn3Am4KcTz3jD8c5MFhqbRW5SvSSBfTwU7vfZ1DuzfGx
Np0aCA8gds5TGG9OADcgpeSU9xudnTq7a/eqc1/5mekqQXALIpr4ArHw7tT7tVVO
TdWlAN2CPeE4esoIn9fpkYiZ13bf0NoUlraS0z8kkEzOPTbYGR09L3PRieiiZCc8
wmqYiIhOFClJt+YDx9uUpskcRycMqW7qc32KpC2RvKz5GZnmiisULzfuTcM7Pz2T
kJWUT6wQqxvIXUG0SCI14UJaUZLEkstfe5y1fiIHPOGYvIq7QhQuEzxYy27Ugw6K
vp7lO2Jp/Rafr8rRZyL74MhzmYhQRmGkoq0DBzMdLVefYZJRRYiFSf8aKPCWdiid
lR9e6effcCNQPGy3N1XXcSyGKj6Tx7TYxtTXbPftuSoSJRGUbHiS+OYOF4sd5lh+
ydp7qIlGzcuU8u16yzu7dfLQfyApe2C+viugwVzuLDfRmRmVLWOtPrpJ87YKBanB
wLq0aAwX0G3rxSurbRySimxZvOksPTWUdyab5doVdKUvxRSaL4FZJp04pMdNS4T7
heyXmJxpaNHlAKQkbQH21dIYuvXhs909FkSn3BMfLyIHlOoHgaU549wNAlw9id0T
hegp18SaJgq5Oofq/757
=mRFB
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
