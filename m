From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 23 Oct 2019 15:59:41 +0000
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-Id: <20191023155941.q563d3cfizre4zvt@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Tue, Oct 22, 2019 at 11:29:54AM +0200, Bartosz Golaszewski wrote:
> wt., 22 paź 2019 o 10:36 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > While working on my other series related to gpio-backlight[1] I noticed
> > that we could simplify the driver if we made the only user of platform
> > data use GPIO lookups and device properties. This series tries to do
> > that.
> >
> > First two patches contain minor fixes. Third patch makes the driver
> > explicitly drive the GPIO line. Fourth patch adds all necessary data
> > structures to ecovec24. Patch 5/9 unifies much of the code for both
> > pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
> > fields. Last two patches contain additional improvements for the GPIO
> > backlight driver while we're already modifying it.
> >
> > I don't have access to this HW but hopefully this works. Only compile
> > tested.
> >
> > [1] https://lkml.org/lkml/2019/6/25/900
> >
> > v1 -> v2:
> > - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> > - added additional two patches with minor improvements
> >
> > v2 -> v3:
> > - in patch 7/7: used initializers to set values for pdata and dev local vars
> >
> > v3 -> v4:
> > - rebased on top of v5.4-rc1
> > - removed changes that are no longer relevant after commit ec665b756e6f
> >   ("backlight: gpio-backlight: Correct initial power state handling")
> > - added patch 7/7
> >
> > v4 -> v5:
> > - in patch 7/7: added a comment replacing the name of the function being
> >   pulled into probe()
> >
> > v5 -> v6:
> > - added a patch making the driver explicitly set the direction of the GPIO
> >   to output
> > - added a patch removing a redundant newline
> >
> > v6 -> v7:
> > - renamed the function calculating the new GPIO value for status update
> > - collected more tags
> >
> > Bartosz Golaszewski (9):
> >   backlight: gpio: remove unneeded include
> >   backlight: gpio: remove stray newline
> >   backlight: gpio: explicitly set the direction of the GPIO
> >   sh: ecovec24: add additional properties to the backlight device
> >   backlight: gpio: simplify the platform data handling
> >   sh: ecovec24: don't set unused fields in platform data
> >   backlight: gpio: remove unused fields from platform data
> >   backlight: gpio: use a helper variable for &pdev->dev
> >   backlight: gpio: pull gpio_backlight_initial_power_state() into probe
> >
> >  arch/sh/boards/mach-ecovec24/setup.c         |  33 +++--
> >  drivers/video/backlight/gpio_backlight.c     | 128 +++++++------------
> >  include/linux/platform_data/gpio_backlight.h |   3 -
> >  3 files changed, 69 insertions(+), 95 deletions(-)
> >
> > --
> > 2.23.0
> >
> 
> Lee, Daniel, Jingoo,
> 
> Jacopo is travelling until November 1st and won't be able to test this
> again before this date. Do you think you can pick it up and in case
> anything's broken on SH, we can fix it after v5.5-rc1, so that it
> doesn't miss another merge window?

Outside of holidays and other emergencies Lee usually collects up the
patches for backlight. I'm not sure when he plans to close things for
v5.5 .


Daniel.
