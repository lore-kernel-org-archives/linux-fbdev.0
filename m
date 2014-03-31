From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 31 Mar 2014 08:50:47 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Use SIMPLE_DEV_PM_OPS()
Message-Id: <20140331085047.GA20397@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

> > > > > Use the SIMPLE_DEV_PM_OPS() macro to declare the driver's pm_ops.
> > > > >=20
> > > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > > ---
> > > > >  drivers/video/backlight/pwm_bl.c | 17 ++++-------------
> > > > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
> > > > > index b75201f..d5e1f5b 100644
> > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > >=20
> > > > [...]
> > > >=20
> > > > > -static int pwm_backlight_resume(struct device *dev)
> > > > > +static int __maybe_unused pwm_bl_resume(struct device *dev)
> > > >=20
> > > > What's the __maybe_unused attribute for?
> > > >=20
> > > > In include/linux/compiler-gcc.h it redefines the attribute as 'unus=
ed':=20
> > > >=20
> > > >   #define __maybe_unused                  __attribute__((unused))
> > > >=20
> > > > ... are you sure this is what you want?
> > >=20
> > > Yes. This avoids compiler warnings if CONFIG_PM is unset.
> >=20
> > What are the advantages of this over the config option? Besides 2
> > lines of code?
>=20
> Just an increase compile coverage.

What does this mean? I replied to another one of your patches with the
same question.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
