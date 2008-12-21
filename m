From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 2/2] mach-pxa: add AM300 platform
	driver
Date: Sun, 21 Dec 2008 18:59:48 +0800
Message-ID: <12298571881580-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LEM2O-0001l1-OT
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 10:59:56 +0000
Received: from ti-out-0910.google.com ([209.85.142.187])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LEM2L-0006Tv-U9 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 10:59:56 +0000
Received: by ti-out-0910.google.com with SMTP id y6so1230426tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Dec 2008 02:59:53 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Eric Miao <eric.miao@marvell.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

This patch adds support for the AM300 platform driver.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-arm-kernel@lists.arm.linux.org.uk
---
 arch/arm/mach-pxa/Kconfig                |    3 +
 arch/arm/mach-pxa/Makefile               |    1 +
 arch/arm/mach-pxa/am300epd.c             |  335 ++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/gumstix.c              |    6 +
 arch/arm/mach-pxa/include/mach/gumstix.h |    1 +
 5 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/am300epd.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 94e3adb..768618b 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -40,6 +40,9 @@ choice
 config GUMSTIX_AM200EPD
 	bool "Enable AM200EPD board support"
 
+config GUMSTIX_AM300EPD
+	bool "Enable AM300EPD board support"
+
 endchoice
 
 config MACH_INTELMOTE2
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 7b28bb5..764f111 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 # Specific board support
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
 obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
+obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
 obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
