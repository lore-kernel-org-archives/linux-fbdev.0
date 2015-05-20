From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 20 May 2015 09:52:14 +0000
Subject: Re: [PATCH v3 2/3] video: fbdev: vesafb: add missing mtrr_del() for added MTRR
Message-Id: <555C594E.1010607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9mvovWKUSjlEIdRsOd5WBLtix8dEeGJDp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648850-17902-1-git-send-email-mcgrof@do-not-panic.com> <1429648850-17902-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429648850-17902-3-git-send-email-mcgrof@do-not-panic.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, plagnioj@jcrosoft.com, hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org, luto@amacapital.net, cocci@systeme.lip6.fr, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Rob Clark <robdclark@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org

--9mvovWKUSjlEIdRsOd5WBLtix8dEeGJDp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On 21/04/15 23:40, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> The MTRR added was never being deleted.
>=20
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/video/fbdev/vesafb.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.=
c
> index 191156b..a2261d0 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -29,6 +29,10 @@
> =20
>  /* -------------------------------------------------------------------=
-- */
> =20
> +struct vesafb_par {
> +	int wc_cookie;
> +};
> +
>  static struct fb_var_screeninfo vesafb_defined =3D {
>  	.activate	=3D FB_ACTIVATE_NOW,
>  	.height		=3D -1,
> @@ -175,7 +179,16 @@ static int vesafb_setcolreg(unsigned regno, unsign=
ed red, unsigned green,
> =20
>  static void vesafb_destroy(struct fb_info *info)
>  {
> +#ifdef CONFIG_MTRR
> +	struct vesafb_par *par =3D info->par;
> +#endif
> +
>  	fb_dealloc_cmap(&info->cmap);
> +
> +#ifdef CONFIG_MTRR
> +	if (par->wc_cookie >=3D 0)
> +		mtrr_del(par->wc_cookie, 0, 0);
> +#endif
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
>  	release_mem_region(info->apertures->ranges[0].base, info->apertures->=
ranges[0].size);
> @@ -228,6 +241,7 @@ static int vesafb_setup(char *options)
>  static int vesafb_probe(struct platform_device *dev)
>  {
>  	struct fb_info *info;
> +	struct vesafb_par *par;
>  	int i, err;
>  	unsigned int size_vmode;
>  	unsigned int size_remap;
> @@ -297,8 +311,8 @@ static int vesafb_probe(struct platform_device *dev=
)
>  		return -ENOMEM;
>  	}
>  	platform_set_drvdata(dev, info);
> -	info->pseudo_palette =3D info->par;
> -	info->par =3D NULL;
> +	info->pseudo_palette =3D NULL;
> +	par =3D info->par;
> =20
>  	/* set vesafb aperture size for generic probing */
>  	info->apertures =3D alloc_apertures(1);
> @@ -407,17 +421,17 @@ static int vesafb_probe(struct platform_device *d=
ev)
>  	if (mtrr =3D=3D 3) {
>  #ifdef CONFIG_MTRR
>  		unsigned int temp_size =3D size_total;
> -		int rc;
> =20
>  		/* Find the largest power-of-two */
>  		temp_size =3D roundup_pow_of_two(temp_size);
> =20
>  		/* Try and find a power of two to add */
>  		do {
> -			rc =3D mtrr_add(vesafb_fix.smem_start, temp_size,
> -				      MTRR_TYPE_WRCOMB, 1);
> +			par->wc_cookie =3D mtrr_add(vesafb_fix.smem_start,
> +						  temp_size,
> +						  MTRR_TYPE_WRCOMB, 1);
>  			temp_size >>=3D 1;
> -		} while (temp_size >=3D PAGE_SIZE && rc =3D=3D -EINVAL);
> +		} while (temp_size >=3D PAGE_SIZE && par->wc_cookie =3D=3D -EINVAL);=

>  #endif
>  		info->screen_base =3D ioremap_wc(vesafb_fix.smem_start, vesafb_fix.s=
mem_len);
>  	} else {
> @@ -462,6 +476,10 @@ static int vesafb_probe(struct platform_device *de=
v)
>  	fb_info(info, "%s frame buffer device\n", info->fix.id);
>  	return 0;
>  err:
> +#ifdef CONFIG_MTRR
> +	if (par->wc_cookie >=3D 0)
> +		mtrr_del(par->wc_cookie, 0, 0);
> +#endif
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
>  	framebuffer_release(info);

Hmm, this looks a bit odd... You're removing the pseudo_palette, and
using its memory for mtrr cookie?

 Tomi


--9mvovWKUSjlEIdRsOd5WBLtix8dEeGJDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXFlOAAoJEPo9qoy8lh71qYQP/3OEki6RrXsMgJ1gAOYvAvyE
ClqyuMe7oPn2UjIHl/LdZiH8bimosVnyh60xi2bv/RrJvkt09mK06ItBrGAWQnBe
+g3NCh+pL5gcjGfqeQFG2MuSfRrDYvKcrnDVxmBQdLD+1MS/MqeqOlMNTaUM7tC/
vnZuuO+Uk6ZPpCZagnVdHO+PSnjUMGcpqNYXcBibY2hRTIMsD3SDM0TIRS++4A6v
LGjaSXeW6IAI6K5ko/9O9cjbvHAl5ipEq3ZQMgdURl+oAX+BJhcKpCP6aDeuEgPc
sRY/a2aP5UpRkXIuqld8cYdUlP6aOS7uP/xUcCR+f99mbx2qAFk9rgZQFj2UWLBm
J1g8raVTnaSDb07AKB1zLwDWYBdOPId2MKFqMKDObmu6f7ChDmY6tLi+LU11Nemn
ix8cMdcSTGcovZ0hLZHzDX7q98wmyvKKznzwa4fbopaXrdCd06ij9R8CYuXMUrau
KhYQsOjMh3RsV65bfCF1xUuwC/zwJ6jD+iRnAcopqPEuGbHTRI3NU09sZLkaT8t+
fUm9LEZ021NMgeojxPxDwCAGd7VRYA5yLjDQeyw86VJMNgN1rJhJ0gDrGR3464rG
Pmr0TnEoIOeDQBuPMOzyhtOgF2/GCjiMWVp4a6kHUrBbHJ8GYmuUl0Rah1GaXzEh
Id8fDMDmR1MXy7NCh1ql
=eG8V
-----END PGP SIGNATURE-----

--9mvovWKUSjlEIdRsOd5WBLtix8dEeGJDp--
