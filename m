From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 13:04:10 +0000
Subject: Re: [patch] fbmem: return -EFAULT on copy_to_user() failure
Message-Id: <51CAE6CA.8000909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2DXRAHWOQQAMUBFXKLBLL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130618070529.GA12329@elgon.mountain>
In-Reply-To: <20130618070529.GA12329@elgon.mountain>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

------enig2DXRAHWOQQAMUBFXKLBLL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/06/13 10:05, Dan Carpenter wrote:
> copy_to_user() returns the number of bytes remaining to be copied.
> put_user() returns -EFAULT on error.
>=20
> This function ORs a bunch of stuff together and returns jumbled non-zer=
o
> values on error.  It should return -EFAULT.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 098bfc6..9217be3 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1305,7 +1305,9 @@ static int do_fscreeninfo_to_user(struct fb_fix_s=
creeninfo *fix,
>  	err |=3D copy_to_user(fix32->reserved, fix->reserved,
>  			    sizeof(fix->reserved));
> =20
> -	return err;
> +	if (err)
> +		return -EFAULT;
> +	return 0;
>  }
> =20
>  static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,

I've added this to fbdev-3.11 branch.

 Tomi




------enig2DXRAHWOQQAMUBFXKLBLL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyubKAAoJEPo9qoy8lh71DQkP/jo/YqxPdBn1fKjZxVunqf+q
/KLfQsF5UTCDyO9O66+imJMjpuyN9T2bnFjZGZ6Xp6lfC/Cyqg1L+BckRY5x/yuS
IDyBJKEB1AewA51Cb1FxNYzwOpGouCAyTF9BVTGkI3d0wllurq8ettV32Z36lNUi
RP3z1Pqcp9ajXakoTMV2QMfqajr31tYv4oVqGV9jqMG9DE+InlbpjpVhCTJVy6/4
d/pGxXHI7zA6fObThcYE54/IuHLqucgkZOO/MruIfN68n3BXehTf2MWUU4i0Swr/
r2nhbudKjIBi8JLikJuEBTuZ2biS3U4z+KKb+0AtJ+c9VtEtPRbw4DNs5svnwAGF
FZw1/gOr6om/ApMeGixAQOX1ChvjnkmHGwzKpvYiYdQhMHJnQ9sNIURQPxdeHYsb
l3r3LFNmvTbaerru7GKxpNyTty4USHdaS3AVFZN4lmoIyuv3NKZ0A2cJ4MOaEWrK
uNUI4PSU+P1JHwWtnwtHWzEw1aZS1fmhvO1qgkErI1HwkOdnr6UA++Xm63HpziYI
3UTxpvtIYB2YVAdy4N0DNDk8Sk5tyUOC3JuixkqVkv7n9fWh1LwO4oeDJlZ8RQUX
rZToCWb1WXrJ727+xbB28eVsjbJpxL7D3gjZJQzhtCO3UzoyZXL2XitLzZrO18Qq
9l99DUvSuuBmIOQ+2pB9
=PxFp
-----END PGP SIGNATURE-----

------enig2DXRAHWOQQAMUBFXKLBLL--
