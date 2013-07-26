From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 08:36:45 +0000
Subject: Re: [PATCH] matroxfb: replace kmalloc and memset with kzalloc.
Message-Id: <51F2351D.6010904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HgqseJ9L2PmQHW44vRjP21C8500UFs2t4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373637618-10529-1-git-send-email-alexj@rosedu.org>
In-Reply-To: <1373637618-10529-1-git-send-email-alexj@rosedu.org>
To: Alexandru Juncu <alexj@rosedu.org>
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--HgqseJ9L2PmQHW44vRjP21C8500UFs2t4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/07/13 17:00, Alexandru Juncu wrote:
> Signed-off-by: Alexandru Juncu <alexj@rosedu.org>
> ---
>  drivers/video/matrox/matroxfb_base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matro=
x/matroxfb_base.c
> index 401a56e..2456529 100644
> --- a/drivers/video/matrox/matroxfb_base.c
> +++ b/drivers/video/matrox/matroxfb_base.c
> @@ -2029,10 +2029,9 @@ static int matroxfb_probe(struct pci_dev* pdev, =
const struct pci_device_id* dumm
>  		return -1;
>  	}
> =20
> -	minfo =3D kmalloc(sizeof(*minfo), GFP_KERNEL);
> +	minfo =3D kzalloc(sizeof(*minfo), GFP_KERNEL);
>  	if (!minfo)
>  		return -1;
> -	memset(minfo, 0, sizeof(*minfo));
> =20
>  	minfo->pcidev =3D pdev;
>  	minfo->dead =3D 0;
>=20

Thanks, I've applied this into my 3.12/fbdev branch.

 Tomi



--HgqseJ9L2PmQHW44vRjP21C8500UFs2t4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8jUdAAoJEPo9qoy8lh71KFQP/0E8DajpqCtuncZ5eQlkcxc9
4SebRU9XpEVdPXhRIUm/CC25ZwrVk4b9nGIda2UW0AaNi7qxqMMcdUbtJIqjEErH
2gp8i3UWdadtwdqN37Ckq4GBdWlBchYSLFt1UhP/JPCuViMqcNhV0SWoI6eIb26o
R6h3yAoV5jBMPRoKpYZoEwh1SiTA6auCxKCL/PROBcc8ymZiiXwAX6pMkWayTOcE
OqhLaaZPPshRaen+SlMA6Rn5AA0neJ+f7eBXNQUP7zsUgW9NeTneF0na47xhaUkO
eJvSRhFnA0QUalxTkJRoU/yBrmYqxjSg1PVCxymMkozIJHsyazm3KCmeIbhxILpz
IEb6SpWW41I0+p7hZqg5L2ctpunIqGUtJYrJQeR35RPIvnL/V94V4W8jzVh/wNXm
moKmk+6Z3JfX8JvHV1rrGFLTbl6H8QrQgnPg/TPW+/zvPkf2vs8U5zlDRuEdqJfh
BfytLiApdIRiNV2XgYl9iF5pRZFpe5KqvZwDw3JT405N8FK9zkKiUf1kOiMCNXzN
H0NN8DyTJimgoxQbSs+JEGVPK54co50bT2OUspxLuRbgzIWjbSy/D0azEthjOLeu
9IpRSaPYNVfQmhtfly8rVM1YShYk/cYGGe4Al6bH94H9CDCtfN8FPdUh2aGgE+kn
mltYinCSTUAKF9rRpN2u
=gS5X
-----END PGP SIGNATURE-----

--HgqseJ9L2PmQHW44vRjP21C8500UFs2t4--
