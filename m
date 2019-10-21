From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 21 Oct 2019 02:39:36 +0000
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
Message-Id: <20191021022736.yu6unspozqf5634p@vireshk-i7>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-input@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>

On 18-10-19, 17:41, Arnd Bergmann wrote:
> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:
> 
> - the cpu_is_pxa* macros
> - an indirect inclusion of mach/addr-map.h
> - the __REG() and io_pv2() helper macros
> 
> Split it up into separate <linux/soc/pxa/cpu.h> and mach/pxa-regs.h
> headers, then change all the files that use mach/hardware.h to
> include the exact set of those three headers that they actually
> need, allowing for further more targeted cleanup.
> 
> linux/soc/pxa/cpu.h can remain permanently exported and is now in
> a global location along with similar headers. pxa-regs.h and
> addr-map.h are only used in a very small number of drivers now
> and can be moved to arch/arm/mach-pxa/ directly when those drivers
> are to pass the necessary data as resources.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c              |  1 +
>  drivers/cpufreq/pxa3xx-cpufreq.c              |  1 +

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
