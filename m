From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 08/10] am200epd: convert to
	shared fb and use gpio api
Date: Thu, 12 Jun 2008 12:59:19 -0400
Message-ID: <1213289961-1562-9-git-send-email-jayakumar.lkml@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6r34-0003lL-Bn for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:57:22 -0700
Received: from yw-out-1718.google.com ([74.125.46.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6r33-0002AY-Ol
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:57:22 -0700
Received: by yw-out-1718.google.com with SMTP id 6so2382811ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 10:57:21 -0700 (PDT)
In-Reply-To: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
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

This patch converts am200epd to use pxafb's fb and to stop performing
direct access to LCDC registers. It now uses the generic GPIO api.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/am200epd.c |  342 ++++++++++++++++++++++++------------------
 arch/arm/mach-pxa/devices.c  |    1 +
 2 files changed, 198 insertions(+), 145 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 51e26c1..67bed6c 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/video/am200epd.c -- Platform device for AM200 EPD kit
+ * am200epd.c -- Platform device for AM200 EPD kit
  *
  * Copyright (C) 2008, Jaya Kumar
  *
@@ -18,6 +18,8 @@
  *
  */
 
+#define DEBUG 1
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -27,13 +29,72 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/list.h>
-#include <linux/uaccess.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include <asm/arch/pxafb.h>
 
 #include <video/metronomefb.h>
 
-#include <asm/arch/pxa-regs.h>
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
 
 /* register offsets for gpio control */
 #define LED_GPIO_PIN 51
@@ -42,163 +103,144 @@
 #define RDY_GPIO_PIN 32
 #define ERR_GPIO_PIN 17
 #define PCBPWR_GPIO_PIN 16
+static int gpios[] = { LED_GPIO_PIN , STDBY_GPIO_PIN , RST_GPIO_PIN,
+			RDY_GPIO_PIN, ERR_GPIO_PIN, PCBPWR_GPIO_PIN };
+static char *gpio_names[] = { "LED" , "STDBY" , "RST", "RDY", "ERR", "PCBPWR" };
 
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
+static int am200_init_gpio_regs(struct metronomefb_par *par)
 {
-	u8 index;
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
 
-	index = pin >> 4;
+	gpio_direction_output(LED_GPIO_PIN, 0);
+	gpio_direction_output(STDBY_GPIO_PIN, 0);
+	gpio_direction_output(RST_GPIO_PIN, 0);
 
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
 }
 
-static void __devinit am200_init_gpio_pin(int pin, int dir)
+static void am200_cleanup(struct metronomefb_par *par)
 {
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
+	int i;
 
-		if (dir)
-			GPDR1 &= ~(1 << GPDR1_OFFSET(pin));
-		else
-			GPDR1 |= (1 << GPDR1_OFFSET(pin));
-		break;
-	case 3:
-		GAFR1_U &= ~(AF_SEL_GPIO_N << GAFR1_U_OFFSET(pin));
+	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par->info);
 
-		if (dir)
-			GPDR1 &= ~(1 << GPDR1_OFFSET(pin));
-		else
-			GPDR1 |= (1 << GPDR1_OFFSET(pin));
-		break;
-	default:
-		printk(KERN_ERR "unimplemented\n");
-	}
+	for (i = 0; i < ARRAY_SIZE(gpios); i++)
+		gpio_free(gpios[i]);
 }
 
-static void am200_init_gpio_regs(struct metronomefb_par *par)
+static struct platform_device *am200_pxa_device_fb;
+
+static int am200_pxa_register_device(struct platform_device *dev,
+					struct pxafb_mach_info *data)
 {
-	am200_init_gpio_pin(LED_GPIO_PIN, 0);
-	am200_set_gpio_output(LED_GPIO_PIN, 0);
+	int ret;
 
-	am200_init_gpio_pin(STDBY_GPIO_PIN, 0);
-	am200_set_gpio_output(STDBY_GPIO_PIN, 0);
+	am200_pxa_device_fb = platform_device_alloc("pxa2xx-fb", -1);
+	if (!am200_pxa_device_fb)
+		return -ENOMEM;
 
-	am200_init_gpio_pin(RST_GPIO_PIN, 0);
-	am200_set_gpio_output(RST_GPIO_PIN, 0);
+	platform_device_add_data(am200_pxa_device_fb, data, sizeof(*data));
 
-	am200_init_gpio_pin(RDY_GPIO_PIN, 1);
+	platform_device_add_resources(am200_pxa_device_fb,
+					pxa_device_fb.resource,
+					pxa_device_fb.num_resources);
 
-	am200_init_gpio_pin(ERR_GPIO_PIN, 1);
+	am200_pxa_device_fb->dev.dma_mask = pxa_device_fb.dev.dma_mask;
+	am200_pxa_device_fb->dev.coherent_dma_mask =
+					pxa_device_fb.dev.coherent_dma_mask;
 
-	am200_init_gpio_pin(PCBPWR_GPIO_PIN, 0);
-	am200_set_gpio_output(PCBPWR_GPIO_PIN, 0);
-}
+	ret = platform_device_add(am200_pxa_device_fb);
 
-static void am200_disable_lcd_controller(struct metronomefb_par *par)
-{
-	LCSR = 0xffffffff;	/* Clear LCD Status Register */
-	LCCR0 |= LCCR0_DIS;	/* Disable LCD Controller */
+	if (ret) {
+		dev_err(&am200_device->dev, "failed adding pxafb %d\n", ret);
+		platform_device_put(am200_pxa_device_fb);
+	}
 
-	/* we reset and just wait for things to settle */
-	msleep(200);
+	return ret;
 }
 
