From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 29 Apr 2015 12:33:03 +0000
Subject: Re: [PATCH] gpio-backlight: Discover driver during boot time
Message-Id: <20150429123303.GK9169@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429143684-3371-1-git-send-email-arun@gumstix.com>
 <20150429123223.GJ9169@x1>
In-Reply-To: <20150429123223.GJ9169@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arun Bharadwaj <arun@gumstix.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ash Charles <ashcharles@gmail.com>

> Jingoo?

Never mind.

Applied, thanks.

> > The gpio-backlight driver seems to be missing the
> > MODULE_DEVICE_TABLE line which is preventing it from
> > being modprobed during boot time even if the
> > gpio-backlight device exists.
> >=20
> > This seems to be a bug and this patch attempts to
> > fix that.
> >=20
> > Signed-off-by: Arun Bharadwaj <arun@gumstix.com>
> > Signed-off-by: Ash Charles <ashcharles@gmail.com>
> > ---
> >  drivers/video/backlight/gpio_backlight.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/b=
acklight/gpio_backlight.c
> > index 439feb2..5fbbc2e 100644
> > --- a/drivers/video/backlight/gpio_backlight.c
> > +++ b/drivers/video/backlight/gpio_backlight.c
> > @@ -146,6 +146,8 @@ static struct of_device_id gpio_backlight_of_match[=
] =3D {
> >  	{ .compatible =3D "gpio-backlight" },
> >  	{ /* sentinel */ }
> >  };
> > +
> > +MODULE_DEVICE_TABLE(of, gpio_backlight_of_match);
> >  #endif
> > =20
> >  static struct platform_driver gpio_backlight_driver =3D {
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
