From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 16 Jan 2017 08:02:59 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: allow reset-gpios is missing
Message-Id: <20170116080259.k47otz6zr6c2i2qc@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="w5zm2ufcjf5nhzgf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170115112146.1787-1-icenowy@aosc.xyz>
In-Reply-To: <20170115112146.1787-1-icenowy-ymACFijhrKM@public.gmane.org>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--w5zm2ufcjf5nhzgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2017 at 07:21:46PM +0800, Icenowy Zheng wrote:
> Currently some SSD1306 OLED modules are sold without a reset pin (only
> VCC, GND, SCK, SDA four pins).
>=20
> Add support for missing reset-gpios property.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Unfortunately, a similar patch has been sent a couple of times
already:
https://www.spinics.net/lists/devicetree/msg158330.html

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--w5zm2ufcjf5nhzgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfH4zAAoJEBx+YmzsjxAgwa4P/A+y2gOtVCFlT73Oyd2uuQy6
33loZT7daIdZgL+YFlhM7Ik+NU7AzkxaoY3Tu90hqmWoU6ApOWsvOu4QLx1WGkvR
4//Cjb8akgTpZCgOVzH4yA/Zvh+H1WiurxVpPCSR/nW22wvFRYYlwA7VKJfm72QL
ZTkKdFHIjuz6MPd5988xbjIPCUsoV6bzPJYS5Ja8Chz1IcXlgmwyN82K7StLWtaW
ETICON52Ai2QZClUrsQh/m+WKjqDKq6aXxC5K4flI9jioxRg+jRQG5NZhGhIoy/V
/91iHU4UOklQW3nhSjS8EDSt6/0cV0Z/ZSP71KpdvuO3ljjSLS+jboSah73VjS1A
DdJwMg4G5IGgO36paXw1Zs+yw+z9khMuF9Ci5TmFGQH6dRUYuG1HpFRsFPjuPd9U
teKbBQ/TSp5nRDM3KF7c9q2q6LQ+S8p26aQbWGFUB4cD1FEY5HIl7gmrakymgm20
s4pT7QwM4YY2ew+8HRLYQ+lET3cJaCI32C+dzhAz0UyW2CDdsZI24EpmwDU8SG0j
Vcwf1S+orbvcdGCHp9GzBwCGLQvU1vahKWAEl/a0ohlUSs94mlX7AoptqLNwjxkQ
gsq9cDcww92M22m3eQXeRMyqxcFacVWLd8ahb7QS3gSXrIQdf7bap5iBi/d/Ym85
bU1tC1QPsPlQ6kG0RvJT
=dA1C
-----END PGP SIGNATURE-----

--w5zm2ufcjf5nhzgf--
