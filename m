From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 19 Oct 2019 10:09:33 +0000
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Message-Id: <CAK8P3a0t-P_w705z0BSXxzj8MmmKVCagLtidiP+NX51zGce0ag@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
In-Reply-To: <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-rtc@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, IDE-ML <linux-ide@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, linux-leds@vger.kernel.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sat, Oct 19, 2019 at 3:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/18/19 8:40 AM, Arnd Bergmann wrote:
>
> I don't get very far.
>
> $ make-arm pxa_defconfig
> arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
> scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed

>
> Did I pick the wrong tree ?

It seems that one line got lost in a rebase and ended up in a different patch
that was not part of the series. I updated the git tree now.

        Arnd
