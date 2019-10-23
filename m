From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 23 Oct 2019 13:13:21 +0000
Subject: Re: [PATCH 28/36] fbdev: s3c2410fb: remove mach header dependency
Message-Id: <20191023131321.GH11048@pi3>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-28-arnd@arndb.de>
In-Reply-To: <20191010203043.1241612-28-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Kukjin Kim <kgene@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org

On Thu, Oct 10, 2019 at 10:30:12PM +0200, Arnd Bergmann wrote:
> The s3c2410fb driver is too deeply intertwined with the s3c24xx
> platform code. Change it in a way that avoids the use of platform
> header files but having all interface data in a platform_data
> header, and the private register definitions next to the driver
> itself.
> 
> One ugly bit here is that the driver pokes directly into gpio
> registers, which are owned by another driver. Passing the
> mapped addresses in platform_data is somewhat suboptimal, but
> it is a small improvement over the previous version.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/include/mach/fb.h       |  2 --
>  arch/arm/mach-s3c24xx/mach-amlm5900.c         |  7 ++--
>  arch/arm/mach-s3c24xx/mach-anubis.c           |  1 -
>  arch/arm/mach-s3c24xx/mach-at2440evb.c        |  3 +-
>  arch/arm/mach-s3c24xx/mach-bast.c             |  3 +-
>  arch/arm/mach-s3c24xx/mach-gta02.c            |  2 +-
>  arch/arm/mach-s3c24xx/mach-h1940.c            |  7 ++--
>  arch/arm/mach-s3c24xx/mach-jive.c             | 10 ++++--
>  arch/arm/mach-s3c24xx/mach-mini2440.c         |  9 +++--
>  arch/arm/mach-s3c24xx/mach-n30.c              |  3 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c           |  1 -
>  arch/arm/mach-s3c24xx/mach-qt2410.c           |  3 +-
>  arch/arm/mach-s3c24xx/mach-rx1950.c           |  8 +++--
>  arch/arm/mach-s3c24xx/mach-rx3715.c           |  7 ++--
>  arch/arm/mach-s3c24xx/mach-smdk2413.c         |  3 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c         |  1 -
>  arch/arm/mach-s3c24xx/mach-smdk2440.c         |  8 +++--
>  arch/arm/mach-s3c24xx/mach-smdk2443.c         |  3 +-
>  arch/arm/mach-s3c24xx/mach-vstms.c            |  3 +-
>  arch/arm/plat-samsung/devs.c                  |  2 +-
>  .../video/fbdev/s3c2410fb-regs-lcd.h          | 28 ++++------------
>  drivers/video/fbdev/s3c2410fb.c               | 16 +++++----
>  .../linux/platform_data}/fb-s3c2410.h         | 33 ++++++++++++++++++-
>  23 files changed, 98 insertions(+), 65 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/fb.h
>  rename arch/arm/mach-s3c24xx/include/mach/regs-lcd.h => drivers/video/fbdev/s3c2410fb-regs-lcd.h (84%)
>  rename {arch/arm/plat-samsung/include/plat => include/linux/platform_data}/fb-s3c2410.h (57%)
> 
> diff --git a/arch/arm/mach-s3c24xx/include/mach/fb.h b/arch/arm/mach-s3c24xx/include/mach/fb.h
> deleted file mode 100644
> index 4e539cb8b884..000000000000
> --- a/arch/arm/mach-s3c24xx/include/mach/fb.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <plat/fb-s3c2410.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
> index 40ad23b52bc0..ef6de1b1d0c6 100644
> --- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
> +++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
> @@ -30,9 +30,8 @@
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
>  #include <asm/mach-types.h>
> -#include <mach/fb.h>
> +#include <linux/platform_data/fb-s3c2410.h>
>  
> -#include <mach/regs-lcd.h>
>  #include <mach/regs-gpio.h>
>  #include <mach/gpio-samsung.h>
>  
> @@ -194,13 +193,17 @@ static struct s3c2410fb_mach_info __initdata amlm5900_fb_info = {
>  
>  	.gpccon =	0xaaaaaaaa,
>  	.gpccon_mask =	0xffffffff,
> +	.gpccon_reg =	S3C2410_GPCCON,
>  	.gpcup =	0x0000ffff,
>  	.gpcup_mask =	0xffffffff,
> +	.gpcup_reg =	S3C2410_GPCUP,
>  
>  	.gpdcon =	0xaaaaaaaa,
>  	.gpdcon_mask =	0xffffffff,
> +	.gpdcon_reg =	S3C2410_GPDCON,
>  	.gpdup =	0x0000ffff,
>  	.gpdup_mask =	0xffffffff,
> +	.gpdup_reg =	S3C2410_GPDUP,
>  };
>  #endif
>  
> diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
> index 072966dcad78..e1a73274e90b 100644
> --- a/arch/arm/mach-s3c24xx/mach-anubis.c
> +++ b/arch/arm/mach-s3c24xx/mach-anubis.c
> @@ -29,7 +29,6 @@
>  #include <asm/mach-types.h>
>  
>  #include <mach/regs-gpio.h>
> -#include <mach/regs-lcd.h>
>  #include <mach/gpio-samsung.h>
>  #include <linux/platform_data/mtd-nand-s3c2410.h>
>  #include <linux/platform_data/i2c-s3c2410.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
> index b2199906e678..bfda6dd2a9d5 100644
> --- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
> +++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
> @@ -25,12 +25,11 @@
>  #include <asm/mach/irq.h>
>  
>  #include <mach/hardware.h>
> -#include <mach/fb.h>
> +#include <linux/platform_data/fb-s3c2410.h>
>  #include <asm/irq.h>
>  #include <asm/mach-types.h>
>  
>  #include <mach/regs-gpio.h>
> -#include <mach/regs-lcd.h>
>  #include <mach/gpio-samsung.h>
>  #include <linux/platform_data/mtd-nand-s3c2410.h>
>  #include <linux/platform_data/i2c-s3c2410.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
> index a7c3955ae8f6..cc941b5030ea 100644
> --- a/arch/arm/mach-s3c24xx/mach-bast.c
> +++ b/arch/arm/mach-s3c24xx/mach-bast.c
> @@ -40,10 +40,9 @@
>  #include <asm/mach/irq.h>
>  #include <asm/mach-types.h>
>  
> -#include <mach/fb.h>
>  #include <mach/hardware.h>
> +#include <linux/platform_data/fb-s3c2410.h>
>  #include <mach/regs-gpio.h>
> -#include <mach/regs-lcd.h>
>  #include <mach/gpio-samsung.h>
>  
>  #include <plat/cpu.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
> index 61b8c6badeb8..1e42782dbd30 100644
> --- a/arch/arm/mach-s3c24xx/mach-gta02.c
> +++ b/arch/arm/mach-s3c24xx/mach-gta02.c
> @@ -57,8 +57,8 @@
>  #include <linux/platform_data/touchscreen-s3c2410.h>
>  #include <linux/platform_data/usb-ohci-s3c2410.h>
>  #include <linux/platform_data/usb-s3c2410_udc.h>
> +#include <linux/platform_data/fb-s3c2410.h>
>  
> -#include <mach/fb.h>
>  #include <mach/hardware.h>
>  #include <mach/regs-gpio.h>
>  #include <mach/regs-irq.h>
> diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
> index 446891e23511..d56e3befa459 100644
> --- a/arch/arm/mach-s3c24xx/mach-h1940.c
> +++ b/arch/arm/mach-s3c24xx/mach-h1940.c
> @@ -47,11 +47,10 @@
>  
>  #include <sound/uda1380.h>
>  
> -#include <mach/fb.h>
> +#include <linux/platform_data/fb-s3c2410.h>
>  #include <mach/hardware.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-gpio.h>
> -#include <mach/regs-lcd.h>
>  #include <mach/gpio-samsung.h>
>  
>  #include <plat/cpu.h>
> @@ -211,12 +210,16 @@ static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
>  	.lpcsel =	0x02,
>  	.gpccon =	0xaa940659,
>  	.gpccon_mask =	0xffffc0f0,
> +	.gpccon_reg =	S3C2410_GPCCON,
>  	.gpcup =	0x0000ffff,
>  	.gpcup_mask =	0xffffffff,
> +	.gpcup_reg =	S3C2410_GPCUP,
>  	.gpdcon =	0xaa84aaa0,
>  	.gpdcon_mask =	0xffffffff,
> +	.gpdcon_reg =	S3C2410_GPDCON,
>  	.gpdup =	0x0000faff,
>  	.gpdup_mask =	0xffffffff,
> +	.gpdup_reg =	S3C2410_GPDUP,
>  };
>  
>  static int power_supply_init(struct device *dev)
> diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
> index 885e8f12e4b9..3b33132b2334 100644
> --- a/arch/arm/mach-s3c24xx/mach-jive.c
> +++ b/arch/arm/mach-s3c24xx/mach-jive.c
> @@ -32,8 +32,7 @@
>  #include <linux/platform_data/i2c-s3c2410.h>
>  
>  #include <mach/regs-gpio.h>
> -#include <mach/regs-lcd.h>
> -#include <mach/fb.h>
> +#include <linux/platform_data/fb-s3c2410.h>
>  #include <mach/gpio-samsung.h>
>  
>  #include <asm/mach-types.h>
> @@ -321,6 +320,7 @@ static struct s3c2410fb_mach_info jive_lcd_config = {
>  	 * data. */
>  
>  	.gpcup		= (0xf << 1) | (0x3f << 10),
> +	.gpcup_reg =	S3C2410_GPCUP,

Nits: indentation before/after '=' looks wrong. Tab should be
before '=', one space after.

Best regards,
Krzysztof
