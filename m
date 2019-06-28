From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Jun 2019 10:15:10 +0000
Subject: Re: [PATCH RFT 0/4] backlight: gpio: simplify the driver
Message-Id: <CACRpkdZqsgXoZcHv9z+7oVrf=i9WPSHG=93qhfA=0SkR0Mdfxg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190628100253.8385-1-brgl@bgdev.pl>
In-Reply-To: <20190628100253.8385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Fri, Jun 28, 2019 at 11:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
>
> The first patch sets up all the required structures in the board file,
> the second modifies the backlight driver, the third and fourth remove
> the leftovers.
>
> This series depends on the three first patches from [1].
>
> I don't have access to this HW but hopefully this works. Only compile
> tested.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Excellent work!

Yours,
Linus Walleij
