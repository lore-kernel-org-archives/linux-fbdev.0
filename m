From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 01 Apr 2019 21:48:47 +0000
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-Id: <20190401214847.GE14681@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DqhR8hV3EnoxUkKN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-4-masneyb@onstation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, jonathan@marek.ca, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, linux-fbdev@vger.kernel.org, lee.jones@linaro.org, linux-leds@vger.kernel.org, dmurphy@ti.com


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-01 06:30:34, Brian Masney wrote:
> Add device tree support to the lm3630a driver and allow configuring
> independently on both banks the mapping mode (linear or exponential),
> initial and maximum LED brightness.
>=20
> Driver was tested on a LG Nexus 5 (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 69 ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlig=
ht/lm3630a_bl.c
> index ef2553f452ca..96fbc1273dda 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -35,6 +35,9 @@
>  #define REG_MAX		0x50
> =20
>  #define INT_DEBOUNCE_MSEC	10
> +
> +#define LM3630A_MAX_SOURCES	2
> +
>  struct lm3630a_chip {
>  	struct device *dev;
>  	struct delayed_work work;
> @@ -364,6 +367,64 @@ static const struct regmap_config lm3630a_regmap =3D=
 {
>  	.max_register =3D REG_MAX,
>  };
> =20
> +static void lm3630a_parse_dt(struct lm3630a_chip *pchip)
> +{
> +	u32 sources[LM3630A_MAX_SOURCES], val;
> +	struct device_node *child_node;
> +	int num_sources, ret, i;
> +	bool linear;
> +
> +	for_each_available_child_of_node(pchip->dev->of_node, child_node) {
> +		num_sources =3D of_property_count_u32_elems(child_node,
> +							  "led-sources");
> +		if (num_sources < 0)
> +			continue;
> +
> +		if (num_sources > LM3630A_MAX_SOURCES)
> +			num_sources =3D LM3630A_MAX_SOURCES;
> +
> +		ret =3D of_property_read_u32_array(child_node, "led-sources",
> +						 sources, num_sources);
> +		if (ret) {
> +			dev_err(pchip->dev,
> +				"Error parsing led-sources node: %d\n", ret);
> +			return;
> +		}
> +
> +		linear =3D of_property_read_bool(child_node,
> +					       "ti,linear-mapping-mode");
> +
> +		for (i =3D 0; i < num_sources; i++) {
> +			if (sources[i] =3D=3D 0)
> +				pchip->pdata->leda_ctrl =3D linear ?
> +					LM3630A_LEDA_ENABLE_LINEAR :
> +					LM3630A_LEDA_ENABLE;
> +			else if (sources[i] =3D=3D 1)
> +				pchip->pdata->ledb_ctrl =3D linear ?
> +					LM3630A_LEDB_ENABLE_LINEAR :
> +					LM3630A_LEDB_ENABLE;

This makes my head spin.

So ... we can have multiple LEDs, each can have up to two
sources.. and the settings are really per source, not per LED.

But you do not test for overlaps. What prevents me from having

   foo {
       led_sources =3D <0>;
       ti,linear-mapping-mode;
   }
   bar {
       led_sources =3D <0>;
   }

(I.e. conflicting settings for a source?)

Plus I do not see parsing of led labels etc...

> +			ret =3D of_property_read_u32(child_node,
> +						   "default-brightness", &val);
> +			if (!ret) {
> +				if (sources[i] =3D=3D 0)
> +					pchip->pdata->leda_init_brt =3D val;
> +				else if (sources[i] =3D=3D 1)
> +					pchip->pdata->ledb_init_brt =3D val;
> +			}
> +
> +			ret =3D of_property_read_u32(child_node, "max-brightness",
> +						   &val);
> +			if (!ret) {
> +				if (sources[i] =3D=3D 0)
> +					pchip->pdata->leda_max_brt =3D val;
> +				else if (sources[i] =3D=3D 1)
> +					pchip->pdata->ledb_max_brt =3D val;
> +			}
> +		}
> +	};

Extra ";"

> +}
> +
>  static int lm3630a_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -405,6 +466,7 @@ static int lm3630a_probe(struct i2c_client *client,
>  		pdata->ledb_init_brt =3D LM3630A_MAX_BRIGHTNESS;
>  	}
>  	pchip->pdata =3D pdata;
> +	lm3630a_parse_dt(pchip);

I'd expect abort if we are using dt and dt parsing fails.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyihz8ACgkQMOfwapXb+vIE4ACeMdpxk/6BCAiO8WWDcfB5Tl89
7EgAnRM1tWG7/UUqMYrJeinnXGnd24zj
=Su8z
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
