From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 18 Mar 2015 19:27:19 +0000
Subject: Re: [PATCHv4 04/10] fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150318192719.GV4638@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gPQW1Pk7T/0rhUBV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-5-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1426525918-12745-5-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--gPQW1Pk7T/0rhUBV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Mar 16, 2015 at 06:11:52PM +0100, Thomas Niederpr=FCm wrote:
> The 130X controllers are very similar from the configuration point of vie=
w.
> The configuration registers for the SSD1305/6/7 are bit identical (except=
 the
> the VHCOM register and the the default values for clock setup register). =
This
> patch unifies the init code of the controller and adds hardware specific
> properties to DT that are needed to correctly initialize the device.
>=20
> The SSD130X can be wired to the OLED panel in various ways. Even for the
> same controller this wiring can differ from one display module to another
> and can not be probed by software. The added DT properties reflect these
> hardware decisions of the display module manufacturer.
> The 'com-sequential', 'com-lrremap' and 'com-invdir' values define differ=
ent
> possibilities for the COM signals pin configuration and readout direction
> of the video memory. The 'segment-no-remap' allows the inversion of the
> memory-to-pin mapping ultimately inverting the order of the controllers
> output pins. The 'prechargepX' values need to be adapted according the
> capacitance of the OLEDs pixel cells.
>=20
> So far these hardware specific bits are hard coded in the init code, maki=
ng
> the driver usable only for one certain wiring of the controller. This pat=
ch
> makes the driver usable with all possible hardware setups, given a valid =
hw
> description in DT. If these values are not set in DT the default values,
> as they are set in the ssd1307 init code right now, are used. This implies
> that without the corresponding DT property "segment-no-remap" the segment
> remap of the ssd130X controller gets activated. Even though this is not t=
he
> default behaviour according to the datasheet it maintains backward
> compatibility with older DTBs.
>=20
> Note that the SSD1306 does not seem to be using the configuration written=
 to
> the registers at all. Therefore this patch does not try to maintain these
> values without changes in DT. For reference an example is added to the DT
> bindings documentation that reproduces the configuration that is set in t=
he
> current init code.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

This looks mostly fine, thanks for your effort on this.

> ---
>  .../devicetree/bindings/video/ssd1307fb.txt        |  21 +++
>  drivers/video/fbdev/ssd1307fb.c                    | 195 ++++++++++++---=
------
>  2 files changed, 137 insertions(+), 79 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt b/Docu=
mentation/devicetree/bindings/video/ssd1307fb.txt
> index 7a12542..be27562 100644
> --- a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
> @@ -15,6 +15,16 @@ Required properties:
> =20
>  Optional properties:
>    - reset-active-low: Is the reset gpio is active on physical low?
> +  - solomon,segment-no-remap: Display needs normal (non-inverted) data c=
olumn
> +                              to segment mapping
> +  - solomon,com-sequential: Display uses sequential COM pin configuration
> +  - solomon,com-lrremap: Display uses left-right COM pin remap
> +  - solomon,com-invdir: Display uses inverted COM pin scan direction
> +  - solomon,com-offset: Offset of the first COM pin wired to the panel

Documenting the offset unit would be fine.

> +  - solomon,prechargep1: Length of deselect period (phase 1) in clock cy=
cles.
> +  - solomon,prechargep2: Length of precharge period (phase 2) in clock c=
ycles.
> +                         This needs to be the higher, the higher the cap=
acitance
> +                         of the OLED's pixels is
> =20
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
> =20
> @@ -26,3 +36,14 @@ ssd1307: oled@3c {
>          reset-gpios =3D <&gpio2 7>;
>          reset-active-low;
>  };
> +
> +ssd1306: oled@3c {
> +        compatible =3D "solomon,ssd1306fb-i2c";
> +        reg =3D <0x3c>;
> +        pwms =3D <&pwm 4 3000>;
> +        reset-gpios =3D <&gpio2 7>;
> +        reset-active-low;
> +        solomon,com-lrremap;
> +        solomon,com-invdir;
> +        solomon,com-offset =3D <32>;
> +};
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 8d34c56..9a66118 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -16,6 +16,9 @@
>  #include <linux/pwm.h>
>  #include <linux/delay.h>
> =20
> +#define DEVID_SSD1306 6
> +#define DEVID_SSD1307 7
> +
>  #define SSD1307FB_DATA			0x40
>  #define SSD1307FB_COMMAND		0x80
> =20
> @@ -38,22 +41,38 @@
>  #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
>  #define	SSD1307FB_SET_VCOMH		0xdb
> =20
> +static u_int contrast =3D 128;
> +module_param(contrast, uint, S_IRUGO);
> +

