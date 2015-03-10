From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 12:02:37 +0000
Subject: Re: [PATCH v2] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <54FEDD5D.4000104@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SUD3jMKKRHuk0DSNffI7BT3HCqMqod5g5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425452771-19313-1-git-send-email-Ying.Liu@freescale.com>
In-Reply-To: <1425452771-19313-1-git-send-email-Ying.Liu@freescale.com>
To: Liu Ying <Ying.Liu@freescale.com>, linux-fbdev@vger.kernel.org
Cc: Peter Chen <peter.chen@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

--SUD3jMKKRHuk0DSNffI7BT3HCqMqod5g5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/03/15 09:06, Liu Ying wrote:
> The LCDIF engines embedded in i.MX6sl and i.MX6sx SoCs need the axi clo=
ck
> as the engine's system clock.  The clock should be enabled when accessi=
ng
> LCDIF registers, otherwise the kernel would hang up.  We should also ke=
ep
> the clock being enabled when the engine is being active to scan out fra=
mes

The text above is a bit confusing. Maybe just "... also keep the clock
enabled when..."

> from memory.  This patch makes sure the axi clock is enabled when acces=
sing
> registers so that the kernel hang up issue can be fixed.
>=20
> Reported-by: Peter Chen <peter.chen@freescale.com>
> Tested-by: Peter Chen <peter.chen@freescale.com>
> Cc: <stable@vger.kernel.org> # 3.19+
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v1->v2:
> * Add 'Tested-by: Peter Chen <peter.chen@freescale.com>' tag.
> * Add 'Cc: <stable@vger.kernel.org> # 3.19+' tag.
>=20
>  drivers/video/fbdev/mxsfb.c | 70 ++++++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 56 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index f8ac4a4..a8cf3b2 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -316,6 +316,18 @@ static int mxsfb_check_var(struct fb_var_screeninf=
o *var,
>  	return 0;
>  }
> =20
> +static inline void mxsfb_enable_axi_clk(struct mxsfb_info *host)
> +{
> +	if (host->clk_axi)
> +		clk_prepare_enable(host->clk_axi);
> +}
> +
> +static inline void mxsfb_disable_axi_clk(struct mxsfb_info *host)
> +{
> +	if (host->clk_axi)
> +		clk_disable_unprepare(host->clk_axi);
> +}
> +
>  static void mxsfb_enable_controller(struct fb_info *fb_info)
>  {
>  	struct mxsfb_info *host =3D to_imxfb_host(fb_info);
> @@ -333,14 +345,13 @@ static void mxsfb_enable_controller(struct fb_inf=
o *fb_info)
>  		}
>  	}
> =20
> -	if (host->clk_axi)
> -		clk_prepare_enable(host->clk_axi);
> -
>  	if (host->clk_disp_axi)
>  		clk_prepare_enable(host->clk_disp_axi);
>  	clk_prepare_enable(host->clk);
>  	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
> =20
> +	mxsfb_enable_axi_clk(host);
> +

Is there some reason to move the clk enable to a different place here?

>  	/* if it was disabled, re-enable the mode again */
>  	writel(CTRL_DOTCLK_MODE, host->base + LCDC_CTRL + REG_SET);
> =20
> @@ -380,11 +391,11 @@ static void mxsfb_disable_controller(struct fb_in=
fo *fb_info)
>  	reg =3D readl(host->base + LCDC_VDCTRL4);
>  	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
> =20
> +	mxsfb_disable_axi_clk(host);
> +
>  	clk_disable_unprepare(host->clk);
>  	if (host->clk_disp_axi)
>  		clk_disable_unprepare(host->clk_disp_axi);
> -	if (host->clk_axi)
> -		clk_disable_unprepare(host->clk_axi);

And same here for disable.

