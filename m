From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 08:34:43 +0000
Subject: Re: [patch -next] fb: fix recent breakage in correct_chipset()
Message-Id: <51F234A3.3030504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vWVOQCinPFBJO33lDE1q8n37mMMXt7xUI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130702062821.GC24410@elgon.mountain>
In-Reply-To: <20130702062821.GC24410@elgon.mountain>
To: linux-fbdev@vger.kernel.org

--vWVOQCinPFBJO33lDE1q8n37mMMXt7xUI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/07/13 09:28, Dan Carpenter wrote:
> The 6e36308a6f "fb: fix atyfb build warning" isn't right.  It makes all=

> the indexes off by one.  This patch reverts it and casts the
> ARRAY_SIZE() to int to silence the build warning.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_b=
ase.c
> index a89c15d..9b0f12c 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -435,8 +435,8 @@ static int correct_chipset(struct atyfb_par *par)
>  	const char *name;
>  	int i;
> =20
> -	for (i =3D ARRAY_SIZE(aty_chips); i > 0; i--)
> -		if (par->pci_id =3D=3D aty_chips[i - 1].pci_id)
> +	for (i =3D (int)ARRAY_SIZE(aty_chips) - 1; i >=3D 0; i--)
> +		if (par->pci_id =3D=3D aty_chips[i].pci_id)
>  			break;
> =20
>  	if (i < 0)
>=20

Thanks, I've applied this into my 3.11-fixes/fbdev branch.

 Tomi



--vWVOQCinPFBJO33lDE1q8n37mMMXt7xUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8jSjAAoJEPo9qoy8lh713iUP/jS8DBgllzX4Fgr4VpoNnKis
svAGn6tfj2Kd6x1INE3iPxnaWDH4Vp+hZRrR6jsOt+1Rxt5KhWNGlzPd0nZAR5fU
wwfuk7IFKqx/SGyQaUsDV7ikLd3h4kIUacVQioQbG5++OIgcVDjPaMwA7QNydZjL
oAJA+txWRBQT1BrmueJu9IickRz0j7SVEqy5Y1ohiEYMT9HqpB1p7B8491NfSH/F
z/s7mmnD42t6SSSLXp0j5DmplOt5eS1hkF4CE7aD7spuSrpJld1O+Ll46O9xv/hK
ilNDkeLoa7yxAcfvcqu5s6uwvRLf6PU90ocTh5FDIMiF0XHlr+84+MT6T6epwgcn
c9qyR8tOqdrqUkdqidHbhAoJVrUth176Y3H0flS1xIBKDvdG2HDZtV2E6IMlxq1w
VBCoIcOEMULMJIfhDUoF0ld8880RHx4zZ/aaOnNCqoC6JgUbY9dKDk+reWPnQf7b
uAJMVhP2aRGILJIYpsnbWo23HqrD0kn/pie8eVqYamfq53wmkWcgY46tl2hB7WoY
xyBKDsJe8sY3Bmb8HX9ILr3WTg90nwVz60TyaLTGNxhjKseieAuAnmaluY4flo8V
Ly8499dS1EH3LKxGZ1VoKyBg0J9aIwdUD5xaVzw2taROUf9AgwLxi4YFqNByKQMQ
YjIwCFGitZ1u2RP98GgJ
=7DUs
-----END PGP SIGNATURE-----

--vWVOQCinPFBJO33lDE1q8n37mMMXt7xUI--
