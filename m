From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Jun 2019 11:16:55 +0000
Subject: Re: [PATCH 06/12] ARM: davinci: da850-evm: model the backlight GPIO as an actual device
Message-Id: <CACRpkdZdKigQ08bf5P9sYf-EhWFn5LmMRPQoMS2O5ouB9h6=MQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl> <20190625163434.13620-7-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Tue, Jun 25, 2019 at 5:34 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Instead of enabling the panel backlight in a callback defined in board
> file using deprecated legacy GPIO API calls, model the line as a GPIO
> backlight device.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
