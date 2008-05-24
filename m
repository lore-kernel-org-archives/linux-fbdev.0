From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.25] pxafb, am200epd, gumstix,
	metronomefb secondary framebuffer
Date: Sat, 24 May 2008 03:35:43 -0400
Message-ID: <20080524073543.3156.77719.sendpatchset@apodmy1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzpBU-0000UG-DW for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 May 2008 01:33:01 -0700
Received: from rv-out-0708.google.com ([209.85.198.247])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzpBU-0004E8-0H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 May 2008 01:33:00 -0700
Received: by rv-out-0708.google.com with SMTP id f25so987835rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 May 2008 01:32:59 -0700 (PDT)
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>

Hi Eric, fbdev,

Sorry for my slow progress on solving the pxafb/am200epd shared framebuffer
issue. I've finally managed to get things working now and am feeling like
this is a good point to stop and ask for your feedback. There is still some
cleanup to be done but I'd like to find out if I'm heading in the right
direction.

My changes are as follows: 

- removed drivers/video/am200epd.c since it was not the right way to
  implement a board support driver.
- added a new arch/arm/mach-pxa/am200epd.c driver that uses the generic GPIO
  API rather than manipulating GAFR/GPSR/etc. 
- changes to arch/arm/mach-pxa/gumstix.c to support MFP to allow am200epd to
  use generic GPIO.
- changed metronomefb/am200epd/pxafb to allow for shared framebuffer rather
  than duplicate control of LCDC.
- callbacks share_video_mem/unshare to allow am200epd to know when pxafb has
  allocated and will free the framebuffer. am200epd handles refcounting of
  pxafb so that it can't be unloaded underneath it. I was not able to
  implement an equivalent using registered_fb[] because there isn't a way to
  identify the fb_info and to get notification of the framebuffer state.
- pxafb changes to use __devinit/exit for probe functions and __init for
  init/exit functions. This is needed so that it can work properly when
  built as a module.
- exports pxa_device_fb so that am200epd can be modular.
- cleanup am200epd board functions so that it doesn't refer to any pxa
  specific registers or descriptors.
- cleanup to use dev_dbg instead of printk

I would be grateful for your feedback and advice on this.

Thanks,
jaya

---

 b/arch/arm/mach-pxa/Kconfig             |   14 +
 b/arch/arm/mach-pxa/Makefile            |    1 
 b/arch/arm/mach-pxa/am200epd.c          |  347 ++++++++++++++++++++++++++++++++
 b/arch/arm/mach-pxa/devices.c           |    3 
 b/arch/arm/mach-pxa/gumstix.c           |   79 +++++--
 b/arch/arm/mach-pxa/pxa25x.c            |   32 ++
 b/drivers/video/Kconfig                 |   20 -
 b/drivers/video/Makefile                |    1 
 b/drivers/video/metronomefb.c           |  270 +++++++++++++-----------
 b/drivers/video/pxafb.c                 |  110 ++++++++--
 b/include/asm-arm/arch-pxa/mfp-pxa25x.h |    1 
 b/include/asm-arm/arch-pxa/pxafb.h      |    9 
 b/include/video/metronomefb.h           |   13 -
 drivers/video/am200epd.c                |  295 ---------------------------
 14 files changed, 721 insertions(+), 474 deletions(-)


diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 5da7a68..423ae1e 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -179,6 +179,20 @@ endchoice
 
 endif
 
+if MACH_GUMSTIX_F
+choice
+	prompt "Select base board for Gumstix board"
+config MACH_AM200EPD
+	tristate "Enable AM200EPD board support"
+	select FB_METRONOME
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
+endchoice
+endif
+
 
 if MACH_TRIZEPS4
 
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 6a83085..ba7f52e 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_LEDS)		+= $(led-y)
 obj-$(CONFIG_PM)		+= pm.o sleep.o standby.o
 obj-$(CONFIG_CPU_FREQ)		+= cpu-pxa.o
 obj-$(CONFIG_PXA_SSP)		+= ssp.o
