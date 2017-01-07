From: Joe Perches <joe@perches.com>
Date: Sat, 07 Jan 2017 01:31:17 +0000
Subject: Re: [PATCH v3 1/2] backlight arcxcnn add support for ArcticSand devices
Message-Id: <1483752677.2449.7.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1483735689-5452-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1483735689-5452-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu@arcticsand.com>, robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, bdodge@arcticsand.com

On Fri, 2017-01-06 at 15:48 -0500, Olimpiu Dejeu wrote:
> backlight: Add support for Arctic Sand LED backlight driver chips
> This driver provides support for the Arctic Sand arc2c0608 chip,=20
>     and provides a framework to support future devices.

style trivia:

> diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlig=
ht/arcxcnn_bl.c
[]
> +static int arcxcnn_bl_update_status(struct backlight_device *bl)
> +{
> +	struct arcxcnn *lp =3D bl_get_data(bl);
> +	u32 brightness =3D bl->props.brightness;
> +
> +	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +		brightness =3D 0;
> +
> +	arcxcnn_set_brightness(lp, brightness);
> +
> +	/* set power-on/off/save modes */
> +	if (bl->props.power =3D 0)
> +		/* take out of standby */
> +		arcxcnn_update_bit(lp, ARCXCNN_CMD, ARCXCNN_CMD_STDBY, 0);
> +	else
> +		 /* place in low-power standby mode */
> +		arcxcnn_update_bit(lp, ARCXCNN_CMD,
> +				ARCXCNN_CMD_STDBY, ARCXCNN_CMD_STDBY);

This is generally smaller code using a temporary and
a single call instead of two calls like:

	int cmd;

	...

	if (bl->props.power =3D 0)
		cmd =3D 0;		/* take out of standby */
	else
		cmd =3D ARCXCNN_CMD_STDBY;
	arcxcnn_update_bit(lp, ARCXCNN_CMD, ARCXCNN_CMD_STDBY,=A0cmd);

or maybe

	arcxcnn_update_bit(lp, ARCXCNN_CMD, ARCXCNN_CMD_STDBY,
			   bl->props.power =3D 0 ? 0 : ARCXCNN_CMD_STDBY);

> +static int arcxcnn_backlight_register(struct arcxcnn *lp)
> +{
> +	struct backlight_properties *props;
> +	const char *name =3D lp->pdata->name ? : "arctic_bl";
> +
> +	props =3D devm_kzalloc(lp->dev, sizeof(*props), GFP_KERNEL);
> +	if (!props)
> +		return -ENOMEM;
> +
> +	memset(props, 0, sizeof(props));

props has already been zeroed by devm_kzalloc and doesn't
need to be memset to 0 again.

> +	props->type =3D BACKLIGHT_PLATFORM;
> +	props->max_brightness =3D MAX_BRIGHTNESS;
> +
> +	if (lp->pdata->initial_brightness > props->max_brightness)
> +		lp->pdata->initial_brightness =3D props->max_brightness;
> +
> +	props->brightness =3D lp->pdata->initial_brightness;
> +
> +	lp->bl =3D devm_backlight_device_register(lp->dev, name, lp->dev, lp,
> +				       &arcxcnn_bl_ops, props);
> +

This blank line above is generally not needed.

> +	if (IS_ERR(lp->bl))
> +		return PTR_ERR(lp->bl);

the typical style is:

	rtn =3D foo(...)
	if (rtn < 0)
		error_handler...

> +static void arcxcnn_parse_dt(struct arcxcnn *lp)
> +{
> +	struct device *dev =3D lp->dev;
> +	struct device_node *node =3D dev->of_node;
> +	u32 prog_val, num_entry, entry, sources[ARCXCNN_LEDEN_BITS];
> +	int ret;
[]
> +	ret =3D of_property_count_u32_elems(node, "led-sources");
> +	if (ret < 0) {
> +		lp->pdata->leden =3D ARCXCNN_LEDEN_MASK; /* all on is default */
> +	} else {
> +		num_entry =3D ret;
> +		if (num_entry > ARCXCNN_LEDEN_BITS)
> +			num_entry =3D ARCXCNN_LEDEN_BITS;
> +
> +		ret =3D of_property_read_u32_array(node, "led-sources", sources,
> +					num_entry);
> +		if (ret < 0) {
> +			dev_err(dev, "led-sources node is invalid.\n");
> +		} else {
> +			u8 onbit;
> +
> +			lp->pdata->leden =3D 0;
> +
> +			/* for each enable in source, set bit in led enable */
> +			for (entry =3D 0; entry < num_entry; entry++) {
> +				onbit =3D 1 << sources[entry];
> +				lp->pdata->leden |=3D onbit;
> +			}
> +		}
> +	}
> +}

The cascading indentation can be avoided by using return;
as necessary

	ret =3D of_property_count_u32_elems(node, "led-sources");
	if (ret < 0) {
		lp->pdata->leden =3D ARCXCNN_LEDEN_MASK; /* all on is default */
		return;
	}

	num_entry =3D min(ret,=A0ARCXCNN_LEDEN_BITS);
	ret =3D of_property_read_u32_array(node, "led-sources", sources, num_entry=
);
	if (ret < 0) {
		dev_err(dev, "led-sources node is invalid\n");
		return;
	}

	lp->pdata->leden =3D 0;

	/* for each enable in source, set bit in led enable */
	for (entry =3D 0; entry < num_entry; entry++) {
		u8 onbit =3D 1 << sources[entry];

		lp->pdata->leden |=3D onbit;
	}

