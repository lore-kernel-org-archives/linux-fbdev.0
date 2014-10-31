From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 31 Oct 2014 07:50:47 +0000
Subject: Re: [PATCH 09/15] ARM: sa1100: don't preallocate IRQ space for locomo
Message-Id: <CACRpkdZnAtXtdtKbuqj8a_6a=2jS_Jf6yrq=iz-GJV+4RifRhw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-10-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1414454528-24240-10-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo

On Tue, Oct 28, 2014 at 1:02 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> As new locomo driver properly supports SPARSE_IRQ, stop playing with
> NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

That's right! By moving to irqdomain things get even better :)

Yours,
Linus Walleij
