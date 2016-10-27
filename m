From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 27 Oct 2016 07:18:46 +0000
Subject: Re: [PATCH 1/2] backlight: pwm_bl: Move the checks for initial power state to a separate function
Message-Id: <476602db-0c9c-b642-83c0-be4979addde0@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160930070259.5710-1-peter.ujfalusi@ti.com>
 <20160930070259.5710-2-peter.ujfalusi@ti.com> <20161026121258.GQ8574@dell>
 <fd224a5e-9487-eabf-a68f-bbd3ae49f8ef@ti.com>
In-Reply-To: <fd224a5e-9487-eabf-a68f-bbd3ae49f8ef@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lee Jones <lee.jones@linaro.org>
Cc: thierry.reding@gmail.com, jingoohan1@gmail.com, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

On 10/26/16 16:02, Peter Ujfalusi wrote:
> On 10/26/16 15:12, Lee Jones wrote:
>> On Fri, 30 Sep 2016, Peter Ujfalusi wrote:
>>
>>> Move the check for gpio and regulator initial state to a new function a=
nd
>>> document better what we are checking and why.
>>>
>>> It is going to be easier to fix or improve the initial power state
>>> configuration later and it is easier to read the code.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>  drivers/video/backlight/pwm_bl.c | 55 +++++++++++++++++++++++++-------=
--------
>>>  1 file changed, 35 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
>>> index b2b366bb0f97..9bc4715bf116 100644
>>> --- a/drivers/video/backlight/pwm_bl.c
>>> +++ b/drivers/video/backlight/pwm_bl.c
>>> @@ -192,6 +192,40 @@ static int pwm_backlight_parse_dt(struct device *d=
ev,
>>>  }
>>>  #endif
>>> =20
>>> +static int pwm_backlight_initial_power_state(const struct pwm_bl_data =
*pb)
>>> +{
>>> +	struct device_node *node =3D pb->dev->of_node;
>>> +
>>> +	/* Not booted with device tree or no phandle link to the node */
>>> +	if (!node || !node->phandle)
>>> +		return FB_BLANK_UNBLANK;
>>
>> This changes the semantics of the current implementation.
>>
>> In the code you're removing, if the enable_gpio is present and no DT
>> is found, we set the GPIO direction to output.  In your implementation,
>> if no DT is found you don't do anything regardless.
>>
>> Is that intentional?
>=20
> Argh, no, it is not intentional.
>=20
> It should have been like this:
>=20
> 	/* Not booted with device tree or no phandle link to the node */
> 	if (!node || !node->phandle) {
> 		/* Set enable GPIO if it is valid */
> 		if (pb->enable_gpio)
> 			gpiod_direction_output(pb->enable_gpio, 1);
>=20
> 		return FB_BLANK_UNBLANK;
> 	}
>=20
> On the other hand we are not doing the same for the regulator in case of =
non
> DT boot or when the backlight has no users. So we do enable the GPIO, but=
 the
> regulator might be left disabled...
>=20
> I'll resend the series with this change.

This is not really correct either.

If we boot in legacy mode the data->enable_gpio number is used to get the G=
PIO
and we configure the initial state as GPIOF_OUT_INIT_HIGH. So legacy boot w=
ill
have the line high in any case.

I think the only case we should handle differently is when the GPIO is
configured as input (I don't think it happens, but just to be sure). In that
case we need to change the direction to output and set the GPIO as disabled.
If it was input, it was not driving the line.

In the pwm_backlight_initial_power_state() function we will not need to che=
ck
for GPIO direction as it is guaranteed that it is output, we can only check
for the value of the GPIO.

I will resubmit with this change.

>=20
>>
>>> +	/*
>>> +	 * If the driver is probed from the device tree and there is a
>>> +	 * phandle link pointing to the backlight node, it is safe to
>>> +	 * assume that another driver will enable the backlight at the
>>> +	 * appropriate time. Therefore, if it is disabled, keep it so.
>>> +	 */
>>> +
>>> +	/*
>>> +	 * if the enable GPIO is set as output and it is disabled, do not ena=
ble
>>> +	 * the backlight
>>> +	 */
>>> +	if (pb->enable_gpio) {
>>> +		if (gpiod_get_direction(pb->enable_gpio) =3D GPIOF_DIR_OUT &&
>>> +		    gpiod_get_value(pb->enable_gpio) =3D 0)
>>> +			return FB_BLANK_POWERDOWN;
>>> +
>>> +		gpiod_direction_output(pb->enable_gpio, 1);
>>> +	}
>>> +
>>> +	/* The regulator is disabled, do not enable the backlight */
>>> +	if (!regulator_is_enabled(pb->power_supply))
>>> +		return FB_BLANK_POWERDOWN;
>>> +
>>> +	return FB_BLANK_UNBLANK;
>>> +}
>>> +
>>>  static int pwm_backlight_probe(struct platform_device *pdev)
>>>  {
>>>  	struct platform_pwm_backlight_data *data =3D dev_get_platdata(&pdev->=
dev);
>>> @@ -200,7 +234,6 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>>>  	struct backlight_device *bl;
>>>  	struct device_node *node =3D pdev->dev.of_node;
>>>  	struct pwm_bl_data *pb;
>>> -	int initial_blank =3D FB_BLANK_UNBLANK;
>>>  	struct pwm_args pargs;
>>>  	int ret;
>>> =20
>>> @@ -267,30 +300,12 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>>>  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
>>>  	}
>>> =20
>>> -	if (pb->enable_gpio) {
>>> -		/*
>>> -		 * If the driver is probed from the device tree and there is a
>>> -		 * phandle link pointing to the backlight node, it is safe to
>>> -		 * assume that another driver will enable the backlight at the
>>> -		 * appropriate time. Therefore, if it is disabled, keep it so.
>>> -		 */
>>> -		if (node && node->phandle &&
>>> -		    gpiod_get_direction(pb->enable_gpio) =3D GPIOF_DIR_OUT &&
>>> -		    gpiod_get_value(pb->enable_gpio) =3D 0)
>>> -			initial_blank =3D FB_BLANK_POWERDOWN;
>>> -		else
>>> -			gpiod_direction_output(pb->enable_gpio, 1);
>>> -	}
>>> -
>>>  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
>>>  	if (IS_ERR(pb->power_supply)) {
>>>  		ret =3D PTR_ERR(pb->power_supply);
>>>  		goto err_alloc;
>>>  	}
>>> =20
>>> -	if (node && node->phandle && !regulator_is_enabled(pb->power_supply))
>>> -		initial_blank =3D FB_BLANK_POWERDOWN;
>>> -
>>>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>>>  	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER && !node) {
>>>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>>> @@ -347,7 +362,7 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>>>  	}
>>> =20
>>>  	bl->props.brightness =3D data->dft_brightness;
>>> -	bl->props.power =3D initial_blank;
>>> +	bl->props.power =3D pwm_backlight_initial_power_state(pb);
>>>  	backlight_update_status(bl);
>>> =20
>>>  	platform_set_drvdata(pdev, bl);
>>
>=20
>=20


--=20
P=E9ter
