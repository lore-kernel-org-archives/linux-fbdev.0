From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 12 May 2020 16:25:46 +0000
Subject: Re: [PATCH 1/1] video: backlight: tosa_lcd: convert to use i2c_new_client_device()
Message-Id: <20200512162546.GG13516@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5UGlQXeG3ziZS81+"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
 <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
 <20200417101446.GB3737@dell>
In-Reply-To: <20200417101446.GB3737@dell>
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 11:14:46AM +0100, Lee Jones wrote:
> On Thu, 26 Mar 2020, Wolfram Sang wrote:
>=20
> > Move away from the deprecated API and return the shiny new ERRPTR where
> > useful.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/video/backlight/tosa_lcd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Applied, thanks.

Thanks! I don't see it in -next, though?


--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66zgoACgkQFA3kzBSg
KbYypBAAm3XnZir6qWFmr4Qj+5zgB/2ULqZE2wKu+zzkI2XF+aRrZbsYLcKdS/Vr
HFdO63UIyU+G2pm+5lxGpbusoi6UxnMJaYvxhlSLaj0PZIG4UKVnIdfRpeTiSXlG
7kV5Azbjhj1lecmgDd0vNhMMkOBDms8/UqUdjshWLl+Nq8z2z+M7MqndXzoNZIW1
mEkQ2+/Myls16BimytTzH5lSTk2LEjL+8GNfIYSj7HOvb4FHuSLg5oZSNfdIuny7
9Xrhh4C18ZZHlCVpauJu7zpuUcvwhoxUBvU1T8wIHXrVqOBUGSzfBk/3hZ1k2wiw
QtBBJZ2z2/nhYINxJ8YQdD4cwVUvTVft9iXfzNTW3o6gD+YTJnhTwjmRrQcYfZC7
Phs/lID6bgCaZDjBED4xZASvQCiDIG0g7SDQlT5sM2Viydy8y3XJvCYasDWcOaxL
zBg/pRgr3099DtdgHv4qPn5lJwz48DRYWISiiNuJmtSxDuFYavAYe8Cbt7i8KYc6
GF26HlYJh+g1h3E4EzjOmHfgm5s9tPU/Tayxni9OlgjUnPYuuWA8vqBLd6qUbP4Q
LpBt75bPUbNlD+HYzq7LwDiUdfrm/Q4WycK/VSk1Xejh4gfclg9uUjSey+oj52Rq
v7NQALUhYKWB+CHGz0w7WkZwalpZtRNA/j4yhEXEz4d0nTUaA7M=
=+eIt
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
