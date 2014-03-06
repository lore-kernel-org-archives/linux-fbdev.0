From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Mar 2014 09:56:37 +0000
Subject: Re: [PATCH] video: fbdev: uvesafb: use CONFIG_X86_PAE surround _PAGE_NX check code
Message-Id: <53184655.2090106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VCxqxQHuIewBi6if6nDCTk361gH3s013k"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140305161611.GA32461@udknight>
In-Reply-To: <20140305161611.GA32461@udknight>
To: Wang YanQing <udknight@gmail.com>
Cc: plagnioj@jcrosoft.com, fengguang.wu@intel.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--VCxqxQHuIewBi6if6nDCTk361gH3s013k
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/03/14 18:16, Wang YanQing wrote:
> Because _PAGE_NX check will always false when we don't define
> CONFIG_X86_PAE for CONFIG_X86_32, so use CONFIG_X86_PAE surround
> the check code.
>=20
> Although I believe "smart" compile will optimize out and generate
> the same code, but use CONFIG_X86_PAE surround check code will
> clear it and prohibit warning from static source code analyze tool.
>=20
> [ This patch fix warning report by fengguang.wu@intel.com
>   "drivers/video/fbdev/uvesafb.c:816 uvesafb_vbe_init()
>    warn: bitwise AND condition is false here" ]
>=20
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  drivers/video/fbdev/uvesafb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesaf=
b.c
> index 509d452..102858c 100644
> --- a/drivers/video/fbdev/uvesafb.c
> +++ b/drivers/video/fbdev/uvesafb.c
> @@ -813,6 +813,7 @@ static int uvesafb_vbe_init(struct fb_info *info)
>  	par->ypan =3D ypan;
> =20
>  	if (par->pmi_setpal || par->ypan) {
> +#ifdef CONFIG_X86_PAE
>  		if (__supported_pte_mask & _PAGE_NX) {
>  			par->pmi_setpal =3D par->ypan =3D 0;
>  			printk(KERN_WARNING "uvesafb: NX protection is active, "
> @@ -820,6 +821,9 @@ static int uvesafb_vbe_init(struct fb_info *info)
>  		} else {
>  			uvesafb_vbe_getpmi(task, par);
>  		}
> +#else
> +		uvesafb_vbe_getpmi(task, par);
> +#endif
>  	}

I don't like this, I think this makes the code more messy, just to avoid
that warning.

And it might even be buggy. For your patch to work correctly, you need
to know the internals of _PAGE_NX, i.e. that when CONFIG_X86_PAE is not
defined, _PAGE_NX is 0. But the driver should not depend on things like
that. If _PAGE_NX is changed later, the driver will not work correctly.

 Tomi



--VCxqxQHuIewBi6if6nDCTk361gH3s013k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGEZVAAoJEPo9qoy8lh71woMP/2lhE4V624scSHRzr3ahoFol
2DT4kNA24ptQpOO83//MF+pv4w8bn1t5sCVOejogPuvNY0J+Uq7mIEggZPGwr2e8
e0VePSKT0oKgtdLorydcnsLdWXakY4Awn5GFHDqCFMVGsP2z9c/BH7kBGWIRJKQK
eUUA9yAPSJdEOSpd66SnxFKYk1YC8xiOanBtjFKLObATNdYdcSFQda3Ga5RcGnR2
VXC64Zlb8bXduwdeGlHo9Ctv2jBCNEavjJ/44oHAsu8IbmiIRDVyDsw+chhFHTDl
W383pAJeAlICuRG6xjMZx8CbduNkNySLlSc3wDUdzhq4OlK2UBvZQouR8VDHfi1f
oQ26IAl65fnpeFD69YKjtQFRM7zjPtfW9YTzO6t9f7fEmbBfBxAGNtNsBcM6o54p
haFjH3czGVyMfWNK7uCAlrpNj/tsZBneKcFJwQ4tpJolqGCyb4+KKnCPHJhqubJp
79qeh3VkecbvsI0ri87iOwalbpuHW16Sz/RNbNeNIyg8zu1r4vd+U0obid0tRT1O
Pc5QxYiCJioMFprKSrESQYTOceKwkcJgVYQG6cWupStOMoQysLYS3pgbHMlJCfnC
By0MGvwghRNWWe/lAO77GlWlDurt3bT8sz51aCxg4sGNKMOurY2RBTiiTOsx1I8O
ZEohSMfmtufZgZLDqnsY
=rAx2
-----END PGP SIGNATURE-----

--VCxqxQHuIewBi6if6nDCTk361gH3s013k--
