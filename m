From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 17 Jan 2017 07:40:13 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: allow reset-gpios is missing
Message-Id: <20170117074013.iqzfuoc3ys27347y@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ds6hxb3kkbfhw6hg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117042658.QtsSkpPN@smtp3o.mail.yandex.net>
In-Reply-To: <20170117042658.QtsSkpPN-/icbEWb855g0PDqKvflMoHmW9unr2Ajn@public.gmane.org>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--ds6hxb3kkbfhw6hg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 05:50:21PM +0800, Icenowy Zheng wrote:
>=20
> 2017=E5=B9=B41=E6=9C=8816=E6=97=A5 16:02=E4=BA=8E Maxime Ripard <maxime.r=
ipard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Jan 15, 2017 at 07:21:46PM +0800, Icenowy Zheng wrote:=20
> > > Currently some SSD1306 OLED modules are sold without a reset pin (onl=
y=20
> > > VCC, GND, SCK, SDA four pins).=20
> > >=20
> > > Add support for missing reset-gpios property.=20
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>=20
> >
> > Unfortunately, a similar patch has been sent a couple of times=20
> > already:=20
> > https://www.spinics.net/lists/devicetree/msg158330.html=20
>=20
> Why is it never merged?

It was sent 4 days ago...

And since you didn't have the right maintainers in the cc list, yours
didn't have a chance to be merged either.
=20
> There are really boards that needs this function.

Then  you can accelerate its inclusion by reviewing it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ds6hxb3kkbfhw6hg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfcpZAAoJEBx+YmzsjxAgUy8QAKbSp6ZD91G+tCYOdV7XBu2R
TOs+qO1ttUUaSbbsgWs1FGIS+/+4Guw4brMsU+eojqrDJ09937syR2a/xwGP0MOJ
LKoDJ9LExmYXbG6ADCkQ3/gWJfktaHkD3poVH0OoACr9gUxfw1p93q8IHbFopoUS
soPEru5gd+3qFGFMtTAaCU/O5blbRCWkvZZ/OdbKzTcugCgKHGAmNPjOLkekMWCJ
i2h8ghEg39R59zZ/n+47Z+Tx5LT09GtbSRumUs3G2zcex3JVnn6wH+09fV/ZqtOH
MNFPJr4yA9tLO2K+d+Beq+Dw/+LB8IzlpVND3bBm+hKZ6TQqlu69zrpzE2e8Bi2c
UZpfyaKyvfH3XtwMAxpAzSgAJIxqD64yu9HxishYr+0GN9jqa+bEQK6Tfoit+6ep
WE5qqo1DnlFJjmzjQQ83k39oO9WJM59C2U5U2JVsnh4rfVblz0czJvgbb79Q/soU
3i33rteGj7tBtmrDKchr5TH1oWEOQaYeHJxBRuJ/7FEpkXRz1/7oyASkrG9Rzlen
tg6hsceJevRDnUFrznx38C1iGYr9nWEHRfd+7yiHPB6MTUOYcowaJkUIJzzttyFC
SNTVzFwPuQugH/4RAB2AZz1bzCE8GIL3OR6fPmKiSVWywRJLceP3YTQWhGO449jg
JbiKnRiXp5zq7bbgSg5T
=vdMG
-----END PGP SIGNATURE-----

--ds6hxb3kkbfhw6hg--
