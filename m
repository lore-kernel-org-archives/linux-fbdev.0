From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 09:51:16 +0000
Subject: Re: [PATCH 22/23] video: da8xx-fb: set upstream clock rate (if reqd)
Message-Id: <51CAB994.3030208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2KORDDVIJVVDQEOMLUOTP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-23-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-23-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2KORDDVIJVVDQEOMLUOTP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> LCDC IP has a clock divider to adjust pixel clock, this limits pixel
> clock range to fck/255 - fck/2(fck - rate of input clock to LCDC IP).
> In the case of AM335x, where this IP is present, default fck is not
> sufficient to provide normal pixel clock rates, hence rendering this
> driver unusable on AM335x.
>=20
> If input clock too is configurable, allowable range of pixel clock
> would increase. Here initially it is checked whether with present fck,
> divider in IP could be configured to obtain required rate, if not,
> fck is adjusted. This makes it usable on AM335x.
>=20
> Note:
> Another solution would be to model an inherited basic clock divider of
> CCF, an advantage would be a better possible resolution for pixel clk.
> And trying to instantiate a CCF clock would mean that to be consistent,=

> 3 bits being turned on to enable clocks of LCDC IP would have to be
> modeled as gate clocks. Now that would bring in a total of 4 clocks,
> including necessity to create a new inherited divider clock, and that
> mean a branch of clock tree would be present in LCDC driver. This
> would add complexity to LCDC driver bringing in considerable amount
> of clock handling code, and this would not bring in much advantage
> for existing use cases other than providing a higher resolution of
> pixel clock. And existing use cases work without relying on clock
> modeling. Another fact is that out of the two platform's using this
> driver DaVinci is not yet converted to CCF. In future if higher
> resolution of pixel clock is required, and probably after DaVinci is
> CCF'ed, modeling clock nodes inside driver may be considered.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   76 +++++++++++++++++++++++++++++++++++---=
--------
>  1 files changed, 58 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 5455682..09dfa12 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -133,6 +133,9 @@
>  #define WSI_TIMEOUT	50
>  #define PALETTE_SIZE	256
> =20
> +#define	CLK_MIN_DIV	2
> +#define	CLK_MAX_DIV	255
> +
>  static void __iomem *da8xx_fb_reg_base;
>  static struct resource *lcdc_regs;
>  static unsigned int lcd_revision;
> @@ -683,23 +686,21 @@ static void da8xx_fb_lcd_reset(void)
>  	}
>  }
> =20
> -static inline unsigned da8xx_fb_calc_clk_divider(struct da8xx_fb_par *=
par,
> -						 unsigned pixclock)
> -{
> -	return par->lcd_fck_rate / (PICOS2KHZ(pixclock) * 1000);
> -}
> -
> -static inline unsigned da8xx_fb_round_clk(struct da8xx_fb_par *par,
> -					  unsigned pixclock)
> +static int da8xx_fb_config_clk_divider(struct da8xx_fb_par *par,
> +					      unsigned div, unsigned rate)

I would suggest to use better names than 'div' and 'rate'. What div?
What rate?

>  {
> -	unsigned div;
> +	int ret;
> =20
> -	div =3D da8xx_fb_calc_clk_divider(par, pixclock);
> -	return KHZ2PICOS(par->lcd_fck_rate / (1000 * div));
> -}
> +	if (par->lcd_fck_rate !=3D rate) {
> +		ret =3D clk_set_rate(par->lcdc_clk, rate);
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(par->dev,
> +				"unable to set clock rate at %u\n", rate);
> +			return ret;
> +		}
> +		par->lcd_fck_rate =3D clk_get_rate(par->lcdc_clk);
> +	}

I think it would be good to require that the caller has calculated the
rate properly, and used clk_round_rate. So instead of silently storing
the actual clock rate to lcd_fck_rate, either fail or give a warning if
the resulting clock rate is different than the requested one.

