From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 03 Dec 2014 02:06:45 +0000
Subject: Re: [PATCH v2 2/2] backlight/lp855x: Add supply regulator to lp855x
Message-Id: <001101d00e9d$ca56b9c0$5f042d40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org>
 <1417570752-23633-2-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417570752-23633-2-git-send-email-seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: 'Sean Paul' <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: milo.kim-l0cyMroinI0@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?UTF-8?Q?'St=C3=A9phane_Marchesin'?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Aaron Durbin' <adurbin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

On Wednesday, December 03, 2014 10:39 AM, Sean Paul wrote:
>=20
> This patch adds a supply regulator to the lp855x platform data to facilit=
ate
> powering on/off the 3V rail attached to the controller.
>=20
> Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> Cc: Aaron Durbin <adurbin@chromium.org>
> Acked-by: Milo Kim <milo.kim@ti.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>=20
> Changes in v2:
> 	- Add NULL check in lp855x_remove
>=20
>=20
>  .../devicetree/bindings/video/backlight/lp855x.txt     |  2 ++
>  drivers/video/backlight/lp855x_bl.c                    | 18 ++++++++++++=
++++++
>  include/linux/platform_data/lp855x.h                   |  2 ++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/video/backlight/lp855x.txt
> b/Documentation/devicetree/bindings/video/backlight/lp855x.txt
> index 96e83a5..0a3ecbc 100644
> --- a/Documentation/devicetree/bindings/video/backlight/lp855x.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/lp855x.txt
> @@ -12,6 +12,7 @@ Optional properties:
>    - pwm-period: PWM period value. Set only PWM input mode used (u32)
>    - rom-addr: Register address of ROM area to be updated (u8)
>    - rom-val: Register value to be updated (u8)
> +  - power-supply: Regulator which controls the 3V rail
>=20
>  Example:
>=20
> @@ -56,6 +57,7 @@ Example:
>  	backlight@2c {
>  		compatible =3D "ti,lp8557";
>  		reg =3D <0x2c>;
> +		power-supply =3D <&backlight_vdd>;
>=20
>  		dev-ctrl =3D /bits/ 8 <0x41>;
>  		init-brt =3D /bits/ 8 <0x0a>;
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backligh=
t/lp855x_bl.c
> index 257b3ba..a26d3bb 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_data/lp855x.h>
>  #include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>
>=20
>  /* LP8550/1/2/3/6 Registers */
>  #define LP855X_BRIGHTNESS_CTRL		0x00
> @@ -383,6 +384,13 @@ static int lp855x_parse_dt(struct lp855x *lp)
>  		pdata->rom_data =3D &rom[0];
>  	}
>=20
> +	pdata->supply =3D devm_regulator_get(dev, "power");
> +	if (IS_ERR(pdata->supply)) {
> +		if (PTR_ERR(pdata->supply) =3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		pdata->supply =3D NULL;
> +	}
> +
>  	lp->pdata =3D pdata;
>=20
>  	return 0;
> @@ -423,6 +431,14 @@ static int lp855x_probe(struct i2c_client *cl, const=
 struct i2c_device_id *id)
>  	else
>  		lp->mode =3D REGISTER_BASED;
>=20
> +	if (lp->pdata->supply) {
> +		ret =3D regulator_enable(lp->pdata->supply);
> +		if (ret < 0) {
> +			dev_err(&cl->dev, "failed to enable supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	i2c_set_clientdata(cl, lp);
>=20
>  	ret =3D lp855x_configure(lp);
> @@ -454,6 +470,8 @@ static int lp855x_remove(struct i2c_client *cl)
>=20
>  	lp->bl->props.brightness =3D 0;
>  	backlight_update_status(lp->bl);
> +	if (lp->pdata->supply)
> +		regulator_disable(lp->pdata->supply);
>  	sysfs_remove_group(&lp->dev->kobj, &lp855x_attr_group);
>=20
>  	return 0;
> diff --git a/include/linux/platform_data/lp855x.h b/include/linux/platfor=
m_data/lp855x.h
> index 1b2ba24..9c7fd1e 100644
> --- a/include/linux/platform_data/lp855x.h
> +++ b/include/linux/platform_data/lp855x.h
> @@ -136,6 +136,7 @@ struct lp855x_rom_data {
>  		Only valid when mode is PWM_BASED.
>   * @size_program : total size of lp855x_rom_data
>   * @rom_data : list of new eeprom/eprom registers
> + * @supply : regulator that supplies 3V input
>   */
>  struct lp855x_platform_data {
>  	const char *name;
> @@ -144,6 +145,7 @@ struct lp855x_platform_data {
>  	unsigned int period_ns;
>  	int size_program;
>  	struct lp855x_rom_data *rom_data;
> +	struct regulator *supply;
>  };
>=20
>  #endif
> --
> 2.2.0.rc0.207.ga3a616c

