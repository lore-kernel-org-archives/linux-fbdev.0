From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 09 May 2014 09:06:45 +0000
Subject: Re: [PATCH] backlight: gpio-backlight: Fix warning when the GPIO is on a I2C chip
Message-Id: <CACRpkdZV647fx5j+a8ds_1eHffwnUijvX7qodH7LgJtYkqvvEw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140509012454.GL2198@atomide.com>
	<004701cf6b2d$e1a39c10$a4ead430$%han@samsung.com>
	<20140509030925.GN2198@atomide.com>
	<000001cf6b38$a6a3ffa0$f3ebfee0$%han@samsung.com>
In-Reply-To: <000001cf6b38$a6a3ffa0$f3ebfee0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>

On Fri, May 9, 2014 at 5:42 AM, Jingoo Han <jg1.han@samsung.com> wrote:

> Linus Walleij,
> Is there any reason to keep these two functions such as
> gpiod_set_raw_value_cansleep() and gpiod_set_raw_value()?

Yes, the former can *not* be called from interrupt context,
and thus erroneous usage can be detected with runtime checks.

Yours,
Linus Walleij
