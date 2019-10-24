From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 24 Oct 2019 12:10:47 +0000
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-Id: <20191024121047.GM15843@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
 <20191023155941.q563d3cfizre4zvt@holly.lan>
 <20191024064726.GB15843@dell>
 <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
In-Reply-To: <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jacopo Mondi <jacopo@jmondi.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Thu, 24 Oct 2019, Jacopo Mondi wrote:
> On Thu, Oct 24, 2019 at 07:47:26AM +0100, Lee Jones wrote:
> > On Wed, 23 Oct 2019, Daniel Thompson wrote:

[...]

> > > > Jacopo is travelling until November 1st and won't be able to test this
> > > > again before this date. Do you think you can pick it up and in case
> > > > anything's broken on SH, we can fix it after v5.5-rc1, so that it
> > > > doesn't miss another merge window?
> >
> > November 1st (-rc6) will be fine.
> >
> > I'd rather apply it late-tested than early-non-tested.
> >
> > Hopefully Jacopo can prioritise testing this on Thursday or Friday,
> > since Monday will be -rc7 which is really cutting it fine.
> 
> I'll do my best, I'll get home Friday late afternoon :)

Thanks. We'd all really appreciate it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
