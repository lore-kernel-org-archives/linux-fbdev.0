From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Sep 2013 09:20:10 +0000
Subject: Re: [PATCH] video/ps3fb: Fix section mismatch warning
Message-Id: <5236CD4A.5060208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lBR7tveO4QCerkahV9jQVeMGP9CBtGrlP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369141302.3652.14.camel@clam>
In-Reply-To: <1369141302.3652.14.camel@clam>
To: linux-fbdev@vger.kernel.org

--lBR7tveO4QCerkahV9jQVeMGP9CBtGrlP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/05/13 16:01, Geoff Levand wrote:
> Remove the __initdata attribute from the ps3fb_fix variable.  This is i=
n
> follow up to the removal of the __devinit attribute on the ps3fb_probe(=
)
> routine in commit 48c68c4f1b542444f175a9e136febcecf3e704d8 (Drivers:
> video: remove __dev* attributes).
>=20
> Fixes build warnings like these:
>=20
>   WARNING: vmlinux.o Section mismatch in reference from the function .p=
s3fb_probe() to the variable .init.data:ps3fb_fix
>   The function .ps3fb_probe() references the variable __initdata ps3fb_=
fix.
>   This is often because .ps3fb_probe lacks a __initdata annotation or t=
he annotation of ps3fb_fix is wrong.
>=20
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  drivers/video/ps3fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
> index a397271d..4819cdf 100644
> --- a/drivers/video/ps3fb.c
> +++ b/drivers/video/ps3fb.c
> @@ -952,7 +952,7 @@ static struct fb_ops ps3fb_ops =3D {
>  	.fb_compat_ioctl =3D ps3fb_ioctl
>  };
> =20
> -static struct fb_fix_screeninfo ps3fb_fix __initdata =3D {
> +static struct fb_fix_screeninfo ps3fb_fix =3D {
>  	.id =3D		DEVICE_NAME,
>  	.type =3D		FB_TYPE_PACKED_PIXELS,
>  	.visual =3D	FB_VISUAL_TRUECOLOR,
>=20

Thanks, applied for 3.13.

 Tomi



--lBR7tveO4QCerkahV9jQVeMGP9CBtGrlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNs1KAAoJEPo9qoy8lh71ub0P/2i3QPQUWL9yckVQShQBQK1z
d5lk1WRO1XG/hDyFkpsPlzo/GyMOF67euga8viS9Jkh9KnH7Ya/aNGS2eNboSF8Z
Gmhx7ZHoh73Pn5oWcqZPZOteXVC6FKFqIOCp9mcO7sTggIhCZb04itS9UXTvFz7X
bniaXJEuFzBFPxRvquwPdd/CNuHVqAFbIu43cpjb2hBdZjn29swctBE498UJa2U8
tqP3I8+lO4+hi0Xy7TzCpbI3b65+FuMLSXT/MFyWNjaNL3QN4X//9UhsmEhcRt7p
RuRXOAk481stl6UINBoIDcv3ZX/8+ipuDOjQgOT60n460f0HWK46tGKL8P2Ct89n
wJeX+vVaLzA7N7t2+4948Q2/c3rwo1T5SKSL7l/vdXfs0YnpPReCtT/D0MFD95j2
0kqLe9STwZMp+zNBjGo0MLKx2EZJ48PJj64/Emb/vXfNrpIrhLHAalcOv9r1ZZNO
KGNxr2Z2xwmBMWsyhltRiCsjtlKA35lHdFPseIjXA1AX2pVdmg9a8zWsxht6T5U0
hk0OI32wlszdJuuBPQ0r+bQPhzBs7sr8VYTDzTB93wEV8mhtOsc4W8e+A4+SWzev
DOi/17NtEl9vL41Yaj3bISXzIxY+mXZrbJWO+/pBlJXVC9l/uZf1wYPZE+lsdZWD
IjaD/PLt/8mqO7+a1vAu
=O3zl
-----END PGP SIGNATURE-----

--lBR7tveO4QCerkahV9jQVeMGP9CBtGrlP--
