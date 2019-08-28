From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 28 Aug 2019 07:32:50 +0000
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
Message-Id: <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl> <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
 <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com>
In-Reply-To: <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lee Jones <lee.jones@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

pt., 16 sie 2019 o 17:48 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>
> czw., 8 sie 2019 o 10:17 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> >
> > śr., 24 lip 2019 o 10:25 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > While working on my other series related to gpio-backlight[1] I noticed
> > > that we could simplify the driver if we made the only user of platform
> > > data use GPIO lookups and device properties. This series tries to do
> > > that.
> > >
> > > The first patch adds all necessary data structures to ecovec24. Patch
> > > 2/7 unifies much of the code for both pdata and non-pdata cases. Patches
> > > 3-4/7 remove unused platform data fields. Last three patches contain
> > > additional improvements for the GPIO backlight driver while we're already
> > > modifying it.
> > >
> > > I don't have access to this HW but hopefully this works. Only compile
> > > tested.
> > >
> > > [1] https://lkml.org/lkml/2019/6/25/900
> > >
> > > v1 -> v2:
> > > - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> > > - added additional two patches with minor improvements
> > >
> > > v2 -> v3:
> > > - in patch 7/7: used initializers to set values for pdata and dev local vars
> > >
> > > Bartosz Golaszewski (7):
> > >   sh: ecovec24: add additional properties to the backlight device
> > >   backlight: gpio: simplify the platform data handling
> > >   sh: ecovec24: don't set unused fields in platform data
> > >   backlight: gpio: remove unused fields from platform data
> > >   backlight: gpio: remove dev from struct gpio_backlight
> > >   backlight: gpio: remove def_value from struct gpio_backlight
> > >   backlight: gpio: use a helper variable for &pdev->dev
> > >
> > >  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
> > >  drivers/video/backlight/gpio_backlight.c     | 82 +++++---------------
> > >  include/linux/platform_data/gpio_backlight.h |  3 -
> > >  3 files changed, 44 insertions(+), 74 deletions(-)
> > >
> > > --
> > > 2.21.0
> > >
> >
> > Hi Rich, Yoshinori,
> >
> > can you ack the sh patches in this series?
> >
> > Bart
>
> Ping.

Hi,

any chance of getting this reviewed for sh?

Bart
