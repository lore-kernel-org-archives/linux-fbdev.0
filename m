From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:11:28 +0000
Subject: Re: [PATCH 0/2] SSD1307fb updates
Message-Id: <5603DA60.3050402@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UtHJcEq1hH7QjaIbUDP4IXlmhdC7nX6Gk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441739991-4676-1-git-send-email-o.schinagl@ultimaker.com>
In-Reply-To: <1441739991-4676-1-git-send-email-o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
To: Olliver Schinagl <o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: =?UTF-8?Q?Thomas_Niederpr=c3=bcm?= <niederp-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Prabhakar Lad <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--UtHJcEq1hH7QjaIbUDP4IXlmhdC7nX6Gk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/09/15 22:19, Olliver Schinagl wrote:
> Having a few ssd1309 128x64 OLED displays laying around, I added suppor=
t for it to the existing 1307fb driver. While doing this I noticed the he=
aders where out of order so I fixed those as well.
>=20
> For this specific display, the following can be used in a i2c node for =
example.
>=20
> 	ssd1309: oled@3c {
> 		compatible =3D "solomon,ssd1309fb-i2c";
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&oled_pins>;
> 		reg =3D <0x3c>;
> 		reset-gpios =3D <&pio 8 13 GPIO_ACTIVE_HIGH>;
> 		solomon,width =3D <128>;
> 		solomon,height =3D <64>;
> 		solomon,com-invdir;
> 		solomon,page-offset =3D <0>;
> 		solomon,prechargep1 =3D <2>;
> 		solomon,prechargep2 =3D <8>;
> 	};
>=20
> Olliver Schinagl (2):
>   fbdev: ssd1307fb: alphabetize headers
>   fbdev: ssd1307fb: add ssd1309 support
>=20
>  .../devicetree/bindings/video/ssd1307fb.txt         |  3 ++-
>  drivers/video/fbdev/ssd1307fb.c                     | 21 +++++++++++++=
+++-----
>  2 files changed, 18 insertions(+), 6 deletions(-)
>=20

Thanks, queued for 4.4.

 Tomi


--UtHJcEq1hH7QjaIbUDP4IXlmhdC7nX6Gk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9pgAAoJEPo9qoy8lh71guUQAJAjnKwhRqlY9ogvX7Bybx1e
iaXFSOjJckWNC9bWY1c0E+m4Bbsl621ITMmNiQe09pfPmO+fe2RToXoeFVR3Hcqp
WpuHUjS/tSqE9o/U3/7IiWTe6A26uO8TXdVujpy1qlIqmxbxC9c1osa+NeHNXxi/
u4/MRRuMnnjdOVyaOAgHhwhD9kleb6IfqVtGKgPwPBnekTAoGofLnHMDk4kjXFUH
2a0PeXVC8Q3ZZseit9usFbkSOVAV8cSVnPG57kP2nQEUaMdhd4uhMFEA1mr/nGDr
t2rm1maZ9xtrEjrPTUvgigPMKnDJ0Gc7Yl6eXRSjdM/PymIMuEPYheg5eyaJ68S6
XPkqAjd5g5VLv3gJ7+bEy8Ur06XKfdzjgCOtdBVNE7RA7Z80lEEHfYTYkUw+91hY
90wFSznP+30aOOtetCHLbGjJlo+sFzI5naC3RDQn+6qud+rNl8vgUq63gQOXkpWW
SNPb0apzmeEaoizaotBrJ1mlzHk04/49cmtVbGZQ4jz6geGI0bnHpl7fRorYHQ0W
DqZP3cl+Y4TGIk3MW9D6W+XeNMtal6VZjR9cgZ6Vefs7yxnaaP/enpS89AX1cLEs
l1OR5lUTNeW0bHXUkkwwEBbrSLfjAywpV+PEzKwiLQcfOolBLjwVIjSbh0Me5gYG
VF8fLBY0eYtSGFzjvu62
=LeeH
-----END PGP SIGNATURE-----

--UtHJcEq1hH7QjaIbUDP4IXlmhdC7nX6Gk--
