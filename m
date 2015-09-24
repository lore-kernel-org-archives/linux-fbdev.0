From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:06:50 +0000
Subject: Re: [PATCH 1/4] [resend #2] tridentfb: fix hang on Blade3D with CONFIG_CC_OPTIMIZE_FOR_SIZE
Message-Id: <5603D94A.5060806@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jkxlfDogvqQp86aW5fEoroMQPfnn821Ui"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>, Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--jkxlfDogvqQp86aW5fEoroMQPfnn821Ui
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/08/15 22:37, Ondrej Zary wrote:
> When the kernel is compiled with -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE), tri=
dentfb
> hangs the machine upon load with Blade3D cards unless acceleration is d=
isabled.
>=20
> This is caused by memcpy() which copies data byte-by-byte (rep movsb) w=
hen
> compiled with -Os. The card does not like that - it requires 32-bit acc=
ess.
>=20
> Use iowrite_32() instead.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
>  drivers/video/fbdev/tridentfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/trid=
entfb.c
> index 7ed9a22..7429713 100644
> --- a/drivers/video/fbdev/tridentfb.c
> +++ b/drivers/video/fbdev/tridentfb.c
> @@ -226,7 +226,7 @@ static void blade_image_blit(struct tridentfb_par *=
par, const char *data,
>  	writemmr(par, DST1, point(x, y));
>  	writemmr(par, DST2, point(x + w - 1, y + h - 1));
> =20
> -	memcpy(par->io_virt + 0x10000, data, 4 * size);
> +	iowrite32_rep(par->io_virt + 0x10000, data, size);
>  }
> =20
>  static void blade_copy_rect(struct tridentfb_par *par,
>=20

Thanks, queued for 4.3 fixes.

 Tomi


--jkxlfDogvqQp86aW5fEoroMQPfnn821Ui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9lLAAoJEPo9qoy8lh715XEP/3OSqqylYQ0IEpdLCZklPS6d
8puNlzbnlbilLIfKzcaZKD3x/39oYvlV42RHhZZtqq668cVey6XuCu8lI5/qxOoJ
S7DnCxau+S8g61N6uk9dlghrSEIDa0Dh68R7PeWksqpy5jPdjdW8PG10xyGT0HPg
rJUFtsF7tzLqJqzXldkz+uilCEv0tIaSeBz7E3sykXymdKsxkZkKf7HBThw2OS09
lk3kU3uz88Lb/vzXi//3o+YanF+cGOP8d3UM5wg9cvR2ZrMF7j0KJ4b92EubAVZ+
wy9WFGIDlJM+5i8n9jAqTUIC67biBQ13FCyrRR0RSdHalYRlSJswOdnfX2aWmNr0
NNOVAQfYVJAf2bLgFBCwi+f0dVdH32Px5MjbGYT4yCtRmne4XnooeyumFqOf48y4
H9yl139m91Oqb4ZEccCknF1DT8yQeMD//YnZOb9g1h2eMzUrFg3Puo7t83NnW3ta
0Uc6rAPF/2yzbsQAS0tc/CGfosYgxixpuB70/+0SE1tmNcx08THgFDxIiga8yCKF
Z6QdtpcdacKa5NxyJbLxo9uwsL//YGr6CLBLeuW/+wB5aNmNK7d7CjMYLPQz2LIY
X5U656H1SWwidfZJbGnJXy3cSQ1mbBd/U6lUbWL4brbrdLKzekdI8ep0dgFcBFQO
42+DA0Fz9HZbPmQVmTAO
=c4u1
-----END PGP SIGNATURE-----

--jkxlfDogvqQp86aW5fEoroMQPfnn821Ui--
