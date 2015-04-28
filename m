From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 28 Apr 2015 19:36:10 +0000
Subject: Re: [PATCH v2 15/17] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Message-Id: <87618gjb9x.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-16-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1430178954-11138-16-git-send-email-dbaryshkov@gmail.com> (Dmitry
	Eremin-Solenikov's message of "Tue, 28 Apr 2015 02:55:52 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
> space for it on poodle.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
