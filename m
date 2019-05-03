From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 03 May 2019 13:29:32 +0000
Subject: Re: [PATCH] backlight: rave-sp: don't touch initial state and register with correct device
Message-Id: <20190503132932.2e3vrvlykofpexkf@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190429152919.27277-1-l.stach@pengutronix.de>
 <c23ecabd-c2ee-8c23-9ee3-13290bc4da35@linaro.org>
 <1556798505.2590.7.camel@pengutronix.de>
In-Reply-To: <1556798505.2590.7.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, patchwork-lst@pengutronix.de, kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>

On Thu, May 02, 2019 at 02:01:45PM +0200, Lucas Stach wrote:
> Hi Daniel,
>=20
> Am Donnerstag, den 02.05.2019, 11:33 +0100 schrieb Daniel Thompson:
> > On 29/04/2019 16:29, Lucas Stach wrote:
> > > This way the backlight can be referenced through its device node and
> > > enabling/disabling can be managed through the panel driver.
> >=20
> > Is it possible to implement something similar to=A0
> > pwm_backlight_initial_power_state() to handle this?
>=20
> I'm not aware of any protocol to the RAVE-SP that would allow to read
> back the backlight state. AFAICS the backlight is implemented as a
> unidirectional protocol.

That function does two things... one is read the current power state to
ensure meta-data is correctly up to date which cannot be replicated.
The other is to choose different behaviour depending on whether the
backlight is standalone or has a phandle link to another device.

Does the second part apply to the rave-sp?


Daniel.



> > backlight drivers already suffer from too much diversity so I prefer=A0
> > things like this to align behaviour with the (fairly heavilyly used) PW=
M=A0
> > driver if possible.
> >=20
> >=20
> > Daniel.
> >=20
> >=20
> > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > =A0 drivers/video/backlight/rave-sp-backlight.c | 4 +---
> > > =A0 1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/vi=
deo/backlight/rave-sp-backlight.c
> > > index 462f14a1b19d..d296bfcf4396 100644
> > > --- a/drivers/video/backlight/rave-sp-backlight.c
> > > +++ b/drivers/video/backlight/rave-sp-backlight.c
> > > @@ -48,15 +48,13 @@ static int rave_sp_backlight_probe(struct platfor=
m_device *pdev)
> > > > > =A0=A0	struct device *dev =3D &pdev->dev;
> > > > > =A0=A0	struct backlight_device *bd;
> > > =A0=A0
> > > > > -	bd =3D devm_backlight_device_register(dev, pdev->name, dev->par=
ent,
> > > > > +	bd =3D devm_backlight_device_register(dev, pdev->name, dev,
> > > > > =A0=A0					=A0=A0=A0=A0dev_get_drvdata(dev->parent),
> > > > > =A0=A0					=A0=A0=A0=A0&rave_sp_backlight_ops,
> > > > > =A0=A0					=A0=A0=A0=A0&rave_sp_backlight_props);
> > > > > =A0=A0	if (IS_ERR(bd))
> > > > > =A0=A0		return PTR_ERR(bd);
> > > =A0=A0
> > > > > -	backlight_update_status(bd);
> > > -
> > > > > =A0=A0	return 0;
> > > =A0 }
> > > =A0=A0
> > >=20
> >=20
> >=20
