From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Jan 2017 14:20:04 +0000
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
Message-Id: <CACRpkdbcO+1c7izYpn0sb1mkE1ORFETMq=xtzVi1hKbJz0EWfw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-5-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p

Forgot to mention this:

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> This driver handles the GPIOs of all the Ingenic JZ47xx SoCs
> currently supported by the upsteam Linux kernel.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
(...)
> +       jzgc->gc.base = -1;

Nice

> +       of_property_read_u32(dev->of_node, "base", &jzgc->gc.base);

Remove this. Dynamic allocation should be fine, if you're using the
new userspace ABI like tools/gpio/* or libgpiod and only that and in-kernel
consumers, dynamic numbers are just fine.

If you have old sysfs userspace that you need to support using the
global GPIO numberspace, please look into ways to phase that out.

Yours,
Linus Walleij
