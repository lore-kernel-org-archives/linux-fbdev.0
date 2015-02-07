From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 07 Feb 2015 10:42:25 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <20150207104225.GM2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RNRUMt0ZF5Yaq/Aq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
To: niederp@physik.uni-kl.de
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 06, 2015 at 11:28:08PM +0100, niederp@physik.uni-kl.de wrote:
> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>=20
> This patches unifies the init code for the ssd130X chips and
> adds device tree bindings to describe the hardware configuration
> of the used controller. This gets rid of the magic bit values
> used in the init code so far.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  .../devicetree/bindings/video/ssd1307fb.txt        |  11 +
>  drivers/video/fbdev/ssd1307fb.c                    | 243 ++++++++++++++-=
------
>  2 files changed, 174 insertions(+), 80 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt b/Docu=
mentation/devicetree/bindings/video/ssd1307fb.txt
> index 7a12542..1230f68 100644
> --- a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
> @@ -15,6 +15,17 @@ Required properties:
> =20
>  Optional properties:
>    - reset-active-low: Is the reset gpio is active on physical low?
> +  - solomon,segment-remap: Invert the order of data column to segment ma=
pping
> +  - solomon,offset: Map the display start line to one of COM0 - COM63
> +  - solomon,contrast: Set initial contrast of the display
> +  - solomon,prechargep1: Set the duration of the precharge period phase1
> +  - solomon,prechargep2: Set the duration of the precharge period phase2
> +  - solomon,com-alt: Enable/disable alternate COM pin configuration
> +  - solomon,com-lrremap: Enable/disable left-right remap of COM pins
> +  - solomon,com-invdir: Invert COM scan direction
> +  - solomon,vcomh: Set VCOMH regulator voltage
> +  - solomon,dclk-div: Set display clock divider
> +  - solomon,dclk-frq: Set display clock frequency

I'm sorry, but this is the wrong approach, for at least two reasons:
you broke all existing users of that driver, which is a clear no-go,
and the DT itself should not contain any direct mapping of the
registers.


