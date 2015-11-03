From: Rongrong Zou <rongrongchau@outlook.com>
Date: Tue, 03 Nov 2015 13:54:56 +0000
Subject: [PATCH 1/3] Hisilicon graphic driver: add fbdev support to hisilicon hi1710 graphic chip
Message-Id: <BLU437-SMTP246338AFFA84224C9B222DC32B0@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Rongrong Zou <zourongrong@huawei.com>

hisi_drv.c, main file of driver, register hisilicon fb driver to kernel.
hssi_hw.c, this file implements controller's display mode.
hisi_power.c, implements power mode setting.
hisi_chip.c, some chip settings, such as pll setting.

Signed-off-by: Rongrong Zou <zourongrong@huawei.com>
---
 MAINTAINERS                                |    7 +
 drivers/video/fbdev/Kconfig                |   14 +
 drivers/video/fbdev/Makefile               |    2 +-
 drivers/video/fbdev/hisilicon/Makefile     |    6 +
 drivers/video/fbdev/hisilicon/hisi_chip.c  |  131 ++++
 drivers/video/fbdev/hisilicon/hisi_chip.h  |   62 ++
 drivers/video/fbdev/hisilicon/hisi_drv.c   | 1118 ++++++++++++++++++++++++++++
 drivers/video/fbdev/hisilicon/hisi_drv.h   |  181 +++++
 drivers/video/fbdev/hisilicon/hisi_help.h  |   64 ++
 drivers/video/fbdev/hisilicon/hisi_hw.c    |  293 ++++++++
 drivers/video/fbdev/hisilicon/hisi_hw.h    |   95 +++
 drivers/video/fbdev/hisilicon/hisi_mode.c  |  286 +++++++
 drivers/video/fbdev/hisilicon/hisi_mode.h  |   39 +
 drivers/video/fbdev/hisilicon/hisi_power.c |  106 +++
 drivers/video/fbdev/hisilicon/hisi_power.h |   18 +
 drivers/video/fbdev/hisilicon/hisi_reg.h   |  418 +++++++++++
 16 files changed, 2839 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/hisilicon/Makefile
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_chip.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_chip.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_drv.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_drv.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_help.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_hw.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_hw.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_mode.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_mode.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_power.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_power.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_reg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 77ed3a0..2813be9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4973,6 +4973,13 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON FRAMEBUFFER DRIVER
+M:	Rongrong Zou <zourongrong@huawei.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/fb/intelfb.txt
+F:	drivers/video/fbdev/hisilicon/
+
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
 L:	hostap@shmoo.com (subscribers-only)
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8b1d371..6399da3 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2489,3 +2489,17 @@ config FB_SM712
 	  This driver is also available as a module. The module will be
 	  called sm712fb. If you want to compile it as a module, say M
 	  here and read <file:Documentation/kbuild/modules.txt>.
+
+config FB_HISILICON
+	tristate "Hisilicon Hi1710 framebuffer support"
+	depends on FB && PCI
+	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Frame buffer driver for Hisilicon Hi1710 integrited graphics chip.
+
+	  This driver is also available as a module. The module will be
+	  called hisiliconfb. If you want to compile it as a module, say M
+	  here and read <file:Documentation/kbuild/modules.txt>.
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 50ed1b4..c7383db 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -132,7 +132,7 @@ obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
 obj-$(CONFIG_FB_HYPERV)		  += hyperv_fb.o
 obj-$(CONFIG_FB_OPENCORES)	  += ocfb.o
 obj-$(CONFIG_FB_SM712)		  += sm712fb.o
-
+obj-$(CONFIG_FB_HISILICON)         += hisilicon/
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
 obj-$(CONFIG_FB_VESA)             += vesafb.o