+obj-$(CONFIG_MACH_AM200EPD)	+= am200epd.o
 
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_MACH_ARMCORE) += cm-x270-pci.o
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
new file mode 100644
index 0000000..96ee642
--- /dev/null
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -0,0 +1,347 @@
+/*
+ * linux/drivers/video/am200epd.c -- Platform device for AM200 EPD kit
+ *
+ * Copyright (C) 2008, Jaya Kumar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
+ *
+ * This work was made possible by help and equipment support from E-Ink
+ * Corporation. http://support.eink.com/community
+ *
+ * This driver is written to be used with the Metronome display controller.
+ * on the AM200 EPD prototype kit/development kit with an E-Ink 800x600
+ * Vizplex EPD on a Gumstix board using the Lyre interface board.
+ *
+ */
+
+#define DEBUG 1
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include <asm/arch/pxafb.h>
+
+#include <video/metronomefb.h>
+
+#include "generic.h"
+#include "devices.h"
+
+static unsigned int panel_type = 6;
+static struct platform_device *am200_device;
+static struct metronome_board am200_board;
+
+static struct pxafb_mode_info am200_fb_mode_9inch7 = {
+	.pixclock	= 40000,
+	.xres		= 1200,
+	.yres		= 842,
+	.bpp		= 16,
+	.hsync_len	= 2,
+	.left_margin	= 2,
+	.right_margin	= 2,
+	.vsync_len	= 1,
+	.upper_margin	= 2,
+	.lower_margin	= 25,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+};
+
+static struct pxafb_mode_info am200_fb_mode_8inch = {
+	.pixclock	= 40000,
+	.xres		= 1088,
+	.yres		= 791,
+	.bpp		= 16,
+	.hsync_len	= 28,
+	.left_margin	= 8,
+	.right_margin	= 30,
+	.vsync_len	= 8,
+	.upper_margin	= 10,
+	.lower_margin	= 8,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+};
+
+static struct pxafb_mode_info am200_fb_mode_6inch = {
+	.pixclock	= 40189,
+	.xres		= 832,
+	.yres		= 622,
+	.bpp		= 16,
+	.hsync_len	= 28,
+	.left_margin	= 34,
+	.right_margin	= 34,
+	.vsync_len	= 25,
+	.upper_margin	= 0,
+	.lower_margin	= 2,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+};
+
+static struct pxafb_mach_info am200_fb_info = {
+	.modes		= &am200_fb_mode_6inch,
+	.num_modes	= 1,
+	.lccr0		= LCCR0_Pas | LCCR0_Sngl | LCCR0_Color,
+	.lccr3		= 0,
+	.lcd_conn	= LCD_TYPE_COLOR_TFT | LCD_PCLK_EDGE_FALL |
+			  LCD_AC_BIAS_FREQ(24),
+	.clkdev		= &pxa_device_fb.dev,
+	.custom_xfer_div = 2,
+};
+
+/* register offsets for gpio control */
+#define LED_GPIO_PIN 51
+#define STDBY_GPIO_PIN 48
+#define RST_GPIO_PIN 49
+#define RDY_GPIO_PIN 32
+#define ERR_GPIO_PIN 17
+#define PCBPWR_GPIO_PIN 16
+static int gpios[] = { LED_GPIO_PIN , STDBY_GPIO_PIN , RST_GPIO_PIN,
+			RDY_GPIO_PIN, ERR_GPIO_PIN, PCBPWR_GPIO_PIN };
+static char *gpio_names[] = { "LED" , "STDBY" , "RST", "RDY", "ERR", "PCBPWR" };
+
+static int am200_init_gpio_regs(struct metronomefb_par *par)
+{
+	int i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		err = gpio_request(gpios[i], gpio_names[i]);
+		if (err) {
+			dev_err(&am200_device->dev, "failed requesting "
+				"gpio %s, err=%d\n", gpio_names[i], err);
+			goto err_req_gpio;
+		}
+	}
+
+	gpio_direction_output(LED_GPIO_PIN, 0);
+	gpio_direction_output(STDBY_GPIO_PIN, 0);
+	gpio_direction_output(RST_GPIO_PIN, 0);
+
+	gpio_direction_input(RDY_GPIO_PIN);
+	gpio_direction_input(ERR_GPIO_PIN);
+
+	gpio_direction_output(PCBPWR_GPIO_PIN, 0);
+
+	return 0;
+
+err_req_gpio:
+	while (i > 0)
+		gpio_free(gpios[i--]);
+
+	return err;
+}
+
+static void am200_cleanup(struct metronomefb_par *par)
+{
+	int i;
+
+	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par->info);
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++)
+		gpio_free(gpios[i]);
+}
+
+static struct platform_device *am200_pxa_device_fb;
+
+static int am200_pxa_register_device(struct platform_device *dev,
+					struct pxafb_mach_info *data)
+{
+	int ret;
+
+	am200_pxa_device_fb = platform_device_alloc("pxa2xx-fb", -1);
+	if (!am200_pxa_device_fb)
+		return -ENOMEM;
+
+	platform_device_add_data(am200_pxa_device_fb, data, sizeof(*data));
+
+	platform_device_add_resources(am200_pxa_device_fb,
+					pxa_device_fb.resource,
+					pxa_device_fb.num_resources);
+
+	am200_pxa_device_fb->dev.dma_mask = pxa_device_fb.dev.dma_mask;
+	am200_pxa_device_fb->dev.coherent_dma_mask =
+					pxa_device_fb.dev.coherent_dma_mask;
+
+	ret = platform_device_add(am200_pxa_device_fb);
+
+	if (ret) {
+		dev_err(&am200_device->dev, "failed adding pxafb %d\n", ret);
+		platform_device_put(am200_pxa_device_fb);
+	}
+
+	return ret;
+}
+
+static int am200_share_video_mem(unsigned char *video_mem, dma_addr_t dma,
+					struct module *fbmaster, void *data)
+{
+	struct metronomefb_par *par = data;
+
+	/* try to refcount the caller since we are the consumer after this */
+	if (!try_module_get(fbmaster))
+		return -ENODEV;
+
+	dev_dbg(&am200_device->dev, "mod_get %p\n", fbmaster);
+	am200_board.fbmaster = fbmaster;
+	par->metromem = video_mem;
+	par->metromem_dma = dma;
+
+	return 0;
+}
+
+static void am200_unshare_video_mem(void *data)
+{
+	struct metronomefb_par *par = data;
+
+	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
+	par->metromem = NULL;
+	par->metromem_dma = 0;
+	dev_dbg(&am200_device->dev, "mod_put %p\n", am200_board.fbmaster);
+	module_put(am200_board.fbmaster);
+}
+
+static int am200_setup_fb(struct metronomefb_par *par)
+{
+	int ret;
+
+	am200_fb_info.extra_video_mem = par->extra_size;
+	am200_fb_info.extra_data = (void *) par;
+	am200_fb_info.share_video_mem = am200_share_video_mem;
+	am200_fb_info.unshare_video_mem = am200_unshare_video_mem;
+
+	switch (panel_type) {
+	case 6:
+		am200_fb_info.modes = &am200_fb_mode_6inch;
+		break;
+	case 8:
+		am200_fb_info.modes = &am200_fb_mode_8inch;
+		break;
+	case 97:
+		am200_fb_info.modes = &am200_fb_mode_9inch7;
+		break;
+	default:
+		dev_err(&am200_device->dev, "invalid panel_type selection,"
+						" setting to 6\n");
+		am200_fb_info.modes = &am200_fb_mode_6inch;
+		break;
+	}
+
+	ret = am200_pxa_register_device(&pxa_device_fb, &am200_fb_info);
+	return ret;
+}
+
+static int am200_get_panel_type(void)
+{
+	return panel_type;
+}
+
+static irqreturn_t am200_handle_irq(int irq, void *dev_id)
+{
+	struct fb_info *info = dev_id;
+	struct metronomefb_par *par = info->par;
+
+	wake_up_interruptible(&par->waitq);
+	return IRQ_HANDLED;
+}
+
+static int am200_setup_irq(struct fb_info *info)
+{
+	int ret;
+
+	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
+				IRQF_DISABLED, "AM200", info);
+	if (ret) {
+		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = set_irq_type(IRQ_GPIO(RDY_GPIO_PIN), IRQT_FALLING);
+	if (ret)
+		dev_err(&am200_device->dev, "set_irq_type failed: %d\n", ret);
+
+	return ret;
+}
+
+static void am200_set_rst(struct metronomefb_par *par, int state)
+{
+	gpio_set_value(RST_GPIO_PIN, state);
+}
+
+static void am200_set_stdby(struct metronomefb_par *par, int state)
+{
+	gpio_set_value(STDBY_GPIO_PIN, state);
+}
+
+static int am200_wait_event(struct metronomefb_par *par)
+{
+	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
+}
+
+static int am200_wait_event_intr(struct metronomefb_par *par)
+{
+	int ret;
+
+	ret = wait_event_interruptible_timeout(par->waitq,
+					gpio_get_value(RDY_GPIO_PIN), HZ);
+	return ret;
+}
+
+static struct metronome_board am200_board = {
+	.owner			= THIS_MODULE,
+	.setup_irq		= am200_setup_irq,
+	.setup_io		= am200_init_gpio_regs,
+	.setup_fb		= am200_setup_fb,
+	.set_rst		= am200_set_rst,
+	.set_stdby		= am200_set_stdby,
+	.met_wait_event		= am200_wait_event,
+	.met_wait_event_intr	= am200_wait_event_intr,
+	.get_panel_type		= am200_get_panel_type,
+	.cleanup		= am200_cleanup,
+};
+
+static int __init am200_init(void)
+{
+	int ret;
+
+	/* request our platform independent driver */
+	request_module("metronomefb");
+
+	am200_device = platform_device_alloc("metronomefb", -1);
+	if (!am200_device)
+		return -ENOMEM;
+
+	platform_device_add_data(am200_device, &am200_board,
+					sizeof(am200_board));
+
+	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
+	ret = platform_device_add(am200_device);
+
+	if (ret)
+		platform_device_put(am200_device);
+
+	return ret;
+}
+
+static void __exit am200_exit(void)
+{
+	platform_device_unregister(am200_pxa_device_fb);
+	platform_device_unregister(am200_device);
+}
+
+module_param(panel_type, uint, 0);
+MODULE_PARM_DESC(panel_type, "Select the display type: 6, 8, 97");
+
+module_init(am200_init);
+module_exit(am200_exit);
+
+MODULE_DESCRIPTION("board driver for am200 metronome epd kit");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d6c05b6..fe0eb07 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -127,9 +127,12 @@ struct platform_device pxa_device_fb = {
 	.num_resources	= ARRAY_SIZE(pxafb_resources),
 	.resource	= pxafb_resources,
 };
