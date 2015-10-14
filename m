From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 14 Oct 2015 12:27:14 +0000
Subject: Re: [PATCH] pwm-backlight: fix the panel power sequence
Message-Id: <20151014122714.GI32409@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442414556-32381-1-git-send-email-yh.huang@mediatek.com>
 <1444816875.31675.2.camel@mtksdaap41>
In-Reply-To: <1444816875.31675.2.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 14 Oct 2015, YH Huang wrote:

> Hi all,
>=20
> If you have any suggestion, please let me know.
> Thanks.

Please don't do that.

If you think the patch has fallen through the gaps, please just RESEND
it, like [RESEND vX] $subject.

> On Wed, 2015-09-16 at 22:42 +0800, YH Huang wrote:
> > In order to match the panel power sequence, disable the enable_gpio
> > in the probe function. Also, reorder the code in the power_on and
> > power_off function to match the timing.
> >=20
> > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > ---
> >  drivers/video/backlight/pwm_bl.c |   15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
> > index eff379b..99eca1e 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_da=
ta *pb, int brightness)
> >  	if (err < 0)
> >  		dev_err(pb->dev, "failed to enable power supply\n");
> > =20
> > +	pwm_enable(pb->pwm);
> > +
> >  	if (pb->enable_gpio)
> >  		gpiod_set_value(pb->enable_gpio, 1);
> > =20
> > -	pwm_enable(pb->pwm);
> >  	pb->enabled =3D true;
> >  }
> > =20
> > @@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_d=
ata *pb)
> >  	if (!pb->enabled)
> >  		return;
> > =20
> > -	pwm_config(pb->pwm, 0, pb->period);
> > -	pwm_disable(pb->pwm);
> > -
> >  	if (pb->enable_gpio)
> >  		gpiod_set_value(pb->enable_gpio, 0);
> > =20
> > +	pwm_config(pb->pwm, 0, pb->period);
> > +	pwm_disable(pb->pwm);
> > +
> >  	regulator_disable(pb->power_supply);
> >  	pb->enabled =3D false;
> >  }
> > @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
> >  	pb->dev =3D &pdev->dev;
> >  	pb->enabled =3D false;
> > =20
> > -	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
> > -						  GPIOD_OUT_HIGH);
> > +	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable");
> >  	if (IS_ERR(pb->enable_gpio)) {
> >  		ret =3D PTR_ERR(pb->enable_gpio);
> >  		goto err_alloc;
> > @@ -264,6 +264,9 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
> >  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
> >  	}
> > =20
> > +	if (pb->enable_gpio)
> > +		gpiod_direction_output(pb->enable_gpio, 0);
> > +
> >  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
> >  	if (IS_ERR(pb->power_supply)) {
> >  		ret =3D PTR_ERR(pb->power_supply);
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