-static void am200_enable_lcd_controller(struct metronomefb_par *par)
+static int am200_share_video_mem(char __iomem *video_mem, dma_addr_t dma,
+					struct module *fbmaster, void *data)
 {
-	LCSR = 0xffffffff;
-	FDADR0 = par->metromem_desc_dma;
-	LCCR0 |= LCCR0_ENB;
+	struct metronomefb_par *par = data;
+
+	/* try to refcount the caller since we are the consumer after this */
+	if (!try_module_get(fbmaster))
+		return -ENODEV;
+
+	dev_dbg(&am200_device->dev, "mod_get %p\n", fbmaster);
+	am200_board.fbmaster = fbmaster;
+	par->metromem = (unsigned char __force *)video_mem;
+	par->metromem_dma = dma;
+
+	return 0;
 }
 
-static void am200_init_lcdc_regs(struct metronomefb_par *par)
+static void am200_unshare_video_mem(void *data)
 {
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
+	struct metronomefb_par *par = data;
 
+	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
+	par->metromem = NULL;
+	par->metromem_dma = 0;
+	dev_dbg(&am200_device->dev, "mod_put %p\n", am200_board.fbmaster);
+	module_put(am200_board.fbmaster);
 }
 
-static void am200_post_dma_setup(struct metronomefb_par *par)
+static int am200_setup_fb(struct metronomefb_par *par)
 {
-	par->metromem_desc->mFDADR0 = par->metromem_desc_dma;
-	par->metromem_desc->mFSADR0 = par->metromem_dma;
-	par->metromem_desc->mFIDR0 = 0;
-	par->metromem_desc->mLDCMD0 = par->info->var.xres
-					* par->info->var.yres;
-	am200_enable_lcd_controller(par);
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
 }
 
-static void am200_free_irq(struct fb_info *info)
+static int am200_get_panel_type(void)
 {
-	free_irq(IRQ_GPIO(RDY_GPIO_PIN), info);
+	return panel_type;
 }
 
 static irqreturn_t am200_handle_irq(int irq, void *dev_id)
@@ -212,53 +254,59 @@ static irqreturn_t am200_handle_irq(int irq, void *dev_id)
 
 static int am200_setup_irq(struct fb_info *info)
 {
-	int retval;
+	int ret;
 
-	retval = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
+	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
 				IRQF_DISABLED, "AM200", info);
-	if (retval) {
-		printk(KERN_ERR "am200epd: request_irq failed: %d\n", retval);
-		return retval;
+	if (ret) {
+		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);
+		return ret;
 	}
 
-	return set_irq_type(IRQ_GPIO(RDY_GPIO_PIN), IRQT_FALLING);
+	ret = set_irq_type(IRQ_GPIO(RDY_GPIO_PIN), IRQT_FALLING);
+	if (ret)
+		dev_err(&am200_device->dev, "set_irq_type failed: %d\n", ret);
+
+	return ret;
 }
 
 static void am200_set_rst(struct metronomefb_par *par, int state)
 {
-	am200_set_gpio_output(RST_GPIO_PIN, state);
+	gpio_set_value(RST_GPIO_PIN, state);
 }
 
 static void am200_set_stdby(struct metronomefb_par *par, int state)
 {
-	am200_set_gpio_output(STDBY_GPIO_PIN, state);
+	gpio_set_value(STDBY_GPIO_PIN, state);
 }
 
 static int am200_wait_event(struct metronomefb_par *par)
 {
-	return wait_event_timeout(par->waitq, (GPLR1 & 0x01), HZ);
+	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
 }
 
 static int am200_wait_event_intr(struct metronomefb_par *par)
 {
-	return wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
+	int ret;
+
+	ret = wait_event_interruptible_timeout(par->waitq,
+					gpio_get_value(RDY_GPIO_PIN), HZ);
+	return ret;
 }
 
 static struct metronome_board am200_board = {
 	.owner			= THIS_MODULE,
-	.free_irq		= am200_free_irq,
 	.setup_irq		= am200_setup_irq,
-	.init_gpio_regs		= am200_init_gpio_regs,
-	.init_lcdc_regs		= am200_init_lcdc_regs,
-	.post_dma_setup		= am200_post_dma_setup,
+	.setup_io		= am200_init_gpio_regs,
+	.setup_fb		= am200_setup_fb,
 	.set_rst		= am200_set_rst,
 	.set_stdby		= am200_set_stdby,
 	.met_wait_event		= am200_wait_event,
 	.met_wait_event_intr	= am200_wait_event_intr,
+	.get_panel_type		= am200_get_panel_type,
+	.cleanup		= am200_cleanup,
 };
 
-static struct platform_device *am200_device;
-
 static int __init am200_init(void)
 {
 	int ret;
@@ -284,9 +332,13 @@ static int __init am200_init(void)
 
 static void __exit am200_exit(void)
 {
+	platform_device_unregister(am200_pxa_device_fb);
 	platform_device_unregister(am200_device);
 }
 
+module_param(panel_type, uint, 0);
+MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
+
 module_init(am200_init);
 module_exit(am200_exit);
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index b72b73a..fe0eb07 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -127,6 +127,7 @@ struct platform_device pxa_device_fb = {
 	.num_resources	= ARRAY_SIZE(pxafb_resources),
 	.resource	= pxafb_resources,
 };
+EXPORT_SYMBOL_GPL(pxa_device_fb);
 
 void __init set_pxa_fb_info(struct pxafb_mach_info *info)
 {
-- 
1.5.3.6


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