+EXPORT_SYMBOL_GPL(pxa_device_fb);
 
 void __init set_pxa_fb_info(struct pxafb_mach_info *info)
 {
+	if (!info->clkdev)
+		info->clkdev = &pxa_device_fb.dev;
 	pxa_register_device(&pxa_device_fb, info);
 }
 
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
index d9b5450..5a44278 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/suspend.h>
 #include <linux/sysdev.h>
+#include <linux/delay.h>
 
 #include <asm/hardware.h>
 #include <asm/arch/irqs.h>
@@ -117,7 +118,38 @@ static struct clk pxa25x_hwuart_clk =
 	INIT_CKEN("UARTCLK", HWUART, 14745600, 1, &pxa_device_hwuart.dev)
 ;
 
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
+		printk(KERN_ERR "gumstix: failed to start 32kHz clock\n");
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
 static struct clk pxa25x_clks[] = {
+	{
+		.name           = "CLK_32K",
+		.ops            = &clk_32k_ops,
+		.rate           = 32000,
+		.delay          = 70,
+	},
+
 	INIT_CK("LCDCLK", LCD, &clk_pxa25x_lcd_ops, &pxa_device_fb.dev),
 	INIT_CKEN("UARTCLK", FFUART, 14745600, 1, &pxa_device_ffuart.dev),
 	INIT_CKEN("UARTCLK", BTUART, 14745600, 1, &pxa_device_btuart.dev),
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index bb1dada..11448c3 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -169,9 +169,8 @@ config FB_SYS_FOPS
        default n
 
 config FB_DEFERRED_IO
-	bool
-	depends on FB
-	default y
+       bool
+       depends on FB
 
 config FB_METRONOME
 	tristate
@@ -715,7 +714,6 @@ config FB_N411
        select FB_SYS_COPYAREA
        select FB_SYS_IMAGEBLIT
        select FB_SYS_FOPS
-       select FB_DEFERRED_IO
        select FB_HECUBA
        help
          This enables support for the Apollo display controller in its
@@ -1940,19 +1938,6 @@ config FB_XILINX
 	  framebuffer. ML300 carries a 640*480 LCD display on the board,
 	  ML403 uses a standard DB15 VGA connector.
 
-config FB_AM200EPD
-       tristate "AM-200 E-Ink EPD devkit support"
-       depends on FB && ARCH_PXA && MMU
-       select FB_SYS_FILLRECT
-       select FB_SYS_COPYAREA
-       select FB_SYS_IMAGEBLIT
-       select FB_SYS_FOPS
-       select FB_DEFERRED_IO
-       select FB_METRONOME
-       help
-         This enables support for the Metronome display controller used on
-         the E-Ink AM-200 EPD devkit.
-
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
@@ -1983,7 +1968,6 @@ config XEN_FBDEV_FRONTEND
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
 	select FB_SYS_FOPS
-	select FB_DEFERRED_IO
 	default y
 	help
 	  This driver implements the front-end of the Xen virtual
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 04bca35..80d5842 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_FB_DEFERRED_IO)   += fb_defio.o
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
-obj-$(CONFIG_FB_AM200EPD)         += am200epd.o
 obj-$(CONFIG_FB_ARC)              += arcfb.o
 obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o
