From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2019 16:20:19 +0000
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
Message-Id: <CAMRc=Mc0-c_Cnbbh981pXQHW70GW1kh5hYioxJQM6JrOnCe4NQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191007033200.13443-1-brgl@bgdev.pl> <20191014081220.GK4545@dell>
 <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
 <20191016130536.222vsi5whkoy6vzo@uno.localdomain> <20191017072550.GK4365@dell>
 <20191018150426.7w5q55nhkiqbqhuk@uno.localdomain>
In-Reply-To: <20191018150426.7w5q55nhkiqbqhuk@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jacopo Mondi <jacopo@jmondi.org>
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

pt., 18 paź 2019 o 17:02 Jacopo Mondi <jacopo@jmondi.org> napisał(a):
>
> Hi,
>
> On Thu, Oct 17, 2019 at 08:25:50AM +0100, Lee Jones wrote:
> > On Wed, 16 Oct 2019, Jacopo Mondi wrote:
> >
> > > Hi, sorry for not having replied earlier
> > >
> > > On Wed, Oct 16, 2019 at 02:56:57PM +0200, Linus Walleij wrote:
> > > > On Mon, Oct 14, 2019 at 10:12 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
> > > > >
> > > > > I guess we're just waiting for the SH Acks now?
> > > >
> > > > The one maintainer with this board is probably overloaded.
> > > >
> > > > I would say just apply it, it can't hold back the entire series.
> > >
> > > I've been able to resurect the Ecovec, and I've also been given a copy
> > > of its schematics file a few weeks ago.
> > >
> > > It's in my TODO list to test this series but I didn't manage to find
> > > time. If I pinky promise I get back to you before end of the week,
> > > could you wait for me ? :)
>
> Finally had some time to spend on this.
>
> As I've reported to Bartosz, this version does not work on Ecovec out
> of the box, as the GPIO line connected to the backlight needs to be
> configured to work in output mode before registering the backlight
> device.
>
> With this simple change:
>
> $ git diff
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index dd427bac5cde..eec6e805c3ed 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -1473,6 +1473,7 @@ static int __init arch_setup(void)
>  #endif
>  #endif
>
> +       gpio_direction_output(GPIO_PTR1, 1);

This is a hack actually. The problem lies with the gpio backlight
driver - it should really set the mode to output, not leave it as is.
If there's no good reason to keep it as it is now, I'll add another
patch to the series that moves the call to devm_gpiod_get() to where
we've already determined the initial value in probe() and pass an
appropriate GPIOD_OUT_HIGH/LOW flag.

Bart

>         gpiod_add_lookup_table(&gpio_backlight_lookup);
>         gpio_backlight_device = platform_device_register_full(
>                                         &gpio_backlight_device_info);
>
> I can now control the gpio through the backlight interface.
>
> So please add this bit on top of next iteration and add my:
> Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Thanks and sorry for the long time it took!
>
> >
> > Yes, no problem.
> >
> > --
> > Lee Jones [李琼斯]
> > Linaro Services Technical Lead
> > Linaro.org │ Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog
