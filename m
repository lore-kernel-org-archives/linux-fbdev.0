From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 04 Feb 2017 20:29:50 +0000
Subject: Re: [PATCH v3 2/2] gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper
Message-Id: <CACRpkdYaLy8dNYEYKCocXf6jc0XPumQ6KoEnSkwaWvUs3m9Djw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1486043591-6278-3-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1486043591-6278-3-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thu, Feb 2, 2017 at 2:53 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:

> devm_fwnode_get_gpiod_from_child() currently allows GPIO users to
> request a GPIO that is defined in a child fwnode instead of directly in
> the device fwnode.
> Extend this API by adding the devm_fwnode_get_index_gpiod_from_child()
> helper which does the same except you can also specify an index in case
> the 'xx-gpios' property describe several GPIOs.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Patch applied.

Both are stacked on ib-gpiod-flags for now, going into test compile.

Yours,
Linus Walleij
