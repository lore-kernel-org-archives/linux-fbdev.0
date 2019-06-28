From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 12:59:55 +0000
Subject: Re: [PATCH 03/12] backlight: gpio: pull the non-pdata device probing code into probe()
Message-Id: <cb6b2f51-f1cb-74f9-2638-fa7becd0b2c4@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163459epcas3p1331f76cb55291f41c5a4c3e37e0713fe@epcas3p1.samsung.com>
        <20190625163434.13620-4-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There's no good reason to have the generic probing code in a separate
> routine. This function is short and is inlined by the compiler anyway.
> Move it into probe under the pdata-specific part.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
