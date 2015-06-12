From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Jun 2015 09:04:14 +0000
Subject: Re: [PATCH v4 3/3] video: fbdev: vesafb: use arch_phys_wc_add()
Message-Id: <557AA08E.6050606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xp6FBBjTRexLOb0hHjnk0l0MG0AWonsoW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433436288-16792-1-git-send-email-mcgrof@do-not-panic.com> <1433436288-16792-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1433436288-16792-4-git-send-email-mcgrof@do-not-panic.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: plagnioj@jcrosoft.com, bp@suse.de, hpa@zytor.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, toshi.kani@hp.com, sbsiddha@gmail.com, mingo@elte.hu, tglx@linutronix.de, jgross@suse.com, daniel.vetter@ffwll.ch, airlied@redhat.com, adaplas@gmail.com, robdclark@gmail.com, jg1.han@samsung.com, wsa@the-dreams.de, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

--xp6FBBjTRexLOb0hHjnk0l0MG0AWonsoW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/06/15 19:44, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> This driver uses the same area for MTRR as for the ioremap_wc(), if
> anything it just uses a smaller size in case MTRR reservation fails.
> ioremap_wc() API is already used to take advantage of architecture
> write-combining when available.
>=20
> Convert the driver from using the x86 specific MTRR code to
> the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
> will avoid MTRR if write-combining is available.
>=20
> There are a few motivations for this:
>=20
> a) Take advantage of PAT when available
>=20
> b) Help bury MTRR code away, MTRR is architecture specific and on
>    x86 its replaced by PAT
>=20
> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
>    de33c442e titled "x86 PAT: fix performance drop for glx,
>    use UC minus for ioremap(), ioremap_nocache() and
>    pci_mmap_page_range()")
>=20
> The conversion done is expressed by the following Coccinelle
> SmPL patch, it additionally required manual intervention to
> address all the #ifdery and removal of redundant things which
> arch_phys_wc_add() already addresses such as verbose message
> about when MTRR fails and doing nothing when we didn't get
> an MTRR.
>=20
> @ mtrr_found @
> expression index, base, size;
> @@
>=20
> -index =3D mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
> +index =3D arch_phys_wc_add(base, size);
>=20
> @ mtrr_rm depends on mtrr_found @
> expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
> @@
>=20
> -mtrr_del(index, base, size);
> +arch_phys_wc_del(index);
>=20
> @ mtrr_rm_zero_arg depends on mtrr_found @
> expression mtrr_found.index;
> @@
>=20
> -mtrr_del(index, 0, 0);
> +arch_phys_wc_del(index);
>=20
> @ mtrr_rm_fb_info depends on mtrr_found @
> struct fb_info *info;
> expression mtrr_found.index;
> @@
>=20
> -mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
> +arch_phys_wc_del(index);
>=20
> @ ioremap_replace_nocache depends on mtrr_found @
> struct fb_info *info;
> expression base, size;
> @@
>=20
> -info->screen_base =3D ioremap_nocache(base, size);
> +info->screen_base =3D ioremap_wc(base, size);
>=20
> @ ioremap_replace_default depends on mtrr_found @
> struct fb_info *info;
> expression base, size;
> @@
>=20
> -info->screen_base =3D ioremap(base, size);
> +info->screen_base =3D ioremap_wc(base, size);
>=20
> Generated-by: Coccinelle SmPL
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/video/fbdev/vesafb.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.=
c
> index 3db3908..528fe91 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -19,10 +19,9 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/screen_info.h>
> +#include <linux/io.h>
> =20
>  #include <video/vga.h>
> -#include <asm/io.h>
> -#include <asm/mtrr.h>
> =20
>  #define dac_reg	(0x3c8)
>  #define dac_val	(0x3c9)
> @@ -180,16 +179,10 @@ static int vesafb_setcolreg(unsigned regno, unsig=
ned red, unsigned green,
> =20
>  static void vesafb_destroy(struct fb_info *info)
>  {
> -#ifdef CONFIG_MTRR
>  	struct vesafb_par *par =3D info->par;
> -#endif
> =20
>  	fb_dealloc_cmap(&info->cmap);
> -
> -#ifdef CONFIG_MTRR
> -	if (par->wc_cookie >=3D 0)
> -		mtrr_del(par->wc_cookie, 0, 0);
> -#endif
> +	arch_phys_wc_del(par->wc_cookie);
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
>  	release_mem_region(info->apertures->ranges[0].base, info->apertures->=
ranges[0].size);
> @@ -420,7 +413,6 @@ static int vesafb_probe(struct platform_device *dev=
)
>  	request_region(0x3c0, 32, "vesafb");
> =20
>  	if (mtrr =3D=3D 3) {
> -#ifdef CONFIG_MTRR
>  		unsigned int temp_size =3D size_total;
> =20
>  		/* Find the largest power-of-two */
> @@ -428,18 +420,16 @@ static int vesafb_probe(struct platform_device *d=
ev)
> =20
>  		/* Try and find a power of two to add */
>  		do {
> -			par->wc_cookie =3D mtrr_add(vesafb_fix.smem_start,
> -						  temp_size,
> -						  MTRR_TYPE_WRCOMB, 1);
> +			par->wc_cookie =3D
> +				arch_phys_wc_add(vesafb_fix.smem_start,
> +						 temp_size);
>  			temp_size >>=3D 1;
> -		} while (temp_size >=3D PAGE_SIZE && par->wc_cookie =3D=3D -EINVAL);=

> -#endif
> +		} while (temp_size >=3D PAGE_SIZE && par->wc_cookie < 0);
> +

Looks like arch_phys_wc_add prints a warning if it fails, and the above
loop may retry it many (?) times. Probably not a big issue, but may be
somewhat confusing.

 Tomi


--xp6FBBjTRexLOb0hHjnk0l0MG0AWonsoW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeqCRAAoJEPo9qoy8lh718+wQAKKfH+79NWubqaBBcCCkrWSX
uzGFRfm0631KjdSBSps5fNa6rpmv2LvQHdWTc1hg+tjSOgYSasjlVbjTGfbM92e6
TADnl8oBpA+Xa3WmCxKzQjdRhLOPzkDO/J+qIzle5YTylc+7rGY2k+nANq4NySJX
GczUQpsY47knV9Hb78w/hG9rJK3wwc5MPfJJI/pvd1o04vOhs4+AHZ/isyS1FVie
J587iby4JW2uk6aLLHI/3BwVTXutOfybhX8IOXbMbAsy52mP5pD85lZTMtIo/XrV
vkumHcK4BfZ2E+AAf2NpIbAL0vLLoEHFk/hMcf0cXRTsJMhU5cBDTCj9vF6oR1wq
2DJndkmZaUlF64XcFBzL3GO2Ta2oIR6fVi4ZM1XZ+UK7YRlLyY2gAw1qIoxfe733
J0ncCai5I184Ul/QnF66CqmVrrNo8nJD8IZLKtHmjpBNEFkmvQj664xFJ14PkWbN
p1qcFUil1n2BQQk9HAjIJculRqLISF5VZEPYhk3nyEb4Cuwo/UwY/SV7QtauU6CW
w4CwT14dEqW4ez3Lard1+YZOlRAWxq78m0FBh0ddOS68nal2S6Vl3YJBkVk1dBys
WI71E1oGNxa766T4a+kylrNXpE0EwwYaiEciPm/CqypFhh/64cSSbrngSibkwFMD
Jj3MeapVLFDDPi/xC0Kh
=45hr
-----END PGP SIGNATURE-----

--xp6FBBjTRexLOb0hHjnk0l0MG0AWonsoW--
