From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 5/5] am200epd: add mach-pxa
	support for am200epd
Date: Fri, 30 May 2008 08:28:50 -0400
Message-ID: <1212150530-14941-6-git-send-email-jayakumar.lkml@gmail.com>
References: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K24cz-0003GM-Ct for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 06:26:42 -0700
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K24cy-0002k6-B4
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 06:26:41 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3329168wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 May 2008 06:26:40 -0700 (PDT)
In-Reply-To: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
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

am200epd implements mach-pxa support for the am200epd carrier board. It
interfaces with metronomefb and pxafb in order to support various E-Ink
panels.
This patch does:
- export pxa_device_fb to be accessed by am200epd
- redo the metronomefb interface code to interface properly with am200epd
- allow am200epd to handle different panels properly
- cleanup to use dev_dbg instead of printk
- remove mach-pxa like structure from metronomefb
- add board support for am200epd

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/Kconfig    |   17 ++
 arch/arm/mach-pxa/Makefile   |    1 +
 arch/arm/mach-pxa/am200epd.c |  347 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/devices.c  |    1 +
 drivers/video/metronomefb.c  |  270 ++++++++++++++++++--------------
 include/video/metronomefb.h  |   21 +--
 6 files changed, 524 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm/mach-pxa/am200epd.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 5da7a68..1bcff21 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -179,6 +179,23 @@ endchoice
 
 endif
 
+if MACH_GUMSTIX_F
+
+choice
+	prompt "Select base board for Gumstix board"
+
+config MACH_AM200EPD
+	tristate "Enable AM200EPD board support"
+	select FB_METRONOME
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
+
+endchoice
+
+endif
 
 if MACH_TRIZEPS4
 
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 0e6d05b..c72db62 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 
 # Specific board support
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
+obj-$(CONFIG_MACH_AM200EPD)	+= am200epd.o
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
 obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
new file mode 100644
index 0000000..7aeee2c
--- /dev/null
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -0,0 +1,347 @@
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
+MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
+
+module_init(am200_init);
+module_exit(am200_exit);
+
+MODULE_DESCRIPTION("board driver for am200 metronome epd kit");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
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
 
diff --git a/include/video/metronomefb.h b/include/video/metronomefb.h
index dab04b4..7eeddf2 100644
--- a/include/video/metronomefb.h
+++ b/include/video/metronomefb.h
@@ -12,14 +12,6 @@
 #ifndef _LINUX_METRONOMEFB_H_
 #define _LINUX_METRONOMEFB_H_
 
-/* address and control descriptors used by metronome controller */
-struct metromem_desc {
-	u32 mFDADR0;
-	u32 mFSADR0;
-	u32 mFIDR0;
-	u32 mLDCMD0;
-};
-
 /* command structure used by metronome controller */
 struct metromem_cmd {
 	u16 opcode;
@@ -30,7 +22,6 @@ struct metromem_cmd {
 /* struct used by metronome. board specific stuff comes from *board */
 struct metronomefb_par {
 	unsigned char *metromem;
-	struct metromem_desc *metromem_desc;
 	struct metromem_cmd *metromem_cmd;
 	unsigned char *metromem_wfm;
 	unsigned char *metromem_img;
@@ -38,25 +29,27 @@ struct metronomefb_par {
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
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
