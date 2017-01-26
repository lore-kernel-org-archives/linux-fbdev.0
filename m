From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 26 Jan 2017 10:10:37 +0000
Subject: Re: [PATCH v3 10/14] mmc: jz4740: Let the pinctrl driver configure  the pins
Message-Id: <0e03c853297688e19a9ddca239aaa583@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701261459.cfXHvGfn%fengguang.wu@intel.com>
In-Reply-To: <201701261459.cfXHvGfn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

Hi Kbuild Test Robot,

> 
> drivers/mmc/host/jz4740_mmc.c: In function 'jz4740_mmc_set_ios':
> drivers/mmc/host/jz4740_mmc.c:864:7: error: implicit declaration of 
> function 'gpio_is_valid' [-Werror=implicit-function-declaration]

  if (gpio_is_valid(host->pdata->gpio_power))
  ^~~~~~~~~~~~~

Uuh, I'm sorry about that. Looks like I removed one header too much 
(<linux/gpio.h>).
My fault, lately I was testing with ci20_defconfig which doesn't enable 
this driver.

Should I send a v4?

Apologies,
-Paul
