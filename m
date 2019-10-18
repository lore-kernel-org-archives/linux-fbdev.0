From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 18 Oct 2019 19:03:54 +0000
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Message-Id: <87v9slg9k5.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Fri, 18 Oct 2019 17:40:52 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Hi PXA maintainers,
>
> I'm in the process of getting the old ARM platforms to all build
> in a single kernel. The largest part of that work is changing all
> the device drivers to no longer require mach/*.h header files.
>
> This series does it for arch/pxa/.
>
> As with the omap1 and s3c24xx series I sent before, I don't
> expect this all to be correct in the first version, though
> a lot of the patches are fairly simple and I did exhaustive
> compile-time testing on them.
>
> Please test if you have the hardware, or review!

Hi Arnd,

Would you have a git tree I can pull from ?
That would make my life easier than applying manually 46 patches...

Cheers.

--
Robert
