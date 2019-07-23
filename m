From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 23 Jul 2019 13:40:22 +0000
Subject: Re: [PATCH v2 7/7] backlight: gpio: use a helper variable for &pdev->dev
Message-Id: <20190723134022.s74giqi3aq7v3djz@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-8-brgl@bgdev.pl>
 <20190722160908.GZ9224@smile.fi.intel.com>
 <CAMRc=McGTk+i0SzWN7AvGu3deYbXX_rJX=7+dKRpKFPKM_qxDA@mail.gmail.com>
In-Reply-To: <CAMRc=McGTk+i0SzWN7AvGu3deYbXX_rJX=7+dKRpKFPKM_qxDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Tue, Jul 23, 2019 at 08:29:52AM +0200, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 18:09 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
> >
> > On Mon, Jul 22, 2019 at 05:03:02PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Instead of dereferencing pdev each time, use a helper variable for
> > > the associated device pointer.
> >
> > >  static int gpio_backlight_probe(struct platform_device *pdev)
> > >  {
> > > -     struct gpio_backlight_platform_data *pdata > > > -             =
dev_get_platdata(&pdev->dev);
> > > +     struct gpio_backlight_platform_data *pdata;
> > >       struct backlight_properties props;
> > >       struct backlight_device *bl;
> > >       struct gpio_backlight *gbl;
> > >       enum gpiod_flags flags;
> > > +     struct device *dev;
> >
> > Can't we do
> >
> >         struct device dev =3D &pdev->dev;
> >         struct gpio_backlight_platform_data *pdata =3D dev_get_platdata=
(dev);
> >
> > ? It fits 80 nicely.
> >
>=20
> IMO it's more readable like that with the reverse christmas tree layout.

There is no requirement for reverse christmas tree layout for this area
of the kernel (and especially not where RCTL is used as a justification
to avoid initializers).

I have a weak personal preference for initializers although it is
sufficiently weak I was happy to put a reviewed by on the original
patch without comment.


Daniel.
