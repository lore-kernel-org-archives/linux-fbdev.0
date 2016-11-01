From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 01 Nov 2016 09:17:18 +0000
Subject: Re: [PATCH v2 1/2] backlight: pwm_bl: Move the checks for initial power state to a separate function
Message-Id: <bc1cda62-b82c-231f-fc38-27b752ecb7c6@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161027100157.2231-1-peter.ujfalusi@ti.com>
 <20161027100157.2231-2-peter.ujfalusi@ti.com>
 <1477661234.3010.49.camel@pengutronix.de>
In-Reply-To: <1477661234.3010.49.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: thierry.reding@gmail.com, lee.jones@linaro.org, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/28/2016 04:27 PM, Philipp Zabel wrote:
> Hi Peter,
>=20
> Am Donnerstag, den 27.10.2016, 13:01 +0300 schrieb Peter Ujfalusi:
>> Move the checks to select the initial state for the backlight to a new
>> function and document the checks we are doing.
>>
>> At the same time correct the handling of the case when the GPIO is
>> initially configured as input: we need to change the direction of the GP=
IO
>> to output and set the GPIO to low as the pin was not driven when the GPIO
>> was configured as input.
>=20
> I think this part should be a separate patch. At least it is a
> significant enough change to warrant a mention in the subject.

Yes, I should have separated it it.

> And I'm not entirely sure this is better than before. If there happens
> to be a pull-up on the GPIO (for whatever reason), we might introduce
> flicker again if the GPIO goes from input (high) to output (low), and
> back to output (high) again due to FB_BLANK_UNBLANK.

This is plausible if the pull-up is strong enough. It might be better to
not change this logic at all and instead of gpiod_direction_output_raw()
use the gpiod_direction_output(pb->enable_gpio, 1); to enable the GPIO
when it is set as input.

I'll resend the patches.

--=20
P=C3=A9ter

> regards
> Philipp
>=20
>> With the separate function it is going to be easier to fix or improve the
>> initial power state configuration later and it is easier to read the cod=
e.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 54 ++++++++++++++++++++++++++-------=
-------
>>  1 file changed, 35 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/=
pwm_bl.c
>> index 12614006211e..74083d880144 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -192,6 +192,32 @@ static int pwm_backlight_parse_dt(struct device *de=
v,
>>  }
>>  #endif
>> =20
>> +static int pwm_backlight_initial_power_state(const struct pwm_bl_data *=
pb)
>> +{
>> +	struct device_node *node =3D pb->dev->of_node;
>> +
>> +	/* Not booted with device tree or no phandle link to the node */
>> +	if (!node || !node->phandle)
>> +		return FB_BLANK_UNBLANK;
>> +
>> +	/*
>> +	 * If the driver is probed from the device tree and there is a
>> +	 * phandle link pointing to the backlight node, it is safe to
>> +	 * assume that another driver will enable the backlight at the
>> +	 * appropriate time. Therefore, if it is disabled, keep it so.
>> +	 */
>> +
>> +	/* if the enable GPIO is disabled, do not enable the backlight */
>=20
> nitpick: s/if/If/ for consistency.
>=20
>> +	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) =3D 0)
>> +		return FB_BLANK_POWERDOWN;
>> +
>> +	/* The regulator is disabled, do not enable the backlight */
>> +	if (!regulator_is_enabled(pb->power_supply))
>> +		return FB_BLANK_POWERDOWN;
>> +
>> +	return FB_BLANK_UNBLANK;
>> +}
>> +
>>  static int pwm_backlight_probe(struct platform_device *pdev)
>>  {
>>  	struct platform_pwm_backlight_data *data =3D dev_get_platdata(&pdev->d=
ev);
>> @@ -200,7 +226,6 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>>  	struct backlight_device *bl;
>>  	struct device_node *node =3D pdev->dev.of_node;
>>  	struct pwm_bl_data *pb;
>> -	int initial_blank =3D FB_BLANK_UNBLANK;
>>  	struct pwm_args pargs;
>>  	int ret;
>> =20
>> @@ -267,20 +292,14 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
>>  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
>>  	}
>> =20
>> -	if (pb->enable_gpio) {
>> -		/*
>> -		 * If the driver is probed from the device tree and there is a
>> -		 * phandle link pointing to the backlight node, it is safe to
>> -		 * assume that another driver will enable the backlight at the
>> -		 * appropriate time. Therefore, if it is disabled, keep it so.
>> -		 */
>> -		if (node && node->phandle &&
>> -		    gpiod_get_direction(pb->enable_gpio) =3D GPIOF_DIR_OUT &&
>> -		    gpiod_get_value(pb->enable_gpio) =3D 0)
>> -			initial_blank =3D FB_BLANK_POWERDOWN;
>> -		else
>> -			gpiod_direction_output(pb->enable_gpio, 1);
>> -	}
>> +	/*
>> +	 * If the GPIO is configured as input, change the direction to output
>> +	 * and set the GPIO as low since the line was not driven when it was
>> +	 * configured as input.
>> +	 */
>> +	if (pb->enable_gpio &&
>> +	    gpiod_get_direction(pb->enable_gpio) =3D GPIOF_DIR_IN)
>> +		gpiod_direction_output_raw(pb->enable_gpio, 0);
>> =20
>>  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
>>  	if (IS_ERR(pb->power_supply)) {
>> @@ -288,9 +307,6 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>>  		goto err_alloc;
>>  	}
>> =20
>> -	if (node && node->phandle && !regulator_is_enabled(pb->power_supply))
>> -		initial_blank =3D FB_BLANK_POWERDOWN;
>> -
>>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>>  	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER && !node) {
>>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>> @@ -347,7 +363,7 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>>  	}
>> =20
>>  	bl->props.brightness =3D data->dft_brightness;
>> -	bl->props.power =3D initial_blank;
>> +	bl->props.power =3D pwm_backlight_initial_power_state(pb);
>>  	backlight_update_status(bl);
>> =20
>>  	platform_set_drvdata(pdev, bl);
>=20
>=20