new file mode 100644
index 0000000..e060ef8
--- /dev/null
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -0,0 +1,335 @@
+/*
+ * am300epd.c -- Platform device for AM300 EPD kit
+ *
+ * Copyright (C) 2008, Jaya Kumar
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * This work was made possible by help and equipment support from E-Ink
+ * Corporation. http://support.eink.com/community
+ *
+ * This driver is written to be used with the Broadsheet display controller.
+ * on the AM300 EPD prototype kit/development kit with an E-Ink 800x600
+ * Vizplex EPD on a Gumstix board using the Broadsheet interface board.
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
+#include <mach/gumstix.h>
+#include <mach/mfp-pxa25x.h>
+#include <mach/pxafb.h>
+
+#include "generic.h"
+
+#include <video/broadsheetfb.h>
+
+static unsigned int panel_type = 6;
+static struct platform_device *am300_device;
+static struct broadsheet_board am300_board;
+
+static unsigned long am300_pin_config[] __initdata = {
+	GPIO16_GPIO,
+	GPIO17_GPIO,
+	GPIO32_GPIO,
+	GPIO48_GPIO,
+	GPIO49_GPIO,
+	GPIO51_GPIO,
+	GPIO74_GPIO,
+	GPIO75_GPIO,
+	GPIO76_GPIO,
+	GPIO77_GPIO,
+
+	/* this is the 16-bit hdb bus 58-73 */
+	GPIO58_GPIO,
+	GPIO59_GPIO,
+	GPIO60_GPIO,
+	GPIO61_GPIO,
+
+	GPIO62_GPIO,
+	GPIO63_GPIO,
+	GPIO64_GPIO,
+	GPIO65_GPIO,
+
+	GPIO66_GPIO,
+	GPIO67_GPIO,
+	GPIO68_GPIO,
+	GPIO69_GPIO,
+
+	GPIO70_GPIO,
+	GPIO71_GPIO,
+	GPIO72_GPIO,
+	GPIO73_GPIO,
+};
+
+/* register offsets for gpio control */
+#define PWR_GPIO_PIN 16
+#define CFG_GPIO_PIN 17
+#define RDY_GPIO_PIN 32
+#define DC_GPIO_PIN 48
+#define RST_GPIO_PIN 49
+#define LED_GPIO_PIN 51
+#define RD_GPIO_PIN 74
+#define WR_GPIO_PIN 75
+#define CS_GPIO_PIN 76
+#define IRQ_GPIO_PIN 77
+
+/* hdb bus */
+#define DB0_GPIO_PIN 58
+#define DB15_GPIO_PIN 73
+
+static int gpios[] = { PWR_GPIO_PIN, CFG_GPIO_PIN, RDY_GPIO_PIN, DC_GPIO_PIN,
+			RST_GPIO_PIN, RD_GPIO_PIN, WR_GPIO_PIN, CS_GPIO_PIN,
+			IRQ_GPIO_PIN, LED_GPIO_PIN };
+static char *gpio_names[] = { "PWR", "CFG", "RDY", "DC", "RST", "RD", "WR",
+				"CS", "IRQ", "LED" };
+
+static int am300_wait_for_rdy(struct broadsheetfb_par *par)
+{
+	unsigned long flags;
+	DEFINE_WAIT(wait);
+
+	spin_lock_irqsave(par->lock, flags);
+	while (!gpio_get_value(RDY_GPIO_PIN)) {
+		prepare_to_wait(&par->waitq, &wait, TASK_INTERRUPTIBLE);
+
+		spin_unlock_irqrestore(par->lock, flags);
+		schedule();
+		spin_lock_irqsave(par->lock, flags);
+	}
+	finish_wait(&par->waitq, &wait);
+
+	spin_unlock_irqrestore(par->lock, flags);
+	return 0;
+
+}
+
+static int am300_init_gpio_regs(struct broadsheetfb_par *par)
+{
+	int i;
+	int err;
+	char dbname[8];
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		err = gpio_request(gpios[i], gpio_names[i]);
+		if (err) {
+			dev_err(&am300_device->dev, "failed requesting "
+				"gpio %s, err=%d\n", gpio_names[i], err);
+			goto err_req_gpio;
+		}
+	}
+
+	/* we also need to take care of the hdb bus */
+	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++) {
+		sprintf(dbname, "DB%d", i);
+		err = gpio_request(i, dbname);
+		if (err) {
+			dev_err(&am300_device->dev, "failed requesting "
+				"gpio %d, err=%d\n", i, err);
+			while (i >= DB0_GPIO_PIN)
+				gpio_free(i--);
+			i = ARRAY_SIZE(gpios) - 1;
+			goto err_req_gpio;
+		}
+	}
+
+	/* setup the outputs and init values */
+	gpio_direction_output(PWR_GPIO_PIN, 0);
+	gpio_direction_output(CFG_GPIO_PIN, 1);
+	gpio_direction_output(DC_GPIO_PIN, 0);
+	gpio_direction_output(RD_GPIO_PIN, 1);
+	gpio_direction_output(WR_GPIO_PIN, 1);
+	gpio_direction_output(CS_GPIO_PIN, 1);
+	gpio_direction_output(RST_GPIO_PIN, 0);
+
+	/* setup the inputs */
+	gpio_direction_input(RDY_GPIO_PIN);
+	gpio_direction_input(IRQ_GPIO_PIN);
+
+	/* start the hdb bus as an input */
+	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
+		gpio_direction_output(i, 0);
+
+	/* go into command mode */
+	gpio_set_value(CFG_GPIO_PIN, 1);
+	gpio_set_value(RST_GPIO_PIN, 0);
+	mdelay(10);
+	gpio_set_value(RST_GPIO_PIN, 1);
+	mdelay(10);
+	am300_wait_for_rdy(par);
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
+static int am300_init_board(struct broadsheetfb_par *par)
+{
+	int ret;
+
+	/* setup pins */
+	ret = am300_init_gpio_regs(par);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void am300_cleanup(struct broadsheetfb_par *par)
+{
+	int i;
+
+	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++)
+		gpio_free(gpios[i]);
+
+	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
+		gpio_free(i);
+
+}
+
+static u16 am300_get_hdb(struct broadsheetfb_par *par)
+{
+	u16 res = 0;
+	int i;
+
+	for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
+		res |= (gpio_get_value(DB0_GPIO_PIN + i)) ? (1 << i) : 0;
+
+	return res;
+}
+
+static void am300_set_hdb(struct broadsheetfb_par *par, u16 data)
+{
+	int i;
+
+	for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
+		gpio_set_value(DB0_GPIO_PIN + i, (data >> i) & 0x01);
+}
+
+
+static void am300_set_ctl(struct broadsheetfb_par *par, unsigned char bit,
+				u8 state)
+{
+	switch (bit) {
+	case BS_CS:
+		gpio_set_value(CS_GPIO_PIN, state);
+		break;
+	case BS_DC:
+		gpio_set_value(DC_GPIO_PIN, state);
+		break;
+	case BS_WR:
+		gpio_set_value(WR_GPIO_PIN, state);
+		break;
+	}
+}
+
+static int am300_get_panel_type(void)
+{
+	return panel_type;
+}
+
+static irqreturn_t am300_handle_irq(int irq, void *dev_id)
+{
+	unsigned long flags;
+	struct broadsheetfb_par *par = dev_id;
+
+	spin_lock_irqsave(par->lock, flags);
+	wake_up_interruptible(&par->waitq);
+	spin_unlock_irqrestore(par->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static int am300_setup_irq(struct fb_info *info)
+{
+	int ret;
+	struct broadsheetfb_par *par = info->par;
+
+	spin_lock_init(&par->lock);
+
+	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am300_handle_irq,
+				IRQF_DISABLED|IRQF_TRIGGER_RISING,
+				"AM300", par);
+	if (ret)
+		dev_err(&am300_device->dev, "request_irq failed: %d\n", ret);
+
+	return ret;
+}
+
+static int am300_wait_event(struct broadsheetfb_par *par)
+{
+	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
+}
+
+static int am300_wait_event_intr(struct broadsheetfb_par *par)
+{
+	return wait_event_interruptible_timeout(par->waitq,
+					gpio_get_value(RDY_GPIO_PIN), HZ);
+}
+
+static struct broadsheet_board am300_board = {
+	.owner			= THIS_MODULE,
+	.init			= am300_init_board,
+	.cleanup		= am300_cleanup,
+	.set_hdb		= am300_set_hdb,
+	.get_hdb		= am300_get_hdb,
+	.set_ctl		= am300_set_ctl,
+	.wait_for_rdy		= am300_wait_for_rdy,
+	.get_panel_type		= am300_get_panel_type,
+	.setup_irq		= am300_setup_irq,
+	.wait_event		= am300_wait_event,
+	.wait_event_intr	= am300_wait_event_intr,
+};
+
+int __init am300_init(void)
+{
+	int ret;
+
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(am300_pin_config));
+
+	/* request our platform independent driver */
+	request_module("broadsheetfb");
+
+	am300_device = platform_device_alloc("broadsheetfb", -1);
+	if (!am300_device)
+		return -ENOMEM;
+
+	/* the am300_board that will be seen by broadsheetfb is a copy */
+	platform_device_add_data(am300_device, &am300_board,
+					sizeof(am300_board));
+
+	ret = platform_device_add(am300_device);
+
+	if (ret) {
+		platform_device_put(am300_device);
+		return ret;
+	}
+
+	return 0;
+}
+
+module_param(panel_type, uint, 0);
+MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
+
+module_init(am300_init);
+
+MODULE_DESCRIPTION("board driver for am300 epd kit");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index e296ce1..9cb4a07 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -191,6 +191,11 @@ int __attribute__((weak)) am200_init(void)
 	return 0;
 }
 
+int __attribute__((weak)) am300_init(void)
+{
+	return 0;
+}
+
 static void __init carrier_board_init(void)
 {
 	/*
@@ -198,6 +203,7 @@ static void __init carrier_board_init(void)
 	 * they cannot be detected programatically
 	 */
 	am200_init();
+	am300_init();
 }
 
 static void __init gumstix_init(void)
diff --git a/arch/arm/mach-pxa/include/mach/gumstix.h b/arch/arm/mach-pxa/include/mach/gumstix.h
index 099f54a..06abd41 100644
--- a/arch/arm/mach-pxa/include/mach/gumstix.h
+++ b/arch/arm/mach-pxa/include/mach/gumstix.h
@@ -97,4 +97,5 @@ has detected a cable insertion; driven low otherwise. */
 
 /* for expansion boards that can't be programatically detected */
 extern int am200_init(void);
+extern int am300_init(void);
 
-- 
1.5.2.3


------------------------------------------------------------------------------
