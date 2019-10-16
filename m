From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2019 12:56:57 +0000
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
Message-Id: <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191007033200.13443-1-brgl@bgdev.pl> <20191014081220.GK4545@dell>
In-Reply-To: <20191014081220.GK4545@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Mon, Oct 14, 2019 at 10:12 AM Lee Jones <lee.jones@linaro.org> wrote:

> >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
>
> I guess we're just waiting for the SH Acks now?

The one maintainer with this board is probably overloaded.

I would say just apply it, it can't hold back the entire series.

Yours,
Linus Walleij
