From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 01 Apr 2015 16:00:36 +0000
Subject: Re: [PATCHv6 04/10] fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150401160036.GH23664@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qCuyVVLLFvr0p6ls"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-5-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427826436-21783-5-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--qCuyVVLLFvr0p6ls
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 08:27:10PM +0200, Thomas Niederpr=FCm wrote:
> The 130X controllers are very similar from the configuration point of vie=
w.
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
> of the video memory. The 'segment-no-remap' allows the inversion of the
> memory-to-pin mapping ultimately inverting the order of the controllers
> output pins. The 'prechargepX' values need to be adapted according to the
> capacitance of the OLEDs pixel cells.
>=20
> So far these hardware specific bits are hard coded in the init code, maki=
ng
> the driver usable only for one certain wiring of the controller. This pat=
ch
> makes the driver usable with all possible hardware setups, given a valid =
hw
> description in DT. If these values are not set in DT the default values,
> as they are set in the ssd1307 init code right now, are used. This implies
> that without the corresponding DT property "segment-no-remap" the segment
> remap of the ssd130X controller gets activated. Even though this is not t=
he
> default behaviour according to the datasheet it maintains backward
> compatibility with older DTBs.
>=20
> Note that the SSD1306 does not seem to be using the configuration written=
 to
> the registers at all. Therefore this patch does not try to maintain these
> values without changes in DT. For reference an example is added to the DT
> bindings documentation that reproduces the configuration that is set in t=
he
> current init code.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> Tested-by: Olliver Schinagl <o.schinagl@ultimaker.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--qCuyVVLLFvr0p6ls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHBYkAAoJEBx+YmzsjxAgTsQP/RI/gev6iAY4hJU/HQLJi6ja
wCOQFaPvsd8S6agsnvALjBtSNRgX41JL/agZH3k8RbbHUlkQj+xaiYUNPhPEBxPN
Ka/VPCMLo3mVTqw6fJx0qIojRy1gVbLu1giiHKYGHzxNO/v4zaszG5Fc0V7vod2a
hngg0S6dSc32DH0tv/BFOm81jZd/8N+dtfGL0LV/T6wlSsLl6gdKjy7FkoiyeALg
67p5hHW4coaSz12zRsIsQQgysM3uaST6N2Q2wyNXgtfyI21WJ5vTm7uTCZyTFrYH
diBOfw2gcmePWAdhZ9uY3istHyx0i9waN/6l9/Nbah6bizTJNfhR6wJoLzoX9wEy
k/NKaqOwrVgc0oLM1i1C8/44L/xzNtZa89q30J6vGIpHr+pM+8NZyMlADtFc8K97
I+S6ISkDBi3h925qhd1zSbCPC3U4qRTl7hbfFCpaGuAIAx0yWEJ0BP6USzr2i7j9
eT7BtVrlZwrPMJHinZeVuS7dwIcect0TN/M8RoYB3OJTPYHz8vBASJ5WlBvxof5X
eHkaeWx99CTW9BGXceCdh3D08Adktjm/Md/DI4lfk7hTd1TUPWdIR60Dn1DQHJbt
ZQcp+DnWC0HMs4AIfH82RpjlHvy2Y6UpkIiYPjrlnj3GU5Rm3MhUaRmfDXKGYY2J
uEAcWTkCJMBXYs2XQxw8
=AUKC
-----END PGP SIGNATURE-----

--qCuyVVLLFvr0p6ls--
