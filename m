From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Jan 2017 15:07:07 +0000
Subject: Re: [PATCH v2 1/1] of: Pass GPIO label down to gpiod_request when using get_gpiod_from_child
Message-Id: <CACRpkdbbRcKvYuE4_oA2pPQsCpEhb_JbPDyvrcuJvK5y1BD6Og@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170112163924.4414-1-alexander.stein@systec-electronic.com>
In-Reply-To: <20170112163924.4414-1-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Thu, Jan 12, 2017 at 5:39 PM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:

> Currently all users of fwnode_get_named_gpiod() have no way to specify a
> label for the GPIO. So GPIOs listed in debugfs are shown with label "?".
> With this change a proper label is used.
> Also adjust all users so they can pass a label, properly retrieved from
> device tree properties.
>
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> ---
> v2:
> * Non-RFC
> * This patch is rebased on gpio/for-next branch and cherry-picked commit
> 2715bbe from https://bitbucket.org/andy-shev/linux.git

Patch applied on top of Andy's patch.

Let's see if this all builds and works :)

Yours,
Linus Walleij