diff --git a/drivers/video/fbdev/hisilicon/Makefile b/drivers/video/fbdev/hisilicon/Makefile
new file mode 100644
index 0000000..540b6d2
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_FB_HISILICON) += hisiliconfb.o
+
+hisiliconfb-y := hisi_drv.o hisi_hw.o hisi_chip.o
+hisiliconfb-y += hisi_mode.o hisi_power.o
+
+hisiliconfb-objs := $(hisiliconfb-y)
diff --git a/drivers/video/fbdev/hisilicon/hisi_chip.c b/drivers/video/fbdev/hisilicon/hisi_chip.c
new file mode 100644
index 0000000..e152f37
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_chip.c
@@ -0,0 +1,131 @@
+#include <linux/delay.h>
+#include "hisi_chip.h"
+#include "hisi_help.h"
+#include "hisi_power.h"
+#include "hisi_reg.h"
+
+void set_vclock_hisilicon(unsigned long pll)
+{
+	unsigned long tmp0, tmp1;
+
+    /* 1. outer_bypass_n=0 */
+	tmp0 = PEEK32(CRT_PLL1_HS);
+	tmp0 &= 0xBFFFFFFF;
+	POKE32(CRT_PLL1_HS, tmp0);
+
+	/* 2. pll_pd=1?inter_bypass=1 */
+	POKE32(CRT_PLL1_HS, 0x21000000);
+
+	/* 3. config pll */
+	POKE32(CRT_PLL1_HS, pll);
+
+	/* 4. delay  */
+	mdelay(1);
+
+	/* 5. pll_pd =0 */
+	tmp1 = pll & ~0x01000000;
+	POKE32(CRT_PLL1_HS, tmp1);
+
+	/* 6. delay  */
+	mdelay(1);
+
+	/* 7. inter_bypass=0 */
+	tmp1 &= ~0x20000000;
+	POKE32(CRT_PLL1_HS, tmp1);
+
+    /* 8. delay  */
+	mdelay(1);
+
+	/* 9. outer_bypass_n=1 */
+	tmp1 |= 0x40000000;
+	POKE32(CRT_PLL1_HS, tmp1);
+}
+
+
+int hisi_init_hw(struct _initchip_param_t *p_init_param)
+{
+	unsigned int reg;
+
+	if (p_init_param->powerMode != 0)
+		p_init_param->powerMode = 0;
+	set_power_mode(p_init_param->powerMode);
+
+	/* Enable display power gate & LOCALMEM power gate*/
+	reg = PEEK32(CURRENT_GATE);
+	reg = FIELD_SET(reg, CURRENT_GATE, DISPLAY, ON);
+	reg = FIELD_SET(reg, CURRENT_GATE, LOCALMEM, ON);
+	set_current_gate(reg);
+
+	{
+#if defined(__i386__) || defined(__x86_64__)
+		/* set graphic mode via IO method */
+		outb_p(0x88, 0x3d4);
+		outb_p(0x06, 0x3d5);
+#endif
+	}
+
+	/* Reset the memory controller. If the memory controller
+	 * is not reset in chip,the system might hang when sw accesses
+	 * the memory.The memory should be resetted after
+	 * changing the MXCLK.
+	 */
+	if (p_init_param->resetMemory = 1) {
+		reg = PEEK32(MISC_CTRL);
+		reg = FIELD_SET(reg, MISC_CTRL, LOCALMEM_RESET, RESET);
+		POKE32(MISC_CTRL, reg);
+
+		reg = FIELD_SET(reg, MISC_CTRL, LOCALMEM_RESET, NORMAL);
+		POKE32(MISC_CTRL, reg);
+	}
+
+	if (p_init_param->setAllEngOff = 1) {
+		enable_2d_engine(0);
+
+		/* Disable Overlay, if a former application left it on */
+		reg = PEEK32(VIDEO_DISPLAY_CTRL);
+		reg = FIELD_SET(reg, VIDEO_DISPLAY_CTRL, PLANE, DISABLE);
+		POKE32(VIDEO_DISPLAY_CTRL, reg);
+
+		/* Disable video alpha, if a former application left it on */
+		reg = PEEK32(VIDEO_ALPHA_DISPLAY_CTRL);
+		reg = FIELD_SET(reg, VIDEO_ALPHA_DISPLAY_CTRL, PLANE, DISABLE);
+		POKE32(VIDEO_ALPHA_DISPLAY_CTRL, reg);
+
+		/* Disable alpha plane, if a former application left it on */
+		reg = PEEK32(ALPHA_DISPLAY_CTRL);
+		reg = FIELD_SET(reg, ALPHA_DISPLAY_CTRL, PLANE, DISABLE);
+		POKE32(ALPHA_DISPLAY_CTRL, reg);
+
+		/* Disable DMA Channel, if a former application left it on */
+		reg = PEEK32(DMA_ABORT_INTERRUPT);
+		reg = FIELD_SET(reg, DMA_ABORT_INTERRUPT, ABORT_1, ABORT);
+		POKE32(DMA_ABORT_INTERRUPT, reg);
+
+		/* Disable DMA Power, if a former application left it on */
+		enable_dma(0);
+	}
+
+	/* We can add more initialization as needed. */
+
+	return 0;
+}
+
+unsigned int format_pll_reg(struct pll *ppll)
+{
+	unsigned int pllreg = 0;
+
+    /* Note that all PLL's have the same format. Here,
+     *we just use Panel PLL parameter to work out the bit
+     * fields in the register.On returning a 32 bit number, the value can
+     * be applied to any PLL in the calling function.
+     */
+	pllreg = FIELD_SET(0, PANEL_PLL_CTRL, BYPASS, OFF) |
+	FIELD_SET(0, PANEL_PLL_CTRL, POWER,  ON)|
+	FIELD_SET(0, PANEL_PLL_CTRL, INPUT,  OSC)|
+	FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    ppll->POD)|
+	FIELD_VALUE(0, PANEL_PLL_CTRL, OD,     ppll->OD)|
+	FIELD_VALUE(0, PANEL_PLL_CTRL, N,      ppll->N)|
+	FIELD_VALUE(0, PANEL_PLL_CTRL, M,      ppll->M);
+
+	return pllreg;
+}
diff --git a/drivers/video/fbdev/hisilicon/hisi_chip.h b/drivers/video/fbdev/hisilicon/hisi_chip.h
new file mode 100644
index 0000000..b33cbfe
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_chip.h
@@ -0,0 +1,62 @@
+#ifndef HISI_CHIP_H__
+#define HISI_CHIP_H__
+
+#define DEFAULT_INPUT_CLOCK 14318181 /* Default reference clock */
+
+
+enum clock_type {
+	MXCLK_PLL,
+	PRIMARY_PLL,
+	SECONDARY_PLL,
+	VGA0_PLL,
+	VGA1_PLL,
+};
+
+struct pll {
+	enum clock_type clock_type;
+	unsigned long intput_freq; /* Input clock frequency to the PLL */
+
+	/* Use this when clock_type = PANEL_PLL */
+	unsigned long M;
+	unsigned long N;
+	unsigned long OD;
+	unsigned long POD;
+};
+
+/* input struct to initChipParam() function */
+struct _initchip_param_t {
+	unsigned short powerMode;    /* Use power mode 0 or 1 */
+	unsigned short chipClock;
+				/* Speed of main chip clock in MHz unit
+				 *0 = keep the current clock setting
+				 *Others = the new main chip clock
+				 */
+	unsigned short memClock;
+				/* Speed of memory clock in MHz unit
+				 * 0 = keep the current clock setting
+				 * Others = the new memory clock
+				 */
+	unsigned short masterClock;
+				/* Speed of master clock in MHz unit
+				 *0 = keep the current clock setting
+				 *Others = the new master clock
+				 */
+	unsigned short setAllEngOff;
+				/* 0 = leave all engine state untouched.
+				 *1 = make sure they are off: 2D, Overlay,
+				 *video alpha, alpha, hardware cursors
+				 */
+	unsigned char resetMemory;
+				/* 0 = Do not reset the memory controller
+				 *1 = Reset the memory controller
+				 */
+
+	/* More initialization parameter can be added if needed */
+};
+
+
+unsigned int format_pll_reg(struct pll *pll);
+int hisi_init_hw(struct _initchip_param_t *);
+void set_vclock_hisilicon(unsigned long pll);
+
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_drv.c b/drivers/video/fbdev/hisilicon/hisi_drv.c
new file mode 100644
index 0000000..521a279
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_drv.c
@@ -0,0 +1,1118 @@
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/screen_info.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include "hisi_drv.h"
+#include "hisi_hw.h"
+
+
+/* chip specific setup routine */
+static void hisi_fb_setup(struct hisi_share *share, char *src);
+static int hisifb_pci_probe(struct pci_dev *, const struct pci_device_id *);
+static void hisifb_pci_remove(struct pci_dev *);
+
+#ifdef CONFIG_PM
+static int hisifb_suspend(struct pci_dev *, pm_message_t);
+static int hisifb_resume(struct pci_dev *);
+#endif
+
+static int hisifb_set_fbinfo(struct fb_info *, int);
+static int hisifb_ops_check_var(struct fb_var_screeninfo *, struct fb_info *);
+static int hisifb_ops_set_par(struct fb_info *);
+static int hisifb_ops_setcolreg(unsigned, unsigned, unsigned,
+	unsigned, unsigned, struct fb_info *);
+static int hisifb_ops_blank(int, struct fb_info *);
+
+typedef void (*PROC_SPEC_SETUP)(struct hisi_share *, char *);
+typedef int (*PROC_SPEC_MAP)(struct hisi_share *, struct pci_dev *);
+typedef int (*PROC_SPEC_INITHW)(struct hisi_share *, struct pci_dev *);
+
+/* common var for all device */
+static int g_hwcursor = 1;
+static int g_noaccel = 1;
+#ifdef CONFIG_MTRR
+static int g_nomtrr;
+#endif
+static const char *g_fbmode[2];
+
+/*modify for hisilicon default mode*/
+static const char *g_def_fbmode = "800x600-16@60";
+static char *g_settings;
+static int g_dualview;
+
+#ifdef MODULE
+static char *g_option;
+#endif
+
+static const struct fb_videomode hisi_vedio_mode_ext[] = {
+	/*024x600-60 VESA [1.71:1]*/
+	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/* 024x600-70 VESA */
+	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*  024x600-75 VESA */
+	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*  024x600-85 VESA */
+	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*20x480	*/
+	{NULL, 60,  720,  480,  37427, 88, 16, 13, 1,   72,  3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*280x720		[1.78:1]	*/
+	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/* 1280x768@60 */
+	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_VMODE_NONINTERLACED},
+
+	/*360 x 768	[1.77083:1]	*/
+	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*368 x 768      [1.78:1]	*/
+	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/* 440 x 900		[16:10]	*/
+	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*440x960		[15:10]	*/
+	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+
+	/*920x1080	[16:9]	*/
+	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
+};
+
+static struct pci_device_id hisi_pci_table[] = {
+	{PCI_VENDOR_ID_HIS, PCI_DEVID_HS_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+static struct pci_driver hisifb_driver = {
+	.name = _moduleName_,
+	.id_table = hisi_pci_table,
+	.probe = hisifb_pci_probe,
+	.remove = hisifb_pci_remove,
+#ifdef CONFIG_PM
+	.suspend = hisifb_suspend,
+	.resume = hisifb_resume,
+#endif
+};
+
+static struct fb_ops hisifb_ops = {
+	.owner = THIS_MODULE,
+	.fb_check_var =  hisifb_ops_check_var,
+	.fb_set_par = hisifb_ops_set_par,
+	.fb_setcolreg = hisifb_ops_setcolreg,
+	.fb_blank = hisifb_ops_blank,
+	/* will be hooked by hardware */
+	.fb_fillrect = cfb_fillrect,
+	.fb_imageblit = cfb_imageblit,
+	.fb_copyarea = cfb_copyarea,
+};
+
+#ifdef CONFIG_PM
+static int hisifb_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct fb_info *info;
+	struct hisi_share *share;
+	int ret;
+
+	if (mesg.event = pdev->dev.power.power_state.event)
+		return 0;
+
+	ret = 0;
+	share = pci_get_drvdata(pdev);
+	switch (mesg.event) {
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_PRETHAW:
+		pdev->dev.power.power_state = mesg;
+		return 0;
+	}
+
+	console_lock();
+	if (mesg.event & PM_EVENT_SLEEP) {
+		info = share->fbinfo[0];
+		if (info)
+			fb_set_suspend(info, 1);/* 1 means do suspend*/
+
+		info = share->fbinfo[1];
+		if (info)
+			fb_set_suspend(info, 1);/* 1 means do suspend*/
+
+		ret = pci_save_state(pdev);
+		if (ret) {
+			err_msg("error:%d occurred in pci_save_state\n", ret);
+			console_unlock();
+			return ret;
+		}
+
+		pci_disable_device(pdev);
+		ret = pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
+		if (ret) {
+			err_msg("error:%d occurred in pci_set_power_state\n",
+				ret);
+			console_unlock();
+			return ret;
+		}
+		/* set chip to sleep mode	*/
+		if (share->suspend)
+			(*share->suspend)();
+	}
+
+	pdev->dev.power.power_state = mesg;
+	console_unlock();
+	return ret;
+}
+
+static int hisifb_resume(struct pci_dev *pdev)
+{
+	struct fb_info *info;
+	struct hisi_share *share;
+
+	struct hisifb_par *par;
+	struct hisifb_crtc *crtc;
+	struct hisi_cursor *cursor;
+
+	int ret;
+
+	ret = 0;
+	share = pci_get_drvdata(pdev);
+
+	console_lock();
+	ret = pci_set_power_state(pdev, PCI_D0);
+	if (ret != 0) {
+		err_msg("error:%d occurred in pci_set_power_state\n", ret);
+		console_lock();
+		return ret;
+	}
+
+	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
+		pci_restore_state(pdev);
+		ret = pci_enable_device(pdev);
+		if (ret != 0) {
+			err_msg("error:%d occurred in pci_enable_device\n",
+				ret);
+			console_lock();
+			return ret;
+		}
+		pci_set_master(pdev);
+	}
+
+	hw_hisi_inithw(share, pdev);
+
+	info = share->fbinfo[0];
+	par = info->par;
+	crtc = &par->crtc;
+	cursor = &crtc->cursor;
+
+	if (info) {
+		hisifb_ops_set_par(info);
+		fb_set_suspend(info, 0);
+	}
+
+	info = share->fbinfo[1];
+
+	if (info) {
+		hisifb_ops_set_par(info);
+		fb_set_suspend(info, 0);
+	}
+
+	if (share->resume)
+		(*share->resume)();
+
+	console_unlock();
+	return ret;
+}
+#endif
+
+static int hisifb_ops_check_var(struct fb_var_screeninfo *var,
+	struct fb_info *info)
+{
+	struct hisifb_par *par;
+	struct hisifb_crtc *crtc;
+	struct hisifb_output *output;
+	struct hisi_share *share;
+	int ret;
+	resource_size_t request;
+
+	par = info->par;
+	crtc = &par->crtc;
+	output = &par->output;
+	share = par->share;
+	ret = 0;
+
+	dbg_msg("check var:%dx%d-%d\n",
+		 var->xres,
+		 var->yres,
+		 var->bits_per_pixel);
+
+	switch (var->bits_per_pixel) {
+	case 8:
+	case 16:
+	case 24: /* support 24 bpp for only lynx712/722/720 */
+	case 32:
+		break;
+	default:
+		err_msg("bpp %d not supported\n", var->bits_per_pixel);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (var->bits_per_pixel) {
+	case 8:
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		var->red.offset = 0;
+		var->red.length = 8;
+		var->green.offset = 0;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 5;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	case 24:
+	case 32:
+		var->red.offset = 16;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	var->height = var->width = -1;
+	var->accel_flags = FB_ACCELF_TEXT;
+
+	/* check if current fb's video memory
+	 * big enought to hold the onscreen
+	 */
+	request = var->xres_virtual * (var->bits_per_pixel >> 3);
+	/* defaulty crtc->channel go with par->index */
+
+	request = PADDING(crtc->line_pad, request);
+	request = request * var->yres_virtual;
+	if (crtc->vidmem_size < request) {
+		err_msg("not enough video memory for mode\n");
+		return -ENOMEM;
+	}
+
+	ret = crtc->proc_check_mode(crtc, var);
+
+exit:
+	return ret;
+}
+
+static int hisifb_ops_set_par(struct fb_info *info)
+{
+	struct hisifb_par *par;
+	struct hisi_share *share;
+	struct hisifb_crtc *crtc;
+	struct hisifb_output *output;
+	struct fb_var_screeninfo *var;
+	struct fb_fix_screeninfo *fix;
+	int ret;
+	unsigned int line_length;
+
+
+	if (!info)
+		return -EINVAL;
+
+	ret = 0;
+	par = info->par;
+	share = par->share;
+	crtc = &par->crtc;
+	output = &par->output;
+	var = &info->var;
+	fix = &info->fix;
+
+	/* fix structur is not so FIX ... */
+	line_length = var->xres_virtual * var->bits_per_pixel / 8;
+	line_length = PADDING(crtc->line_pad, line_length);
+	fix->line_length = line_length;
+	dbg_msg("fix->line_length = %d\n", fix->line_length);
+
+	/* var->red,green,blue,transp are need to be set by driver
+	 * and these data should be set before setcolreg routine
+	 */
+
+	switch (var->bits_per_pixel) {
+	case 8:
+		fix->visual = FB_VISUAL_PSEUDOCOLOR;
+		var->red.offset = 0;
+		var->red.length = 8;
+		var->green.offset = 0;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 5;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		fix->visual = FB_VISUAL_TRUECOLOR;
+		break;
+	case 24:
+	case 32:
+		var->red.offset = 16;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		fix->visual = FB_VISUAL_TRUECOLOR;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	var->height = var->width = -1;
+	var->accel_flags = FB_ACCELF_TEXT;
+
+	if (ret) {
+		err_msg("pixel bpp format not satisfied\n.");
+		return ret;
+	}
+	ret = crtc->proc_set_mode(crtc, var, fix);
+	if (!ret)
+		ret = output->proc_set_mode(output, var, fix);
+
+	return ret;
+}
+static inline unsigned int chan_to_field(unsigned int chan,
+	struct fb_bitfield *bf)
+{
+	chan &= 0xffff;
+	chan >>= 16 - bf->length;
+	return chan << bf->offset;
+}
+
+static int hisifb_ops_setcolreg(unsigned regno, unsigned red,
+	unsigned green, unsigned blue, unsigned transp, struct fb_info *info)
+{
+	struct hisifb_par *par;
+	struct hisifb_crtc *crtc;
+	struct fb_var_screeninfo *var;
+	int ret;
+
+	par = info->par;
+	crtc = &par->crtc;
+	var = &info->var;
+	ret = 0;
+
+
+	if (regno > 256) {
+		err_msg("regno = %d\n", regno);
+		return -EINVAL;
+	}
+
+	if (info->var.grayscale)
+		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+
+	if (var->bits_per_pixel = 8 &&
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR) {
+		red >>= 8;
+		green >>= 8;
+		blue >>= 8;
+		ret = crtc->proc_set_col_reg(crtc, regno, red, green, blue);
+		goto exit;
+	}
+
+
+	if (info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256) {
+		u32 val;
+
+		if (var->bits_per_pixel = 16 ||
+			var->bits_per_pixel = 32 ||
+			var->bits_per_pixel = 24) {
+			val = chan_to_field(red, &var->red);
+			val |= chan_to_field(green, &var->green);
+			val |= chan_to_field(blue, &var->blue);
+			par->pseudo_palette[regno] = val;
+			goto exit;
+		}
+	}
+
+	ret = -EINVAL;
+
+exit:
+	return ret;
+}
+
+static int hisifb_ops_blank(int blank, struct fb_info *info)
+{
+	return 0;
+}
+
+/*
+ * HS_F,HS_A all go through this routine
+ */
+static int hisifb_set_drv(struct hisifb_par *par)
+{
+	int ret = 0;
+	struct hisi_share *share;
+	struct hisi_a_share *spec_share;
+	struct hisifb_output *output;
+	struct hisifb_crtc *crtc;
+
+
+	share = par->share;
+	spec_share = container_of(share, struct hisi_a_share, share);
+	output = &par->output;
+	crtc = &par->crtc;
+
+	crtc->vidmem_size = (share->dual) ?
+		share->vidmem_size >> 1 : share->vidmem_size;
+
+	/* setup crtc and output member */
+	spec_share->hwcursor = g_hwcursor;
+
+	crtc->proc_set_mode = hw_hisi_crtc_setmode;
+	crtc->proc_check_mode = hw_hisi_crtc_checkmode;
+	crtc->proc_set_col_reg = hw_hisi_set_col_reg;
+	crtc->clear = NULL;
+	crtc->line_pad = 16;
+	crtc->xpanstep = crtc->ypanstep = crtc->ywrapstep = 0;
+
+	output->proc_set_mode = hw_hisi_output_setmode;
+	output->proc_check_mode = NULL;
+
+	output->proc_set_blank = hw_hisile_set_blank;
+	share->accel.de_wait = hw_hisile_dewait;
+	output->clear = NULL;
+
+	switch (spec_share->state.dataflow) {
+	case hisi_simul_pri:
+		output->paths = hisi_pnc;
+		crtc->channel = hisi_primary;
+		crtc->oscreen = 0;
+		crtc->vscreen = share->pvmem;
+		inf_msg("use simul primary mode\n");
+		break;
+	case hisi_simul_sec:
+		output->paths = hisi_pnc;
+		crtc->channel = hisi_secondary;
+		crtc->oscreen = 0;
+		crtc->vscreen = share->pvmem;
+		break;
+	case hisi_dual_normal:
+		if (par->index = 0) {
+			output->paths = hisi_panel;
+			crtc->channel = hisi_primary;
+			crtc->oscreen = 0;
+			crtc->vscreen = share->pvmem;
+		} else {
+			output->paths = hisi_crt;
+			crtc->channel = hisi_secondary;
+		/* not consider of padding stuffs for oscreen,need fix*/
+			crtc->oscreen = (share->vidmem_size >> 1);
+			crtc->vscreen = share->pvmem + crtc->oscreen;
+		}
+		break;
+	case hisi_dual_swap:
+		if (par->index = 0) {
+			output->paths = hisi_panel;
+			crtc->channel = hisi_secondary;
+			crtc->oscreen = 0;
+			crtc->vscreen = share->pvmem;
+		} else {
+			output->paths = hisi_crt;
+			crtc->channel = hisi_primary;
+		/* not consider of padding stuffs for oscreen,need fix*/
+			crtc->oscreen = (share->vidmem_size >> 1);
+			crtc->vscreen = share->pvmem + crtc->oscreen;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int hisifb_set_fbinfo(struct fb_info *info, int index)
+{
+	int i;
+	struct hisifb_par *par;
+	struct hisi_share *share;
+	struct hisifb_crtc *crtc;
+	struct hisifb_output *output;
+	struct fb_var_screeninfo *var;
+	struct fb_fix_screeninfo *fix;
+
+	const struct fb_videomode *pdb[] = {
+		hisi_vedio_mode_ext, NULL, vesa_modes,
+	};
+	int cdb[] = {ARRAY_SIZE(hisi_vedio_mode_ext), 0, VESA_MODEDB_SIZE};
+	static const char *const mdb_desc[] = {
+		"driver prepared modes",
+		"kernel prepared default modedb",
+		"kernel HELPERS prepared vesa_modes",
+	};
+
+	static const char *fixId[2] = {
+		"hisi_fb1", "hisi_fb2",
+	};
+
+	int ret, line_length;
+
+
+	ret = 0;
+	par = (struct hisifb_par *)info->par;
+	share = par->share;
+	crtc = &par->crtc;
+	output = &par->output;
+	var = &info->var;
+	fix = &info->fix;
+
+	/* set index */
+	par->index = index;
+	output->channel = &crtc->channel;
+	hisifb_set_drv(par);
+
+	/* set info->fbops, must be set before fb_find_mode */
+
+	info->fbops = &hisifb_ops;
+
+	if (!g_fbmode[index]) {
+		g_fbmode[index] = g_def_fbmode;
+		if (index)
+			g_fbmode[index] = g_fbmode[0];
+	}
+
+	for (i = 0; i < 3; i++) {
+		ret = fb_find_mode(var, info, g_fbmode[index],
+				   pdb[i], cdb[i], NULL, 8);
+
+		if (ret = 1) {
+			inf_msg("success! use specified mode:%s in %s\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
+			break;
+		} else if (ret = 2) {
+			war_msg("use specified mode:%s in %s,\n"
+				 "with an ignored refresh rate\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
+			break;
+		} else if (ret = 3) {
+			war_msg("wanna use default mode\n");
+		} else if (ret = 4) {
+			war_msg("fall back to any valid mode\n");
+		} else {
+			err_msg("ret = %d,fb_find_mode failed,with %s\n",
+				 ret, mdb_desc[i]);
+		}
+	}
+
+	/* some member of info->var had been set by fb_find_mode */
+
+	inf_msg("Member of info->var is :\n"
+		 "xres=%d\n"
+		 "yres=%d\n"
+		 "xres_virtual=%d\n"
+		 "yres_virtual=%d\n"
+		 "xoffset=%d\n"
+		 "yoffset=%d\n"
+		 "bits_per_pixel=%d\n"
+		 "...\n", var->xres, var->yres, var->xres_virtual,
+		 var->yres_virtual, var->xoffset, var->yoffset,
+		 var->bits_per_pixel);
+
+	/* set par */
+	par->info = info;
+
+	/* set info */
+	line_length = PADDING(crtc->line_pad,
+	(var->xres_virtual * var->bits_per_pixel / 8));
+
+	info->pseudo_palette = &par->pseudo_palette[0];
+	info->screen_base = crtc->vscreen;
+	dbg_msg("screen_base vaddr = %p\n", info->screen_base);
+	info->screen_size = line_length * var->yres_virtual;
+	info->flags = FBINFO_FLAG_DEFAULT | 0;
+
+	/* set info->fix */
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->type_aux = 0;
+	fix->xpanstep = crtc->xpanstep;
+	fix->ypanstep = crtc->ypanstep;
+	fix->ywrapstep = crtc->ywrapstep;
+	fix->accel = FB_ACCEL_NONE;
+
+	strlcpy(fix->id, fixId[index], sizeof(fix->id));
+
+
+	fix->smem_start = crtc->oscreen + share->vidmem_start;
+	inf_msg("fix->smem_start = %lx\n", fix->smem_start);
+
+	/*
+	 * according to mmap experiment from user space application,
+	 * fix->mmio_len should not larger than virtual size
+	 * (xres_virtual x yres_virtual x ByPP)
+	 * Below line maybe buggy when user mmap fb dev node and write
+	 * data into the bound over virtual size
+	 */
+	fix->smem_len = crtc->vidmem_size;
+	inf_msg("fix->smem_len = %x\n", fix->smem_len);
+	fix->line_length = line_length;
+	fix->mmio_start = share->vidreg_start;
+	inf_msg("fix->mmio_start = %lx\n", fix->mmio_start);
+	fix->mmio_len = share->vidreg_size;
+	inf_msg("fix->mmio_len = %x\n", fix->mmio_len);
+	switch (var->bits_per_pixel) {
+	case 8:
+		fix->visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 32:
+		fix->visual = FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
+	/* set var */
+	var->activate = FB_ACTIVATE_NOW;
+	var->accel_flags = FB_ACCELF_TEXT;
+	var->vmode = FB_VMODE_NONINTERLACED;
+
+	dbg_msg("#1 show info->cmap :\n"
+		 "start=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+		 info->cmap.start, info->cmap.len,
+		 info->cmap.red, info->cmap.green,
+		 info->cmap.blue, info->cmap.transp);
+
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret < 0) {
+		err_msg("Could not allcate memory for cmap.\n");
+		goto exit;
+	}
+
+	dbg_msg("#2 show info->cmap :\n"
+		 "start=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+		 info->cmap.start, info->cmap.len,
+		 info->cmap.red, info->cmap.green, info->cmap.blue,
+		 info->cmap.transp);
+exit:
+	return ret;
+}
+
+static int hisifb_pci_probe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
+{
+	struct fb_info *info[] = {NULL, NULL};
+	struct hisi_share *share = NULL;
+
+	void *spec_share = NULL;
+	size_t spec_offset = 0;
+	int fbidx;
+
+
+	/* enable device */
+	if (pci_enable_device(pdev)) {
+		err_msg("can not enable device.\n");
+		goto err_enable;
+	}
+
+	/* though offset of share in hisi_a_share is 0,
+	 * we use this marcro as the same
+	 */
+	spec_offset = offsetof(struct hisi_a_share, share);
+
+
+	dbg_msg("spec_offset = %ld\n", spec_offset);
+	spec_share = kzalloc(sizeof(struct hisi_a_share), GFP_KERNEL);
+
+	if (!spec_share) {
+		err_msg("Could not allocate memory for share.\n");
+		goto err_share;
+	}
+
+	/* setting share structure */
+	share = (struct hisi_share *)(spec_share + spec_offset);
+	share->fbinfo[0] = share->fbinfo[1] = NULL;
+
+	inf_msg("share->revid = %02x\n", pdev->revision);
+	share->pdev = pdev;
+#ifdef CONFIG_MTRR
+	share->mtrr_off = g_nomtrr;
+	share->mtrr.vram = 0;
+	share->mtrr.vram_added = 0;
+#endif
+	share->accel_off = g_noaccel;
+	share->dual = g_dualview;
+
+	/* call chip specific setup routine  */
+	hisi_fb_setup(share, g_settings);
+
+	/* call chip specific mmap routine */
+	if (hw_hisi_map(share, pdev)) {
+		err_msg("Memory map failed\n");
+		goto err_map;
+	}
+
+#ifdef CONFIG_MTRR
+	if (!share->mtrr_off) {
+		inf_msg("enable mtrr\n");
+		share->mtrr.vram = mtrr_add(share->vidmem_start,
+					    share->vidmem_size,
+					    MTRR_TYPE_WRCOMB, 1);
+		if (share->mtrr.vram < 0) {
+			/* don't block driver with the failure of MTRR */
+			err_msg("Unable to setup MTRR.\n");
+		} else {
+			share->mtrr.vram_added = 1;
+			inf_msg("MTRR added successfully\n");
+		}
+	}
+#endif
+
+	/*memset(share->pvmem,0,share->vidmem_size);*/
+
+	inf_msg("sm%3x mmio address = %p\n", pdev->device, share->pvreg);
+
+	pci_set_drvdata(pdev, share);
+
+	/* call chipInit routine */
+	hw_hisi_inithw(share, pdev);
+
+	/* allocate frame buffer info structor according to g_dualview */
+	fbidx = 0;
+	info[fbidx] = framebuffer_alloc(sizeof(struct hisifb_par), &pdev->dev);
+	if (!info[fbidx]) {
+		err_msg("Could not allocate framebuffer #%d.\n", fbidx);
+		if (fbidx = 0)
+			goto err_info0_alloc;
+		else
+			goto err_info1_alloc;
+	} else {
+		struct hisifb_par *par;
+
+		inf_msg("framebuffer #%d alloc okay\n", fbidx);
+		share->fbinfo[fbidx] = info[fbidx];
+		par = info[fbidx]->par;
+		par->share = share;
+
+		/* set fb_info structure */
+		if (hisifb_set_fbinfo(info[fbidx], fbidx)) {
+			err_msg("Failed to initial fb_info #%d.\n", fbidx);
+			if (fbidx = 0)
+				goto err_info0_set;
+			else
+				goto err_info1_set;
+		}
+
+		/* register frame buffer*/
+		inf_msg("Ready to register framebuffer #%d.\n", fbidx);
+		if (register_framebuffer(info[fbidx]) < 0) {
+			err_msg("Failed to register fb_info #%d.\n", fbidx);
+			if (fbidx = 0)
+				goto err_register0;
+			else
+				goto err_register1;
+		}
+		inf_msg("Accomplished register framebuffer #%d.\n", fbidx);
+	}
+
+	return 0;
+
+err_register1:
+err_info1_set:
+	framebuffer_release(info[1]);
+err_info1_alloc:
+	unregister_framebuffer(info[0]);
+err_register0:
+err_info0_set:
+	framebuffer_release(info[0]);
+err_info0_alloc:
+err_map:
+	kfree(spec_share);
+err_share:
+err_enable:
+	return -ENODEV;
+}
+
+static void hisifb_pci_remove(struct pci_dev *pdev)
+{
+	struct fb_info *info;
+	struct hisi_share *share;
+	void *spec_share;
+	struct hisifb_par *par;
+	int cnt;
+
+
+	cnt = 2;
+	share = pci_get_drvdata(pdev);
+
+	while (cnt-- > 0) {
+		info = share->fbinfo[cnt];
+		if (!info)
+			continue;
+		par = info->par;
+
+		unregister_framebuffer(info);
+		/* clean crtc & output allocations*/
+		par->crtc.clear(&par->crtc);
+		par->output.clear(&par->output);
+		/* release frame buffer*/
+		framebuffer_release(info);
+	}
+#ifdef CONFIG_MTRR
+	if (share->mtrr.vram_added)
+		mtrr_del(share->mtrr.vram, share->vidmem_start,
+		share->vidmem_size);
+#endif
+
+	iounmap(share->pvreg);
+	iounmap(share->pvmem);
+
+	spec_share = share;
+
+	kfree(g_settings);
+	kfree(spec_share);
+	pci_set_drvdata(pdev, NULL);
+}
+
+/*chip specific g_option configuration routine */
+static void hisi_fb_setup(struct hisi_share *share, char *src)
+{
+	struct hisi_a_share *spec_share;
+	char *opt;
+#ifdef CAP_EXPENSION
+	char *exp_res;
+#endif
+	int swap;
+
+	spec_share = container_of(share, struct hisi_a_share, share);
+#ifdef CAP_EXPENSIION
+	exp_res = NULL;
+#endif
+	swap = 0;
+
+	spec_share->state.initParm.chip_clk = 0;
+	spec_share->state.initParm.mem_clk = 0;
+	spec_share->state.initParm.master_clk = 0;
+	spec_share->state.initParm.power_mode = 0;
+	spec_share->state.initParm.all_eng_off = 0;
+	spec_share->state.initParm.reset_memory = 1;
+
+	/*defaultly turn g_hwcursor on for both view */
+	g_hwcursor = 0;
+
+	if (!src || !*src) {
+		war_msg("no specific g_option.\n");
+		goto NO_PARAM;
+	}
+
+
+	while ((opt = strsep(&src, ",")) != NULL) {
+		if (!strncmp(opt, "swap", strlen("swap")))
+			swap = 1;
+		else if (!strncmp(opt, "nocrt", strlen("nocrt")))
+			spec_share->state.nocrt = 1;
+		else if (!strncmp(opt, "36bit", strlen("36bit")))
+			spec_share->state.pnltype = TYPE_DOUBLE_TFT;
+		else if (!strncmp(opt, "18bit", strlen("18bit")))
+			spec_share->state.pnltype = TYPE_DUAL_TFT;
+		else if (!strncmp(opt, "24bit", strlen("24bit")))
+			spec_share->state.pnltype = TYPE_24TFT;
+#ifdef CAP_EXPANSION
+		else if (!strncmp(opt, "exp:", strlen("exp:")))
+			exp_res = opt + strlen("exp:");
+#endif
+		else if (!strncmp(opt, "nohwc0", strlen("nohwc0")))
+			g_hwcursor &= ~0x1;
+		else if (!strncmp(opt, "nohwc1", strlen("nohwc1")))
+			g_hwcursor &= ~0x2;
+		else if (!strncmp(opt, "nohwc", strlen("nohwc")))
+			g_hwcursor = 0;
+		else {
+			if (!g_fbmode[0]) {
+				g_fbmode[0] = opt;
+				inf_msg("find fbmode0 : %s.\n", g_fbmode[0]);
+			} else if (!g_fbmode[1]) {
+				g_fbmode[1] = opt;
+				inf_msg("find fbmode1 : %s.\n", g_fbmode[1]);
+			} else {
+				war_msg("How many view you wann set?\n");
+			}
+		}
+	}
+#ifdef CAP_EXPANSION
+	if (getExpRes(exp_res, &spec_share->state.xLCD,
+		&spec_share->state.yLCD)) {
+		/* seems exp_res is not valid*/
+		spec_share->state.xLCD = spec_share->state.yLCD = 0;
+	}
+#endif
+
+NO_PARAM:
+	if (share->dual) {
+		if (swap)
+			spec_share->state.dataflow = hisi_dual_swap;
+		else
+			spec_share->state.dataflow = hisi_dual_normal;
+	} else {
+		if (swap)
+			spec_share->state.dataflow = hisi_simul_sec;
+		else
+			spec_share->state.dataflow = hisi_simul_pri;
+	}
+
+}
+
+static int __init hisifb_setup(char *options)
+{
+	int len;
+	char *opt, *tmp;
+
+
+	if (!options || !*options) {
+		war_msg("no options.\n");
+		return 0;
+	}
+
+	inf_msg("options:%s\n", options);
+	len = strlen(options) + 1;
+	g_settings = kzalloc(len, GFP_KERNEL);
+	if (!g_settings)
+		return -ENOMEM;
+
+	tmp = g_settings;
+
+	/*    Notes:
+	 *	char * strsep(char **s,const char * ct);
+	 *	@s: the string to be searched
+	 *	@ct :the characters to search for
+	 *	strsep() updates @options to pointer after the first found token
+	 *	it also returns the pointer ahead the token.
+	 */
+
+	while ((opt = strsep(&options, ",")) != NULL) {
+		/* options that mean for any  chips are configured here */
+		if (!strncmp(opt, "noaccel", strlen("noaccel")))
+			g_noaccel = 1;
+#ifdef CONFIG_MTRR
+		else if (!strncmp(opt, "nomtrr", strlen("nomtrr")))
+			g_nomtrr = 1;
+#endif
+		else if (!strncmp(opt, "dual", strlen("dual")))
+			g_dualview = 1;
+		else {
+			strcat(tmp, opt);
+			tmp += strlen(opt);
+			if (options != NULL)
+				*tmp++ = ',';
+			else
+				*tmp++ = 0;
+		}
+	}
+
+	/* misc g_settings are transport to chip specific routines */
+	inf_msg("parameter left for chip specific analysis:%s\n", g_settings);
+	return 0;
+}
+
+static void claim(void)
+{
+	inf_msg("Hisilicon Driver version: v" _version_ "\n");
+}
+
+
+static int __init hisifb_init(void)
+{
+	char *option;
+	int ret;
+
+
+	claim();
+#ifdef MODULE
+	option = g_option;
+#else
+	if (fb_get_options("hisifb", &option))
+		return -ENODEV;
+#endif
+
+	hisifb_setup(option);
+	ret = pci_register_driver(&hisifb_driver);
+	return ret;
+}
+
+module_init(hisifb_init);
+
+#ifdef MODULE
+static void __exit hisifb_exit(void)
+{
+	inf_msg(_moduleName_ " exit\n");
+	pci_unregister_driver(&hisifb_driver);
+}
+module_exit(hisifb_exit);
+
+module_param(g_option, charp, S_IRUGO);
+
+MODULE_PARM_DESC(g_option,
+"\n\t\tCommon options:\n"
+"\t\tnoaccel:disable 2d capabilities\n"
+"\t\tnomtrr:disable MTRR attribute for video memory\n"
+"\t\tdualview:dual frame buffer feature enabled\n"
+"\t\tnohwc:disable hardware cursor\n"
+"\t\tUsual example:\n"
+"\t\tinsmod ./hisiliconfb.ko g_option=\"noaccel,nohwc,1280x1024-8@60\"\n"
+"\t\tFor more detail chip specific options,please contact hisilicon\n"
+);
+#endif
+
+MODULE_AUTHOR("lixiancai<lixiancai@huawei.com>");
+MODULE_DESCRIPTION("Frame buffer driver for Hisilicon graphic device");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(pci, hisi_pci_table);
diff --git a/drivers/video/fbdev/hisilicon/hisi_drv.h b/drivers/video/fbdev/hisilicon/hisi_drv.h
new file mode 100644
index 0000000..e859325
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_drv.h
@@ -0,0 +1,181 @@
+#ifndef HISI_DRV_H_
+#define HISI_DRV_H_
+
+#include "hisi_chip.h"
+
+
+#define _version_	"1.0.0"
+
+/* Vendor and Device id for HISILICON Graphics chip*/
+#define PCI_VENDOR_ID_HIS 0x19e5
+#define PCI_DEVID_HS_VGA 0x1711
+
+
+#define _moduleName_ "hisifb"
+#define PFX _moduleName_ ": "
+#define err_msg(fmt, args...) pr_err(PFX fmt, ## args)
+#define war_msg(fmt, args...) pr_warn(PFX fmt, ## args)
+#define inf_msg(fmt, args...) pr_info(PFX fmt, ## args)
+#define dbg_msg(fmt, args...) pr_debug(PFX fmt, ## args)
+
+#define MB(x) ((x) << 20)
+#define MHZ(x) ((x) * 1000000)
+/* align should be 2,4,8,16 */
+#define PADDING(align, data) (((data) + (align) - 1)&(~((align) - 1)))
+
+
+struct hisi_accel {
+	/* base virtual address of DPR registers */
+	unsigned char __iomem *dpr_base;
+	/* base virtual address of de data port */
+	unsigned char __iomem *dp_port_base;
+
+	/* function fointers */
+	int (*de_init)(struct hisi_accel *);
+
+	int (*de_wait)(void);/* see if hardware ready to work */
+
+	int (*de_fillrect)(struct hisi_accel *, u32, u32, u32,
+		u32, u32, u32, u32, u32, u32);
+
+	int (*de_copyarea)(struct hisi_accel *, u32, u32, u32,
+		u32, u32, u32, u32, u32, u32, u32, u32, u32);
+
+	int (*de_imageblit)(struct hisi_accel *, const char *,
+		u32, u32, u32, u32, u32, u32, u32,
+		u32, u32, u32, u32, u32);
+};
+
+/* hisi_share stands for a presentation of two frame buffer
+* that use one smi adaptor , it is similar to a basic class of C++
+*/
+struct hisi_share {
+	/* driver members */
+	struct pci_dev *pdev;
+	struct fb_info *fbinfo[2];
+	struct hisi_accel accel;
+	int accel_off;
+	int dual;
+#ifdef CONFIG_MTRR
+	int mtrr_off;
+	struct {
+		int vram;
+		int vram_added;
+	} mtrr;
+#endif
+	/* all smi graphic adaptor get below attributes */
+	resource_size_t vidmem_start;
+	resource_size_t vidreg_start;
+	resource_size_t vidmem_size;
+	resource_size_t vidreg_size;
+	unsigned char __iomem *pvreg;
+	unsigned char __iomem *pvmem;
+	/* function pointers */
+	void (*suspend)(void);
+	void (*resume)(void);
+};
+
+struct hisi_cursor {
+	/* cursor width ,height and size */
+	int w;
+	int h;
+	int size;
+	/* hardware limitation */
+	int maxW;
+	int maxH;
+	/* base virtual address and offset  of cursor image */
+	char __iomem *vstart;
+	int offset;
+	/* mmio addr of hw cursor */
+	char __iomem *mmio;
+	/* the hisi_share of this adaptor */
+	struct hisi_share *share;
+	/* proc_routines */
+	void (*enable)(struct hisi_cursor *);
+	void (*disable)(struct hisi_cursor *);
+	void (*set_size)(struct hisi_cursor *, int, int);
+	void (*set_pos)(struct hisi_cursor *, int, int);
+	void (*set_color)(struct hisi_cursor *, u32, u32);
+	void (*set_data)(struct hisi_cursor *, u16, const u8*, const u8*);
+};
+
+struct hisifb_crtc {
+	unsigned char __iomem *vcursor;/*virtual address of cursor*/
+	unsigned char __iomem *vscreen;/*virtual address of on_screen*/
+	int ocursor;/*cursor address offset in vidmem*/
+	int oscreen;/*onscreen address offset in vidmem*/
+	int channel;/* which channel this crtc stands for*/
+	/* this view's video memory max size */
+	resource_size_t vidmem_size;
+
+	/* below attributes belong to info->fix,
+	 * their value depends on specific adaptor
+	 */
+	u16 line_pad;/* padding information:0,1,2,4,8,16,... */
+	u16 xpanstep;
+	u16 ypanstep;
+	u16 ywrapstep;
+
+	void *priv;
+
+	int (*proc_set_mode)(struct hisifb_crtc *,
+						struct fb_var_screeninfo *,
+						struct fb_fix_screeninfo *);
+	int (*proc_check_mode)(struct hisifb_crtc *,
+		struct fb_var_screeninfo*);
+	int (*proc_set_col_reg)(struct hisifb_crtc *,
+		ushort, ushort, ushort, ushort);
+	void (*clear)(struct hisifb_crtc *);
+	/* cursor information */
+	struct hisi_cursor cursor;
+};
+
+struct hisifb_output {
+	int dpms;
+	int paths;
+	/*which paths(s) this output stands for,hisi vga may not metioned:
+	* paths=1:means output for panel paths
+	* paths=2:means output for crt paths
+	* paths=3:means output for both panel and crt paths
+	*/
+
+	int *channel;
+	/*which channel these outputs linked with, hisi vga may
+	* not metioned:channel=0 means primary channel
+	* channel=1 means secondary channel
+	* output->channel => &crtc->channel
+	*/
+	void *priv;
+	int (*proc_set_mode)(struct hisifb_output *,
+						struct fb_var_screeninfo *,
+						struct fb_fix_screeninfo *);
+	int (*proc_check_mode)(struct hisifb_output *,
+		struct fb_var_screeninfo *);
+	int (*proc_set_blank)(struct hisifb_output *, int);
+	void (*clear)(struct hisifb_output *);
+};
+
+struct hisifb_par {
+	/* either 0 or 1 for dual head adaptor,0 is the older one registered */
+	int index;
+	unsigned int pseudo_palette[256];
+	struct hisifb_crtc crtc;
+	struct hisifb_output output;
+	struct fb_info *info;
+	struct hisi_share *share;
+};
+
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+#endif
+
+
+static inline unsigned long ps_to_hz(unsigned int psvalue)
+{
+	unsigned long long numerator = 1000 * 1000 * 1000 * 1000ULL;
+	/* 10^12 / picosecond period gives frequency in Hz */
+	do_div(numerator, psvalue);
+	return (unsigned long)numerator;
+}
+
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_help.h b/drivers/video/fbdev/hisilicon/hisi_help.h
new file mode 100644
index 0000000..cfbd77e
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_help.h
@@ -0,0 +1,64 @@
+#ifndef HISI_HELP_H__
+#define HISI_HELP_H__
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+
+
+/* Internal macros */
+#define _F_START(f)             (0 ? f)
+#define _F_END(f)               (1 ? f)
+#define _F_SIZE(f)              (1 + _F_END(f) - _F_START(f))
+#define _F_MASK(f)              (((1 << _F_SIZE(f)) - 1) << _F_START(f))
+#define _F_NORMALIZE(v, f)      (((v) & _F_MASK(f)) >> _F_START(f))
+#define _F_DENORMALIZE(v, f)    (((v) << _F_START(f)) & _F_MASK(f))
+
+
+/* Global macros */
+#define FIELD_GET(x, reg, field) \
+( \
+	_F_NORMALIZE((x), reg ## _ ## field) \
+)
+
+#define FIELD_SET(x, reg, field, value) \
+( \
+	(x & ~_F_MASK(reg ## _ ## field)) \
+	| _F_DENORMALIZE(reg ## _ ## field ## _ ## value, reg ## _ ## field) \
+)
+
+#define FIELD_VALUE(x, reg, field, value) \
+( \
+	(x & ~_F_MASK(reg ## _ ## field)) \
+	| _F_DENORMALIZE(value, reg ## _ ## field) \
+)
+
+#define FIELD_CLEAR(reg, field) \
+( \
+	~_F_MASK(reg ## _ ## field) \
+)
+
+
+/* Field Macros */
+#define FIELD_START(field)              (0 ? field)
+#define FIELD_END(field)                (1 ? field)
+#define FIELD_SIZE(field) \
+	(1 + FIELD_END(field) - FIELD_START(field))
+#define FIELD_MASK(field) \
+	(((1 << (FIELD_SIZE(field)-1)) |\
+	((1 << (FIELD_SIZE(field)-1)) - 1)) << FIELD_START(field))
+#define FIELD_NORMALIZE(reg, field) \
+	(((reg) & FIELD_MASK(field)) >> FIELD_START(field))
+#define FIELD_DENORMALIZE(field, value) \
+	(((value) << FIELD_START(field)) & FIELD_MASK(field))
+#define RGB(r, g, b) \
+( \
+	(unsigned long) (((r) << 16) | ((g) << 8) | (b)) \
+)
+
+#define PEEK32(addr) readl((addr)+mmio_hisi_vga)
+#define POKE32(addr, data) writel((data), (addr)+mmio_hisi_vga)
+extern unsigned  char __iomem *mmio_hisi_vga;
+
+
+
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_hw.c b/drivers/video/fbdev/hisilicon/hisi_hw.c
new file mode 100644
index 0000000..e993f25
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_hw.c
@@ -0,0 +1,293 @@
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/screen_info.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include "hisi_drv.h"
+#include "hisi_help.h"
+#include "hisi_hw.h"
+#include "hisi_mode.h"
+#include "hisi_power.h"
+#include "hisi_reg.h"
+
+unsigned char __iomem *mmio_hisi_vga;
+
+int hw_hisi_map(struct hisi_share *share, struct pci_dev *pdev)
+{
+	int ret;
+	struct hisi_a_share *spec_share;
+
+	spec_share = container_of(share, struct hisi_a_share, share);
+	ret = 0;
+
+	share->vidreg_start  = pci_resource_start(pdev, 1);
+	share->vidreg_size = MB(2);
+
+	/* now map mmio and vidmem*/
+	share->pvreg = ioremap_nocache(share->vidreg_start, share->vidreg_size);
+	if (!share->pvreg) {
+		err_msg("mmio failed\n");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	share->accel.dpr_base = share->pvreg + DE_BASE_ADDR_TYPE1;
+	share->accel.dp_port_base = share->pvreg + DE_PORT_ADDR_TYPE1;
+
+	mmio_hisi_vga = share->pvreg;
+
+	share->vidmem_start = pci_resource_start(pdev, 0);
+	/* don't use pdev_resource[x].end - resource[x].start to
+	 * calculate the resource size,its only the maximum available
+	 * size but not the actual size,hisilicon provide 16MB buffer.
+	 */
+	share->vidmem_size = MB(16);
+	inf_msg("video memory size = %llu mb\n", share->vidmem_size >> 20);
+
+	share->pvmem = ioremap(share->vidmem_start, share->vidmem_size);
+
+	if (!share->pvmem) {
+		err_msg("Map video memory failed\n");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	inf_msg("video memory vaddr = %p\n", share->pvmem);
+
+exit:
+	return ret;
+}
+
+int hw_hisi_inithw(struct hisi_share *share, struct pci_dev *pdev)
+{
+	struct hisi_a_share *spec_share;
+	struct init_status *parm;
+
+
+	spec_share = container_of(share, struct hisi_a_share, share);
+	parm = &spec_share->state.initParm;
+
+	if (parm->chip_clk = 0)
+		parm->chip_clk = DEFAULT_HISILE_CHIP_CLOCK;
+
+	if (parm->mem_clk = 0)
+		parm->mem_clk = parm->chip_clk;
+
+	if (parm->master_clk = 0)
+		parm->master_clk = parm->chip_clk / 3;
+
+	hisi_init_hw((struct _initchip_param_t *)&spec_share->state.initParm);
+
+	/* init 2d engine */
+	if (!share->accel_off)
+		hw_hisi_init_accel(share);
+
+	return 0;
+}
+
+int hw_hisi_output_setmode(struct hisifb_output *output,
+	struct fb_var_screeninfo *var,
+	struct fb_fix_screeninfo *fix)
+{
+	u32 reg;
+
+	/* just open DISPLAY_CONTROL_HISILE register bit 3:0*/
+	reg = PEEK32(DISPLAY_CONTROL_HISILE);
+	reg |= 0xf;
+	POKE32(DISPLAY_CONTROL_HISILE, reg);
+
+	inf_msg("set output mode done\n");
+
+	return 0;
+}
+
+int hw_hisi_crtc_checkmode(struct hisifb_crtc *crtc,
+	struct fb_var_screeninfo *var)
+{
+	switch (var->bits_per_pixel) {
+	case 8:
+	case 16:
+	case 32:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+* set the controller's mode for @crtc
+* charged with @var and @fix parameters
+*/
+int hw_hisi_crtc_setmode(struct hisifb_crtc *crtc,
+	struct fb_var_screeninfo *var,
+	struct fb_fix_screeninfo *fix)
+{
+	int ret;
+	u32 reg;
+	struct mode_para modparm;
+	enum clock_type clock;
+	struct hisifb_par *par;
+
+	ret = 0;
+	par = container_of(crtc, struct hisifb_par, crtc);
+	/* set timing */
+	modparm.pixel_clock = ps_to_hz(var->pixclock);
+	modparm.vsync_polarity +		(var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS : NEG;
+	modparm.hsync_polarity +		(var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS : NEG;
+	modparm.clock_phase_polarity +		(var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS : NEG;
+	modparm.h_display_end = var->xres;
+	modparm.h_sync_width = var->hsync_len;
+	modparm.h_sync_start = var->xres + var->right_margin;
+	modparm.horizontal_total = var->xres +
+		var->left_margin + var->right_margin + var->hsync_len;
+	modparm.v_display_end = var->yres;
+	modparm.v_sync_height = var->vsync_len;
+	modparm.v_sync_start = var->yres + var->lower_margin;
+	modparm.vertical_total = var->yres + var->upper_margin +
+		var->lower_margin + var->vsync_len;
+
+	/* choose pll */
+	clock = SECONDARY_PLL;
+
+	dbg_msg("Request pixel clock = %lu\n", modparm.pixel_clock);
+	ret = hisi_set_mode_timing(&modparm, clock);
+	if (ret) {
+		err_msg("Set mode timing failed\n");
+		goto exit;
+	}
+
+	/* not implemented now */
+	POKE32(CRT_FB_ADDRESS, crtc->oscreen);
+	reg = var->xres * (var->bits_per_pixel >> 3);
+	/* crtc->channel is not equal to
+	 * par->index on numeric,be aware of that
+	 */
+	reg = PADDING(crtc->line_pad, reg);
+
+	POKE32(CRT_FB_WIDTH,
+		FIELD_VALUE(0, CRT_FB_WIDTH, WIDTH, reg) |
+		FIELD_VALUE(0, CRT_FB_WIDTH, OFFSET, fix->line_length));
+
+	/* SET PIXEL FORMAT */
+	reg = PEEK32(CRT_DISPLAY_CTRL);
+	reg = FIELD_VALUE(reg, CRT_DISPLAY_CTRL,
+			   FORMAT, var->bits_per_pixel >> 4);
+	POKE32(CRT_DISPLAY_CTRL, reg);
+
+exit:
+	return ret;
+}
+
+int hw_hisi_set_col_reg(struct hisifb_crtc *crtc,
+	ushort index, ushort red,
+	ushort green, ushort blue)
+{
+	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
+
+
+	POKE32(add[crtc->channel] + index * 4,
+		(red << 16) | (green << 8) | blue);
+
+	return 0;
+}
+
+int hw_hisile_set_blank(struct hisifb_output *output, int blank)
+{
+	int dpms, crtdb;
+
+
+	switch (blank) {
+	case FB_BLANK_UNBLANK:
+		dpms = CRT_DISPLAY_CTRL_DPMS_0;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_OFF;
+		break;
+	case FB_BLANK_NORMAL:
+		dpms = CRT_DISPLAY_CTRL_DPMS_0;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+		dpms = CRT_DISPLAY_CTRL_DPMS_2;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
+	case FB_BLANK_HSYNC_SUSPEND:
+		dpms = CRT_DISPLAY_CTRL_DPMS_1;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
+	case FB_BLANK_POWERDOWN:
+		dpms = CRT_DISPLAY_CTRL_DPMS_3;
+		crtdb = CRT_DISPLAY_CTRL_BLANK_ON;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (output->paths & hisi_crt) {
+		POKE32(CRT_DISPLAY_CTRL,
+			FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL),
+			CRT_DISPLAY_CTRL, DPMS, dpms));
+		POKE32(CRT_DISPLAY_CTRL,
+			FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL),
+			CRT_DISPLAY_CTRL, BLANK, crtdb));
+	}
+
+	return 0;
+}
+
+void hw_hisi_init_accel(struct hisi_share *share)
+{
+	u32 reg;
+
+
+	enable_2d_engine(1);
+
+	reg = PEEK32(DE_STATE1);
+	reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, ON);
+	POKE32(DE_STATE1, reg);
+
+	reg = PEEK32(DE_STATE1);
+	reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, OFF);
+	POKE32(DE_STATE1, reg);
+
+	/* call 2d init */
+	share->accel.de_init(&share->accel);
+}
+
+int hw_hisile_dewait(void)
+{
+	int i = 0x10000000;
+
+	while (i--) {
+		unsigned int dwval = PEEK32(DE_STATE2);
+
+		if ((FIELD_GET(dwval, DE_STATE2, DE_STATUS)
+			= DE_STATE2_DE_STATUS_IDLE) &&
+		    (FIELD_GET(dwval, DE_STATE2, DE_FIFO)
+			= DE_STATE2_DE_FIFO_EMPTY) &&
+		    (FIELD_GET(dwval, DE_STATE2, DE_MEM_FIFO)
+			= DE_STATE2_DE_MEM_FIFO_EMPTY)) {
+			return 0;
+		}
+	}
+
+	/* timeout error */
+	return -1;
+}
diff --git a/drivers/video/fbdev/hisilicon/hisi_hw.h b/drivers/video/fbdev/hisilicon/hisi_hw.h
new file mode 100644
index 0000000..c4e40b3
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_hw.h
@@ -0,0 +1,95 @@
+#ifndef HISI_HW_H__
+#define HISI_HW_H__
+
+
+#define DEFAULT_HISILE_CHIP_CLOCK	333
+
+/* notes: below address are the offset value from de_base_address (0x100000)*/
+
+/* de_base is at mmreg_1mb*/
+#define DE_BASE_ADDR_TYPE1 0x100000
+
+/* type1 data port address is at mmreg_0x110000*/
+#define DE_PORT_ADDR_TYPE1 0x110000
+
+
+
+enum hisilicon_pnltype {
+
+	TYPE_24TFT = 0,/* 24bit tft */
+
+	TYPE_DUAL_TFT = 2,/* dual 18 bit tft */
+
+	TYPE_DOUBLE_TFT = 1,/* 36 bit double pixel tft */
+};
+
+/* vga channel is not concerned  */
+enum hisilicon_dataflow {
+	hisi_simul_pri,/* primary => all head */
+	hisi_simul_sec,/* secondary => all head */
+	hisi_dual_normal,/* primary => panel head and secondary => crt */
+	hisi_dual_swap,/* primary => crt head and secondary => panel */
+};
+
+
+enum hisi_channel {
+	hisi_primary = 0,
+	/* enum value equal to the register filed data */
+	hisi_secondary = 1,
+};
+
+enum hisi_display_path {
+	hisi_panel = 1,
+	hisi_crt = 2,
+	hisi_pnc = 3,/* panel and crt */
+};
+
+struct init_status {
+	ushort power_mode;
+	/* below three clocks are in unit of MHZ*/
+	ushort chip_clk;
+	ushort mem_clk;
+	ushort master_clk;
+	ushort all_eng_off;
+	ushort reset_memory;
+};
+
+struct hisi_state {
+	struct init_status initParm;
+	enum hisilicon_pnltype pnltype;
+	enum hisilicon_dataflow dataflow;
+	int nocrt;
+	int xlcd;
+	int ylcd;
+};
+
+/* hisi_a_share stands for a presentation of two frame buffer
+ * that use one hisi adaptor
+*/
+
+struct hisi_a_share {
+	/* Put hisi_share struct to the first place of hisi_a_share */
+	struct hisi_share share;
+	struct hisi_state state;
+	int hwcursor;
+	/*0: no hardware cursor
+	* 1: primary crtc hw cursor enabled,
+	* 2: secondary crtc hw cursor enabled
+	* 3: both ctrc hw cursor enabled
+	*/
+};
+
+int hw_hisi_map(struct hisi_share *share, struct pci_dev *pdev);
+int hw_hisi_inithw(struct hisi_share*, struct pci_dev *);
+void hw_hisi_init_accel(struct hisi_share *);
+int hw_hisile_dewait(void);
+
+int hw_hisi_output_setmode(struct hisifb_output*, struct fb_var_screeninfo*,
+			struct fb_fix_screeninfo*);
+int hw_hisi_crtc_checkmode(struct hisifb_crtc*, struct fb_var_screeninfo*);
+int hw_hisi_crtc_setmode(struct hisifb_crtc*, struct fb_var_screeninfo*,
+			struct fb_fix_screeninfo*);
+int hw_hisi_set_col_reg(struct hisifb_crtc*, ushort, ushort, ushort, ushort);
+int hw_hisile_set_blank(struct hisifb_output*, int);
+
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_mode.c b/drivers/video/fbdev/hisilicon/hisi_mode.c
new file mode 100644
index 0000000..fba0e02
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_mode.c
@@ -0,0 +1,286 @@
+#include "hisi_help.h"
+#include "hisi_mode.h"
+#include "hisi_reg.h"
+
+/*
+ *  Timing parameter for modes supported by Hisilicon
+ *  Note that most timings in this table is made according to standard VESA
+ *  parameters.
+ *  It is a subset of gDefaultModeParamTable[], all timings are copy from it.
+ */
+static struct mode_para g_hisi_mode_para_table[] = {
+/* 640 x 480  [4:3] */
+{ 800, 640, 656, 96, NEG, 525, 480, 490, 2, NEG, 25175000, 31469, 60, NEG},
+
+/* 800 x 600  [4:3] */
+/* The first 2 commented lines below are taken from SM502, the rest timing are
+ * taken from the VESA Monitor Timing Standard
+ */
+{1056, 800, 840, 128, POS, 628, 600, 601, 4, POS, 40000000, 37879, 60, POS},
+
+/* 1024 x 768  [4:3] */
+/* The first 2 commented lines below are taken from SM502, the rest timing are
+ * taken from the VESA Monitor Timing Standard
+ */
+{1344, 1024, 1048, 136, NEG, 806, 768, 771, 6, NEG, 65000000, 48363, 60, NEG},
+
+/* 1152 x 864  [4:3] -- Widescreen eXtended Graphics Array */
+{1475, 1152, 1208, 96, POS, 888, 864, 866, 3, POS, 78600000, 53288, 60, NEG},
+
+/* 1280 x 720  [16:9] -- HDTV (WXGA) */
+{1650, 1280, 1390, 40, POS, 750, 720, 725, 5, POS, 74250000, 45000, 60, NEG},
+
+/* 1280 x 768  [5:3] -- Not a popular mode */
+{1664, 1280, 1344, 128, POS, 798, 768, 771, 7, POS, 79500000, 47776, 60, NEG},
+
+/* 1280 x 960  [4:3] */
+/* The first commented line below are taken from SM502, the rest timing are
+ * taken from the VESA Monitor Timing Standard
+ */
+{1800, 1280, 1376, 112, POS, 1000, 960, 961, 3, POS, 108000000, 60000, 60, NEG},
+
+/* 1280 x 1024 [5:4] */
+/* GTF with C = 40, M = 600, J = 20, K = 128 */
+{1688, 1280, 1328, 112, NEG, 1066, 1024,
+	1025, 3, POS, 108000000, 63900, 60, NEG},
+
+/* 1600 x 1200 [4:3]. -- Ultra eXtended Graphics Array */
+/* VESA */
+{2160, 1600, 1664, 192, POS, 1250, 1200,
+	1201, 3, POS, 162000000, 75000, 60, NEG},
+
+/* 1920 x 1080 [16:9]. This is a make-up value, need to be proven.
+ * The Pixel clock is calculated based on the maximum resolution of
+ * "Single Link" DVI, which support a maximum 165MHz pixel clock.
+ * The second values are taken from:
+ *http://www.tek.com/Measurement/App_Notes/25_14700/eng/25W_14700_3.pdf
+ */
+{2200, 1920, 2008, 44, POS, 1125, 1080,
+	1084, 5, POS, 148500000, 67500, 60, NEG},
+
+/* 1920 x 1200 [8:5]. -- Widescreen Ultra eXtended Graphics Array (WUXGA) */
+{2592, 1920, 2048, 208, NEG, 1242, 1200,
+	1201, 3, POS, 193160000, 74522, 60, NEG},
+
+/* End of table. */
+{ 0, 0, 0, 0, NEG, 0, 0, 0, 0, NEG, 0, 0, 0, NEG},
+};
+
+/*
+ *   This function takes care the extra registers and bit fields required to set
+ *   up a mode in board.
+ *
+ *	Explanation about Display Control register:
+ *  FPGA only supports 7 predefined pixel clocks, and clock select is
+ *  in bit 4:0 of new register 0x802a8.
+ */
+unsigned int display_ctrl_adjust(struct mode_para *para, unsigned int ctrl)
+{
+	unsigned long x, y;
+	unsigned long pll1; /* bit[31:0] of PLL */
+	unsigned long pll2; /* bit[63:32] of PLL */
+
+	x = para->h_display_end;
+	y = para->v_display_end;
+
+	/* Hisilicon has to set up a new register for PLL control
+	 *(CRT_PLL1_HS & CRT_PLL2_HS).
+	 */
+	if (x = 800 && y = 600) {
+		pll1 = CRT_PLL1_HS_40MHZ;
+		pll2 = CRT_PLL2_HS_40MHZ;
+	} else if (x = 1024 && y = 768) {
+		pll1 = CRT_PLL1_HS_65MHZ;
+		pll2 = CRT_PLL2_HS_65MHZ;
+	} else if (x = 1152 && y = 864) {
+		pll1 = CRT_PLL1_HS_80MHZ_1152;
+		pll2 = CRT_PLL2_HS_80MHZ;
+	} else if (x = 1280 && y = 768) {
+		pll1 = CRT_PLL1_HS_80MHZ;
+		pll2 = CRT_PLL2_HS_80MHZ;
+	} else if (x = 1280 && y = 720) {
+		pll1 = CRT_PLL1_HS_74MHZ;
+		pll2 = CRT_PLL2_HS_74MHZ;
+	} else if (x = 1280 && y = 960) {
+		pll1 = CRT_PLL1_HS_108MHZ;
+		pll2 = CRT_PLL2_HS_108MHZ;
+	} else if (x = 1280 && y = 1024) {
+		pll1 = CRT_PLL1_HS_108MHZ;
+		pll2 = CRT_PLL2_HS_108MHZ;
+	} else if (x = 1600 && y = 1200) {
+		pll1 = CRT_PLL1_HS_162MHZ;
+		pll2 = CRT_PLL2_HS_162MHZ;
+	} else if (x = 1920 && y = 1080) {
+		pll1 = CRT_PLL1_HS_148MHZ;
+		pll2 = CRT_PLL2_HS_148MHZ;
+	} else if (x = 1920 && y = 1200) {
+		pll1 = CRT_PLL1_HS_193MHZ;
+		pll2 = CRT_PLL2_HS_193MHZ;
+	} else /* default to VGA clock */ {
+		pll1 = CRT_PLL1_HS_25MHZ;
+		pll2 = CRT_PLL2_HS_25MHZ;
+	}
+
+	POKE32(CRT_PLL2_HS, pll2);
+	set_vclock_hisilicon(pll1);
+
+
+	/* Hisilicon has to set up the top-left and bottom-right
+	 * registers as well.
+	 * Note that normal chip only use those two register for
+	 * auto-centering mode.
+	 */
+	POKE32(CRT_AUTO_CENTERING_TL,
+	  FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, TOP, 0)
+	| FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, LEFT, 0));
+
+	POKE32(CRT_AUTO_CENTERING_BR,
+	  FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, BOTTOM, y-1)
+	| FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, RIGHT, x-1));
+
+	/* Assume common fields in ctrl have been properly set before
+	 * calling this function.
+	 * This function only sets the extra fields in ctrl.
+	 */
+
+	/* Set bit 25 of display controller: Select CRT or VGA clock */
+	ctrl = FIELD_SET(ctrl, CRT_DISPLAY_CTRL, CRTSELECT, CRT);
+
+	/* Set bit 14 of display controller */
+	ctrl &= FIELD_CLEAR(CRT_DISPLAY_CTRL, CLOCK_PHASE);
+	if (para->clock_phase_polarity = NEG)
+		ctrl = FIELD_SET(ctrl,
+			CRT_DISPLAY_CTRL, CLOCK_PHASE, ACTIVE_LOW);
+	else
+		ctrl = FIELD_SET(ctrl, CRT_DISPLAY_CTRL,
+			CLOCK_PHASE, ACTIVE_HIGH);
+
+	POKE32(CRT_DISPLAY_CTRL, ctrl);
+
+	return ctrl;
+}
+
+/* only timing related registers will be programed */
+static int program_mode_registers(struct mode_para *para, struct pll *pll)
+{
+	int ret = 0;
+	unsigned int val;
+
+	if (pll->clock_type = SECONDARY_PLL) {
+		/* programe secondary pixel clock */
+		POKE32(CRT_PLL_CTRL, format_pll_reg(pll));
+		POKE32(CRT_HORIZONTAL_TOTAL,
+			FIELD_VALUE(0, CRT_HORIZONTAL_TOTAL,
+			TOTAL, para->horizontal_total - 1)|
+			FIELD_VALUE(0, CRT_HORIZONTAL_TOTAL,
+			DISPLAY_END, para->h_display_end - 1));
+
+		POKE32(CRT_HORIZONTAL_SYNC,
+			FIELD_VALUE(0, CRT_HORIZONTAL_SYNC, WIDTH,
+			para->h_sync_width)|
+			FIELD_VALUE(0, CRT_HORIZONTAL_SYNC,
+			START, para->h_sync_start - 1));
+
+		POKE32(CRT_VERTICAL_TOTAL,
+			FIELD_VALUE(0, CRT_VERTICAL_TOTAL,
+			TOTAL, para->vertical_total - 1)|
+			FIELD_VALUE(0, CRT_VERTICAL_TOTAL,
+			DISPLAY_END, para->v_display_end - 1));
+
+		POKE32(CRT_VERTICAL_SYNC,
+			FIELD_VALUE(0, CRT_VERTICAL_SYNC,
+			HEIGHT, para->v_sync_height)|
+			FIELD_VALUE(0, CRT_VERTICAL_SYNC,
+			START, para->v_sync_start - 1));
+
+		val = FIELD_VALUE(0, CRT_DISPLAY_CTRL, VSYNC_PHASE,
+				para->vsync_polarity)|
+			FIELD_VALUE(0, CRT_DISPLAY_CTRL,
+				HSYNC_PHASE, para->hsync_polarity)|
+			FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING, ENABLE)|
+			FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
+
+		display_ctrl_adjust(para, val);
+	}  else {
+		ret = -1;
+	}
+	return ret;
+}
+
+/*
+ *  find_mode_para
+ *      This function locates the requested mode in the given parameter table
+ *
+ *  Input:
+ *      width           - Mode width
+ *      height          - Mode height
+ *      refresh_rate    - Mode refresh rate
+ *      index           - Index that is used for multiple search of the same
+ *                        mode that have the same width, height, and refresh
+ *                        rate,but have different timing parameters.
+ *
+ *  Output:
+ *      Success: return a pointer to the mode_para entry.
+ *      Fail: a NULL pointer.
+ */
+struct mode_para *find_mode_para(
+	unsigned long width,
+	unsigned long height,
+	unsigned long refresh_rate,
+	unsigned short index,
+	struct mode_para *para
+)
+{
+	unsigned short modeIndex = 0, tempIndex = 0;
+
+	/* Walk the entire mode table. */
+	while (para[modeIndex].pixel_clock != 0) {
+		if (((width = (unsigned long)(-1))
+			|| (para[modeIndex].h_display_end = width))
+		    && ((height = (unsigned long)(-1))
+			|| (para[modeIndex].v_display_end = height))
+		    && ((refresh_rate = (unsigned long)(-1))
+			|| (para[modeIndex].vertical_freq = refresh_rate))) {
+
+			if (tempIndex < index)
+				tempIndex++;
+			else
+				return &para[modeIndex];
+		}
+
+		/* Next entry */
+		modeIndex++;
+	}
+
+	/* No match */
+	return NULL;
+}
+
+int hisi_set_mode_timing(struct mode_para *para, enum clock_type clock)
+{
+	struct pll pll;
+	unsigned long width;
+	unsigned long height;
+	unsigned long refresh_rate;
+
+
+	pll.intput_freq = DEFAULT_INPUT_CLOCK;
+	pll.clock_type = clock;
+
+	width = para->h_display_end;
+	height = para->v_display_end;
+	refresh_rate = 60;
+
+	para = find_mode_para(width, height, refresh_rate, 0,
+						g_hisi_mode_para_table);
+
+	/* fix Segmentation fault on arm platform */
+#if defined(__i386__) || defined(__x86_64__)
+		/* set graphic mode via IO method */
+	outb_p(0x88, 0x3d4);
+	outb_p(0x06, 0x3d5);
+#endif
+
+	program_mode_registers(para, &pll);
+	return 0;
+}
diff --git a/drivers/video/fbdev/hisilicon/hisi_mode.h b/drivers/video/fbdev/hisilicon/hisi_mode.h
new file mode 100644
index 0000000..576e09a
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_mode.h
@@ -0,0 +1,39 @@
+#ifndef HISI_MODE_H__
+#define HISI_MODE_H__
+
+#include "hisi_chip.h"
+
+
+enum spolarity_t {
+	POS = 0, /* positive */
+	NEG, /* negative */
+};
+
+
+struct mode_para {
+	/* Horizontal timing. */
+	unsigned long horizontal_total;
+	unsigned long h_display_end;
+	unsigned long h_sync_start;
+	unsigned long h_sync_width;
+	enum spolarity_t hsync_polarity;
+
+	/* Vertical timing. */
+	unsigned long vertical_total;
+	unsigned long v_display_end;
+	unsigned long v_sync_start;
+	unsigned long v_sync_height;
+	enum spolarity_t vsync_polarity;
+
+	/* Refresh timing. */
+	unsigned long pixel_clock;
+	unsigned long horizontal_freq;
+	unsigned long vertical_freq;
+
+	/* Clock Phase. This clock phase only applies to Panel. */
+	enum spolarity_t clock_phase_polarity;
+};
+
+int hisi_set_mode_timing(struct mode_para *, enum clock_type);
+
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_power.c b/drivers/video/fbdev/hisilicon/hisi_power.c
new file mode 100644
index 0000000..0072f6b
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_power.c
@@ -0,0 +1,106 @@
+#include "hisi_help.h"
+#include "hisi_power.h"
+#include "hisi_reg.h"
+
+unsigned int get_power_mode(void)
+{
+	return FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE);
+}
+
+/*
+ * It can operate in one of three modes: 0, 1 or Sleep.
+ * On hardware reset, power mode 0 is default.
+ */
+void set_power_mode(unsigned int power_mode)
+{
+	unsigned int control_value = 0;
+
+	control_value = PEEK32(POWER_MODE_CTRL);
+
+
+	switch (power_mode) {
+	case POWER_MODE_CTRL_MODE_MODE0:
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL,
+			MODE, MODE0);
+		break;
+
+	case POWER_MODE_CTRL_MODE_MODE1:
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL,
+			MODE, MODE1);
+		break;
+
+	case POWER_MODE_CTRL_MODE_SLEEP:
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL,
+			MODE, SLEEP);
+		break;
+
+	default:
+		break;
+	}
+
+    /* Set up other fields in Power Control Register */
+	if (power_mode = POWER_MODE_CTRL_MODE_SLEEP) {
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL,
+			OSC_INPUT,  OFF);
+	} else {
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL,
+			OSC_INPUT,  ON);
+	}
+    /* Program new power mode. */
+	POKE32(POWER_MODE_CTRL, control_value);
+}
+
+void set_current_gate(unsigned int gate)
+{
+	unsigned int gate_reg;
+	unsigned int mode;
+
+	/* Get current power mode. */
+	mode = get_power_mode();
+
+	switch (mode) {
+	case POWER_MODE_CTRL_MODE_MODE0:
+		gate_reg = MODE0_GATE;
+		break;
+
+	case POWER_MODE_CTRL_MODE_MODE1:
+		gate_reg = MODE1_GATE;
+		break;
+
+	default:
+		gate_reg = MODE0_GATE;
+		break;
+	}
+	POKE32(gate_reg, gate);
+}
+
+/* This function enable/disable the 2D engine. */
+void enable_2d_engine(unsigned int enable)
+{
+	uint32_t gate;
+
+	gate = PEEK32(CURRENT_GATE);
+	if (enable) {
+		gate = FIELD_SET(gate, CURRENT_GATE, DE, ON);
+		gate = FIELD_SET(gate, CURRENT_GATE, CSC, ON);
+	} else {
+		gate = FIELD_SET(gate, CURRENT_GATE, DE, OFF);
+		gate = FIELD_SET(gate, CURRENT_GATE, CSC, OFF);
+	}
+
+	set_current_gate(gate);
+}
+
+void enable_dma(unsigned int enable)
+{
+	uint32_t gate;
+    /* Enable DMA Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+		gate = FIELD_SET(gate, CURRENT_GATE, DMA, ON);
+	else
+		gate = FIELD_SET(gate, CURRENT_GATE, DMA, OFF);
+
+	set_current_gate(gate);
+}
+
diff --git a/drivers/video/fbdev/hisilicon/hisi_power.h b/drivers/video/fbdev/hisilicon/hisi_power.h
new file mode 100644
index 0000000..59dc8954
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_power.h
@@ -0,0 +1,18 @@
+#ifndef HISI_POWER_H__
+#define HISI_POWER_H__
+
+
+
+unsigned int get_power_mode(void);
+
+/* This function sets the current power mode */
+void set_power_mode(unsigned int powerMode);
+
+/* This function sets current gate */
+void set_current_gate(unsigned int gate);
+
+/* This function enable/disable the 2D engine. */
+void enable_2d_engine(unsigned int enable);
+/* This function enable/disable the DMA Engine */
+void enable_dma(unsigned int enable);
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_reg.h b/drivers/video/fbdev/hisilicon/hisi_reg.h
new file mode 100644
index 0000000..ceb1ead
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_reg.h
@@ -0,0 +1,418 @@
+#ifndef HISI_REG_H__
+#define HISI_REG_H__
+
+#define F(v)    v
+
+/* register definition */
+#define DE_STATE1                                        0x100054
+#define DE_STATE1_DE_ABORT                               F(0:0)
+#define DE_STATE1_DE_ABORT_OFF                           0
+#define DE_STATE1_DE_ABORT_ON                            1
+
+#define DE_STATE2                                        0x100058
+#define DE_STATE2_DE_FIFO                                F(3:3)
+#define DE_STATE2_DE_FIFO_NOTEMPTY                       0
+#define DE_STATE2_DE_FIFO_EMPTY                          1
+#define DE_STATE2_DE_STATUS                              F(2:2)
+#define DE_STATE2_DE_STATUS_IDLE                         0
+#define DE_STATE2_DE_STATUS_BUSY                         1
+#define DE_STATE2_DE_MEM_FIFO                            F(1:1)
+#define DE_STATE2_DE_MEM_FIFO_NOTEMPTY                   0
+#define DE_STATE2_DE_MEM_FIFO_EMPTY                      1
+
+#define MISC_CTRL                                     0x000004
+#define MISC_CTRL_DAC_POWER                           F(20:20)
+#define MISC_CTRL_DAC_POWER_ON                        0
+#define MISC_CTRL_DAC_POWER_OFF                       1
+#define MISC_CTRL_LOCALMEM_RESET                      F(6:6)
+#define MISC_CTRL_LOCALMEM_RESET_RESET                0
+#define MISC_CTRL_LOCALMEM_RESET_NORMAL               1
+
+#define CURRENT_GATE                                  0x000040
+#define CURRENT_GATE_MCLK                             F(15:14)
+#define CURRENT_GATE_CSC                              F(4:4)
+#define CURRENT_GATE_CSC_OFF                          0
+#define CURRENT_GATE_CSC_ON                           1
+#define CURRENT_GATE_DE                               F(3:3)
+#define CURRENT_GATE_DE_OFF                           0
+#define CURRENT_GATE_DE_ON                            1
+#define CURRENT_GATE_DISPLAY                          F(2:2)
+#define CURRENT_GATE_DISPLAY_OFF                      0
+#define CURRENT_GATE_DISPLAY_ON                       1
+#define CURRENT_GATE_LOCALMEM                         F(1:1)
+#define CURRENT_GATE_LOCALMEM_OFF                     0
+#define CURRENT_GATE_LOCALMEM_ON                      1
+#define CURRENT_GATE_DMA                              F(0:0)
+#define CURRENT_GATE_DMA_OFF                          0
+#define CURRENT_GATE_DMA_ON                           1
+
+#define MODE0_GATE                                    0x000044
+
+#define MODE1_GATE                                    0x000048
+
+#define POWER_MODE_CTRL                               0x00004C
+
+#define POWER_MODE_CTRL_OSC_INPUT                     F(3:3)
+#define POWER_MODE_CTRL_OSC_INPUT_OFF                 0
+#define POWER_MODE_CTRL_OSC_INPUT_ON                  1
+#define POWER_MODE_CTRL_ACPI                          F(2:2)
+#define POWER_MODE_CTRL_ACPI_OFF                      0
+#define POWER_MODE_CTRL_ACPI_ON                       1
+#define POWER_MODE_CTRL_MODE                          F(1:0)
+#define POWER_MODE_CTRL_MODE_MODE0                    0
+#define POWER_MODE_CTRL_MODE_MODE1                    1
+#define POWER_MODE_CTRL_MODE_SLEEP                    2
+
+#define PANEL_PLL_CTRL                                0x00005C
+#define PANEL_PLL_CTRL_BYPASS                         F(18:18)
+#define PANEL_PLL_CTRL_BYPASS_OFF                     0
+#define PANEL_PLL_CTRL_BYPASS_ON                      1
+#define PANEL_PLL_CTRL_POWER                          F(17:17)
+#define PANEL_PLL_CTRL_POWER_OFF                      0
+#define PANEL_PLL_CTRL_POWER_ON                       1
+#define PANEL_PLL_CTRL_INPUT                          F(16:16)
+#define PANEL_PLL_CTRL_INPUT_OSC                      0
+#define PANEL_PLL_CTRL_INPUT_TESTCLK                  1
+
+#define PANEL_PLL_CTRL_POD                        F(15:14)
+#define PANEL_PLL_CTRL_OD                         F(13:12)
+
+#define PANEL_PLL_CTRL_N                              F(11:8)
+#define PANEL_PLL_CTRL_M                              F(7:0)
+
+#define CRT_PLL_CTRL                                  0x000060
+/* Video Control */
+
+#define VIDEO_DISPLAY_CTRL                              0x080040
+#define VIDEO_DISPLAY_CTRL_PLANE                        F(2:2)
+#define VIDEO_DISPLAY_CTRL_PLANE_DISABLE                0
+#define VIDEO_DISPLAY_CTRL_PLANE_ENABLE                 1
+
+/* Video Alpha Control */
+
+#define VIDEO_ALPHA_DISPLAY_CTRL                        0x080080
+#define VIDEO_ALPHA_DISPLAY_CTRL_PLANE                  F(2:2)
+#define VIDEO_ALPHA_DISPLAY_CTRL_PLANE_DISABLE          0
+#define VIDEO_ALPHA_DISPLAY_CTRL_PLANE_ENABLE           1
+
+/* Panel Cursor Control */
+#define ALPHA_DISPLAY_CTRL                            0x080100
+#define ALPHA_DISPLAY_CTRL_PLANE                      F(2:2)
+#define ALPHA_DISPLAY_CTRL_PLANE_DISABLE              0
+#define ALPHA_DISPLAY_CTRL_PLANE_ENABLE               1
+
+/* CRT Graphics Control */
+#define CRT_DISPLAY_CTRL                              0x080200
+#define CRT_DISPLAY_CTRL_RESERVED_1_MASK              F(31:27)
+#define CRT_DISPLAY_CTRL_RESERVED_1_MASK_DISABLE      0
+#define CRT_DISPLAY_CTRL_RESERVED_1_MASK_ENABLE       0x1F
+
+/* register definition */
+#define CRT_DISPLAY_CTRL_DPMS                         F(31:30)
+#define CRT_DISPLAY_CTRL_DPMS_0                       0
+#define CRT_DISPLAY_CTRL_DPMS_1                       1
+#define CRT_DISPLAY_CTRL_DPMS_2                       2
+#define CRT_DISPLAY_CTRL_DPMS_3                       3
+
+/* register definition */
+#define CRT_DISPLAY_CTRL_CRTSELECT                    F(25:25)
+#define CRT_DISPLAY_CTRL_CRTSELECT_VGA                0
+#define CRT_DISPLAY_CTRL_CRTSELECT_CRT                1
+
+#define CRT_DISPLAY_CTRL_CLOCK_PHASE                  F(14:14)
+#define CRT_DISPLAY_CTRL_CLOCK_PHASE_ACTIVE_HIGH      0
+#define CRT_DISPLAY_CTRL_CLOCK_PHASE_ACTIVE_LOW       1
+#define CRT_DISPLAY_CTRL_VSYNC_PHASE                  F(13:13)
+#define CRT_DISPLAY_CTRL_VSYNC_PHASE_ACTIVE_HIGH      0
+#define CRT_DISPLAY_CTRL_VSYNC_PHASE_ACTIVE_LOW       1
+#define CRT_DISPLAY_CTRL_HSYNC_PHASE                  F(12:12)
+#define CRT_DISPLAY_CTRL_HSYNC_PHASE_ACTIVE_HIGH      0
+#define CRT_DISPLAY_CTRL_HSYNC_PHASE_ACTIVE_LOW       1
+#define CRT_DISPLAY_CTRL_BLANK                        F(10:10)
+#define CRT_DISPLAY_CTRL_BLANK_OFF                    0
+#define CRT_DISPLAY_CTRL_BLANK_ON                     1
+#define CRT_DISPLAY_CTRL_TIMING                       F(8:8)
+#define CRT_DISPLAY_CTRL_TIMING_DISABLE               0
+#define CRT_DISPLAY_CTRL_TIMING_ENABLE                1
+#define CRT_DISPLAY_CTRL_PLANE                        F(2:2)
+#define CRT_DISPLAY_CTRL_PLANE_DISABLE                0
+#define CRT_DISPLAY_CTRL_PLANE_ENABLE                 1
+#define CRT_DISPLAY_CTRL_FORMAT                       F(1:0)
+#define CRT_DISPLAY_CTRL_FORMAT_8                     0
+#define CRT_DISPLAY_CTRL_FORMAT_16                    1
+#define CRT_DISPLAY_CTRL_FORMAT_32                    2
+#define CRT_DISPLAY_CTRL_RESERVED_BITS_MASK           0xFF000200
+
+#define CRT_FB_ADDRESS                                0x080204
+#define CRT_FB_ADDRESS_STATUS                         F(31:31)
+#define CRT_FB_ADDRESS_STATUS_CURRENT                 0
+#define CRT_FB_ADDRESS_STATUS_PENDING                 1
+#define CRT_FB_ADDRESS_EXT                            F(27:27)
+#define CRT_FB_ADDRESS_EXT_LOCAL                      0
+#define CRT_FB_ADDRESS_EXT_EXTERNAL                   1
+#define CRT_FB_ADDRESS_ADDRESS                        F(25:0)
+
+#define CRT_FB_WIDTH                                  0x080208
+#define CRT_FB_WIDTH_WIDTH                            F(29:16)
+#define CRT_FB_WIDTH_OFFSET                           F(13:0)
+
+#define CRT_HORIZONTAL_TOTAL                          0x08020C
+#define CRT_HORIZONTAL_TOTAL_TOTAL                    F(27:16)
+#define CRT_HORIZONTAL_TOTAL_DISPLAY_END              F(11:0)
+
+#define CRT_HORIZONTAL_SYNC                           0x080210
+#define CRT_HORIZONTAL_SYNC_WIDTH                     F(23:16)
+#define CRT_HORIZONTAL_SYNC_START                     F(11:0)
+
+#define CRT_VERTICAL_TOTAL                            0x080214
+#define CRT_VERTICAL_TOTAL_TOTAL                      F(26:16)
+#define CRT_VERTICAL_TOTAL_DISPLAY_END                F(10:0)
+
+#define CRT_VERTICAL_SYNC                             0x080218
+#define CRT_VERTICAL_SYNC_HEIGHT                      F(21:16)
+#define CRT_VERTICAL_SYNC_START                       F(10:0)
+
+/* Auto Centering */
+#define CRT_AUTO_CENTERING_TL                     0x080280
+#define CRT_AUTO_CENTERING_TL_TOP                 F(26:16)
+#define CRT_AUTO_CENTERING_TL_LEFT                F(10:0)
+
+#define CRT_AUTO_CENTERING_BR                     0x080284
+#define CRT_AUTO_CENTERING_BR_BOTTOM              F(26:16)
+#define CRT_AUTO_CENTERING_BR_RIGHT               F(10:0)
+
+/* register to control panel output */
+#define DISPLAY_CONTROL_HISILE                    0x80288
+
+
+/* register and values for PLL control */
+#define CRT_PLL1_HS                            0x802a8
+#define CRT_PLL1_HS_25MHZ	               0x23d40f02
+#define CRT_PLL1_HS_40MHZ	               0x23940801
+#define CRT_PLL1_HS_65MHZ	               0x23940d01
+#define CRT_PLL1_HS_78MHZ	               0x23540F82
+#define CRT_PLL1_HS_74MHZ	               0x23941dc2
+#define CRT_PLL1_HS_80MHZ	               0x23941001
+#define CRT_PLL1_HS_80MHZ_1152	           0x23540fc2
+#define CRT_PLL1_HS_108MHZ	               0x23b41b01
+#define CRT_PLL1_HS_162MHZ	               0x23480681
+#define CRT_PLL1_HS_148MHZ	               0x23541dc2
+#define CRT_PLL1_HS_193MHZ	               0x234807c1
+
+#define CRT_PLL2_HS                         0x802ac
+#define CRT_PLL2_HS_25MHZ	               0x206B851E
+#define CRT_PLL2_HS_40MHZ	               0x30000000
+#define CRT_PLL2_HS_65MHZ	               0x40000000
+#define CRT_PLL2_HS_78MHZ	               0x50E147AE
+#define CRT_PLL2_HS_74MHZ	               0x602B6AE7
+#define CRT_PLL2_HS_80MHZ	               0x70000000
+#define CRT_PLL2_HS_108MHZ	               0x80000000
+#define CRT_PLL2_HS_162MHZ	               0xA0000000
+#define CRT_PLL2_HS_148MHZ	               0xB0CCCCCD
+#define CRT_PLL2_HS_193MHZ	               0xC0872B02
+
+/* Palette RAM */
+
+/* Panel Palette register starts at 0x080400 ~ 0x0807FC */
+#define PANEL_PALETTE_RAM                             0x080400
+
+/* Panel Palette register starts at 0x080C00 ~ 0x080FFC */
+#define CRT_PALETTE_RAM                               0x080C00
+
+#define DMA_ABORT_INTERRUPT                             0x0D0020
+#define DMA_ABORT_INTERRUPT_ABORT_1                     F(5:5)
+#define DMA_ABORT_INTERRUPT_ABORT_1_ENABLE              0
+#define DMA_ABORT_INTERRUPT_ABORT_1_ABORT               1
+
+/* cursor control */
+#define HWC_ADDRESS                         0x0
+#define HWC_ADDRESS_ENABLE                  F(31:31)
+#define HWC_ADDRESS_ENABLE_DISABLE          0
+#define HWC_ADDRESS_ENABLE_ENABLE           1
+#define HWC_ADDRESS_EXT                     F(27:27)
+#define HWC_ADDRESS_EXT_LOCAL               0
+#define HWC_ADDRESS_EXT_EXTERNAL            1
+#define HWC_ADDRESS_CS                      F(26:26)
+#define HWC_ADDRESS_CS_0                    0
+#define HWC_ADDRESS_CS_1                    1
+#define HWC_ADDRESS_ADDRESS                 F(25:0)
+
+#define HWC_LOCATION                        0x4
+#define HWC_LOCATION_Y                      F(26:16)
+#define HWC_LOCATION_LEFT                   F(11:11)
+#define HWC_LOCATION_LEFT_INSIDE            0
+#define HWC_LOCATION_LEFT_OUTSIDE           1
+#define HWC_LOCATION_X                      F(10:0)
+
+#define HWC_COLOR_12                        0x8
+
+#define HWC_COLOR_3                         0xC
+
+/* accelate 2d graphic */
+#define DE_SOURCE                                       0x0
+#define DE_SOURCE_WRAP                                  F(31:31)
+#define DE_SOURCE_WRAP_DISABLE                          0
+#define DE_SOURCE_WRAP_ENABLE                           1
+#define DE_SOURCE_X_K1                                  F(29:16)
+#define DE_SOURCE_Y_K2                                  F(15:0)
+#define DE_SOURCE_X_K1_MONO                             F(20:16)
+
+#define DE_DESTINATION                                  0x4
+#define DE_DESTINATION_WRAP                             F(31:31)
+#define DE_DESTINATION_WRAP_DISABLE                     0
+#define DE_DESTINATION_WRAP_ENABLE                      1
+#define DE_DESTINATION_X                                F(28:16)
+#define DE_DESTINATION_Y                                F(15:0)
+
+#define DE_DIMENSION                                    0x8
+#define DE_DIMENSION_X                                  F(28:16)
+#define DE_DIMENSION_Y_ET                               F(15:0)
+
+#define DE_CONTROL                                      0xC
+#define DE_CONTROL_STATUS                               F(31:31)
+#define DE_CONTROL_STATUS_STOP                          0
+#define DE_CONTROL_STATUS_START                         1
+#define DE_CONTROL_PATTERN                              F(30:30)
+#define DE_CONTROL_PATTERN_MONO                         0
+#define DE_CONTROL_PATTERN_COLOR                        1
+#define DE_CONTROL_UPDATE_DESTINATION_X                 F(29:29)
+#define DE_CONTROL_UPDATE_DESTINATION_X_DISABLE         0
+#define DE_CONTROL_UPDATE_DESTINATION_X_ENABLE          1
+#define DE_CONTROL_QUICK_START                          F(28:28)
+#define DE_CONTROL_QUICK_START_DISABLE                  0
+#define DE_CONTROL_QUICK_START_ENABLE                   1
+#define DE_CONTROL_DIRECTION                            F(27:27)
+#define DE_CONTROL_DIRECTION_LEFT_TO_RIGHT              0
+#define DE_CONTROL_DIRECTION_RIGHT_TO_LEFT              1
+#define DE_CONTROL_MAJOR                                F(26:26)
+#define DE_CONTROL_MAJOR_X                              0
+#define DE_CONTROL_MAJOR_Y                              1
+#define DE_CONTROL_STEP_X                               F(25:25)
+#define DE_CONTROL_STEP_X_POSITIVE                      1
+#define DE_CONTROL_STEP_X_NEGATIVE                      0
+#define DE_CONTROL_STEP_Y                               F(24:24)
+#define DE_CONTROL_STEP_Y_POSITIVE                      1
+#define DE_CONTROL_STEP_Y_NEGATIVE                      0
+#define DE_CONTROL_STRETCH                              F(23:23)
+#define DE_CONTROL_STRETCH_DISABLE                      0
+#define DE_CONTROL_STRETCH_ENABLE                       1
+#define DE_CONTROL_HOST                                 F(22:22)
+#define DE_CONTROL_HOST_COLOR                           0
+#define DE_CONTROL_HOST_MONO                            1
+#define DE_CONTROL_LAST_PIXEL                           F(21:21)
+#define DE_CONTROL_LAST_PIXEL_OFF                       0
+#define DE_CONTROL_LAST_PIXEL_ON                        1
+#define DE_CONTROL_COMMAND                              F(20:16)
+#define DE_CONTROL_COMMAND_BITBLT                       0
+#define DE_CONTROL_COMMAND_RECTANGLE_FILL               1
+#define DE_CONTROL_COMMAND_DE_TILE                      2
+#define DE_CONTROL_COMMAND_TRAPEZOID_FILL               3
+#define DE_CONTROL_COMMAND_ALPHA_BLEND                  4
+#define DE_CONTROL_COMMAND_RLE_STRIP                    5
+#define DE_CONTROL_COMMAND_SHORT_STROKE                 6
+#define DE_CONTROL_COMMAND_LINE_DRAW                    7
+#define DE_CONTROL_COMMAND_HOST_WRITE                   8
+#define DE_CONTROL_COMMAND_HOST_READ                    9
+#define DE_CONTROL_COMMAND_HOST_WRITE_BOTTOM_UP         10
+#define DE_CONTROL_COMMAND_ROTATE                       11
+#define DE_CONTROL_COMMAND_FONT                         12
+#define DE_CONTROL_COMMAND_TEXTURE_LOAD                 15
+#define DE_CONTROL_ROP_SELECT                           F(15:15)
+#define DE_CONTROL_ROP_SELECT_ROP3                      0
+#define DE_CONTROL_ROP_SELECT_ROP2                      1
+#define DE_CONTROL_ROP2_SOURCE                          F(14:14)
+#define DE_CONTROL_ROP2_SOURCE_BITMAP                   0
+#define DE_CONTROL_ROP2_SOURCE_PATTERN                  1
+#define DE_CONTROL_MONO_DATA                            F(13:12)
+#define DE_CONTROL_MONO_DATA_NOT_PACKED                 0
+#define DE_CONTROL_MONO_DATA_8_PACKED                   1
+#define DE_CONTROL_MONO_DATA_16_PACKED                  2
+#define DE_CONTROL_MONO_DATA_32_PACKED                  3
+#define DE_CONTROL_REPEAT_ROTATE                        F(11:11)
+#define DE_CONTROL_REPEAT_ROTATE_DISABLE                0
+#define DE_CONTROL_REPEAT_ROTATE_ENABLE                 1
+#define DE_CONTROL_TRANSPARENCY_MATCH                   F(10:10)
+#define DE_CONTROL_TRANSPARENCY_MATCH_OPAQUE            0
+#define DE_CONTROL_TRANSPARENCY_MATCH_TRANSPARENT       1
+#define DE_CONTROL_TRANSPARENCY_SELECT                  F(9:9)
+#define DE_CONTROL_TRANSPARENCY_SELECT_SOURCE           0
+#define DE_CONTROL_TRANSPARENCY_SELECT_DESTINATION      1
+#define DE_CONTROL_TRANSPARENCY                         F(8:8)
+#define DE_CONTROL_TRANSPARENCY_DISABLE                 0
+#define DE_CONTROL_TRANSPARENCY_ENABLE                  1
+#define DE_CONTROL_ROP                                  F(7:0)
+
+/* Pseudo fields. */
+
+#define DE_CONTROL_SHORT_STROKE_DIR                     F(27:24)
+#define DE_CONTROL_SHORT_STROKE_DIR_225                 0
+#define DE_CONTROL_SHORT_STROKE_DIR_135                 1
+#define DE_CONTROL_SHORT_STROKE_DIR_315                 2
+#define DE_CONTROL_SHORT_STROKE_DIR_45                  3
+#define DE_CONTROL_SHORT_STROKE_DIR_270                 4
+#define DE_CONTROL_SHORT_STROKE_DIR_90                  5
+#define DE_CONTROL_SHORT_STROKE_DIR_180                 8
+#define DE_CONTROL_SHORT_STROKE_DIR_0                   10
+#define DE_CONTROL_ROTATION                             F(25:24)
+#define DE_CONTROL_ROTATION_0                           0
+#define DE_CONTROL_ROTATION_270                         1
+#define DE_CONTROL_ROTATION_90                          2
+#define DE_CONTROL_ROTATION_180                         3
+
+#define DE_PITCH                                        0x000010
+#define DE_PITCH_DESTINATION                            F(28:16)
+#define DE_PITCH_SOURCE                                 F(12:0)
+
+#define DE_FOREGROUND                                   0x000014
+
+#define DE_BACKGROUND                                   0x000018
+
+#define DE_STRETCH_FORMAT                               0x00001C
+#define DE_STRETCH_FORMAT_PATTERN_XY                    F(30:30)
+#define DE_STRETCH_FORMAT_PATTERN_XY_NORMAL             0
+#define DE_STRETCH_FORMAT_PATTERN_XY_OVERWRITE          1
+#define DE_STRETCH_FORMAT_PATTERN_Y                     F(29:27)
+#define DE_STRETCH_FORMAT_PATTERN_X                     F(25:23)
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT                  F(21:20)
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_8                0
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_16               1
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_32               2
+#define DE_STRETCH_FORMAT_PIXEL_FORMAT_24               3
+
+#define DE_STRETCH_FORMAT_ADDRESSING                    F(19:16)
+#define DE_STRETCH_FORMAT_ADDRESSING_XY                 0
+#define DE_STRETCH_FORMAT_ADDRESSING_LINEAR             15
+#define DE_STRETCH_FORMAT_SOURCE_HEIGHT                 F(11:0)
+
+#define DE_COLOR_COMPARE                                0x000020
+
+#define DE_COLOR_COMPARE_MASK                           0x000024
+
+#define DE_MASKS                                        0x000028
+
+#define DE_CLIP_TL                                      0x00002C
+
+#define DE_CLIP_BR                                      0x000030
+
+#define DE_WINDOW_WIDTH                                 0x00003C
+#define DE_WINDOW_WIDTH_DESTINATION                     F(28:16)
+#define DE_WINDOW_WIDTH_SOURCE                          F(12:0)
+
+#define DE_WINDOW_SOURCE_BASE                           0x000040
+#define DE_WINDOW_SOURCE_BASE_EXT                       F(27:27)
+#define DE_WINDOW_SOURCE_BASE_EXT_LOCAL                 0
+#define DE_WINDOW_SOURCE_BASE_EXT_EXTERNAL              1
+#define DE_WINDOW_SOURCE_BASE_CS                        F(26:26)
+#define DE_WINDOW_SOURCE_BASE_CS_0                      0
+#define DE_WINDOW_SOURCE_BASE_CS_1                      1
+#define DE_WINDOW_SOURCE_BASE_ADDRESS                   F(25:0)
+
+#define DE_WINDOW_DESTINATION_BASE                      0x000044
+#define DE_WINDOW_DESTINATION_BASE_EXT                  F(27:27)
+#define DE_WINDOW_DESTINATION_BASE_EXT_LOCAL            0
+#define DE_WINDOW_DESTINATION_BASE_EXT_EXTERNAL         1
+#define DE_WINDOW_DESTINATION_BASE_CS                   F(26:26)
+#define DE_WINDOW_DESTINATION_BASE_CS_0                 0
+#define DE_WINDOW_DESTINATION_BASE_CS_1                 1
+#define DE_WINDOW_DESTINATION_BASE_ADDRESS              F(25:0)
+#endif
-- 
1.9.1