Why is this patch adding a contrast parameter? You don't even mention
it in your commit log. This should be a separate patch.

>  struct ssd1307fb_par;
> =20
> -struct ssd1307fb_ops {
> -	int (*init)(struct ssd1307fb_par *);
> -	int (*remove)(struct ssd1307fb_par *);
> +struct ssd1307fb_deviceinfo {
> +	int device_id;
> +	u32 default_vcomh;
> +	u32 default_dclk_div;
> +	u32 default_dclk_frq;
>  };
> =20
>  struct ssd1307fb_par {
> +	u32 com_invdir;
> +	u32 com_lrremap;
> +	u32 com_offset;
> +	u32 com_seq;
> +	u32 contrast;
> +	u32 dclk_div;
> +	u32 dclk_frq;
> +	struct ssd1307fb_deviceinfo *device_info;
>  	struct i2c_client *client;
>  	u32 height;
>  	struct fb_info *info;
> -	struct ssd1307fb_ops *ops;
>  	u32 page_offset;
> +	u32 prechargep1;
> +	u32 prechargep2;
>  	struct pwm_device *pwm;
>  	u32 pwm_period;
>  	int reset;
> +	u32 seg_remap;
> +	u32 vcomh;
>  	u32 width;
>  };
> =20
> @@ -254,69 +273,46 @@ static struct fb_deferred_io ssd1307fb_defio =3D {
>  	.deferred_io	=3D ssd1307fb_deferred_io,
>  };
> =20
> -static int ssd1307fb_ssd1307_init(struct ssd1307fb_par *par)
> +static int ssd1307fb_init(struct ssd1307fb_par *par)
>  {
>  	int ret;
> +	u32 precharge, dclk, com_invdir, compins;
> =20
> -	par->pwm =3D pwm_get(&par->client->dev, NULL);
> -	if (IS_ERR(par->pwm)) {
> -		dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
> -		return PTR_ERR(par->pwm);
> -	}
> -
> -	par->pwm_period =3D pwm_get_period(par->pwm);
> -	/* Enable the PWM */
> -	pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
> -	pwm_enable(par->pwm);
> -
> -	dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> -		par->pwm->pwm, par->pwm_period);
> -
> -	/* Map column 127 of the OLED to segment 0 */
> -	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SEG_REMAP_ON);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Turn on the display */
> -	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int ssd1307fb_ssd1307_remove(struct ssd1307fb_par *par)
> -{
> -	pwm_disable(par->pwm);
> -	pwm_put(par->pwm);
> -	return 0;
> -}
> +	if (par->device_info->device_id =3D=3D DEVID_SSD1307) {
> +		par->pwm =3D pwm_get(&par->client->dev, NULL);
> +		if (IS_ERR(par->pwm)) {
> +			dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
> +			return PTR_ERR(par->pwm);
> +		}
> =20
> -static struct ssd1307fb_ops ssd1307fb_ssd1307_ops =3D {
> -	.init	=3D ssd1307fb_ssd1307_init,
> -	.remove	=3D ssd1307fb_ssd1307_remove,
> -};
> +		par->pwm_period =3D pwm_get_period(par->pwm);
> +		/* Enable the PWM */
> +		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
> +		pwm_enable(par->pwm);
> =20
> -static int ssd1307fb_ssd1306_init(struct ssd1307fb_par *par)
> -{
> -	int ret;
> +		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> +			par->pwm->pwm, par->pwm_period);
> +	};
> =20
>  	/* Set initial contrast */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x7f);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Set COM direction */
> -	ret =3D ssd1307fb_write_cmd(par->client, 0xc8);
> +	ret =3D ssd1307fb_write_cmd(par->client, par->contrast);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set segment re-map */
> -	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SEG_REMAP_ON);
> +	if (par->seg_remap) {
> +		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SEG_REMAP_ON);
> +		if (ret < 0)
> +			return ret;
> +	};
> +
> +	/* Set COM direction */
> +	com_invdir =3D 0xc0 | (par->com_invdir & 0xf) << 3;
> +	ret =3D ssd1307fb_write_cmd(par->client,  com_invdir);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -334,34 +330,38 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_=
par *par)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x20);
> +	ret =3D ssd1307fb_write_cmd(par->client, par->com_offset);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set clock frequency */
> +	dclk =3D (par->dclk_div & 0xf) | (par->dclk_frq & 0xf) << 4;
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_CLOCK_FREQ);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0xf0);
> +	ret =3D ssd1307fb_write_cmd(par->client, dclk);

