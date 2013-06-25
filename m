From: Felipe Balbi <balbi@ti.com>
Date: Tue, 25 Jun 2013 15:09:58 +0000
Subject: Re: [PATCH v2 5/5] ARM: Samsung: Remove MIPI PHY setup code
Message-Id: <20130625150958.GD21334@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="11Y7aswkeuHtSBEs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <1372170110-12993-5-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1372170110-12993-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org

--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 04:21:50PM +0200, Sylwester Nawrocki wrote:
> Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
> DPHYs so we can remove now unused code at arch/arm/plat-samsung.
> In case there is any board file for S5PV210 platforms using MIPI
> CSIS/DSIM (not any upstream currently) it should use the generic
> PHY API to bind the PHYs to respective PHY consumer drivers.
>=20
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

pretty cool stuff

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRybLGAAoJEIaOsuA1yqRE/P8P/1NFpYzmZOjWX4O5YfCFJcb6
VJRtCXfNxvkh7capMYBfsIeit3N+yStBDZ24FEybI33E4xjj3UAHecHq0USxZz+V
lDjwHfx9588ivw2wsOFzc71LZwFNUgQmxGSuRZOtCfuFZoaEn/iUCTEP7f1lyqJi
WTcvnVZhhwqmldiS8Sg/HBtC2f7gG18uP+DY12iEiDOqfOwUmKzjUkD6jOSS/MIt
HTPL5tEt6OQ27bE1T4CN6ZJy9sjLRyCH/sf7CzTlOe5mBkSRspHu+2MjdBkW2o9y
sAyfI1n7Ilep64UE+lgwGBKANJwOWl/pYoJm835s8kr7M2kNRy/tKsvBn5+emS0F
yx2JrncbYM57NThUIKEu2IPtxzP38ec+tTVfcRup4Bn1ZQuKkq293yKkiu6wgiys
7TZwo57BQi3XOolTABoddlVvlzhen+ZKxIduxZGKm2Dma/+6eoij0U2bCePxoPxM
Ap2gxA0nuxt99GuX0v5UCBsFZzLG5bV+88ti2RozDJe+woMc+ghN4lqh+kL+U5bV
PFoA2sQBfA1q8zfXhbD7OhldceiL2w26fSZcEQatkG9r7zLRCOYtEln7fTW0+30f
vZHredQAshZPAgJUIhfIHCi/HnPOuVpjxFTJkvk62Rs9nr3+/qTx/0613xDQHFaa
ZGXO4AJVWFH20ISs4omI
=h90o
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