diff --git a/drivers/video/am200epd.c b/drivers/video/am200epd.c
deleted file mode 100644
index 51e26c1..0000000
--- a/drivers/video/am200epd.c
+++ /dev/null
@@ -1,295 +0,0 @@
-/*
- * linux/drivers/video/am200epd.c -- Platform device for AM200 EPD kit
- *
- * Copyright (C) 2008, Jaya Kumar
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file COPYING in the main directory of this archive for
- * more details.
- *
- * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
- *
- * This work was made possible by help and equipment support from E-Ink
- * Corporation. http://support.eink.com/community
- *
- * This driver is written to be used with the Metronome display controller.
- * on the AM200 EPD prototype kit/development kit with an E-Ink 800x600
- * Vizplex EPD on a Gumstix board using the Lyre interface board.
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/list.h>
-#include <linux/uaccess.h>
-#include <linux/irq.h>
-
-#include <video/metronomefb.h>
-
-#include <asm/arch/pxa-regs.h>
-
-/* register offsets for gpio control */
-#define LED_GPIO_PIN 51
-#define STDBY_GPIO_PIN 48
-#define RST_GPIO_PIN 49
-#define RDY_GPIO_PIN 32
-#define ERR_GPIO_PIN 17
-#define PCBPWR_GPIO_PIN 16
-
-#define AF_SEL_GPIO_N 0x3
-#define GAFR0_U_OFFSET(pin) ((pin - 16) * 2)
-#define GAFR1_L_OFFSET(pin) ((pin - 32) * 2)
-#define GAFR1_U_OFFSET(pin) ((pin - 48) * 2)
-#define GPDR1_OFFSET(pin) (pin - 32)
-#define GPCR1_OFFSET(pin) (pin - 32)
-#define GPSR1_OFFSET(pin) (pin - 32)
-#define GPCR0_OFFSET(pin) (pin)
-#define GPSR0_OFFSET(pin) (pin)
-
-static void am200_set_gpio_output(int pin, int val)
-{
-	u8 index;
-
-	index = pin >> 4;
-
-	switch (index) {
-	case 1:
-		if (val)
-			GPSR0 |= (1 << GPSR0_OFFSET(pin));
-		else
-			GPCR0 |= (1 << GPCR0_OFFSET(pin));
-		break;
-	case 2:
-		break;
-	case 3:
-		if (val)
-			GPSR1 |= (1 << GPSR1_OFFSET(pin));
-		else
-			GPCR1 |= (1 << GPCR1_OFFSET(pin));
-		break;
-	default:
-		printk(KERN_ERR "unimplemented\n");
-	}
-}
-
-static void __devinit am200_init_gpio_pin(int pin, int dir)
-{
-	u8 index;
-	/* dir 0 is output, 1 is input
-	- do 2 things here:
-	- set gpio alternate function to standard gpio
-	- set gpio direction to input or output  */
-
-	index = pin >> 4;
-	switch (index) {
-	case 1:
-		GAFR0_U &= ~(AF_SEL_GPIO_N << GAFR0_U_OFFSET(pin));
-
-		if (dir)
-			GPDR0 &= ~(1 << pin);
-		else
-			GPDR0 |= (1 << pin);
-		break;
-	case 2:
-		GAFR1_L &= ~(AF_SEL_GPIO_N << GAFR1_L_OFFSET(pin));
-
-		if (dir)
-			GPDR1 &= ~(1 << GPDR1_OFFSET(pin));
-		else
-			GPDR1 |= (1 << GPDR1_OFFSET(pin));
-		break;
-	case 3:
-		GAFR1_U &= ~(AF_SEL_GPIO_N << GAFR1_U_OFFSET(pin));
-
-		if (dir)
-			GPDR1 &= ~(1 << GPDR1_OFFSET(pin));
-		else
-			GPDR1 |= (1 << GPDR1_OFFSET(pin));
-		break;
-	default:
-		printk(KERN_ERR "unimplemented\n");
-	}
-}
-
-static void am200_init_gpio_regs(struct metronomefb_par *par)
-{
-	am200_init_gpio_pin(LED_GPIO_PIN, 0);
-	am200_set_gpio_output(LED_GPIO_PIN, 0);
-
-	am200_init_gpio_pin(STDBY_GPIO_PIN, 0);
-	am200_set_gpio_output(STDBY_GPIO_PIN, 0);
-
-	am200_init_gpio_pin(RST_GPIO_PIN, 0);
-	am200_set_gpio_output(RST_GPIO_PIN, 0);
-
-	am200_init_gpio_pin(RDY_GPIO_PIN, 1);
-
-	am200_init_gpio_pin(ERR_GPIO_PIN, 1);
-
-	am200_init_gpio_pin(PCBPWR_GPIO_PIN, 0);
-	am200_set_gpio_output(PCBPWR_GPIO_PIN, 0);
-}
-
-static void am200_disable_lcd_controller(struct metronomefb_par *par)
-{
-	LCSR = 0xffffffff;	/* Clear LCD Status Register */
-	LCCR0 |= LCCR0_DIS;	/* Disable LCD Controller */
-
-	/* we reset and just wait for things to settle */
-	msleep(200);
-}
-
-static void am200_enable_lcd_controller(struct metronomefb_par *par)
-{
-	LCSR = 0xffffffff;
-	FDADR0 = par->metromem_desc_dma;
-	LCCR0 |= LCCR0_ENB;
-}
-
-static void am200_init_lcdc_regs(struct metronomefb_par *par)
-{
-	/* here we do:
-	- disable the lcd controller
-	- setup lcd control registers
-	- setup dma descriptor
-	- reenable lcd controller
-	*/
-
-	/* disable the lcd controller */
-	am200_disable_lcd_controller(par);
-
-	/* setup lcd control registers */
-	LCCR0 = LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM | LCCR0_PAS
-		| LCCR0_QDM | LCCR0_BM | LCCR0_OUM;
-
-	LCCR1 = (par->info->var.xres/2 - 1) /* pixels per line */
-		| (27 << 10) /* hsync pulse width - 1 */
-		| (33 << 16) /* eol pixel count */
-		| (33 << 24); /* bol pixel count */
-
-	LCCR2 = (par->info->var.yres - 1) /* lines per panel */
-		| (24 << 10) /* vsync pulse width - 1 */
-		| (2 << 16) /* eof pixel count */
-		| (0 << 24); /* bof pixel count */
-
-	LCCR3 = 2 /* pixel clock divisor */
-		| (24 << 8) /* AC Bias pin freq */
-		| LCCR3_16BPP /* BPP */
-		| LCCR3_PCP;  /* PCP falling edge */
-
-}
-
-static void am200_post_dma_setup(struct metronomefb_par *par)
-{
-	par->metromem_desc->mFDADR0 = par->metromem_desc_dma;
-	par->metromem_desc->mFSADR0 = par->metromem_dma;
-	par->metromem_desc->mFIDR0 = 0;
-	par->metromem_desc->mLDCMD0 = par->info->var.xres
-					* par->info->var.yres;
-	am200_enable_lcd_controller(par);
-}
-
-static void am200_free_irq(struct fb_info *info)
-{
-	free_irq(IRQ_GPIO(RDY_GPIO_PIN), info);
-}
-
-static irqreturn_t am200_handle_irq(int irq, void *dev_id)
-{
-	struct fb_info *info = dev_id;
-	struct metronomefb_par *par = info->par;
-
-	wake_up_interruptible(&par->waitq);
-	return IRQ_HANDLED;
-}
-
-static int am200_setup_irq(struct fb_info *info)
-{
-	int retval;
-
-	retval = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
-				IRQF_DISABLED, "AM200", info);
-	if (retval) {
-		printk(KERN_ERR "am200epd: request_irq failed: %d\n", retval);
-		return retval;
-	}
-
-	return set_irq_type(IRQ_GPIO(RDY_GPIO_PIN), IRQT_FALLING);
-}
-
-static void am200_set_rst(struct metronomefb_par *par, int state)
-{
-	am200_set_gpio_output(RST_GPIO_PIN, state);
-}
-
-static void am200_set_stdby(struct metronomefb_par *par, int state)
-{
-	am200_set_gpio_output(STDBY_GPIO_PIN, state);
-}
-
-static int am200_wait_event(struct metronomefb_par *par)
-{
-	return wait_event_timeout(par->waitq, (GPLR1 & 0x01), HZ);
-}
-
-static int am200_wait_event_intr(struct metronomefb_par *par)
-{
-	return wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
-}
-
-static struct metronome_board am200_board = {
-	.owner			= THIS_MODULE,
-	.free_irq		= am200_free_irq,
-	.setup_irq		= am200_setup_irq,
-	.init_gpio_regs		= am200_init_gpio_regs,
-	.init_lcdc_regs		= am200_init_lcdc_regs,
-	.post_dma_setup		= am200_post_dma_setup,
-	.set_rst		= am200_set_rst,
-	.set_stdby		= am200_set_stdby,
-	.met_wait_event		= am200_wait_event,
-	.met_wait_event_intr	= am200_wait_event_intr,
-};
-
-static struct platform_device *am200_device;
-
-static int __init am200_init(void)
-{
-	int ret;
-
-	/* request our platform independent driver */
-	request_module("metronomefb");
-
-	am200_device = platform_device_alloc("metronomefb", -1);
-	if (!am200_device)
-		return -ENOMEM;
-
-	platform_device_add_data(am200_device, &am200_board,
-					sizeof(am200_board));
-
-	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
-	ret = platform_device_add(am200_device);
-
-	if (ret)
-		platform_device_put(am200_device);
-
-	return ret;
-}
-
-static void __exit am200_exit(void)
-{
-	platform_device_unregister(am200_device);
-}
-
-module_init(am200_init);
-module_exit(am200_exit);
-
-MODULE_DESCRIPTION("board driver for am200 metronome epd kit");
-MODULE_AUTHOR("Jaya Kumar");
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index cc4c038..6e1c1eb 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -18,6 +18,8 @@
  * is provided as am200epd.c
  *
  */
+#define DEBUG 1
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -40,29 +42,63 @@
 
 #include <asm/unaligned.h>
 
-
-#define DEBUG 1
-#ifdef DEBUG
-#define DPRINTK(f, a...) printk(KERN_DEBUG "%s: " f, __func__ , ## a)
-#else
-#define DPRINTK(f, a...)
-#endif
-
-
 /* Display specific information */
 #define DPY_W 832
 #define DPY_H 622
 
