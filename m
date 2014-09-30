From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 30 Sep 2014 08:03:54 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930080354.GI4081@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pe+tqlI1iYzVj1X/"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be> <20140930053900.GD29874@ulmo>
In-Reply-To: <20140930053900.GD29874@ulmo>
To: linux-arm-kernel@lists.infradead.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 07:39:02AM +0200, Thierry Reding wrote:
> You keep bringing up the Raspberry Pi for some reason and suggest that
> it is somehow inferior to sunxi. What makes you think it's less entitled
> to be supported on Linux than sunxi? I don't care about the Raspberry Pi
> and I equally don't care about sunxi. I don't own a Raspberry Pi and I
> don't own any Allwinner hardware. What I do care about is Linux and I
> want it to work well for all SoCs equally.
>=20
> Perhaps if you could put aside your crusade against the Raspberry Pi for
> just a second you'll realize that we're all on the same team. This isn't
> a competition and I'm not trying to put a spoke in your wheel. On the
> contrary, I'm actually trying to help you.

We've been over this already, and I'll tell you again that you're
getting this wrong.

No platform is more entitled to get merged than another one. I do care
about the Allwinner SoCs, and I care just as much about the broader
Linux support for all the other SoCs, be it from nvidia, samsung or
whatever vendor you can come up with.

But you can't hide the fact that the bcm2835 still has a very limited
clock support, and I really don't know about its clock tree, but I
guess that if the times come when they add a more complete clock
support, they will face the same issue.

If the driver would have been developped initially to create a
framebuffer on the Allwinner SoCs, at a time when we didn't have any
clock support too, calling it only usable on sunxi wouldn't have
shocked me tbh.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKmPqAAoJEBx+YmzsjxAg3WEP/2ksSk9UcaTBA3pQkKoN0hdz
0q3BvAD2zrHfTxyokL1RAC8VrwQf/kkv1gu0mOFGMPEkeyshVhdjNG20YdqJIN3I
hi8EmUrAF7Hlq+M2taSZz/2WMe46oEus/r13lK9k7llS5lgPFudz/C4yfapQYVT9
xlaAozu/v3dGSlTQ8RHpC8wUOrkHYl3xo+T6V8xMRhZ2Th0s8qJMc2cbIFKp05AU
MEMmF0+KDHnchowkjr/iCjZxVlmM02ID35biabvp2AhVsZfqGHNxT2mMEEjaO37B
Z9fqk+RjaSiDaaj8Z41VyP4Zk0HxemyodgA7UdqOfe/FWUrKczVaTJ/DjrMOCd+r
9UFpONm3lPpdeTHmphqXRH8aD47dmXy9I0pr4ljaF/lco+zIkmfA/ohke4COrwBY
UOfFOPBrD/HFUhcIYbMA9LSzat+IEqHcRpK9QOOjSYGJDnKVoYDxyxdB9YsvxFcp
n6Nkkekd6hJ6Q6SDmXd3i0r1+dc5m6YT0kMcbksLfeVKcBBAlARupXN48wvG8b4w
/ueXFM6Z/8lr9iljyGKfedWThzmOSdLMS4JPugwZte3qRoMYjSP8KQc8q1O+8i4k
hMrjm4ZMkUghke8YxQPpuGMiUXLi/AR/VscMU1XXaj+M5u5U4r+NQ8pdbydc9MUg
Thk+/wMKsr1lMSj63BJT
=+nyi
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
