From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 3/7] gumstix: conversion to MFP
	support and add bluetooth support
Date: Sat,  7 Jun 2008 00:49:22 -0400
Message-ID: <1212814166-10313-4-git-send-email-jayakumar.lkml@gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4rGL-0006JN-GJ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 22:46:49 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4rGK-0006CT-Uu
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 22:46:49 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1257559wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Jun 2008 22:46:48 -0700 (PDT)
In-Reply-To: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
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
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

This patch converts gumstix over to the MFP configuration system and adds
bluetooth support. Added a CLK_32K clock to enable bluetooth.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/gumstix.c           |   79 ++++++++++++++++++++++++++-------
 arch/arm/mach-pxa/pxa25x.c            |   31 +++++++++++++
 include/asm-arm/arch-pxa/mfp-pxa25x.h |    1 +
 3 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index bdf2397..3e0a962 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -20,8 +20,12 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -40,7 +44,7 @@
 
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/pxa2xx-regs.h>
-#include <asm/arch/pxa2xx-gpio.h>
+#include <asm/arch/mfp-pxa25x.h>
 
 #include "generic.h"
 
@@ -85,21 +89,8 @@ static struct platform_device *devices[] __initdata = {
 };
 
 #ifdef CONFIG_MMC_PXA
-static struct pxamci_platform_data gumstix_mci_platform_data;
-
-static int gumstix_mci_init(struct device *dev, irq_handler_t detect_int,
-				void *data)
-{
-	pxa_gpio_mode(GPIO6_MMCCLK_MD);
-	pxa_gpio_mode(GPIO53_MMCCLK_MD);
-	pxa_gpio_mode(GPIO8_MMCCS0_MD);
-
-	return 0;
-}
-
 static struct pxamci_platform_data gumstix_mci_platform_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init		= gumstix_mci_init,
 };
 
 static void __init gumstix_mmc_init(void)
@@ -109,7 +100,7 @@ static void __init gumstix_mmc_init(void)
 #else
 static void __init gumstix_mmc_init(void)
 {
-	printk(KERN_INFO "Gumstix mmc disabled\n");
+	pr_debug("Gumstix mmc disabled\n");
 }
 #endif
 
@@ -126,12 +117,68 @@ static void __init gumstix_udc_init(void)
 #else
 static void gumstix_udc_init(void)
 {
-	printk(KERN_INFO "Gumstix udc is disabled\n");
+	pr_debug("Gumstix udc is disabled\n");
+}
+#endif
+
+#ifdef CONFIG_BT
+static void __init gumstix_bluetooth_init(void)
+{
+	int err;
+	struct clk *clk32k;
+
+	clk32k = clk_get(NULL, "CLK_32K");
+	if (IS_ERR(clk32k)) {
+		pr_err("gumstix: failed to find 32kHz clock\n");
+		return;
+	}
+	clk_enable(clk32k);
+
+	err = gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
+	if (err) {
+		pr_err("gumstix: can't reset bluetooth\n");
+		return;
+	}
+	gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
+	udelay(100);
+	gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
+}
+#else
+static void gumstix_bluetooth_init(void)
+{
+	pr_debug("Gumstix Bluetooth is disabled\n");
 }
 #endif
 
+static unsigned long gumstix_pin_config[] __initdata = {
+#ifdef CONFIG_BT
+	GPIO12_32KHz,
+	/* BTUART */
+	GPIO42_HWUART_RXD,
+	GPIO43_HWUART_TXD,
+	GPIO44_HWUART_CTS,
+	GPIO45_HWUART_RTSL,
+#endif
+#ifdef CONFIG_MMC_PXA
+	/* MMC */
+	GPIO6_MMC_CLK,
+	GPIO53_MMC_CLK,
+	GPIO8_MMC_CS0,
+#endif
+	/* these are used by AM200EPD */
+	GPIO51_GPIO,
+	GPIO49_GPIO,
+	GPIO48_GPIO,
+	GPIO32_GPIO,
+	GPIO17_GPIO,
+	GPIO16_GPIO,
+};
+
 static void __init gumstix_init(void)
 {
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(gumstix_pin_config));
+
+	gumstix_bluetooth_init();
 	gumstix_udc_init();
 	gumstix_mmc_init();
 	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index e5b417d..1ffe773 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
 #include <linux/sysdev.h>
+#include <linux/delay.h>
 
 #include <asm/hardware.h>
 #include <asm/arch/irqs.h>
@@ -108,6 +109,30 @@ static const struct clkops clk_pxa25x_lcd_ops = {
 	.getrate	= clk_pxa25x_lcd_getrate,
 };
 
+static void clk_32k_enable(struct clk *clk)
+{
+	int timeout = 500;
+
+	OSCC |= OSCC_OON;
+	do {
+		if (OSCC & OSCC_OOK)
+			break;
+		udelay(1);
+	} while (--timeout);
+	if (!timeout)
+		pr_err("Failed to start 32kHz clock\n");
+}
+
+static void clk_32k_disable(struct clk *clk)
+{
+	OSCC &= ~OSCC_OON;
+}
+
+static const struct clkops clk_32k_ops = {
+	.enable		= clk_32k_enable,
+	.disable	= clk_32k_disable,
+};
+
 /*
  * 3.6864MHz -> OST, GPIO, SSP, PWM, PLLs (95.842MHz, 147.456MHz)
  * 95.842MHz -> MMC 19.169MHz, I2C 31.949MHz, FICP 47.923MHz, USB 47.923MHz
@@ -118,6 +143,12 @@ static struct clk pxa25x_hwuart_clk =
 ;
 
 static struct clk pxa25x_clks[] = {
+	{
+		.name           = "CLK_32K",
+		.ops            = &clk_32k_ops,
+		.rate           = 32000,
+		.delay          = 70,
+	},
 	INIT_CK("LCDCLK", LCD, &clk_pxa25x_lcd_ops, &pxa_device_fb.dev),
 	INIT_CKEN("UARTCLK", FFUART, 14745600, 1, &pxa_device_ffuart.dev),
 	INIT_CKEN("UARTCLK", BTUART, 14745600, 1, &pxa_device_btuart.dev),
diff --git a/include/asm-arm/arch-pxa/mfp-pxa25x.h b/include/asm-arm/arch-pxa/mfp-pxa25x.h
index 0499323..6c82a74 100644
--- a/include/asm-arm/arch-pxa/mfp-pxa25x.h
+++ b/include/asm-arm/arch-pxa/mfp-pxa25x.h
@@ -79,6 +79,7 @@
 #define GPIO43_HWUART_TXD	MFP_CFG_OUT(GPIO43, AF3, DRIVE_HIGH)
 #define GPIO44_HWUART_CTS	MFP_CFG_IN(GPIO44, AF3)
 #define GPIO45_HWUART_RTS	MFP_CFG_OUT(GPIO45, AF3, DRIVE_HIGH)
+#define GPIO45_HWUART_RTSL	MFP_CFG_OUT(GPIO45, AF3, DRIVE_LOW)
 #define GPIO48_HWUART_TXD	MFP_CFG_OUT(GPIO48, AF1, DRIVE_HIGH)
 #define GPIO49_HWUART_RXD	MFP_CFG_IN(GPIO49, AF1)
 #define GPIO50_HWUART_CTS	MFP_CFG_IN(GPIO50, AF1)
-- 
1.5.3.6


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
