From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 05 Aug 2019 09:53:04 +0000
Subject: Re: [PATCH v2 1/7] sh: ecovec24: add additional properties to the backlight device
Message-Id: <CACRpkdYexsXR=n+t1iVb1QMZc9U1FeKdyHy3w4VnfPy4B=xeiA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722150302.29526-1-brgl@bgdev.pl> <20190722150302.29526-2-brgl@bgdev.pl>
In-Reply-To: <20190722150302.29526-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Mon, Jul 22, 2019 at 5:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add a GPIO lookup entry and a device property for GPIO backlight to the
> board file. Tie them to the platform device which is now registered using
> platform_device_register_full() because of the properties. These changes
> are inactive now but will be used once the gpio backlight driver is
> modified.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Clever! I must also use these dynamic properties now.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
