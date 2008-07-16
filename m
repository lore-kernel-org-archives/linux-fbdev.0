From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 2/5] gumstix: conversion to
	MFP support and add bluetooth support
Date: Wed, 16 Jul 2008 14:55:00 +0800
Message-ID: <f17812d70807152355t72247d4dt34763c580e0f607b@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-3-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ0um-00085F-Bp for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 23:55:04 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ0uj-0000zZ-Pg
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 23:55:04 -0700
Received: by py-out-1112.google.com with SMTP id f31so1157148pyh.20
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 15 Jul 2008 23:55:01 -0700 (PDT)
In-Reply-To: <1215955587-20367-3-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch converts gumstix over to the MFP configuration system and adds
> bluetooth support. Added a CLK_32K clock to enable bluetooth.
>

The CLK_32KHz is assumed to be enabled always, so it's really not
necessary to create a struct clk for it. Please remove that from this
patch.

> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  arch/arm/mach-pxa/gumstix.c |   77 +++++++++++++++++++++++++++++++++---------
>  arch/arm/mach-pxa/pxa25x.c  |   31 +++++++++++++++++
>  2 files changed, 91 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
> index bdf2397..73c1cc5 100644
> --- a/arch/arm/mach-pxa/gumstix.c
> +++ b/arch/arm/mach-pxa/gumstix.c
> @@ -20,8 +20,12 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> +#include <linux/delay.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/gpio.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
>
>  #include <asm/setup.h>
>  #include <asm/memory.h>
> @@ -40,7 +44,7 @@
>
>  #include <asm/arch/pxa-regs.h>
>  #include <asm/arch/pxa2xx-regs.h>
> -#include <asm/arch/pxa2xx-gpio.h>
> +#include <asm/arch/mfp-pxa25x.h>
>
>  #include "generic.h"
>
> @@ -85,21 +89,8 @@ static struct platform_device *devices[] __initdata = {
>  };
>
>  #ifdef CONFIG_MMC_PXA
> -static struct pxamci_platform_data gumstix_mci_platform_data;
> -
> -static int gumstix_mci_init(struct device *dev, irq_handler_t detect_int,
> -                               void *data)
> -{
> -       pxa_gpio_mode(GPIO6_MMCCLK_MD);
> -       pxa_gpio_mode(GPIO53_MMCCLK_MD);
> -       pxa_gpio_mode(GPIO8_MMCCS0_MD);
> -
> -       return 0;
> -}
> -
>  static struct pxamci_platform_data gumstix_mci_platform_data = {
>        .ocr_mask       = MMC_VDD_32_33|MMC_VDD_33_34,
> -       .init           = gumstix_mci_init,
>  };
>
>  static void __init gumstix_mmc_init(void)
> @@ -109,11 +100,11 @@ static void __init gumstix_mmc_init(void)
>  #else
>  static void __init gumstix_mmc_init(void)
>  {
> -       printk(KERN_INFO "Gumstix mmc disabled\n");
> +       pr_debug("Gumstix mmc disabled\n");
>  }
>  #endif
>
> -#ifdef CONFIG_USB_GADGET_PXA2XX
> +#ifdef CONFIG_USB_GADGET_PXA25X
>  static struct pxa2xx_udc_mach_info gumstix_udc_info __initdata = {
>        .gpio_vbus              = GPIO_GUMSTIX_USB_GPIOn,
>        .gpio_pullup            = GPIO_GUMSTIX_USB_GPIOx,
> @@ -126,12 +117,64 @@ static void __init gumstix_udc_init(void)
>  #else
>  static void gumstix_udc_init(void)
>  {
> -       printk(KERN_INFO "Gumstix udc is disabled\n");
> +       pr_debug("Gumstix udc is disabled\n");
>  }
>  #endif
>
> +#ifdef CONFIG_BT
> +static void __init gumstix_bluetooth_init(void)
> +{
> +       int err;
> +       struct clk *clk32k;
> +
> +       clk32k = clk_get(NULL, "CLK_32K");
> +       if (IS_ERR(clk32k)) {
> +               pr_err("gumstix: failed to find 32kHz clock\n");
> +               return;
> +       }
> +       clk_enable(clk32k);
> +
> +       err = gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
> +       if (err) {
> +               pr_err("gumstix: can't reset bluetooth\n");
> +               return;
> +       }
> +       gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
> +       udelay(100);
> +       gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
> +}
> +#else
> +static void gumstix_bluetooth_init(void)
> +{
> +       pr_debug("Gumstix Bluetooth is disabled\n");
> +}
> +#endif
> +
> +static unsigned long gumstix_pin_config[] __initdata = {
> +       GPIO12_32KHz,
> +       /* BTUART */
> +       GPIO42_HWUART_RXD,
> +       GPIO43_HWUART_TXD,
> +       GPIO44_HWUART_CTS,
> +       GPIO45_HWUART_RTS,
> +       /* MMC */
> +       GPIO6_MMC_CLK,
> +       GPIO53_MMC_CLK,
> +       GPIO8_MMC_CS0,
> +       /* these are used by AM200EPD */
> +       GPIO51_GPIO,
> +       GPIO49_GPIO,
> +       GPIO48_GPIO,
> +       GPIO32_GPIO,
> +       GPIO17_GPIO,
> +       GPIO16_GPIO,
> +};
> +
>  static void __init gumstix_init(void)
>  {
> +       pxa2xx_mfp_config(ARRAY_AND_SIZE(gumstix_pin_config));
> +
> +       gumstix_bluetooth_init();
>        gumstix_udc_init();
>        gumstix_mmc_init();
>        (void) platform_add_devices(devices, ARRAY_SIZE(devices));
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index c5b845b..5930a8b 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/suspend.h>
>  #include <linux/sysdev.h>
> +#include <linux/delay.h>
>
>  #include <asm/hardware.h>
>  #include <asm/arch/irqs.h>
> @@ -155,6 +156,30 @@ static const struct clkops clk_pxa25x_gpio11_ops = {
>        .disable        = clk_gpio11_disable,
>  };
>
> +static void clk_32k_enable(struct clk *clk)
> +{
> +       int timeout = 500;
> +
> +       if (!(OSCC & OSCC_OOK))
> +               pr_warning("32kHz clock was not on. Bootloader may need to "
> +                               "be updated\n");
> +       else
> +               return;
> +
> +       OSCC |= OSCC_OON;
> +       do {
> +               if (OSCC & OSCC_OOK)
> +                       break;
> +               udelay(1);
> +       } while (--timeout);
> +       if (!timeout)
> +               pr_err("Failed to start 32kHz clock\n");
> +}
> +
> +static const struct clkops clk_32k_ops = {
> +       .enable         = clk_32k_enable,
> +};
> +
>  /*
>  * 3.6864MHz -> OST, GPIO, SSP, PWM, PLLs (95.842MHz, 147.456MHz)
>  * 95.842MHz -> MMC 19.169MHz, I2C 31.949MHz, FICP 47.923MHz, USB 47.923MHz
> @@ -169,6 +194,12 @@ static struct clk pxa25x_hwuart_clk =
>  * Please be careful not to disrupt the ordering.
>  */
>  static struct clk pxa25x_clks[] = {
> +       {
> +               .name           = "CLK_32K",
> +               .ops            = &clk_32k_ops,
> +               .rate           = 32768,
> +               .delay          = 70,
> +       },
>        INIT_CK("LCDCLK", LCD, &clk_pxa25x_lcd_ops, &pxa_device_fb.dev),
>        INIT_CKEN("UARTCLK", FFUART, 14745600, 1, &pxa_device_ffuart.dev),
>        INIT_CKEN("UARTCLK", BTUART, 14745600, 1, &pxa_device_btuart.dev),
> --
> 1.5.3.6
>
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
