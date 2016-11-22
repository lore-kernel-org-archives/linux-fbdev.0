From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 22 Nov 2016 13:33:22 +0000
Subject: Re: [PATCH v3 1/2] backlight: pwm_bl: Move the checks for initial power state to a separate function
Message-Id: <193bd483-5403-e92b-d769-0b971abb7caa@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161101125933.11168-1-peter.ujfalusi@ti.com>
 <20161101125933.11168-2-peter.ujfalusi@ti.com>
 <20161121081005.GA25171@ulmo.ba.sec>
In-Reply-To: <20161121081005.GA25171@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: lee.jones@linaro.org, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de



On 11/21/2016 10:10 AM, Thierry Reding wrote:
> On Tue, Nov 01, 2016 at 02:59:32PM +0200, Peter Ujfalusi wrote:
>> Move the checks to select the initial state for the backlight to a new
>> function and document the checks we are doing.
>>
>> With the separate function it is going to be easier to fix or improve the
>> initial power state configuration later and it is easier to read the cod=
e.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 53 ++++++++++++++++++++++++++-------=
-------
>>  1 file changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/=
pwm_bl.c
>> index 12614006211e..4b07da278b4f 100644
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
>> @@ -267,20 +292,13 @@ static int pwm_backlight_probe(struct platform_dev=
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
>> +	 * and set the GPIO as active.
>> +	 */
>> +	if (pb->enable_gpio &&
>> +	    gpiod_get_direction(pb->enable_gpio) =3D GPIOF_DIR_IN)
>> +		gpiod_direction_output(pb->enable_gpio, 1);
>=20
> I'm confused about this. Isn't it redundant to check for the direction
> if you're going to configure it as output either way? Why not just set
> it as output unconditionally?
>=20
> Also, is this not counterproductive? pwm_backlight_initial_power_state()
> will check the value of the GPIO to determine whether or not to mark the
> backlight as enabled. If we're setting this to active, then the check in
> the initial state retrieval will only be false if the GPIO is an output
> and inactive.
>=20
> Oh wait... I guess that's exactly why you're doing this. =3D) Perhaps this
> could be made somewhat clearer by beefing up the comment. As it is, the
> comment /seems/ rather useless because it restates what the code does. I
> think it'd be better to explain more verbosely what's going on, to avoid
> confusing people like me.

Extending the commit to:
/*
 * If the GPIO is configured as input, change the direction to output
 * and set the GPIO as active.
 * Do not force the GPIO to active when it was already output as it
 * could cause backlight flickering or we would enable the backlight too
 * early. Leave the decision of the initial backlight state for later.
 */

> Either way, though, the patch looks correct now that I understand it
> properly, I'll leave it up to Lee if he wants to insist on a clarifying
> comment.
>=20
> Reviewed-by: Thierry Reding <treding@nvidia.com>
>=20

--=20
P=E9ter
