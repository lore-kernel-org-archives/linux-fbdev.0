From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Sat, 21 Mar 2015 09:15:14 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <20150321091514.GA22926@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wrote:
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/a=
ty/atyfb_base.c
> index 8025624..8875e56 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
> =20
>  #ifdef CONFIG_MTRR
>  	par->mtrr_aper =3D -1;
> -	par->mtrr_reg =3D -1;
>  	if (!nomtrr) {
> -		/* Cover the whole resource. */
> -		par->mtrr_aper =3D mtrr_add(par->res_start, par->res_size,
> +		par->mtrr_aper =3D mtrr_add(info->fix.smem_start,
> +					  info->fix.smem_len,
>  					  MTRR_TYPE_WRCOMB, 1);

MTRRs need power of two size, so how is this supposed to work?

> -		if (par->mtrr_aper >=3D 0 && !par->aux_start) {
> -			/* Make a hole for mmio. */
> -			par->mtrr_reg =3D mtrr_add(par->res_start + 0x800000 -
> -						 GUI_RESERVE, GUI_RESERVE,
> -						 MTRR_TYPE_UNCACHABLE, 1);
> -			if (par->mtrr_reg < 0) {
> -				mtrr_del(par->mtrr_aper, 0, 0);
> -				par->mtrr_aper =3D -1;
> -			}
> -		}
>  	}
>  #endif
> =20
> @@ -2776,10 +2765,6 @@ aty_init_exit:
>  	par->pll_ops->set_pll(info, &par->saved_pll);
> =20
>  #ifdef CONFIG_MTRR
> -	if (par->mtrr_reg >=3D 0) {
> -		mtrr_del(par->mtrr_reg, 0, 0);
> -		par->mtrr_reg =3D -1;
> -	}
>  	if (par->mtrr_aper >=3D 0) {
>  		mtrr_del(par->mtrr_aper, 0, 0);
>  		par->mtrr_aper =3D -1;
> @@ -3466,7 +3451,7 @@ static int atyfb_setup_generic(struct pci_dev *pdev=
, struct fb_info *info,
>  	}
> =20
>  	info->fix.mmio_start =3D raddr;
> -	par->ati_regbase =3D ioremap(info->fix.mmio_start, 0x1000);
> +	par->ati_regbase =3D ioremap_nocache(info->fix.mmio_start, 0x1000);
>  	if (par->ati_regbase =3D NULL)
>  		return -ENOMEM;
> =20
> @@ -3491,6 +3476,8 @@ static int atyfb_setup_generic(struct pci_dev *pdev=
, struct fb_info *info,
>  	info->fix.smem_start =3D addr;
>  	info->fix.smem_len =3D 0x800000;
> =20
> +	aty_fudge_framebuffer_len(info);
> +
>  	info->screen_base =3D ioremap(info->fix.smem_start, info->fix.smem_len);
>  	if (info->screen_base =3D NULL) {
>  		ret =3D -ENOMEM;
> @@ -3563,6 +3550,7 @@ static int atyfb_pci_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
>  	}
>  	par =3D info->par;
> +	par->bus_type =3D PCI;
>  	info->fix =3D atyfb_fix;
>  	info->device =3D &pdev->dev;
>  	par->pci_id =3D pdev->device;
> @@ -3732,10 +3720,6 @@ static void atyfb_remove(struct fb_info *info)
>  #endif
> =20
>  #ifdef CONFIG_MTRR
> -	if (par->mtrr_reg >=3D 0) {
> -		mtrr_del(par->mtrr_reg, 0, 0);
> -		par->mtrr_reg =3D -1;
> -	}
>  	if (par->mtrr_aper >=3D 0) {
>  		mtrr_del(par->mtrr_aper, 0, 0);
>  		par->mtrr_aper =3D -1;
> --=20
> 2.3.2.209.gd67f9d5.dirty
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
