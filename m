From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 19 Jan 2017 06:38:57 +0000
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
Message-Id: <CACRpkdYJFsgVN4Q+7XbMcNC1topUan7+o6PCBWBC4aifM8sq-g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117231421.16310-1-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p

On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> One problem still unresolved: the pinctrl framework does not allow us to
> configure each pin on demand (someone please prove me wrong), when the
> various PWM channels are requested or released. For instance, the PWM
> channels can be configured from sysfs, which would require all PWM pins
> to be configured properly beforehand for the PWM function, eventually
> causing conflicts with other platform or board drivers.

Why do you think this?

- Pincontrol handles can be obtained at runtime.
- Pincontrol states can be changed at runtime.

The fact that a the handle is retrived by the device core and set to
the states named "init" or "default" during boot is just a convenience.

You can have as many and as fine-grained states as you want. They
can pertain to just one pin too.

Linus Walleij
