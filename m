From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Wed, 01 Jul 2015 12:08:18 +0000
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Message-Id: <3530235.H11CYEfk28@diego>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <3495901.qMzLCVWCDl@diego> <20150701140531.2041b05c@bbrezillon>
In-Reply-To: <20150701140531.2041b05c@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Am Mittwoch, 1. Juli 2015, 14:05:31 schrieb Boris Brezillon:
> Hi Heiko,
>=20
> On Wed, 01 Jul 2015 13:58:09 +0200
>=20
> Heiko St=FCbner <heiko@sntech.de> wrote:
> > Am Mittwoch, 1. Juli 2015, 10:22:00 schrieb Boris Brezillon:
> > > Implement the ->enable(), ->disable() and ->is_enabled methods and
> > > remove
> > > the PWM call in ->set_voltage_sel().
> > > This is particularly important for critical regulators tagged as
> > > always-on,
> > > because not claiming the PWM (and its dependencies) might lead to
> > > unpredictable behavior (like a system hang because the PWM clk is only
> > > claimed when the PWM device is enabled).
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >=20
> > >  drivers/regulator/pwm-regulator.c | 32 ++++++++++++++++++++++++++---=
---
> > >  1 file changed, 26 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/regulator/pwm-regulator.c
> > > b/drivers/regulator/pwm-regulator.c index 12b4d9d..8159518 100644
> > > --- a/drivers/regulator/pwm-regulator.c
> > > +++ b/drivers/regulator/pwm-regulator.c
> > > @@ -59,12 +59,6 @@ static int pwm_regulator_set_voltage_sel(struct
> > > regulator_dev *rdev,
> > >=20
> > >  	drvdata->state =3D selector;
> > >=20
> > > -	ret =3D pwm_enable(drvdata->pwm);
> > > -	if (ret) {
> > > -		dev_err(&rdev->dev, "Failed to enable PWM\n");
> > > -		return ret;
> > > -	}
> > > -
> > >=20
> > >  	return 0;
> > > =20
> > >  }
> > >=20
> > > @@ -79,11 +73,37 @@ static int pwm_regulator_list_voltage(struct
> > > regulator_dev *rdev, return drvdata->duty_cycle_table[selector].uV;
> > >=20
> > >  }
> > >=20
> > > +static int pwm_regulator_enable(struct regulator_dev *dev)
> > > +{
> > > +	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +
> > > +	return pwm_enable(drvdata->pwm);
> > > +}
> > > +
> > > +static int pwm_regulator_disable(struct regulator_dev *dev)
> > > +{
> > > +	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +
> > > +	pwm_disable(drvdata->pwm);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int pwm_regulator_is_enabled(struct regulator_dev *dev)
> > > +{
> > > +       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +
> > > +       return pwm_is_enabled(drvdata->pwm);
> > > +}
> >=20
> > nit: indentation is wrong in pwm_regulator_is_enabled (spaces instead of
> > tabs)
> Yep, I noticed checkpatch warnings/errors before sending the patch, but
> since this is just an RFC I decided to fix them for the next version ;-)

ok, so I'll just skip over any more style issues for now. Making my way=20
through your series and trying it on my veyron right now :-)


Heiko
