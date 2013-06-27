From: Felipe Balbi <balbi@ti.com>
Date: Thu, 27 Jun 2013 08:40:04 +0000
Subject: Re: [PATCH v3 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
Message-Id: <20130627084004.GS15455@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wnBGVoaGQwxWUIo6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372258946-15607-1-git-send-email-s.nawrocki@samsung.com>
 <1372258946-15607-2-git-send-email-s.nawrocki@samsung.com>
 <20130627075223.GQ15455@arwen.pp.htv.fi>
 <51CBF9B8.70103@samsung.com>
In-Reply-To: <51CBF9B8.70103@samsung.com>
To: linux-arm-kernel@lists.infradead.org

--wnBGVoaGQwxWUIo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 10:37:12AM +0200, Sylwester Nawrocki wrote:
> On 06/27/2013 09:52 AM, Felipe Balbi wrote:
> > On Wed, Jun 26, 2013 at 05:02:22PM +0200, Sylwester Nawrocki wrote:
> >> Add a PHY provider driver for the Samsung S5P/Exynos SoC MIPI CSI-2
> >> receiver and MIPI DSI transmitter DPHYs.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >=20
> > Acked-by: Felipe Balbi <balbi@ti.com>
>=20
> Thank you for your review and ack!
>=20
> Just for the record, I have tested this driver as a loadable
> module on Exynos4412 TRATS2 board and it all worked fine for
> both the camera and display side.

Awesome dude :-) very cool, let's hope more users convert to Kishon's
generic phy layer :-)

--=20
balbi

--wnBGVoaGQwxWUIo6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRy/pkAAoJEIaOsuA1yqRE0usP/0kXzaQLwW6FcUZS/DU+PZ03
Blwk6lKVGICnyrhp/xYuqQKmSgSk1wMJ+KIfu8mRi0OPJ2p0u4sDAPQ8sq0oLNVS
rCwj75LqkbjqRWXYziFwyiSQqEsP1D4rvD3aDJXot+A5As86XAqc/YY629WZRraO
jbpeY4FpK1A9eWgNyW4uBtyhJQKxe2/kV3Jipw6/TOl/cO2yCE+snWJXZTbrEaOy
M1LxjHLhKqNjltxrWs5HJe2iQPSXl0zpgWZHuNht26u6wZY7F+Eo83RQeLnwzzlZ
tK25jRT5e66UZ5vkQvKv/4cDdjGdESf5L68pAUKiUa35Bmre20GiO1IIdFy1n95f
fb0FcK0Ye3RghjVDF8qqBqYnCGIR7+rHmRHp76/7PqbOujUHX0Nt8h3hqzthpA3I
Uqrow12JDInJuVEgRsSEGkSU2+DT1bbZSJT2f5AYQKLu6bYLa4QU8ZuF4Ap5vysR
UFVN8ZN2faPsB1+eQ8V2+qet5Enh46N+AAHnpe+iOJHb5khnJ8w+OKQFXwQPjag6
2f1t9Jywy0CRWueJRhIWMv07dgZAb311JLBMzT06GzmqjsfHWo3iSkuhrWXO1Ota
znPhyjEEifx4MeeMXfRJfE9PpcC59YH9YxWykbRFuWm3qApZFgBYq1hl5sZoGQxx
di/7prNpFT4B2wAJF3Nu
=OBbu
-----END PGP SIGNATURE-----

--wnBGVoaGQwxWUIo6--
