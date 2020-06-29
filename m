From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 29 Jun 2020 21:08:17 +0000
Subject: Re: [PATCH] Remove handhelds.org links and email addresses
Message-Id: <20200629210817.GA32399@kozik-lap>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200629203121.7892-1-grandmaster@al2klimov.de>
In-Reply-To: <20200629203121.7892-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: ulf.hansson@linaro.org, gustavo@embeddedor.com, tony@atomide.com, daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com, mchehab+samsung@kernel.org, lee.jones@linaro.org, corbet@lwn.net, linux-samsung-soc@vger.kernel.org, aaro.koskinen@iki.fi, robert.jarzmik@free.fr, rafael.j.wysocki@intel.com, yuehaibing@huawei.com, linux@armlinux.org.uk, kgene@kernel.org, viresh.kumar@linaro.org, kuba@kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, jani.nikula@intel.com, linux-mmc@vger.kernel.org, linux-input@vger.kernel.org, j.neuschaefer@gmx.net, haojian.zhuang@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, yanaijie@huawei.com, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Julia.Lawall@inria.fr, netdev@vger.kernel.org, davem@davemloft.net, daniel@zonque.org

On Mon, Jun 29, 2020 at 10:31:21PM +0200, Alexander A. Klimov wrote:
> Rationale:
> https://lore.kernel.org/linux-doc/20200626110706.7b5d4a38@lwn.net/
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  @Jon I thought about what I said and *no*, unfortunately I *can't* automate
>  the detection of such as easy as the HTTPSifying. As you maybe see below
>  cleaning up is even "harder".
> 
>  We have only 17 files and one domain here. Shall I split it up per subsystem
>  or can we let it as is?
> 
>  Documentation/arm/sa1100/assabet.rst           |  2 --
>  Documentation/arm/samsung-s3c24xx/h1940.rst    | 10 ----------
>  Documentation/arm/samsung-s3c24xx/overview.rst |  3 +--
>  Documentation/arm/samsung-s3c24xx/smdk2440.rst |  4 ----
>  arch/arm/mach-omap1/Kconfig                    |  4 +---
>  arch/arm/mach-pxa/h5000.c                      |  2 +-
>  arch/arm/mach-s3c24xx/mach-h1940.c             |  2 --
>  arch/arm/mach-s3c24xx/mach-n30.c               |  3 ---
>  arch/arm/mach-s3c24xx/mach-rx3715.c            |  2 --

For s3c24xx, I am fine taking it through docs tree:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Otherwise, after splitting, I could take the s3c-24xx bits.

Best regards,
Krzysztof


>  drivers/input/keyboard/gpio_keys.c             |  2 +-
>  drivers/input/keyboard/jornada720_kbd.c        |  2 +-
>  drivers/input/touchscreen/jornada720_ts.c      |  2 +-
>  drivers/mfd/asic3.c                            |  2 +-
>  drivers/mmc/host/renesas_sdhi_core.c           |  2 +-
>  drivers/net/ethernet/dec/tulip/de4x5.c         |  1 -
>  drivers/video/fbdev/sa1100fb.c                 |  2 +-
>  include/linux/apm-emulation.h                  |  2 --
>  17 files changed, 9 insertions(+), 38 deletions(-)
