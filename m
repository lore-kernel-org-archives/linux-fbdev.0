From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 09:43:43 +0000
Subject: Re: [patch 1/2] backlight: lm3630: signedness bug in lm3630a_chip_init()
Message-Id: <524401CF.1060605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sETPJMOF5hfNQumAl5xGH55eg90DFsEBQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130925085451.GA6661@elgon.mountain>
In-Reply-To: <20130925085451.GA6661@elgon.mountain>
To: linux-fbdev@vger.kernel.org

--sETPJMOF5hfNQumAl5xGH55eg90DFsEBQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 11:54, Dan Carpenter wrote:
> "rval" needs to be signed for the error handling to work.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backl=
ight/lm3630a_bl.c
> index c63f918..65392f9 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -105,7 +105,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *p=
chip)
>  /* interrupt handling */
>  static void lm3630a_delayed_func(struct work_struct *work)
>  {
> -	unsigned int rval;
> +	int rval;
>  	struct lm3630a_chip *pchip;
> =20
>  	pchip =3D container_of(work, struct lm3630a_chip, work.work);
>=20

There's no drivers/video/backlight/lm3630a_bl.c in v3.12. Which kernel
is this for?

 Tomi



--sETPJMOF5hfNQumAl5xGH55eg90DFsEBQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRAHPAAoJEPo9qoy8lh71juIQAJHQi4LxmqTj4uk3EdPzVGwz
aIG+3arTAS8WrOgrnurm563CRKFqrdk29f9yYRxfQRLkW1/bXTOrWXOZ+Mlj8U4t
JvoFmCUtfs60xep8juIQ5ATa5I4jta35gu8gN0LIZbiGsn0wEJ6okWbcnXsD9lzf
PxHUqGGccjh93Nwj3gQ1QNfGxU7Z37+AubDNG+KvfUSK9H8/3xIEMADIG9pQo+dc
O6sfKz4OML5BYvSHzFXwoPq5hW+2OJu+yPIW0qilYJdOaxA6fRuoWIzyznPCQRu8
gNq2SyP1f+Po9TQ9kkzsGWpqtGkz9oBlxBWjA0FFpq7ExWoawzrFGNM+zkcI1+Nr
wGEpaGf3S1EGG9xBrJphvTWZE3nc0KKJO9Fcc/kfXt+6j+V8j7RZwVsLkYqAlGtw
oiyygxV/DQNeYlWTHPQf86cWcltB55BDAUq5p4UcGolAcEzVHzNUND1kKzaVWmBq
RTYA+pYYG/E8n1fjb0UeeONC1vnFDyHPCorFAd3fDvUBU8uARr0AjUO4+XaL27F9
ZjWcB0AEFwPxs1OOkR43AHBcShh67pYfhfuI7ze4hIaUcfb0FNLQpIck+RO4Xr9w
akkl+sPpTBNlFcA9YBL3AvZBu9S79LG4pRTPaLOTwKC4tXW9qUY+ENnBheGy8rcH
4HXIF7Ky9bb4q5PXB4VP
=osCi
-----END PGP SIGNATURE-----

--sETPJMOF5hfNQumAl5xGH55eg90DFsEBQ--
