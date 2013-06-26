From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 12:18:02 +0000
Subject: Re: [PATCH] uvesafb: Correct/simplify warning message
Message-Id: <51CADBFA.6020808@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2LXCRFQFWAIUFIIXGSNBI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366380325-2038-1-git-send-email-bp@alien8.de>
In-Reply-To: <1366380325-2038-1-git-send-email-bp@alien8.de>
To: linux-fbdev@vger.kernel.org

------enig2LXCRFQFWAIUFIIXGSNBI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/04/13 17:05, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>=20
> Streamline it a bit. No functional change.
>=20
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Wang YanQing <udknight@gmail.com>
> Cc: Michal Januszewski <spock@gentoo.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/uvesafb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
> index d4284458377e..a309f9fabe8b 100644
> --- a/drivers/video/uvesafb.c
> +++ b/drivers/video/uvesafb.c
> @@ -819,8 +819,8 @@ static int uvesafb_vbe_init(struct fb_info *info)
>  	if (par->pmi_setpal || par->ypan) {
>  		if (__supported_pte_mask & _PAGE_NX) {
>  			par->pmi_setpal =3D par->ypan =3D 0;
> -			printk(KERN_WARNING "uvesafb: NX protection is actively."
> -				"We have better not to use the PMI.\n");
> +			printk(KERN_WARNING "uvesafb: NX protection is active, "
> +					    "better not use the PMI.\n");
>  		} else {
>  			uvesafb_vbe_getpmi(task, par);
>  		}
>=20

I've added this to my fbdev-3.11 branch.

 Tomi



------enig2LXCRFQFWAIUFIIXGSNBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRytv6AAoJEPo9qoy8lh71EDcP/2DFJEs/YivTRKcMYVHax2rT
j7U0x6cJNYB1AcOui6ID4l93F/3nnld0MjLtgh35tFJz6MAZRWFRXGQTeZjgai/9
ekuPxzNzzuiwA+8EI4GR2xewmDR+mo/HjaPwjlz3HJ0KWOp8m2SBPO12UFIT6uSd
/wKHp9sJv7UTpziIKXHiIEMOKesMqHTNJKbxEejRfu0Y+4eJWc6JC8nJlimJbrO2
sdhhOz7P677QhResW/2GwNhnmCDrLSckXIdMEY7wFv9zlrCUNoHibulttViLbXzu
b4apH1UZwX2VWVAa8HAZmbWs3BcfeMUJHsZKodP4QRI5BGIhGguXv5Df8KwLxUz0
xSFr5MK21luywXvXPq1eWsA5X2GSxDL0osE5PoN1bFbLyia1xC4MSB4miFyrjhR4
1Ue3GfH4KqrQVxysBcop29mmBRaMWbHRBk6yfx4wL0dlzlAZH91Z6m8IQp8YU29+
GVtTMZ7dUy7Hu+nWuTaoLDBXXmChlB6U5fEKbgMLBRFGtPZXaxu6YWz5XSPO9Jpk
gAJYWfMomMGRavCI1xkil8R9rutT32hpSbLs0ferL+13+4nroaiwvNoOxkKuM0/V
sC7t393yIsf1pXhPrQVzuVdmTf3onp9IXhMzmk1SsSDI4cwgxx38U3Ei55b5OvPT
Iktrl7UyeeHYG5rD1pa4
=uopS
-----END PGP SIGNATURE-----

------enig2LXCRFQFWAIUFIIXGSNBI--
