From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 10 Jun 2019 13:01:50 +0000
Subject: Re: [PATCH 8/8] drivers: regulator: 88pm800: fix warning same module names
Message-Id: <CADYN=9+5RCiSRQdV+vcUT9cqH6fMAMFpMUmApzT2hRfeivfhHg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190606094736.23970-1-anders.roxell@linaro.org> <20190606105954.GZ2456@sirena.org.uk>
In-Reply-To: <20190606105954.GZ2456@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, marex@denx.de, stefan@agner.ch, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, shawnguo@kernel.org, s.hauer@pengutronix.de, b.zolnierkie@samsung.com, a.hajda@samsung.com, Mauro Carvalho Chehab <mchehab@kernel.org>, p.zabel@pengutronix.de, hkallweit1@gmail.com, Lee Jones <lee.jones@linaro.org>, David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

On Thu, 6 Jun 2019 at 13:00, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 06, 2019 at 11:47:36AM +0200, Anders Roxell wrote:
>
> >  obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
> > -obj-$(CONFIG_REGULATOR_88PM800) += 88pm800.o
> > +obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
> > +88pm800-regulator-objs               := 88pm800.o
>
> Don't do this, no need for this driver to look different to all the
> others in the Makefile - just rename the whole file.

Thank you for your review, I'll rework and resend v2 shortly.

Cheers,
Anders