>  	host->enabled =3D 0;
> =20
> @@ -421,6 +432,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		mxsfb_disable_controller(fb_info);
>  	}
> =20
> +	mxsfb_enable_axi_clk(host);
> +
>  	/* clear the FIFOs */
>  	writel(CTRL1_FIFO_CLEAR, host->base + LCDC_CTRL1 + REG_SET);
> =20
> @@ -438,6 +451,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		ctrl |=3D CTRL_SET_WORD_LENGTH(3);
>  		switch (host->ld_intf_width) {
>  		case STMLCDIF_8BIT:
> +			mxsfb_disable_axi_clk(host);
>  			dev_err(&host->pdev->dev,
>  					"Unsupported LCD bus width mapping\n");
>  			return -EINVAL;
> @@ -451,6 +465,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		writel(CTRL1_SET_BYTE_PACKAGING(0x7), host->base + LCDC_CTRL1);
>  		break;
>  	default:
> +		mxsfb_disable_axi_clk(host);
>  		dev_err(&host->pdev->dev, "Unhandled color depth of %u\n",
>  				fb_info->var.bits_per_pixel);
>  		return -EINVAL;
> @@ -504,6 +519,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  			fb_info->fix.line_length * fb_info->var.yoffset,
>  			host->base + host->devdata->next_buf);
> =20
> +	mxsfb_disable_axi_clk(host);
> +
>  	if (reenable)
>  		mxsfb_enable_controller(fb_info);
> =20
> @@ -582,10 +599,16 @@ static int mxsfb_pan_display(struct fb_var_screen=
info *var,
> =20
>  	offset =3D fb_info->fix.line_length * var->yoffset;
> =20
> +	if (!host->enabled)
> +		mxsfb_enable_axi_clk(host);
> +
>  	/* update on next VSYNC */
>  	writel(fb_info->fix.smem_start + offset,
>  			host->base + host->devdata->next_buf);
> =20
> +	if (!host->enabled)
> +		mxsfb_disable_axi_clk(host);
> +

Why do you check for host->enabled here, but not elsewhere?

 Tomi



--SUD3jMKKRHuk0DSNffI7BT3HCqMqod5g5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/t1dAAoJEPo9qoy8lh71rBgP/i8vO3k2VHNg1zO/vPYEpq1G
R5yYcd9LCMebiQJ6UJrKG+tt3cpBUjh2W2ku4rBZMIYkkPOH2YIc425B/WiHWOPt
Z2HwDZScmzmSUVdCslTzUILlj9Q2yKGXWozHed2YPdw49dWL9+44i8vDsSavInSL
g2Jo3rOPlh6MdcLKHa+9OCTryL3PVX0An/KbXATL3Eku4bTBgl9CjayerSE44pZt
Ivc5lWPquPwPBKTa2ORiZZqwBvFJWnZY02mM/0DJg8gBj6o6t8v/U6OtrhmKCjbt
ZO29lGEtW0R2QtVZ62QZoRG1r13hnCnACDHv5tXmM5+TiZRA5evUbiVz5JRL+zmD
QDEI/+nXRRI4hUJbGX4HaMQxOGsn/HkgtAyjHgsLtTYZrKl9+/0QkCUXlZr58nqf
MTgFbPTlNpcw6qsA9rqImVE5o96TnBjJBoF5fqTsvWDAUmxRMX0jYzua+pgBh8Id
jg0vT6SuKrr2nrSpgiPQx1Dewiop30i1m2JMmgQtC/29e6mUufi3eXdvfv3d6Yi9
pCGRdTZq+rD9a1bxbf3Exmkz1Ntympu7akYqujvHwfBkgYxE/PUrBOr90zpjD5qJ
UBaLM8wFkJYJrD1hPSdPFicoVZTGx/leZ0lnunRoVcEBEnVDbFFPpnMjrzGB23bW
lUQBFJErKmZF0apPnQXs
=1Qpv
-----END PGP SIGNATURE-----

--SUD3jMKKRHuk0DSNffI7BT3HCqMqod5g5--
