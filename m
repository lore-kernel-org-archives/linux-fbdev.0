From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Sun, 20 Dec 2015 10:31:03 +0000
Subject: Re: [PATCH 3/5] fbdev: omap2: panel-dpi: drop assignment to local variable
Message-Id: <20151220103103.GE28361@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello,

On Wed, Dec 16, 2015 at 07:29:17PM +0200, Tomi Valkeinen wrote:
> On 10/12/15 15:11, Uwe Kleine-K=F6nig wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > The variable gpio is only used to store the return value of
> > devm_gpiod_get_optional just to assign it to a member of the driver
> > data.
> >=20
> > Get rid of this local variable and assign to driver data directly.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> > index e780fd4f8b46..1216341a0d19 100644
> > --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> > +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> > @@ -205,13 +205,11 @@ static int panel_dpi_probe_of(struct platform_dev=
ice *pdev)
> >  	int r;
> >  	struct display_timing timing;
> >  	struct videomode vm;
> > -	struct gpio_desc *gpio;
> > =20
> > -	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW);
> > -	if (IS_ERR(gpio))
> > -		return PTR_ERR(gpio);
> > -
> > -	ddata->enable_gpio =3D gpio;
> > +	ddata->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> > +						     "enable", GPIOD_OUT_LOW);
> > +	if (IS_ERR(ddata->enable_gpio))
> > +		return PTR_ERR(ddata->enable_gpio);
> > =20
> >  	ddata->backlight_gpio =3D -ENOENT;
>=20
> I usually try to avoid writing bad values to fields. Here
> ddata->enable_gpio may get an error ptr. It probably doesn't matter as
> we bail out right away, but still. If devm_gpiod_get_optional's return
> value would be NULL or valid gpio_desc*, then it'd be fine.

this is probably a matter of taste but still I don't see why people
don't like writing to structs immediately.

With the local variable you might have

	gpio =3D -ESOMETHING

and

	ddata->enable_gpio =3D NULL;

In the case that the error is handled correctly it doesn't matter if the
value was written to the struct or not (if you accept a little
performance penalty for writing the value actually to memory maybe). So
the motivation is the consideration that the error might not be handled
correctly after a later patch, right? But when ddata->enable_gpio is a
negative error code this probably results in a crash already during
development of the faulty patch, while when the struct's member isn't
assigned it probably doesn't.

This convinces me that writing to the struct is actually a good thing.

Additionally even though the line length of=20

	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW);
	if (IS_ERR(gpio))
		return PTR_ERR(gpio);

	ddata->enable_gpio =3D gpio;

is shorter (which is good), with my approach of doing:

	ddata->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev,
						     "enable", GPIOD_OUT_LOW);
	if (IS_ERR(ddata->enable_gpio))
		return PTR_ERR(ddata->enable_gpio);

apart from saving an assignment also "enable_gpio" and "enable" are
nearer to each other which IMHO makes it easier to see that the
assignment is correct which outweighs the longer lines. This argument
even gets more important when reset_gpio is added in patch 4 when the
situation looks as follows:

	gpio =3D devm_gpiod_get_optional(... "enable" ...);
	if (IS_ERR(gpio))
		...
	ddata->enable_gpio =3D gpio;

	gpio =3D devm_gpiod_get_optional(... "reset" ...);
	if (IS_ERR(gpio))
		...
	ddata->reset_gpio =3D gpio;

vs.

	ddata->enable_gpio =3D devm_gpiod_get_optional(... "enable" ...);
	if (IS_ERR(ddata->enable_gpio))
		...

	ddata->reset_gpio =3D devm_gpiod_get_optional(... "reset" ...);
	if (IS_ERR(ddata->reset_gpio))
		...

I like my approach better, but if you don't agree, I don't care enough
to argue (more).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
