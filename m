From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Aug 2019 08:36:47 +0000
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
Message-Id: <CAMuHMdV3obGtQ7qohNedQNgpvZvyL9xjH0HUiBKD6b8Ou5F+XA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl> <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
 <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com> <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com>
In-Reply-To: <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lee Jones <lee.jones@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jacopo Mondi <jacopo@jmondi.org>

CC the pour soul with the ecovec board.

On Wed, Aug 28, 2019 at 9:33 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> pt., 16 sie 2019 o 17:48 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > czw., 8 sie 2019 o 10:17 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > śr., 24 lip 2019 o 10:25 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > While working on my other series related to gpio-backlight[1] I noticed
> > > > that we could simplify the driver if we made the only user of platform
> > > > data use GPIO lookups and device properties. This series tries to do
> > > > that.
> > > >
> > > > The first patch adds all necessary data structures to ecovec24. Patch
> > > > 2/7 unifies much of the code for both pdata and non-pdata cases. Patches
> > > > 3-4/7 remove unused platform data fields. Last three patches contain
> > > > additional improvements for the GPIO backlight driver while we're already
> > > > modifying it.
> > > >
> > > > I don't have access to this HW but hopefully this works. Only compile
> > > > tested.
> > > >
> > > > [1] https://lkml.org/lkml/2019/6/25/900
> > > >
> > > > v1 -> v2:
> > > > - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> > > > - added additional two patches with minor improvements
> > > >
> > > > v2 -> v3:
> > > > - in patch 7/7: used initializers to set values for pdata and dev local vars
> > > >
> > > > Bartosz Golaszewski (7):
> > > >   sh: ecovec24: add additional properties to the backlight device
> > > >   backlight: gpio: simplify the platform data handling
> > > >   sh: ecovec24: don't set unused fields in platform data
> > > >   backlight: gpio: remove unused fields from platform data
> > > >   backlight: gpio: remove dev from struct gpio_backlight
> > > >   backlight: gpio: remove def_value from struct gpio_backlight
> > > >   backlight: gpio: use a helper variable for &pdev->dev
> > > >
> > > >  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
> > > >  drivers/video/backlight/gpio_backlight.c     | 82 +++++---------------
> > > >  include/linux/platform_data/gpio_backlight.h |  3 -
> > > >  3 files changed, 44 insertions(+), 74 deletions(-)
> > > >
> > > > --
> > > > 2.21.0
> > > >
> > >
> > > Hi Rich, Yoshinori,
> > >
> > > can you ack the sh patches in this series?
> > >
> > > Bart
> >
> > Ping.
>
> Hi,
>
> any chance of getting this reviewed for sh?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
