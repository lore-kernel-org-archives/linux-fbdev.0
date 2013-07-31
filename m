From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Jul 2013 11:38:52 +0000
Subject: Re: [PATCH v2 10/24] video: da8xx-fb: fb_set_par support
Message-Id: <51F8F74C.5080707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ET6KGAto4O59tQvQD8m3eF05bhA11A5WJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-11-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-11-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--ET6KGAto4O59tQvQD8m3eF05bhA11A5WJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/07/13 21:26, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> fb_set_par helps in runtime configuration of lcd controller like
> changing resolution, pixel clock etc. (eg. using fbset utility)
>=20
> Reconfigure lcd controller based on information passed by framework.
> Enable raster back if it was already enabled.
>=20
> As fb_set_par would get invoked indirectly from probe via fb_set_var,
> remove existing lcdc initialization in probe and do lcdc reset in
> probe so that reset happens only at the begining.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   60 +++++++++++++++++++++++++++++++++++++-=
-------
>  1 files changed, 49 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 8d73730..b25b810 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -243,6 +243,11 @@ static struct fb_videomode known_lcd_panels[] =3D =
{
>  	},
>  };
> =20
> +static inline bool da8xx_fb_is_raster_enabled(void)
> +{
> +	return !!(lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE);
> +}

See Documentation/CodingStyle about inline.

I think, generally, it's better not to use inline at all in normal
functions. Let the compiler decide. Even more so with funcs like
da8xx_fb_is_raster_enabled(), which I guess is only used rarely.

There are some inlines added in other patches in the series also.

>  /* Enable the Raster Engine of the LCD Controller */
>  static inline void lcd_enable_raster(void)
>  {
> @@ -665,9 +670,6 @@ static int fb_setcolreg(unsigned regno, unsigned re=
d, unsigned green,
> =20
>  static void da8xx_fb_lcd_reset(void)
>  {
> -	/* Disable the Raster if previously Enabled */
> -	lcd_disable_raster(false);
> -
>  	/* DMA has to be disabled */
>  	lcdc_write(0, LCD_DMA_CTRL_REG);
>  	lcdc_write(0, LCD_RASTER_CTRL_REG);
> @@ -720,8 +722,6 @@ static int lcd_init(struct da8xx_fb_par *par, const=
 struct lcd_ctrl_config *cfg,
>  	u32 bpp;
>  	int ret =3D 0;
> =20
> -	da8xx_fb_lcd_reset();
> -
>  	da8xx_fb_calc_config_clk_divider(par, panel);
> =20
>  	if (panel->sync & FB_SYNC_CLK_INVERT)
> @@ -1201,9 +1201,52 @@ static int da8xx_pan_display(struct fb_var_scree=
ninfo *var,
>  	return ret;
>  }
> =20
> +static int da8xxfb_set_par(struct fb_info *info)
> +{
> +	struct da8xx_fb_par *par =3D info->par;
> +	int ret;
> +	bool raster =3D da8xx_fb_is_raster_enabled();
> +
> +	if (raster)
> +		lcd_disable_raster(true);
> +	else
> +		lcd_disable_raster(false);

This looks odd. If raster is enabled, you disable it. And if raster is
disabled, you disable it.

 Tomi



--ET6KGAto4O59tQvQD8m3eF05bhA11A5WJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+PdMAAoJEPo9qoy8lh71pUEP/AloOpTEzlssqFZ2w3dcfuKZ
LAwvFsRwmc0mMdFCCPHKeA49+jH8zDkngQ/IgHw399L2Oz9GANGhIAFhehZhvLUE
LgdYOKG946ONM+wqY6Vwn1DzdkN0AC2wcS4Kt4WndVPBrC5jpXbVQOq8jGoPuhWg
QBSuYtbBxJu5az3e2PzzA5/NWVXAXdOBwQDS+YJxEPintq1AOLhE5S+vwieO+143
2dfC3On+8Ri+ydgqYJWmF2tFw5gA8EFsB+HTn5bSeweIDOC0Jfq2YqfC4KQlbsfa
U57BkMi4dC3nJY+ikq+RIU727xYRQlaV5MbHN0g2uOs2MQmSCpNtqZeisLbgkxcl
updExryyWGR6ehnUROiWwP0KVlEO1CFT50NV15snsH7Vb1OzKrm5SMPbgKx1Meyd
dyt9ibdpRguLHurHemREYxEMGa6zvEuRjnzcbuC9Wrt4IRR+1qijm+1N5Piaa1h1
1sdzE3bH4Esb9sTuo5f6BwRMXsHjUvYdK+ip1IJSB9eSBhOu5u6ABH0lgrosjH9e
mNPgCTzlevDjs7i5TMl5ZG1C8/dKv2qc20w4+ZSX10dSKxqWuxPKgPrKrTRmOYkn
fsl7NagM6R5z80gyzJiPPuPxuDHW1aPiLdXRoHzo9uSixTTt2JdbAasceyMmOAa9
Jp9lXy9R3AWIHz7n1o9a
=WZrg
-----END PGP SIGNATURE-----

--ET6KGAto4O59tQvQD8m3eF05bhA11A5WJ--
