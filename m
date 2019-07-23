From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 23 Jul 2019 15:32:50 +0000
Subject: Re: [PATCH v2 2/7] backlight: gpio: simplify the platform data handling
Message-Id: <20190723153250.GK9224@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-3-brgl@bgdev.pl>
 <20190722160603.GY9224@smile.fi.intel.com>
 <CAMRc=Mfuvh6byfPhPdB51dy_YbAS5scJQT3n3pL_5VZLCjB3Hw@mail.gmail.com>
In-Reply-To: <CAMRc=Mfuvh6byfPhPdB51dy_YbAS5scJQT3n3pL_5VZLCjB3Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Tue, Jul 23, 2019 at 08:28:00AM +0200, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 18:06 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
> >
> > On Mon, Jul 22, 2019 at 05:02:57PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Now that the last user of platform data (sh ecovec24) defines a proper
> > > GPIO lookup and sets the 'default-on' device property, we can drop the
> > > platform_data-specific GPIO handling and unify a big chunk of code.
> > >
> > > The only field used from the platform data is now the fbdev pointer.
> >
> > > -static int gpio_backlight_probe_dt(struct platform_device *pdev,
> > > -                                struct gpio_backlight *gbl)
> > > -{
> > > -     struct device *dev =3D &pdev->dev;
> > > -     enum gpiod_flags flags;
> > > -     int ret;
> > > -
> > > -     gbl->def_value =3D device_property_read_bool(dev, "default-on");
> > > -     flags =3D gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> > > -
> > > -     gbl->gpiod =3D devm_gpiod_get(dev, NULL, flags);
> > > -     if (IS_ERR(gbl->gpiod)) {
> > > -             ret =3D PTR_ERR(gbl->gpiod);
> > > -
> > > -             if (ret !=3D -EPROBE_DEFER) {
> > > -                     dev_err(dev,
> > > -                             "Error: The gpios parameter is missing =
or invalid.\n");
> > > -             }
> > > -             return ret;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> >
> > Why not leave this function (perhaps with different name)?
>=20
> Why would we do that if the entire probe() function is now less than
> 50 lines long? Also: it gets inlined by the compiler anyway. It
> doesn't make sense IMO.

I'm not against this, perhaps, dropping and moving can be split to two chan=
ges.

--=20
With Best Regards,
Andy Shevchenko
