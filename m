From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 2/5] gumstix: conversion to MFP
	support and add bluetooth support
Date: Wed, 30 Jul 2008 08:51:06 -0400
Message-ID: <1217422269-11093-3-git-send-email-jayakumar.lkml@gmail.com>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOC1i-000119-6D for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:38 -0700
Received: from yw-out-1718.google.com ([74.125.46.156])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOC1h-0001fS-Qm
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:38 -0700
Received: by yw-out-1718.google.com with SMTP id 6so10226ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 Jul 2008 06:47:37 -0700 (PDT)
In-Reply-To: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
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
bluetooth support.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Acked-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/gumstix.c |  100 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index bdf2397..49b78e7 100644
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
@@ -109,11 +100,11 @@ static void __init gumstix_mmc_init(void)
 #else
 static void __init gumstix_mmc_init(void)
 {
-	printk(KERN_INFO "Gumstix mmc disabled\n");
+	pr_debug("Gumstix mmc disabled\n");
 }
 #endif
 
-#ifdef CONFIG_USB_GADGET_PXA2XX
+#ifdef CONFIG_USB_GADGET_PXA25X
 static struct pxa2xx_udc_mach_info gumstix_udc_info __initdata = {
 	.gpio_vbus		= GPIO_GUMSTIX_USB_GPIOn,
 	.gpio_pullup		= GPIO_GUMSTIX_USB_GPIOx,
@@ -126,12 +117,87 @@ static void __init gumstix_udc_init(void)
 #else
 static void gumstix_udc_init(void)
 {
-	printk(KERN_INFO "Gumstix udc is disabled\n");
+	pr_debug("Gumstix udc is disabled\n");
 }
 #endif
 
+#ifdef CONFIG_BT
+/* Normally, the bootloader would have enabled this 32kHz clock but many
+** boards still have u-boot 1.1.4 so we check if it has been turned on and
+** if not, we turn it on with a warning message. */
+static void gumstix_setup_bt_clock(void)
+{
+	int timeout = 500;
+
+	if (!(OSCC & OSCC_OOK))
+		pr_warning("32kHz clock was not on. Bootloader may need to "
+				"be updated\n");
+	else
+		return;
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
+static void __init gumstix_bluetooth_init(void)
+{
+	int err;
+
+	gumstix_setup_bt_clock();
+
+	err = gpio_request(GPIO_GUMSTIX_BTRESET, "BTRST");
+	if (err) {
+		pr_err("gumstix: failed request gpio for bluetooth reset\n");
+		return;
+	}
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
+}
+#endif
+
+static unsigned long gumstix_pin_config[] __initdata = {
+	GPIO12_32KHz,
+	/* BTUART */
+	GPIO42_HWUART_RXD,
+	GPIO43_HWUART_TXD,
+	GPIO44_HWUART_CTS,
+	GPIO45_HWUART_RTS,
+	/* MMC */
+	GPIO6_MMC_CLK,
+	GPIO53_MMC_CLK,
+	GPIO8_MMC_CS0,
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
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
