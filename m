From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Jan 2012 12:11:33 +0000
Subject: Re: [PATCH] video: use gpio_request_one
Message-Id: <1327579893.1895.35.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-SZ/EV1757AuLusEb2HUj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <000d01ccdc15$d0e2a500$72a7ef00$%han@samsung.com>
In-Reply-To: <000d01ccdc15$d0e2a500$72a7ef00$%han@samsung.com>
To: linux-fbdev@vger.kernel.org


--=-SZ/EV1757AuLusEb2HUj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-26 at 19:32 +0900, Jingoo Han wrote:
> Using gpio_request_one can make the code simpler because it can
> set the direction and initial value in one shot.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/bf537-lq035.c                        |   12 +++---------
>  drivers/video/bf54x-lq043fb.c                      |    4 +---
>  drivers/video/bfin-lq035q1-fb.c                    |    8 ++++----
>  drivers/video/bfin_adv7393fb.c                     |    5 +++--
>  drivers/video/msm/mddi_client_nt35399.c            |    7 +------
>  drivers/video/msm/mddi_client_toshiba.c            |    7 +------
>  drivers/video/omap/lcd_inn1610.c                   |   10 ++++------
>  drivers/video/omap2/displays/panel-taal.c          |    4 +---
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |   11 ++---------
>  9 files changed, 20 insertions(+), 48 deletions(-)

Looks good to me. For the OMAP parts:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--=-SZ/EV1757AuLusEb2HUj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPIUL1AAoJEPo9qoy8lh714NQP/AhV94CVYJrO5SyzSWdQ9BIV
VtwsbA6xa7LlpO/FTJZLOyVNl607KkqfpSFwfoHcExi9R4N/gkyQjM2/bm9nqXvm
UPhvUkLbMKKqLNB5biNa7PdCoyZ48Wx8CtyOBIlJhklvIEcVgJmlN57lKP6xqnPq
Zu77mUjUdd0yaW4Y31q6ngrlKCF8pBeJWI7stJXw5CHAqJ8VuT4Q3z2L4iXP7xlQ
7K2c/phewR0QvHAC3ahbjG/lN/2mH7Lje1AAV0XxqGw0JItuo8NCmffY2HgZEalj
CHccKXvcNRo72RPhsoCXWQSbDdtC8XfXvsx4TZGEwSO7kTQnwDGMbcggcynoze2Z
uxyuvlg2bDQ2xFaEKclxflKfxDg6JFwob4JODClHmLAIzUPRvxTbF8w5gJL7Q5c8
2F2X2K7Shdng9UkGTipx2PWEPcFPhXQIUl1ztluy09VBJhOw6uo8gBhLj7U1xxf6
ijhSEF7sWuGp6lnrm2rEiHob7hlJff89quj417bDkWUOUIfGjdKGTMGwztAv8NC3
xf5OBIMuhZtXEKhFxgYtzZIKF0lr/nor/3B+6vG3PfDGPK7dcy5oStV6A+3H8+tN
7MWHaloarguU+mSpQCArTdqAmJoQ5Sypay09J8zkensnfs1R4SSX+lCCIWQEu7qt
3tb6+xh7YO8WUQTFWA6a
=qGeq
-----END PGP SIGNATURE-----

--=-SZ/EV1757AuLusEb2HUj--

