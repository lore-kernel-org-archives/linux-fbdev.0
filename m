From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Jun 2014 11:51:42 +0000
Subject: Re: [patch] video/mbx: indent some if statements
Message-Id: <53A814CE.5090708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="H0Xlk5F5qCMThsJdx78QX9XLn3irerRx7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140611064535.GA16443@mwanda>
In-Reply-To: <20140611064535.GA16443@mwanda>
To: linux-fbdev@vger.kernel.org

--H0Xlk5F5qCMThsJdx78QX9XLn3irerRx7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/06/14 09:45, Dan Carpenter wrote:
> Checkpatch.pl worries that we have left off the conditional bit because=

> it isn't indented correctly.
>=20
> WARNING: suspect code indent for conditional statements (24, 24)
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/=
mbxfb.c
> index 2bd52ed..698df954 100644
> --- a/drivers/video/fbdev/mbx/mbxfb.c
> +++ b/drivers/video/fbdev/mbx/mbxfb.c
> @@ -628,14 +628,14 @@ static int mbxfb_ioctl(struct fb_info *info, unsi=
gned int cmd,
>  		case MBXFB_IOCS_PLANEORDER:
>  			if (copy_from_user(&porder, (void __user*)arg,
>  					sizeof(struct mbxfb_planeorder)))
> -			return -EFAULT;
> +				return -EFAULT;
> =20
>  			return mbxfb_ioctl_planeorder(&porder);
> =20
>  		case MBXFB_IOCS_ALPHA:
>  			if (copy_from_user(&alpha, (void __user*)arg,
>  					sizeof(struct mbxfb_alphaCtl)))
> -			return -EFAULT;
> +				return -EFAULT;
> =20
>  			return mbxfb_ioctl_alphactl(&alpha);
> =20
>=20

Thanks, queued for 3.17.

 Tomi



--H0Xlk5F5qCMThsJdx78QX9XLn3irerRx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqBTOAAoJEPo9qoy8lh71Ez8P/2gyCPiiiiS7AjK7V6tx7YFc
OcLqQ7ya8nCA6bpzK91oa/ULDpYywmARVordzPCASe77hqVeJK1LMWOmSIV9t/gQ
UOVEzYKJWiymHdbAQVYD1iO+VctSh27TamDTlTHVIzgOL4Utr7Xwe5mm2d7fYcTY
liYh6Iar3sGv4Ji4BwGabSO37LQP21YhrztyvftPOfVroJ8tj3ejSBGqjF1gOvxk
K7Orki+zRfXXFlj6/51a7iI9QUZKAXp3PUEtGdBy1vW0vCUta+QT5XJqJY4FFRIJ
YdkB1KoYjXGWzNt/TQBzYLrhNuF4iGf+AeVb7vi3AjzdhcOJ1e/fADSUQNNjBJGL
TX8RQ+ZHL9XphNBFzuqSeA0pnQgO/U/TdLJNBRTC8TL266CddnpxMiOLcUeA8o5T
FdMSbVso/lkb2rVxjqZA0CKsTVCSVd0R4GPI6NJqqFXa4FOP7aJ3xicsA0Tvgdbb
yTzJde2WgZmEdcUb8xTUn1aaPi4ils0pYtZcfiEidiBl4fldK5j+Wv8g5FoyFGBZ
Rl89ClhuDiVmgImpzX7ziiDEJ7jQKsmiOzWZNzFcXDit2tiJBR6ZjdQMxzDxpDHR
e0GPR8/+Eyli+QR8BMByFXTQgkLxjWLv8IPwi15wT+LBdHXTFIvcfsIbSxStvT94
Kg9QJ6cnOrVl9hDEXhNr
=OwNX
-----END PGP SIGNATURE-----

--H0Xlk5F5qCMThsJdx78QX9XLn3irerRx7--