+int user_wfm_size;
+
 /* frame differs from image. frame includes non-visible pixels */
 struct epd_frame {
 	int fw; /* frame width */
 	int fh; /* frame height */
+	u16 config[4];
+	int wfm_size;
 };
 
 static struct epd_frame epd_frame_table[] = {
 	{
-	.fw = 832,
-	.fh = 622
+		.fw = 832,
+		.fh = 622,
+		.config = {
+			15 /* sdlew */
+			| 2 << 8 /* sdosz */
+			| 0 << 11 /* sdor */
+			| 0 << 12 /* sdces */
+			| 0 << 15, /* sdcer */
+			42 /* gdspl */
+			| 1 << 8 /* gdr1 */
+			| 1 << 9 /* sdshr */
+			| 0 << 15, /* gdspp */
+			18 /* gdspw */
+			| 0 << 15, /* dispc */
+			599 /* vdlc */
+			| 0 << 11 /* dsi */
+			| 0 << 12, /* dsic */
+		},
+		.wfm_size = 47001,
+	},
+	{
+		.fw = 1088,
+		.fh = 791,
+		.config = {
+			0x0104,
+			0x031f,
+			0x0088,
+			0x02ff,
+		},
+		.wfm_size = 46770,
+	},
+	{
+		.fw = 1200,
+		.fh = 842,
+		.config = {
+			0x0101,
+			0x030e,
+			0x0012,
+			0x0280,
+		},
+		.wfm_size = 46770,
 	},
 };
 
@@ -134,9 +170,8 @@ static u16 calc_img_cksum(u16 *start, int length)
 }
 
 /* here we decode the incoming waveform file and populate metromem */