> -static inline void da8xx_fb_config_clk_divider(unsigned div)
> -{
>  	/* Configure the LCD clock divisor. */
>  	lcdc_write(LCD_CLK_DIVISOR(div) |
>  			(LCD_RASTER_MODE & 0x1), LCD_CTRL_REG);
> @@ -707,14 +708,49 @@ static inline void da8xx_fb_config_clk_divider(un=
signed div)
>  	if (lcd_revision =3D=3D LCD_VERSION_2)
>  		lcdc_write(LCD_V2_DMA_CLK_EN | LCD_V2_LIDD_CLK_EN |
>  				LCD_V2_CORE_CLK_EN, LCD_CLK_ENABLE_REG);
> +
> +	return 0;
> +}
> +
> +static unsigned int da8xx_fb_calc_clk_divider(struct da8xx_fb_par *par=
,
> +					      unsigned pixclock,
> +					      unsigned *rate)
> +{
> +	unsigned div;
> +
> +	pixclock =3D PICOS2KHZ(pixclock) * 1000;
> +
> +	*rate =3D par->lcd_fck_rate;
> +
> +	if (pixclock < (*rate / CLK_MAX_DIV)) {
> +		*rate =3D clk_round_rate(par->lcdc_clk, pixclock * CLK_MAX_DIV);
> +		div =3D CLK_MAX_DIV;
> +	} else if (pixclock > (*rate / CLK_MIN_DIV)) {
> +		*rate =3D clk_round_rate(par->lcdc_clk, pixclock * CLK_MIN_DIV);
> +		div =3D CLK_MIN_DIV;
> +	} else {
> +		div =3D *rate / pixclock;
> +	}
> +
> +	return div;
>  }

If I understand correctly, the function returns the LCDC clock divider
and the fclk clock rate, calculated for the given pixclock.

What happens if this function is called with a pixel clock of 1Hz or
1GHz (ie. something not achievable)?

And wouldn't it be better to always set the fclk clock rate? Even if the
pixclock is in the range achieved with a divider between CLK_MIN_DIV and
CLK_MAX_DIV, it can be quite far from the requested clock rate.
Adjusting the fclk rate could give a much better match.

> -static inline void da8xx_fb_calc_config_clk_divider(struct da8xx_fb_pa=
r *par,
> +static inline int da8xx_fb_calc_config_clk_divider(struct da8xx_fb_par=
 *par,

Don't use inline. The compiler can decide if it's worth to inline a
function or not. I guess inline is fine for funcs like lcdc_read(), but
generally leave it for the compiler.

 Tomi



------enig2KORDDVIJVVDQEOMLUOTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyrmUAAoJEPo9qoy8lh71wiwP/3uaUpQY3nOGsDfC8xoKSNpw
nswdUbaLRefrtPhL4lK78zxb3VO85+yiMjUrT/erHdKAn/KgXMV7qLGvQsBi9tw2
avFylTcqX4xuP5EbkmlSsy6NTUjtVUbM8YtSTu4R8+sy+oGT/GCBIh9/jcBJf3Fr
WNzrjHmSapUKn+EBRQ7E9ahBzMjU34UYpRYVGuuPABrygSS8utCWtD1RxFg/FV6p
3cv8P3pi+z1N14lzISBGa8IZXRss22GwH+JEVHKfiRuN2TOaD4gxygHoI3cnCv+0
HhTXfubTUYXn3gtrt0jKB0yrWa3rJii2y1q7R7ymYKT3veb02XdHFDmWK4/NvNCC
BvKGOnBDNvxWvANq5cUk9AertlR963eHspfJvBBTVLLLOC5rKkIvftT5F2+GWVR5
E5gA0kdS1NSwOXrScgDPyqCcxUQSu5sIWrmEpJ1ZTrt8omFtFU4TnUVHEKy/RNJw
6R9O7u00ehCUJ0+Zi/NCUeJIZYN53O2GS5QevF3aMHq3VHLd434PaKsOTVfEUmTV
YcyfZxxJRW3jgOHaQuGGlEgrf9YHl8y5Wys5ZcYoK64dGs25GjP/+bG5kzvXC08m
uNdaSoFmoGKKvtQfnImFpxV0Wyrx5FMjYwR7EllP541/gRHt6uIffGzaQnSDKGk+
L86+2PbbzFfhXTbSr6hb
=+RD1
-----END PGP SIGNATURE-----

------enig2KORDDVIJVVDQEOMLUOTP--
