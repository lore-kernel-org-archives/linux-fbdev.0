From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 1/2] am200epd: use fb notifiers
	and gpio api
Date: Sat,  2 Aug 2008 09:08:19 -0400
Message-ID: <1217682500-31503-2-git-send-email-jayakumar.lkml@gmail.com>
References: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPHip-0005x8-C1 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 07:04:39 -0700
Received: from wx-out-0506.google.com ([66.249.82.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPHim-00043D-AW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 07:04:39 -0700
Received: by wx-out-0506.google.com with SMTP id h29so810192wxd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Aug 2008 07:04:36 -0700 (PDT)
In-Reply-To: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
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
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

The original am200epd driver was designed with bad assumptions. It
manipulated GPSR/GPLR registers directly. It relied on direct access to the
pxa LCDC registers which have since conflicted with commit
ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into mach-pxa
and overhauls it to use a fb obtained through fb notifiers. It now uses the
generic GPIO api.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/Kconfig    |    3 +
 arch/arm/mach-pxa/Makefile   |    1 +
 arch/arm/mach-pxa/am200epd.c |  374 ++++++++++++++++++++++++++++++++++++++++++
 drivers/video/Kconfig        |   13 --
 drivers/video/Makefile       |    1 -
 drivers/video/am200epd.c     |  295 ---------------------------------
 6 files changed, 378 insertions(+), 309 deletions(-)
 create mode 100644 arch/arm/mach-pxa/am200epd.c
 delete mode 100644 drivers/video/am200epd.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3e28521..945014e 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -243,6 +243,9 @@ config PCM990_DISPLAY_NONE
 
 endchoice
 
+config MACH_AM200EPD
+	depends on MACH_GUMSTIX_F
+	bool "Enable AM200EPD board support"
 
 config PXA_EZX
 	bool "Motorola EZX Platform"
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 5220a5c..618fe96 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 
 # Specific board support
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
+obj-$(CONFIG_MACH_AM200EPD)	+= am200epd.o
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
 obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
new file mode 100644
index 0000000..5329548
--- /dev/null
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -0,0 +1,374 @@
+/*
+ * am200epd.c -- Platform device for AM200 EPD kit
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
+	.lcd_conn	= LCD_TYPE_COLOR_TFT | LCD_PCLK_EDGE_FALL |
+			  LCD_AC_BIAS_FREQ(24),
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
+	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++)
+		gpio_free(gpios[i]);
+}
+
+static int am200_share_video_mem(struct fb_info *info)
+{
+	/* rough check if this is our desired fb and not something else */
+	if ((info->var.xres != am200_fb_info.modes->xres)
+		|| (info->var.yres != am200_fb_info.modes->yres))
+		return 0;
+
+	/* we've now been notified that we have our new fb */
+	am200_board.metromem = info->screen_base;
+	am200_board.host_fbinfo = info;
+
+	/* try to refcount host drv since we are the consumer after this */
+	if (!try_module_get(info->fbops->owner))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int am200_unshare_video_mem(struct fb_info *info)
+{
+	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
+
+	if (info != am200_board.host_fbinfo)
+		return 0;
+
+	module_put(am200_board.host_fbinfo->fbops->owner);
+	return 0;
+}
+
+static int am200_fb_notifier_callback(struct notifier_block *self,
+				 unsigned long event, void *data)
+{
+	struct fb_event *evdata = data;
+	struct fb_info *info = evdata->info;
+
+	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
+
+	if (event == FB_EVENT_FB_REGISTERED)
+		return am200_share_video_mem(info);
+	else if (event == FB_EVENT_FB_UNREGISTERED)
+		return am200_unshare_video_mem(info);
+
+	return 0;
+}
+
+static struct notifier_block am200_fb_notif = {
+	.notifier_call = am200_fb_notifier_callback,
+};
+
+/* this gets called as part of our init. these steps must be done now so
+ * that we can use set_pxa_fb_info */
+static void __init am200_presetup_fb(void)
+{
+	int fw;
+	int fh;
+	int padding_size;
+	int totalsize;
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
+	/* the frame buffer is divided as follows:
+	command | CRC | padding
+	16kb waveform data | CRC | padding
+	image data | CRC
+	*/
+
+	fw = am200_fb_info.modes->xres;
+	fh = am200_fb_info.modes->yres;
+
+	/* waveform must be 16k + 2 for checksum */
+	am200_board.wfm_size = roundup(16*1024 + 2, fw);
+
+	padding_size = PAGE_SIZE + (4 * fw);
+
+	/* total is 1 cmd , 1 wfm, padding and image */
+	totalsize = fw + am200_board.wfm_size + padding_size + (fw*fh);
+
+	/* save this off because we're manipulating fw after this and
+	 * we'll need it when we're ready to setup the framebuffer */
+	am200_board.fw = fw;
+	am200_board.fh = fh;
+
+	/* the reason we do this adjustment is because we want to acquire
+	 * more framebuffer memory without imposing custom awareness on the
+	 * underlying pxafb driver */
+	am200_fb_info.modes->yres = DIV_ROUND_UP(totalsize, fw);
+
+	/* we divide since we told the LCD controller we're 16bpp */
+	am200_fb_info.modes->xres /= 2;
+
+	set_pxa_fb_info(&am200_fb_info);
+
+}
+
+/* this gets called by metronomefb as part of its init, in our case, we
+ * have already completed initial framebuffer init in presetup_fb so we
+ * can just setup the fb access pointers */
+static int am200_setup_fb(struct metronomefb_par *par)
+{
+	int fw;
+	int fh;
+
+	fw = am200_board.fw;
+	fh = am200_board.fh;
+
+	/* metromem was set up by the notifier in share_video_mem so now
+	 * we can use its value to calculate the other entries */
+	par->metromem_cmd = (struct metromem_cmd *) am200_board.metromem;
+	par->metromem_wfm = am200_board.metromem + fw;
+	par->metromem_img = par->metromem_wfm + am200_board.wfm_size;
+	par->metromem_img_csum = (u16 *) (par->metromem_img + (fw * fh));
+	par->metromem_dma = am200_board.host_fbinfo->fix.smem_start;
+
+	return 0;
+}
+
+static int am200_get_panel_type(void)
+{
+	return panel_type;
+}
+
+static irqreturn_t am200_handle_irq(int irq, void *dev_id)
+{
+	struct metronomefb_par *par = dev_id;
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
+				IRQF_DISABLED|IRQF_TRIGGER_FALLING,
+				"AM200", info->par);
+	if (ret)
+		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);
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
+	return wait_event_interruptible_timeout(par->waitq,
+					gpio_get_value(RDY_GPIO_PIN), HZ);
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
+	/* before anything else, we request notification for any fb
+	 * creation events */
+	fb_register_client(&am200_fb_notif);
+
+	/* request our platform independent driver */
+	request_module("metronomefb");
+
+	am200_device = platform_device_alloc("metronomefb", -1);
+	if (!am200_device)
+		return -ENOMEM;
+
+	/* the am200_board that will be seen by metronomefb is a copy */
+	platform_device_add_data(am200_device, &am200_board,
+					sizeof(am200_board));
+
+	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
+	ret = platform_device_add(am200_device);
+
+	if (ret) {
+		platform_device_put(am200_device);
+		fb_unregister_client(&am200_fb_notif);
+		return ret;
+	}
+
+	am200_presetup_fb();
+
+	return 0;
+}
+
+module_param(panel_type, uint, 0);
+MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
+
+module_init(am200_init);
+
+MODULE_DESCRIPTION("board driver for am200 metronome epd kit");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e0c5f96..752907d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1938,19 +1938,6 @@ config FB_XILINX
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
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
