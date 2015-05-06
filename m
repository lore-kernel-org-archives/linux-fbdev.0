From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 06 May 2015 14:19:14 +0000
Subject: Re: [PATCH v2 13/17] ASoC: pxa: poodle: make use of new locomo GPIO interface
Message-Id: <CACRpkdYDRA-qtotEqniqd6m=HetBgtX5r7gJoc9x4oA9mp9i8w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-14-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1430178954-11138-14-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, linux-leds@vger.kernel.or

On Tue, Apr 28, 2015 at 1:55 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Since LoCoMo driver has been converted to provide proper gpiolib
> interface, make poodle ASoC platform driver use gpiolib API.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
