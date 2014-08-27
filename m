From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 08:55:38 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827085538.GS15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RB5uydEdcEFAVq/X"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
In-Reply-To: <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--RB5uydEdcEFAVq/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Aug 27, 2014 at 10:37:36AM +0200, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Wed, Aug 27, 2014 at 10:22 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> >> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr=F6m wrote:
> >>
> >> > It is not clear to me where the hardware resources should be listed =
in
> >> > DT, being it a simplefb node or part of the actual hardware device n=
ode
> >> > properly marked as dynamic boot defaults or something else? It's
> >> > somewhere inbetween hardware and virtual device, and somewhat volati=
le.
> >> > As far as simplefb is concerned it is a hardware desription of the
> >> > framebuffer, but for a kms driver it's no more than firmware handove=
r of
> >> > boottime settings and ceases to exists once the kms driver have
> >> > reconfigured the hardware.
> >>
> >> Is simplefb something that should be in the device tree distinctly in
> >> the first place - shouldn't it be a subset of the functionality of the
> >> video nodes?  It's the same hardware being driven differently.
> >
> > Therorically, yes, but that would mean knowing beforehand what the
> > final binding will look like, even before submitting the driver. Since
> > the bindings are always reviewed, and most of the time changed
> > slightly, that wouldn't work very well with the DT as a stable ABI
> > policy I guess.
>=20
> If you don't know how the bindings for a device will look like at the tim=
e of
> writing your DTS, you're always screwed, whether you add a simpefb
> node or not.
>=20
> If you know how the bindings look like, just add the device, with an extra
> "linux,simplefb" compatibility value.
> If you don't know how the bindings look like, do your utter best in
> guessing. Your DTS must be amended later anyway, either because
> you guessed wrong[*] (in case you added a node to have simplefb
> working), or because you have to add a real device node (in case you
> didn't add one for simplefb).

Let's be conservative and consider the case where we would guess
wrong.

If we just rely on a simplefb node, when reviewing and integrating the
"new" bindings to describe accureately the various IPs involved in the
display path, we would obviously create new compatibles for
them. Since it's new compatibles, we can come up with any binding we'd
like, without have to consider the backward compatibility, since it's
a new binding.

Then, we just remove the simplefb, all is good.

If we were to try to create our bindings for all the IPs involved, and
were not pleased with the binding anymore when merging the driver,
then we would have to break the bindings, since we don't introduce a
new compatible anymore, but modifying an existing one.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--RB5uydEdcEFAVq/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/Z0KAAoJEBx+YmzsjxAgOa0P/AipjDztg9nTSMqVSHvCKWkn
2m1v0WOQb2A3jPpcqYk8zPA0tvpkG54aAbZDNXF4DyDm8149aL0OYA7SVOekodci
dMXBl/2TX8/dbBqkPfctfQMbUvcGEwlgzZ40Q3+gdJJLt7nPcUZo7sKD3C0BghKn
oU2JWG9iOfmORKJBSpdHcpw9efArqRi23DyezU9PF6fAhsHhDiOBSrz7sYBNiVL9
ON3D4ua3xF6RPAtCuvjehgI4lOPKcnO+c/SH/Jzqhz6A/KzKWoNeYcrJVBBBGcaO
8NvVXNMqLOibzfc5FShn3nGu3dDKZYraFm6hmPmjuVRYWYIKzmTH+aaHS1KQtWzW
yn0OatlJkYoKi7K+TBXz4iuiPEZ3nxLuq5jy8R+ryCkb+/FhkFyaASAeSwkhLmnl
B1W+jnLzJeOi8OGxabtILWCP9oDXH628R7/pn66KLMZNPBoh7EXyG+xCCForbLe/
/jJHYRce6tGICykjMTkgQVxQD+8Y/2sCWuurA0pas21bHyYpDXQTSbACt8zsir5E
shh4Ojahab3zNSnb6RCIqxhEUaDqO0T7/sV/p3FwsP8KHCnM4W8+9aLRXUlCgmXl
SxMuFEslACHFzx/wCmFuKjO5zgwt8bKmuHUvMtYmdnyzTdauOq0t5kmzGxJM205X
yjr2SZFj20WbrC+Fl4LK
=G/G8
-----END PGP SIGNATURE-----

--RB5uydEdcEFAVq/X--
