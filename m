From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Mon, 18 May 2015 08:37:51 +0000
Subject: Re: [PATCH v3 02/17] leds: port locomo leds driver to new locomo core
Message-Id: <5559A4DF.3010101@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
 <1431880077-26321-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1431880077-26321-3-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org

Hi Dmitry,

On 05/17/2015 06:27 PM, Dmitry Eremin-Solenikov wrote:
> Adapt locomo leds driver to new locomo core setup.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>   drivers/leds/Kconfig       |   2 +-
>   drivers/leds/leds-locomo.c | 117 +++++++++++++++++++++++----------------------
>   2 files changed, 61 insertions(+), 58 deletions(-)

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski
