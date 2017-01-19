From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jan 2017 10:55:41 +0000
Subject: Re: [PATCH 09/13] mmc: jz4740: Let the pinctrl driver configure the pins
Message-Id: <CAPDyKFp4idZx+ynQByz22zwsiK+reBcvt3OdHm1kR2QUy+sUhw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-10-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-10-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, Linux

[...]

>
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int jz4740_mmc_suspend(struct device *dev)
> -{
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
> -

Shouldn't this be replaced with a call to:
pinctrl_pm_select_sleep_state();

> -       return 0;
> -}
> -
> -static int jz4740_mmc_resume(struct device *dev)
> -{
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));

Shouldn't this be replaced with a call to:
pinctrl_pm_select_default_state();

[...]

Kind regards
Uffe
