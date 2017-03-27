From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 27 Mar 2017 14:27:40 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Fix GPIO out for unimplemented .get_direction()
Message-Id: <20170327142740.kz74sy56zpup5zgu@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1490203285-28324-1-git-send-email-geert+renesas@glider.be>
 <c00f689f-dae6-14d6-55d3-b1b44db19dc1@linaro.org>
 <6960ceea-5e34-3435-eecb-10e18322b15c@linaro.org>
In-Reply-To: <6960ceea-5e34-3435-eecb-10e18322b15c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 24 Mar 2017, Daniel Thompson wrote:

> On 24/03/17 16:42, Daniel Thompson wrote:
> > On 22/03/17 17:21, Geert Uytterhoeven wrote:
> > > Commit 7613c922315e308a ("backlight: pwm_bl: Move the checks for init=
ial
> > > power state to a separate function") not just moved some code, but ma=
de
> > > slight changes in semantics.
> > >=20
> > > If a gpiochip doesn't implement the optional .get_direction() callbac=
k,
> > > gpiod_get_direction always returns -EINVAL, which is never equal to
> > > GPIOF_DIR_IN, leading to the GPIO not being configured for output.
> > >=20
> > > To avoid this, invert the test and check for not GPIOF_DIR_OUT instea=
d,
> > > like the original code did.
> > >=20
> > > This restores the display on r8a7740/armadillo.
> > >=20
> > > Fixes: 7613c922315e308a ("backlight: pwm_bl: Move the checks for
> > > initial power state to a separate function")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >=20
> > Acked-by: Daniel Thommpson <daniel.thompson@linaro.org>
>=20
> Actually, it would be better if there only one m...
>=20
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

You probably don't want to be typing out your Acks manually every
time.  Can you set a key combination in your editor?

> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > b/drivers/video/backlight/pwm_bl.c
> > > index d7efcb632f7d9dde..002f1ce22bd02032 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -297,14 +297,15 @@ static int pwm_backlight_probe(struct
> > > platform_device *pdev)
> > >      }
> > >=20
> > >      /*
> > > -     * If the GPIO is configured as input, change the direction to
> > > output
> > > -     * and set the GPIO as active.
> > > +     * If the GPIO is not known to be already configured as output, =
that
> > > +     * is, if gpiod_get_direction returns either GPIOF_DIR_IN or
> > > -EINVAL,
> > > +     * change the direction to output and set the GPIO as active.
> > >       * Do not force the GPIO to active when it was already output as=
 it
> > >       * could cause backlight flickering or we would enable the
> > > backlight too
> > >       * early. Leave the decision of the initial backlight state for
> > > later.
> > >       */
> > >      if (pb->enable_gpio &&
> > > -        gpiod_get_direction(pb->enable_gpio) =3D GPIOF_DIR_IN)
> > > +        gpiod_get_direction(pb->enable_gpio) !=3D GPIOF_DIR_OUT)
> > >          gpiod_direction_output(pb->enable_gpio, 1);
> > >=20
> > >      pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
> > >=20
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
