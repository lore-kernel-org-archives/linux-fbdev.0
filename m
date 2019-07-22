From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 22 Jul 2019 16:09:50 +0000
Subject: Re: [PATCH v2 0/7] backlight: gpio: simplify the driver
Message-Id: <20190722160950.GA9224@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722150302.29526-1-brgl@bgdev.pl>
In-Reply-To: <20190722150302.29526-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Mon, Jul 22, 2019 at 05:02:55PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
> 
> The first patch adds all necessary data structures to ecovec24. Patch
> 2/7 unifies much of the code for both pdata and non-pdata cases. Patches
> 3-4/7 remove unused platform data fields. Last three patches contain
> additional improvements for the GPIO backlight driver while we're already
> modifying it.
> 
> I don't have access to this HW but hopefully this works. Only compile
> tested.
> 
> [1] https://lkml.org/lkml/2019/6/25/900

For uncommented ones
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> v1 -> v2:
> - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> - added additional two patches with minor improvements
> 
> Bartosz Golaszewski (7):
>   sh: ecovec24: add additional properties to the backlight device
>   backlight: gpio: simplify the platform data handling
>   sh: ecovec24: don't set unused fields in platform data
>   backlight: gpio: remove unused fields from platform data
>   backlight: gpio: remove dev from struct gpio_backlight
>   backlight: gpio: remove def_value from struct gpio_backlight
>   backlight: gpio: use a helper variable for &pdev->dev
> 
>  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
>  drivers/video/backlight/gpio_backlight.c     | 87 ++++++--------------
>  include/linux/platform_data/gpio_backlight.h |  3 -
>  3 files changed, 48 insertions(+), 75 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko
