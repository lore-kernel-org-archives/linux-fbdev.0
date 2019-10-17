From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 17 Oct 2019 07:25:50 +0000
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
Message-Id: <20191017072550.GK4365@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191007033200.13443-1-brgl@bgdev.pl>
 <20191014081220.GK4545@dell>
 <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
 <20191016130536.222vsi5whkoy6vzo@uno.localdomain>
In-Reply-To: <20191016130536.222vsi5whkoy6vzo@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jacopo Mondi <jacopo@jmondi.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Wed, 16 Oct 2019, Jacopo Mondi wrote:

> Hi, sorry for not having replied earlier
> 
> On Wed, Oct 16, 2019 at 02:56:57PM +0200, Linus Walleij wrote:
> > On Mon, Oct 14, 2019 at 10:12 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
> > >
> > > I guess we're just waiting for the SH Acks now?
> >
> > The one maintainer with this board is probably overloaded.
> >
> > I would say just apply it, it can't hold back the entire series.
> 
> I've been able to resurect the Ecovec, and I've also been given a copy
> of its schematics file a few weeks ago.
> 
> It's in my TODO list to test this series but I didn't manage to find
> time. If I pinky promise I get back to you before end of the week,
> could you wait for me ? :)

Yes, no problem.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