It would make more sense to assign the variable where you use it.

>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set precharge period in number of ticks from the internal clock */
> +	precharge =3D (par->prechargep1 & 0xf) | (par->prechargep2 & 0xf) << 4;
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PRECHARGE_PERIOD=
);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x22);
> +	ret =3D ssd1307fb_write_cmd(par->client, precharge);

Here too.

>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set COM pins configuration */
> +	compins =3D 0x02 | (!par->com_seq & 0x1) << 4
> +				   | (par->com_lrremap & 0x1) << 5;
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COM_PINS_CONFIG);
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x22);
> +	ret =3D ssd1307fb_write_cmd(par->client, compins);

And here.

>  	if (ret < 0)
>  		return ret;
> =20
> @@ -370,18 +370,20 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_=
par *par)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x49);
> +	ret =3D ssd1307fb_write_cmd(par->client, par->vcomh);
>  	if (ret < 0)
>  		return ret;
> =20
> -	/* Turn on the DC-DC Charge Pump */
> -	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
> -	if (ret < 0)
> -		return ret;
> +	if (par->device_info->device_id =3D=3D DEVID_SSD1306) {
> +		/* Turn on the DC-DC Charge Pump */
> +		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
> +		if (ret < 0)
> +			return ret;
> =20
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x14);
> -	if (ret < 0)
> -		return ret;
> +		ret =3D ssd1307fb_write_cmd(par->client, 0x14);
> +		if (ret < 0)
> +			return ret;
> +	};
> =20
>  	/* Switch to horizontal addressing mode */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
> @@ -393,6 +395,7 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_pa=
r *par)
>  	if (ret < 0)
>  		return ret;
> =20
> +    /* Set column range */

The indentation is wrong.

>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
>  	if (ret < 0)
>  		return ret;
> @@ -405,6 +408,7 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_pa=
r *par)
>  	if (ret < 0)
>  		return ret;
> =20
> +    /* Set page range */

Here too.

>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
>  	if (ret < 0)
>  		return ret;
> @@ -426,18 +430,28 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_=
par *par)
>  	return 0;
>  }
> =20
> -static struct ssd1307fb_ops ssd1307fb_ssd1306_ops =3D {
> -	.init	=3D ssd1307fb_ssd1306_init,
> +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1306_deviceinfo =3D {
> +	.device_id  =3D DEVID_SSD1306,
> +	.default_vcomh =3D 0x20,
> +	.default_dclk_div =3D 0,
> +	.default_dclk_frq =3D 8,
> +};
> +
> +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1307_deviceinfo =3D {
> +	.device_id  =3D DEVID_SSD1307,
> +	.default_vcomh =3D 0x20,
> +	.default_dclk_div =3D 1,
> +	.default_dclk_frq =3D 12,
>  };
> =20
>  static const struct of_device_id ssd1307fb_of_match[] =3D {
>  	{
>  		.compatible =3D "solomon,ssd1306fb-i2c",
> -		.data =3D (void *)&ssd1307fb_ssd1306_ops,
> +		.data =3D (void *)&ssd1307fb_ssd1306_deviceinfo,
>  	},
>  	{
>  		.compatible =3D "solomon,ssd1307fb-i2c",
> -		.data =3D (void *)&ssd1307fb_ssd1307_ops,
> +		.data =3D (void *)&ssd1307fb_ssd1307_deviceinfo,

Do we need this ID? Wouldn't it make more sense to pass the pointer to
the struct we need to use?

>  	},
>  	{},
>  };
> @@ -468,8 +482,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	par->info =3D info;
>  	par->client =3D client;
> =20
> -	par->ops =3D (struct ssd1307fb_ops *)of_match_device(ssd1307fb_of_match,
> -							   &client->dev)->data;
> +	par->device_info =3D (struct ssd1307fb_deviceinfo *)of_match_device(
> +			ssd1307fb_of_match, &client->dev)->data;
> =20
>  	par->reset =3D of_get_named_gpio(client->dev.of_node,
>  					 "reset-gpios", 0);
> @@ -487,6 +501,27 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset=
))
>  		par->page_offset =3D 1;
> =20
> +	if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
> +		par->com_offset =3D 0;
> +
> +	if (of_property_read_u32(node, "solomon,prechargep1", &par->prechargep1=
))
> +		par->prechargep1 =3D 2;
> +
> +	if (of_property_read_u32(node, "solomon,prechargep2", &par->prechargep2=
))
> +		par->prechargep2 =3D 0;
> +
> +	par->seg_remap =3D !of_property_read_bool(node, "solomon,segment-no-rem=
ap");
> +	par->com_seq =3D of_property_read_bool(node, "solomon,com-sequential");
> +	par->com_lrremap =3D of_property_read_bool(node, "solomon,com-lrremap");
> +	par->com_invdir =3D of_property_read_bool(node, "solomon,com-invdir");
> +
> +	par->contrast =3D contrast;
> +	par->vcomh =3D par->device_info->default_vcomh;
> +
> +	/* Setup display timing */
> +	par->dclk_div =3D par->device_info->default_dclk_div;
> +	par->dclk_frq =3D par->device_info->default_dclk_frq;
> +
>  	vmem_size =3D par->width * par->height / 8;
> =20
>  	vmem =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> @@ -539,11 +574,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	gpio_set_value(par->reset, 1);
>  	udelay(4);
> =20
> -	if (par->ops->init) {
> -		ret =3D par->ops->init(par);
> -		if (ret)
> -			goto reset_oled_error;
> -	}
> +	ret =3D ssd1307fb_init(par);
> +	if (ret)
> +		goto reset_oled_error;
> =20
>  	ret =3D register_framebuffer(info);
>  	if (ret) {
> @@ -556,8 +589,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	return 0;
> =20
>  panel_init_error:
> -	if (par->ops->remove)
> -		par->ops->remove(par);
> +	if (par->device_info->device_id =3D=3D DEVID_SSD1307) {
> +		pwm_disable(par->pwm);
> +		pwm_put(par->pwm);
> +	};
>  reset_oled_error:
>  	fb_deferred_io_cleanup(info);
>  fb_alloc_error:
> @@ -571,8 +606,10 @@ static int ssd1307fb_remove(struct i2c_client *clien=
t)
>  	struct ssd1307fb_par *par =3D info->par;
> =20
>  	unregister_framebuffer(info);
> -	if (par->ops->remove)
> -		par->ops->remove(par);
> +	if (par->device_info->device_id =3D=3D DEVID_SSD1307) {
> +		pwm_disable(par->pwm);
> +		pwm_put(par->pwm);
> +	};
>  	fb_deferred_io_cleanup(info);
>  	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
>  	framebuffer_release(info);
> --=20
> 2.3.0
>=20

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--gPQW1Pk7T/0rhUBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCdGXAAoJEBx+YmzsjxAgtkYP/Ar3o+MGcTCueiNmOzBPWmKO
bCr81P4zp5PfAt7EnU6pHVRAuUBPhOARGTVhFkZGYlXFoj9/CwP0VWgc50V4w+Ea
4l1dBxAxZ2zXEG2z5q1U4bf6T+5Ly3dUu9iW9ZIfSmrKJc+IWrR17GDye81ljnud
Fqf7jMJLqlN7We817qFCtflL/RoQwMU2MaK0xPinJQyFAGAraWSn3hOLX/QFxZUs
wW6Op1LpD/po+NZvrvPIKz6TQjEZrHDzsD7Uj47nQuupP5M1neHfxuD2HEUGe4aC
39zL4JM0XaPjvwld6BkHv6bVo/x5Tu6F5DNlG7dBaYQjsVXYAgRRuJR4JT2qIJL9
psz6HsocgNXgQfO/duw5avgkzP2EOeIeEpFCaLGQ+q70TDgVJUl1GFkvWatVlMg4
9wJGXBFyRnJQsYkJ00DIstzvlN+R3P/qPp6Twb2iDhQ9S6cCd7HTdi0TPL7+/5aR
/AP7NMYOPlmaHOHsOhQjjfJgDaGNZhupMhNnz3rbuY5C+MbDd7x5R5Kx/TZYkMSS
mfQOAAfX+yZbNdULPrUyFVu98jmBWeZnxDOLmHyCmwWDgB+Ilf2px+CibSEX/qbR
Wcnm4cBa8aNcwVGWglOWql+7B49nFtuAYJNpjlNUwOE5WfAtV0ADAZeMXCafZrNF
ajmFkl+rk6oSrJa9QEo5
=8Xug
-----END PGP SIGNATURE-----

--gPQW1Pk7T/0rhUBV--
