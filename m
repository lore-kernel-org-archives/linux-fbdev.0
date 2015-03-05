From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 05 Mar 2015 21:49:58 +0000
Subject: Re: [PATCHv2 04/10] fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150305214958.GB4522@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-5-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-5-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2015 at 11:27:57PM +0100, Thomas Niederpr=FCm wrote:
> The SSD130X controllers are very similar from the configuration point of =
view.
> The configuration registers for the SSD1305/6/7 are bit identical (except=
 the
> the VHCOM register and the the default values for clock setup register). =
This
> patch unifies the init code of the controller and adds hardware specific
> properties to DT that are needed to correctly initialize the device.
>=20
> The SSD130X can be wired to the OLED panel in various ways. Even for the
> same controller this wiring can differ from one display module to another
> and can not be probed by software. The added DT properties reflect these
> hardware decisions of the display module manufacturer.
> The 'com-sequential', 'com-lrremap' and 'com-invdir' values define differ=
ent
> possibilities for the COM signals pin configuration and readout direction
> of the video memory. The 'segment-remap' allows the inversion of the memo=
ry-
> to-pin mapping ultimately inverting the order of the controllers output p=
ins.
> The 'prechargepX' values need to be adapted according the capacitance of =
the
> OLEDs pixel cells.
>=20
> So far these hardware specific bits are hard coded in the init code, maki=
ng
> the driver usable only for one certain wiring of the controller. This pat=
ch
> makes the driver usable with all possible hardware setups, given a valid =
hw
> description in DT. If the values are not set in DT the default values
> according to the controllers datasheet are assumed.

Unfortunately, this is not a reasonable thing to do, even if you fix
the existing user, there's still the case where you have an older DT
with a newer kernel.

Keeping (and documenting) the previous defaults is the only easy way
to support this.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+M+GAAoJEBx+YmzsjxAgEU0P/RZC/+405t9nPW0asy36Rdgq
MY89M+jbLnI7wGVI/NxN2YwkcYxTC3UliL/EeQxV6xRrpzfCVrsfFEQlCf4fuaOH
8cxAgjLQfjS/9Mb0IzY1faJ/lup0OOkvOcallophfbf4uwUNbw+l8At9PVpR7eRz
G3VquXDgfou99TSTesB9AWAr4/3H6YVpTOm6LD7rP3cKeA4BL4JrJu3eq8aAneTe
+OXAhbXS8tK7qHwPP/GuNnP0kenaTHQdyEAs8LBJwL3zqHK2XCTRKJ5oZHkzQVAB
/QiGTZXrGE1GWEQjnq4+NaX9NNOi62RNwqegqSLgcjpTRO0EIQTEkUb+oGD/dncR
zsrQmT6B9+e7GQHWhhYMaK0GK9bqXiWJ6AxIWUHOgmBX3kDWZrqBGVWiB8+utCFJ
ttoySbdS1bna4j61xWl0/nAXIe7wdecxXWkW0aDuec2PtOdMh4KDO+3PVnfy0Ebd
wSzC8lBLWnWignMSnO1u1x2PhOQXeTM0Gy+tvHcqhZgHrbwQ33KFsGivXju5wwFV
Wmd3MzasTePAJOHYdbeMYgKYGvxUavkO3Sbi+EPqclDzal60SSq7tpwZ2W4F9GL3
Lf4pgSFpkPzdkLpXhIj8H5caQWao42NYQe2QFOyigDzZZDcoR7G0x4PUQRbLyO0B
fCo6HAd3ixxNPNMdaW52
=m/+h
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