-#define EXP_WFORM_SIZE 47001
-static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
-				u8 *frame_count)
+static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
+				struct metronomefb_par *par)
 {
 	int tta;
 	int wmta;
@@ -148,26 +183,31 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	int wfm_idx, owfm_idx;
 	int mem_idx = 0;
 	struct waveform_hdr *wfm_hdr;
+	u8 *metromem = par->metromem_wfm;
+	struct device *dev = par->info->dev;
 
-	if (size != EXP_WFORM_SIZE) {
-		printk(KERN_ERR "Error: unexpected size %d != %d\n", size,
-					EXP_WFORM_SIZE);
+	if (user_wfm_size)
+		epd_frame_table[par->dt].wfm_size = user_wfm_size;
+
+	if (size != epd_frame_table[par->dt].wfm_size) {
+		dev_err(dev, "Error: unexpected size %d != %d\n", size,
+					epd_frame_table[par->dt].wfm_size);
 		return -EINVAL;
 	}
 
 	wfm_hdr = (struct waveform_hdr *) mem;
 
 	if (wfm_hdr->fvsn != 1) {
-		printk(KERN_ERR "Error: bad fvsn %x\n", wfm_hdr->fvsn);
+		dev_err(dev, "Error: bad fvsn %x\n", wfm_hdr->fvsn);
 		return -EINVAL;
 	}
 	if (wfm_hdr->luts != 0) {
-		printk(KERN_ERR "Error: bad luts %x\n", wfm_hdr->luts);
+		dev_err(dev, "Error: bad luts %x\n", wfm_hdr->luts);
 		return -EINVAL;
 	}
 	cksum = calc_cksum(32, 47, mem);
 	if (cksum != wfm_hdr->wfm_cs) {
-		printk(KERN_ERR "Error: bad cksum %x != %x\n", cksum,
+		dev_err(dev, "Error: bad cksum %x != %x\n", cksum,
 					wfm_hdr->wfm_cs);
 		return -EINVAL;
 	}
@@ -175,7 +215,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	wfm_hdr->trc += 1;
 	for (i = 0; i < 5; i++) {
 		if (*(wfm_hdr->stuff2a + i) != 0) {
-			printk(KERN_ERR "Error: unexpected value in padding\n");
+			dev_err(dev, "Error: unexpected value in padding\n");
 			return -EINVAL;
 		}
 	}
@@ -200,7 +240,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(sizeof(*wfm_hdr), cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad temperature range table cksum"
+		dev_err(dev, "Error: bad temperature range table cksum"
 				" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
@@ -212,7 +252,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad mode table address cksum"
+		dev_err(dev, "Error: bad mode table address cksum"
 				" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
@@ -224,7 +264,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad temperature table address cksum"
+		dev_err(dev, "Error: bad temperature table address cksum"
 			" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
@@ -259,11 +299,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(owfm_idx, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad waveform data cksum"
+		dev_err(dev, "Error: bad waveform data cksum"
 				" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
-	*frame_count = (mem_idx/64);
+	par->frame_count = (mem_idx/64);
 
 	return 0;
 }
@@ -335,44 +375,17 @@ static int __devinit metronome_powerup_cmd(struct metronomefb_par *par)
 
 static int __devinit metronome_config_cmd(struct metronomefb_par *par)
 {
-	int i;
-	u16 cs;
-
 	/* setup config command
 	we can't immediately set the opcode since the controller
-	will try parse the command before we've set it all up
-	so we just set cs here and set the opcode at the end */
-
-	cs = 0xCC10;
-
-	/* set the 12 args ( 8 bytes ) for config. see spec for meanings */
-	i = 0;
-	par->metromem_cmd->args[i] = 	15 /* sdlew */
-					| 2 << 8 /* sdosz */
-					| 0 << 11 /* sdor */
-					| 0 << 12 /* sdces */
-					| 0 << 15; /* sdcer */
-	cs += par->metromem_cmd->args[i++];
-
-	par->metromem_cmd->args[i] = 	42 /* gdspl */
-					| 1 << 8 /* gdr1 */
-					| 1 << 9 /* sdshr */
-					| 0 << 15; /* gdspp */
-	cs += par->metromem_cmd->args[i++];
-
-	par->metromem_cmd->args[i] = 	18 /* gdspw */
-					| 0 << 15; /* dispc */
-	cs += par->metromem_cmd->args[i++];
-
-	par->metromem_cmd->args[i] = 	599 /* vdlc */
-					| 0 << 11 /* dsi */
-					| 0 << 12; /* dsic */
-	cs += par->metromem_cmd->args[i++];
+	will try parse the command before we've set it all up */
 
+	memcpy(par->metromem_cmd->args, epd_frame_table[par->dt].config,
+		sizeof(epd_frame_table[par->dt].config));
 	/* the rest are 0 */
-	memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
+	memset((u8 *) (par->metromem_cmd->args + 4), 0, (32-4)*2);
 
-	par->metromem_cmd->csum = cs;
+	par->metromem_cmd->csum = 0xCC10;
+	par->metromem_cmd->csum += calc_img_cksum(par->metromem_cmd->args, 4);
 	par->metromem_cmd->opcode = 0xCC10; /* config cmd */
 
 	return par->board->met_wait_event(par);
@@ -408,12 +421,9 @@ static int __devinit metronome_init_regs(struct metronomefb_par *par)
 {
 	int res;
 
-	par->board->init_gpio_regs(par);
-
-	par->board->init_lcdc_regs(par);
-
-	/* now that lcd is setup, setup dma descriptor */
-	par->board->post_dma_setup(par);
+	res = par->board->setup_io(par);
+	if (res)
+		return res;
 
 	res = metronome_powerup_cmd(par);
 	if (res)
@@ -430,16 +440,16 @@ static int __devinit metronome_init_regs(struct metronomefb_par *par)
 
 static void metronomefb_dpy_update(struct metronomefb_par *par)
 {
+	int fbsize;
 	u16 cksum;
 	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
 
+	fbsize = par->info->fix.smem_len;
 	/* copy from vm to metromem */
-	memcpy(par->metromem_img, buf, DPY_W*DPY_H);
+	memcpy(par->metromem_img, buf, fbsize);
 
-	cksum = calc_img_cksum((u16 *) par->metromem_img,
-				(epd_frame_table[0].fw * DPY_H)/2);
-	*((u16 *)(par->metromem_img) +
-			(epd_frame_table[0].fw * DPY_H)/2) = cksum;
+	cksum = calc_img_cksum((u16 *) par->metromem_img, fbsize/2);
+	*((u16 *)(par->metromem_img) + fbsize/2) = cksum;
 	metronome_display_cmd(par);
 }
 
@@ -569,13 +579,16 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct metronome_board *board;
-	int retval = -ENOMEM;
+	int ret = -ENOMEM;
 	int videomemorysize;
 	unsigned char *videomemory;
 	struct metronomefb_par *par;
 	const struct firmware *fw_entry;
 	int cmd_size, wfm_size, img_size, padding_size, totalsize;
 	int i;
+	int panel_type;
+	int fw, fh;
+	int epd_dt_index;
 
 	/* pick up board specific routines */
 	board = dev->dev.platform_data;
@@ -591,9 +604,29 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	par->metromem which is physically contiguous memory and
 	contains the display controller commands, waveform,
 	processed image data and padding. this is the data pulled
-	by the device's LCD controller and pushed to Metronome */
-
-	videomemorysize = (DPY_W*DPY_H);
+	by the device's LCD controller and pushed to Metronome.
+	the metromem memory is allocated by the board driver and
+	is provided to us */
+
+	panel_type = board->get_panel_type();
+	switch (panel_type) {
+	case 6:
+		epd_dt_index = 0;
+		break;
+	case 8:
+		epd_dt_index = 1;
+		break;
+	case 97:
+		epd_dt_index = 2;
+		break;
+	default:
+		dev_err(&dev->dev, "Unexpected panel type. Defaulting to 6\n");
+		epd_dt_index = 0;
+		break;
+	}
+	fw = epd_frame_table[epd_dt_index].fw;
+	fh = epd_frame_table[epd_dt_index].fh;
+	videomemorysize = fw * fh;
 	videomemory = vmalloc(videomemorysize);
 	if (!videomemory)
 		return -ENOMEM;
@@ -607,12 +640,18 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	info->screen_base = (char __force __iomem *)videomemory;
 	info->fbops = &metronomefb_ops;
 
+	metronomefb_fix.line_length = fw;
+	metronomefb_var.xres = fw;
+	metronomefb_var.yres = fh;
+	metronomefb_var.xres_virtual = fw;
+	metronomefb_var.yres_virtual= fh;
 	info->var = metronomefb_var;
 	info->fix = metronomefb_fix;
 	info->fix.smem_len = videomemorysize;
 	par = info->par;
 	par->info = info;
 	par->board = board;
+	par->dt = epd_dt_index;
 	init_waitqueue_head(&par->waitq);
 
 	/* this table caches per page csum values. */
@@ -628,20 +667,21 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	eg: IW=832 IH=622 WS=128
 	*/
 
-	cmd_size = 1 * epd_frame_table[0].fw;
-	wfm_size = ((16*1024 + 2 + epd_frame_table[0].fw - 1)
-			/ epd_frame_table[0].fw) * epd_frame_table[0].fw;
-	img_size = epd_frame_table[0].fh * epd_frame_table[0].fw;
-	padding_size = 4 * epd_frame_table[0].fw;
+	cmd_size = 1 * fw;
+	wfm_size = ((16*1024 + 2 + fw - 1) / fw) * fw;
+	img_size = fh * fw;
+	padding_size = 4 * fw;
+	par->extra_size = cmd_size + wfm_size + padding_size;
 	totalsize = cmd_size + wfm_size + img_size + padding_size;
 	par->metromemsize = PAGE_ALIGN(totalsize + 256);
-	DPRINTK("desired memory size = %d\n", par->metromemsize);
-	dev->dev.coherent_dma_mask = 0xffffffffull;
-	par->metromem = dma_alloc_writecombine(&dev->dev, par->metromemsize,
-						&par->metromem_dma, GFP_KERNEL);
+	ret = par->board->setup_fb(par);
+	if (ret) {
+		dev_err(&dev->dev, "Failed to setup fb\n");
+		goto err_vfree;
+	}
+	/* after this point we should have a framebuffer */
 	if (!par->metromem) {
-		printk(KERN_ERR
-			"metronomefb: unable to allocate dma buffer\n");
+		ret = -EINVAL;
 		goto err_vfree;
 	}
 
@@ -649,36 +689,29 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	par->metromem_cmd = (struct metromem_cmd *) par->metromem;
 	par->metromem_wfm = par->metromem + cmd_size;
 	par->metromem_img = par->metromem + cmd_size + wfm_size;
-	par->metromem_img_csum = (u16 *) (par->metromem_img +
-					(epd_frame_table[0].fw * DPY_H));
-	DPRINTK("img offset=0x%x\n", cmd_size + wfm_size);
-	par->metromem_desc = (struct metromem_desc *) (par->metromem + cmd_size
-					+ wfm_size + img_size + padding_size);
-	par->metromem_desc_dma = par->metromem_dma + cmd_size + wfm_size
-				 + img_size + padding_size;
-
+	par->metromem_img_csum = (u16 *) (par->metromem_img + (fw * fh));
 	/* load the waveform in. assume mode 3, temp 31 for now
 		a) request the waveform file from userspace
 		b) process waveform and decode into metromem */
-	retval = request_firmware(&fw_entry, "metronome.wbf", &dev->dev);
-	if (retval < 0) {
-		printk(KERN_ERR "metronomefb: couldn't get waveform\n");
-		goto err_dma_free;
+	ret = request_firmware(&fw_entry, "metronome.wbf", &dev->dev);
+	if (ret < 0) {
+		dev_err(&dev->dev, "Failed to get waveform\n");
+		goto err_csum_table;
 	}
 
-	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size,
-				par->metromem_wfm, 3, 31, &par->frame_count);
+	ret = load_waveform((u8 *) fw_entry->data, fw_entry->size, 3, 31,
+				par);
 	release_firmware(fw_entry);
-	if (retval < 0) {
-		printk(KERN_ERR "metronomefb: couldn't process waveform\n");
-		goto err_dma_free;
+	if (ret < 0) {
+		dev_err(&dev->dev, "Failed processing waveform\n");
+		goto err_csum_table;
 	}
 
 	if (board->setup_irq(info))
-		goto err_dma_free;
+		goto err_csum_table;
 
-	retval = metronome_init_regs(par);
-	if (retval < 0)
+	ret = metronome_init_regs(par);
+	if (ret < 0)
 		goto err_free_irq;
 
 	info->flags = FBINFO_FLAG_DEFAULT;
@@ -686,9 +719,9 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	info->fbdefio = &metronomefb_defio;
 	fb_deferred_io_init(info);
 
-	retval = fb_alloc_cmap(&info->cmap, 8, 0);
-	if (retval < 0) {
-		printk(KERN_ERR "Failed to allocate colormap\n");
+	ret = fb_alloc_cmap(&info->cmap, 8, 0);
+	if (ret < 0) {
+		dev_err(&dev->dev, "Failed to allocate colormap\n");
 		goto err_fb_rel;
 	}
 
@@ -698,13 +731,13 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 	memcpy(info->cmap.green, info->cmap.red, sizeof(u16)*8);
 	memcpy(info->cmap.blue, info->cmap.red, sizeof(u16)*8);
 
-	retval = register_framebuffer(info);
-	if (retval < 0)
+	ret = register_framebuffer(info);
+	if (ret < 0)
 		goto err_cmap;
 
 	platform_set_drvdata(dev, info);
 
-	printk(KERN_INFO
+	dev_dbg(&dev->dev,
 		"fb%d: Metronome frame buffer device, using %dK of video"
 		" memory\n", info->node, videomemorysize >> 10);
 
@@ -715,16 +748,13 @@ err_cmap:
 err_fb_rel:
 	framebuffer_release(info);
 err_free_irq:
-	board->free_irq(info);
-err_dma_free:
-	dma_free_writecombine(&dev->dev, par->metromemsize, par->metromem,
-				par->metromem_dma);
+	board->cleanup(par);
 err_csum_table:
 	vfree(par->csum_table);
 err_vfree:
 	vfree(videomemory);
 	module_put(board->owner);
-	return retval;
+	return ret;
 }
 
 static int __devexit metronomefb_remove(struct platform_device *dev)
@@ -734,14 +764,13 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
 	if (info) {
 		struct metronomefb_par *par = info->par;
 		fb_deferred_io_cleanup(info);
-		dma_free_writecombine(&dev->dev, par->metromemsize,
-					par->metromem, par->metromem_dma);
 		fb_dealloc_cmap(&info->cmap);
 		vfree(par->csum_table);
 		unregister_framebuffer(info);
 		vfree((void __force *)info->screen_base);
-		par->board->free_irq(info);
+		par->board->cleanup(par);
 		module_put(par->board->owner);
+		dev_dbg(&dev->dev, "calling release\n");
 		framebuffer_release(info);
 	}
 	return 0;
@@ -766,6 +795,9 @@ static void __exit metronomefb_exit(void)
 	platform_driver_unregister(&metronomefb_driver);
 }
 
+module_param(user_wfm_size, uint, 0);
+MODULE_PARM_DESC(user_wfm_size, "Set custom waveform size");
+
 module_init(metronomefb_init);
 module_exit(metronomefb_exit);
 
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3ab6e3d..bd9d0a7 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -22,6 +22,7 @@
  *
  */
 
+#define DEBUG 1
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -57,6 +58,8 @@
  */
 #define DEBUG_VAR 1
 
+static struct platform_driver pxafb_driver;
+
 #include "pxafb.h"
 
 /* Bits which should not be set in machine configuration structures */
@@ -776,10 +779,17 @@ int pxafb_smart_flush(struct fb_info *info)
 static void setup_parallel_timing(struct pxafb_info *fbi,
 				  struct fb_var_screeninfo *var)
 {
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+
 	unsigned int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);
 
+	unsigned int pix_per_line = var->xres;
+
+	if (inf->custom_xfer_div)
+		pix_per_line = pix_per_line / inf->custom_xfer_div;
+
 	fbi->reg_lccr1 =
-		LCCR1_DisWdth(var->xres) +
+		LCCR1_DisWdth(pix_per_line) +
 		LCCR1_HorSnchWdth(var->hsync_len) +
 		LCCR1_BegLnDel(var->left_margin) +
 		LCCR1_EndLnDel(var->right_margin);
@@ -820,6 +830,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 {
 	u_long flags;
 	size_t nbytes;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 #if DEBUG_VAR
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
@@ -879,6 +890,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	fbi->reg_lccr3 |= pxafb_bpp_to_lccr3(var);
 
 	nbytes = var->yres * fbi->fb.fix.line_length;
+	if (inf->custom_xfer_div)
+		nbytes = nbytes / inf->custom_xfer_div;
 
 	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual) {
 		nbytes = nbytes / 2;
@@ -1040,7 +1053,6 @@ static irqreturn_t pxafb_handle_irq(int irq, void *dev_id)
 		lcd_writel(fbi, LCCR0, lccr0 | LCCR0_LDM);
 		complete(&fbi->disable_done);
 	}
-
 #ifdef CONFIG_FB_PXA_SMARTPANEL
 	if (lcsr & LCSR_CMD_INT)
 		complete(&fbi->command_done);
@@ -1247,22 +1259,25 @@ static int pxafb_resume(struct platform_device *dev)
  *      cache.  Once this area is remapped, all virtual memory
  *      access to the video memory should occur at the new region.
  */
-static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
+static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi,
+					 struct pxafb_mach_info *inf)
 {
+	int ret;
 	/*
 	 * We reserve one page for the palette, plus the size
 	 * of the framebuffer.
 	 */
 	fbi->video_offset = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
-	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset);
+	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset +
+					inf->extra_video_mem);
 	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
 					      &fbi->map_dma, GFP_KERNEL);
 
 	if (fbi->map_cpu) {
 		/* prevent initial garbage on screen */
 		memset(fbi->map_cpu, 0, fbi->map_size);
-		fbi->fb.screen_base = fbi->map_cpu + fbi->video_offset;
-		fbi->screen_dma = fbi->map_dma + fbi->video_offset;
+		fbi->fb.screen_base = fbi->map_cpu;
+		fbi->screen_dma = fbi->map_dma;
 
 		/*
 		 * FIXME: this is actually the wrong thing to place in
@@ -1273,14 +1288,23 @@ static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
 		fbi->fb.fix.smem_start = fbi->screen_dma;
 		fbi->palette_size = fbi->fb.var.bits_per_pixel == 8 ? 256 : 16;
 
-		fbi->dma_buff = (void *) fbi->map_cpu;
-		fbi->dma_buff_phys = fbi->map_dma;
+		fbi->dma_buff = (void *) fbi->map_cpu + fbi->map_size
+						- fbi->video_offset;
+		fbi->dma_buff_phys = fbi->map_dma + fbi->map_size
+						- fbi->video_offset;
 		fbi->palette_cpu = (u16 *) fbi->dma_buff->palette;
 
 #ifdef CONFIG_FB_PXA_SMARTPANEL
 		fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 		fbi->n_smart_cmds = 0;
 #endif
+		if (inf->share_video_mem) {
+			ret = inf->share_video_mem(fbi->fb.screen_base,
+				fbi->screen_dma, pxafb_driver.driver.owner,
+				inf->extra_data);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -1291,11 +1315,14 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
 				   unsigned int num_modes)
 {
 	unsigned int i, smemlen;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 	pxafb_setmode(&fbi->fb.var, &modes[0]);
 
 	for (i = 0; i < num_modes; i++) {
 		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
+		if (inf->custom_xfer_div)
+			smemlen /= inf->custom_xfer_div;
 		if (smemlen > fbi->fb.fix.smem_len)
 			fbi->fb.fix.smem_len = smemlen;
 	}
@@ -1347,7 +1374,7 @@ static int pxafb_decode_mach_info(struct pxafb_info *fbi,
 	return 0;
 }
 
-static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
+static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 {
 	struct pxafb_info *fbi;
 	void *addr;
@@ -1362,7 +1389,7 @@ static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
 	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 
-	fbi->clk = clk_get(dev, "LCDCLK");
+	fbi->clk = clk_get(inf->clkdev, "LCDCLK");
 	if (IS_ERR(fbi->clk)) {
 		kfree(fbi);
 		return NULL;
@@ -1410,7 +1437,7 @@ static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
 }
 
 #ifdef CONFIG_FB_PXA_PARAMETERS
-static int __init parse_opt_mode(struct device *dev, const char *this_opt)
+static int __devinit parse_opt_mode(struct device *dev, const char *this_opt)
 {
 	struct pxafb_mach_info *inf = dev->platform_data;
 
@@ -1469,7 +1496,7 @@ done:
 	return 0;
 }
 
-static int __init parse_opt(struct device *dev, char *this_opt)
+static int __devinit parse_opt(struct device *dev, char *this_opt)
 {
 	struct pxafb_mach_info *inf = dev->platform_data;
 	struct pxafb_mode_info *mode = &inf->modes[0];
@@ -1567,7 +1594,7 @@ static int __init parse_opt(struct device *dev, char *this_opt)
 	return 0;
 }
 
-static int __init pxafb_parse_options(struct device *dev, char *options)
+static int __devinit pxafb_parse_options(struct device *dev, char *options)
 {
 	char *this_opt;
 	int ret;
@@ -1586,10 +1613,10 @@ static int __init pxafb_parse_options(struct device *dev, char *options)
 	return 0;
 }
 
-static char g_options[256] __devinitdata = "";
+static char g_options[256] __initdata = "";
 
 #ifndef CONFIG_MODULES
-static int __devinit pxafb_setup_options(void)
+static int __init pxafb_setup_options(void)
 {
 	char *options = NULL;
 
@@ -1613,7 +1640,7 @@ MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
 #define pxafb_setup_options()		(0)
 #endif
 
-static int __init pxafb_probe(struct platform_device *dev)
+static int __devinit pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf;
@@ -1703,8 +1730,12 @@ static int __init pxafb_probe(struct platform_device *dev)
 	}
 
 	/* Initialize video memory */
-	ret = pxafb_map_video_memory(fbi);
-	if (ret) {
+	ret = pxafb_map_video_memory(fbi, inf);
+	if (ret == -ENODEV) {
+		dev_err(&dev->dev, "Failed device binding: %d\n", ret);
+		ret = -ENODEV;
+		goto failed_free_mem;
+	} else if (ret) {
 		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
 		goto failed_free_io;
@@ -1772,22 +1803,57 @@ failed_free_io:
 failed_free_mem:
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 			fbi->map_cpu, fbi->map_dma);
+	if (inf->unshare_video_mem)
+		inf->unshare_video_mem(inf->extra_data);
 failed:
 	platform_set_drvdata(dev, NULL);
 	kfree(fbi);
 	return ret;
 }
 
+static int __devexit pxafb_remove(struct platform_device *dev)
+{
+	struct pxafb_info *fbi = platform_get_drvdata(dev);
+	struct resource *r;
+	int irq;
+
+	if (fbi) {
+		struct pxafb_mach_info *inf;
+		struct fb_info *info = &fbi->fb;
+
+		irq = platform_get_irq(dev, 0);
+		free_irq(irq, fbi);
+
+		r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+		release_mem_region(r->start, r->end - r->start + 1);
+
+		iounmap(fbi->mmio_base);
+
+		inf = dev->dev.platform_data;
+		dev_dbg(&dev->dev, "extra_data %p\n", inf->extra_data);
+		if (inf->unshare_video_mem)
+			inf->unshare_video_mem(inf->extra_data);
+		dma_free_writecombine(&dev->dev, fbi->map_size,
+					fbi->map_cpu, fbi->map_dma);
+		fb_dealloc_cmap(&info->cmap);
+		unregister_framebuffer(info);
+		kfree(fbi);
+	}
+	return 0;
+}
+
 static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
+	.remove 	= pxafb_remove,
 	.suspend	= pxafb_suspend,
 	.resume		= pxafb_resume,
 	.driver		= {
+		.owner	= THIS_MODULE,
 		.name	= "pxa2xx-fb",
 	},
 };
 
-static int __devinit pxafb_init(void)
+static int __init pxafb_init(void)
 {
 	if (pxafb_setup_options())
 		return -EINVAL;
@@ -1795,7 +1861,13 @@ static int __devinit pxafb_init(void)
 	return platform_driver_register(&pxafb_driver);
 }
 
+static void __exit pxafb_exit(void)
+{
+	platform_driver_unregister(&pxafb_driver);
+}
+
 module_init(pxafb_init);
+module_exit(pxafb_exit);
 
 MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
 MODULE_LICENSE("GPL");
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
diff --git a/include/asm-arm/arch-pxa/pxafb.h b/include/asm-arm/arch-pxa/pxafb.h
index bbd2239..c703633 100644
--- a/include/asm-arm/arch-pxa/pxafb.h
+++ b/include/asm-arm/arch-pxa/pxafb.h
@@ -138,9 +138,18 @@ struct pxafb_mach_info {
 	 * All other bits in LCCR4 should be left alone.
 	 */
 	u_int		lccr4;
+	unsigned int	custom_xfer_div; /* divides the pixel transfer */
+	/* size of extra mem needed for secondary driver */
+	unsigned int	extra_video_mem;
+	void		*extra_data; /* extra data for secondary */
 	void (*pxafb_backlight_power)(int);
 	void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
 	void (*smart_update)(struct fb_info *);
+	/* share_video_mem allows client drivers to get our framebuffer */
+	int (*share_video_mem)(unsigned char *, dma_addr_t, struct module *,
+				void *);
+	void (*unshare_video_mem)(void *);
+	struct device *clkdev;
 };
 void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
 void set_pxa_fb_parent(struct device *parent_dev);
diff --git a/include/video/metronomefb.h b/include/video/metronomefb.h
index dab04b4..83670cc 100644
--- a/include/video/metronomefb.h
+++ b/include/video/metronomefb.h
@@ -30,7 +30,6 @@ struct metromem_cmd {
 /* struct used by metronome. board specific stuff comes from *board */
 struct metronomefb_par {
 	unsigned char *metromem;
-	struct metromem_desc *metromem_desc;
 	struct metromem_cmd *metromem_cmd;
 	unsigned char *metromem_wfm;
 	unsigned char *metromem_img;
@@ -38,25 +37,27 @@ struct metronomefb_par {
 	u16 *csum_table;
 	int metromemsize;
 	dma_addr_t metromem_dma;
-	dma_addr_t metromem_desc_dma;
 	struct fb_info *info;
 	struct metronome_board *board;
 	wait_queue_head_t waitq;
 	u8 frame_count;
+	int extra_size;
+	int dt;
 };
 
 /* board specific routines */
 struct metronome_board {
 	struct module *owner;
-	void (*free_irq)(struct fb_info *);
-	void (*init_gpio_regs)(struct metronomefb_par *);
-	void (*init_lcdc_regs)(struct metronomefb_par *);
-	void (*post_dma_setup)(struct metronomefb_par *);
+	struct module *fbmaster;
 	void (*set_rst)(struct metronomefb_par *, int);
 	void (*set_stdby)(struct metronomefb_par *, int);
+	void (*cleanup)(struct metronomefb_par *);
 	int (*met_wait_event)(struct metronomefb_par *);
 	int (*met_wait_event_intr)(struct metronomefb_par *);
 	int (*setup_irq)(struct fb_info *);
+	int (*setup_fb)(struct metronomefb_par *);
+	int (*setup_io)(struct metronomefb_par *);
+	int (*get_panel_type)(void);
 };
 
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