> =20
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
> =20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 3d6611f..4f435aa 100644
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
> @@ -40,20 +43,33 @@
> =20
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
> +	u32 com_alt;
> +	u32 com_invdir;
> +	u32 com_lrremap;
> +	u32 contrast;
> +	u32 dclk_div;
> +	u32 dclk_frq;
> +	struct ssd1307fb_deviceinfo *device_info;
>  	struct i2c_client *client;
>  	u32 height;
>  	struct fb_info *info;
> -	struct ssd1307fb_ops *ops;
> +	u32 offset;
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
> @@ -254,127 +270,151 @@ static struct fb_deferred_io ssd1307fb_defio =3D {
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
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x7f);
>  	if (ret < 0)
>  		return ret;
> =20
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
>  	/* Set multiplex ratio value */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_MULTIPLEX_RATIO);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, par->height - 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, par->height - 1);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* set display offset value */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_DISPLAY_OFFSET);
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x20);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, par->offset);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set clock frequency */
> +	dclk =3D (par->dclk_div & 0xf) | (par->dclk_frq & 0xf) << 4;
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_CLOCK_FREQ);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0xf0);
>  	if (ret < 0)
>  		return ret;
> =20
> -	/* Set precharge period in number of ticks from the internal clock */
> +	ret =3D ssd1307fb_write_cmd(par->client, dclk);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set precharge period in number of ticks from the internal clock*/
> +	precharge =3D (par->prechargep1 & 0xf) | (par->prechargep2 & 0xf) << 4;
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PRECHARGE_PERIOD=
);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x22);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, precharge);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set COM pins configuration */
> +	compins =3D 0x02 | (par->com_alt & 0x1) << 4
> +				   | (par->com_lrremap & 0x1) << 5;
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COM_PINS_CONFIG);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x22);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, compins);
>  	if (ret < 0)
>  		return ret;
> =20
>  	/* Set VCOMH */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_VCOMH);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x49);
>  	if (ret < 0)
>  		return ret;
> =20
> -	/* Turn on the DC-DC Charge Pump */
> -	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x14);
> +	ret =3D ssd1307fb_write_cmd(par->client, par->vcomh);
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (par->device_info->device_id =3D=3D DEVID_SSD1306) {
> +		/* Turn on the DC-DC Charge Pump */
> +		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D ssd1307fb_write_cmd(par->client, 0x14);
> +		if (ret < 0)
> +			return ret;
> +	};
> +
>  	/* Switch to horizontal addressing mode */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client,
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client,
>  					SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
>  	if (ret < 0)
>  		return ret;
> =20
> +    /* Set column range */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x0);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, par->width - 1);
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D ssd1307fb_write_cmd(par->client, 0x0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, par->width - 1);
> +	if (ret < 0)
> +		return ret;
> +
> +    /* Set page range */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x0);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client,
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client, 0x0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd1307fb_write_cmd(par->client,
>  					par->page_offset + (par->height / 8) - 1);
>  	if (ret < 0)
>  		return ret;
> @@ -387,18 +427,28 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_=
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
>  	},
>  	{},
>  };
> @@ -429,8 +479,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
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
> @@ -449,8 +499,40 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  		par->page_offset =3D 1;
> =20
>  	vmem_size =3D par->width * par->height / 8;
> +	if (of_property_read_u32(node, "solomon,segment-remap", &par->seg_remap=
))
> +		par->seg_remap =3D 0;
> +
> +	if (of_property_read_u32(node, "solomon,offset", &par->offset))
> +		par->offset =3D 0;
> +
> +	if (of_property_read_u32(node, "solomon,contrast", &par->contrast))
> +		par->contrast =3D 128;
> +
> +	if (of_property_read_u32(node, "solomon,prechargep1", &par->prechargep1=
))
> +		par->prechargep1 =3D 2;
> +
> +	if (of_property_read_u32(node, "solomon,prechargep2", &par->prechargep2=
))
> +		par->prechargep2 =3D 2;
> +
> +	if (of_property_read_u32(node, "solomon,com-alt", &par->com_alt))
> +		par->com_alt =3D 1;
> +
> +	if (of_property_read_u32(node, "solomon,com-lrremap", &par->com_lrremap=
))
> +		par->com_lrremap =3D 0;
> +
> +	if (of_property_read_u32(node, "solomon,com-invdir", &par->com_invdir))
> +		par->com_invdir =3D 0;
> +
> +	if (of_property_read_u32(node, "solomon,vcomh", &par->vcomh))
> +		par->vcomh =3D par->device_info->default_vcomh;
> =20
>  	vmem =3D devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
> +	if (of_property_read_u32(node, "solomon,dclk-div", &par->dclk_div))
> +		par->dclk_div =3D par->device_info->default_dclk_div;
> +
> +	if (of_property_read_u32(node, "solomon,dclk-frq", &par->dclk_frq))
> +		par->dclk_frq  =3D par->device_info->default_dclk_frq;
> +
>  	if (!vmem) {
>  		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
>  		ret =3D -ENOMEM;
> @@ -499,11 +581,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
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
> @@ -516,8 +596,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
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
> @@ -531,11 +613,12 @@ static int ssd1307fb_remove(struct i2c_client *clie=
nt)
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
>  	framebuffer_release(info);
> -
>  	return 0;
>  }
> =20
> --=20
> 2.1.1
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1ewRAAoJEBx+YmzsjxAgQSwP/RecmzWGW35rebyEMxEovW5I
DjfuGJWQNcWizlpPLcBWI0dbt4drZyOBCZsHZmlMr6Y6W2suhF75ir62VNZ3bfbU
qNoQXKOoc8RRRjZHZU9wHsLy4c8ynxQeEUwWTQ0ND6GrA67LhlNrcqJQWrO0Zmh9
U1lewTq3PiRaMKuoqnhexgqd1/ST/gaMuc/9D2w7h+/MkPB+7VGrdA2k+sEpizlX
AFi7i50C4de79N0bHmO/mGD4eENvQaqP05htvg0Z8eF5V+KIbT251vCgLZ2IpAso
b9RljzFYpylhf8eK+YgJPue2gLTRCea7YaSgFtYQHd8rn77v1phMCvd2FDPljjrW
FZC9waEklLG/KXh5EwlRYIQp+OgEqR3X+FVX7vErnG/sxnnHeWQL0aLCT1iV4tJz
ie420jwLWrOlXjosx3NU2VcYL+Ya/lIhtP1dLjnVlpHM/Xs5Iu7ZdKVWlwpTBGhy
wVU+O5NehJGOFM+HSqqwW1BkDojDjgLlNdtjsZ6Q7Oln/yzO5Tux4cjE6fGdJoD5
9pmORKAr58/yrGGWTgwEbmgN0QFt51HX1Lwvq8bHKNxIzNGqc1ZmIcCoKZeKSyDP
exXu2l0aq7SIqYKC09O8V1nXm2cc2BdJ7/ZTfhYwW75cs1xjrl+nVzXuXeP2bdM3
ivL4q/yfwb73vzieHJFf
=E0ev
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--
