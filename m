From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 12:58:34 +0000
Subject: Re: [PATCH 01/12] backlight: gpio: allow to probe non-pdata devices from board files
Message-Id: <bec514d8-a005-5c10-7770-d6fcd541ded4@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163457epcas3p2e246a27cb3ec0f0ffa48d32561ff3972@epcas3p2.samsung.com>
        <20190625163434.13620-2-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently we can only probe devices that either use device tree or pass
> platform data to probe(). Rename gpio_backlight_probe_dt() to
> gpio_backlight_probe_prop() and use generic device properties instead
> of OF specific helpers. Reverse the logic checking the presence of
> platform data in probe(). This way we can probe devices() registered
> from machine code that neither have a DT node nor use platform data.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
