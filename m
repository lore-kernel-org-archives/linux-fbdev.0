From: Erik Gilling <konkers@android.com>
Date: Wed, 11 Aug 2010 23:11:12 +0000
Subject: [PATCH] video: tegra: add tegra display controller and fb driver
Message-Id: <1281568272-25871-1-git-send-email-konkers@android.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch supersedes the previous framebuffer patch

Supports:
	* panel setup
	* overlays
	* suspend / resume

Notable ommisions:
	* support for anything but lvds panels
	* inegration with nvhost driver to sync updates with 3D
	* FB physical geometry is not set
	* lacks interface to set overlay/window x,y offset

Signed-off-by: Erik Gilling <konkers@android.com>
Cc: Colin Cross <ccross@android.com>
Cc: Travis Geiselbrecht <travis@palm.com>
---
 arch/arm/mach-tegra/include/mach/dc.h |  152 ++++++
 arch/arm/mach-tegra/include/mach/fb.h |   44 ++
 drivers/video/Kconfig                 |    1 +
 drivers/video/Makefile                |    1 +
 drivers/video/tegra/Kconfig           |   15 +
 drivers/video/tegra/Makefile          |    2 +
 drivers/video/tegra/dc/Makefile       |    2 +
 drivers/video/tegra/dc/dc.c           |  894 +++++++++++++++++++++++++++++++++
 drivers/video/tegra/dc/dc_priv.h      |   86 ++++
 drivers/video/tegra/dc/dc_reg.h       |  342 +++++++++++++
 drivers/video/tegra/dc/rgb.c          |   63 +++
 drivers/video/tegra/fb.c              |  311 ++++++++++++
 12 files changed, 1913 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/dc.h
 create mode 100644 arch/arm/mach-tegra/include/mach/fb.h
 create mode 100644 drivers/video/tegra/Kconfig
 create mode 100644 drivers/video/tegra/Makefile
 create mode 100644 drivers/video/tegra/dc/Makefile
 create mode 100644 drivers/video/tegra/dc/dc.c
 create mode 100644 drivers/video/tegra/dc/dc_priv.h
 create mode 100644 drivers/video/tegra/dc/dc_reg.h
 create mode 100644 drivers/video/tegra/dc/rgb.c
 create mode 100644 drivers/video/tegra/fb.c

diff --git a/arch/arm/mach-tegra/include/mach/dc.h b/arch/arm/mach-tegra/include/mach/dc.h
new file mode 100644
index 0000000..b8a0e7a
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/dc.h
@@ -0,0 +1,152 @@
+/*
+ * arch/arm/mach-tegra/include/mach/dc.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_DC_H
+#define __MACH_TEGRA_DC_H
+
+
+#define TEGRA_MAX_DC		2
+#define DC_N_WINDOWS		3
+
+struct tegra_dc_blend {
+	u32	nokey;
+	u32	one_win;
+	u32	two_win_x;
+	u32	two_win_y;
+	u32	three_win_xy;
+};
+
+#define BLEND(key, control, weight0, weight1)				\
+	(CKEY_ ## key | BLEND_CONTROL_ ## control |			\
+	 BLEND_WEIGHT0(weight0) | BLEND_WEIGHT0(weight1))
+
+struct tegra_dc_mode {
+	int	pclk;
+	int	h_ref_to_sync;
+	int	v_ref_to_sync;
+	int	h_sync_width;
+	int	v_sync_width;
+	int	h_back_porch;
+	int	v_back_porch;
+	int	h_active;
+	int	v_active;
+	int	h_front_porch;
+	int	v_front_porch;
+};
+
+enum {
+	TEGRA_DC_OUT_RGB,
+};
+
+struct tegra_dc_out {
+	int			type;
+
+	unsigned		order;
+	unsigned		align;
+
+	struct tegra_dc_mode	*modes;
+	int			n_modes;
+};
+
+#define TEGRA_DC_ALIGN_MSB		0
+#define TEGRA_DC_ALIGN_LSB		1
+
+#define TEGRA_DC_ORDER_RED_BLUE		0
+#define TEGRA_DC_ORDER_BLUE_RED		1
+
+struct tegra_dc;
+
+struct tegra_dc_win {
+	u8			idx;
+	u8			fmt;
+	u32			flags;
+
+	void			*virt_addr;
+	dma_addr_t		phys_addr;
+	unsigned		x;
+	unsigned		y;
+	unsigned		w;
+	unsigned		h;
+	unsigned		out_w;
+	unsigned		out_h;
+
+	int			dirty;
+	struct tegra_dc		*dc;
+};
+
+#define TEGRA_WIN_FLAG_ENABLED		(1 << 0)
+#define TEGRA_WIN_FLAG_COLOR_EXPAND	(1 << 1)
+
+/* Note: These are the actual values written to the DC_WIN_COLOR_DEPTH register
+ * and may change in new tegra architectures.
+ */
+#define TEGRA_WIN_FMT_P1		0
+#define TEGRA_WIN_FMT_P2		1
+#define TEGRA_WIN_FMT_P4		2
+#define TEGRA_WIN_FMT_P8		3
+#define TEGRA_WIN_FMT_B4G4R4A4		4
+#define TEGRA_WIN_FMT_B5G5R5A		5
+#define TEGRA_WIN_FMT_B5G6R5		6
+#define TEGRA_WIN_FMT_AB5G5R5		7
+#define TEGRA_WIN_FMT_B8G8R8A8		12
+#define TEGRA_WIN_FMT_R8G8B8A8		13
+#define TEGRA_WIN_FMT_B6x2G6x2R6x2A8	14
+#define TEGRA_WIN_FMT_R6x2G6x2B6x2A8	15
+#define TEGRA_WIN_FMT_YCbCr422		16
+#define TEGRA_WIN_FMT_YUV422		17
+#define TEGRA_WIN_FMT_YCbCr420P		18
+#define TEGRA_WIN_FMT_YUV420P		19
+#define TEGRA_WIN_FMT_YCbCr422P		20
+#define TEGRA_WIN_FMT_YUV422P		21
+#define TEGRA_WIN_FMT_YCbCr422R		22
+#define TEGRA_WIN_FMT_YUV422R		23
+#define TEGRA_WIN_FMT_YCbCr422RA	24
+#define TEGRA_WIN_FMT_YUV422RA		25
+
+struct tegra_fb_data {
+	int		win;
+
+	int		xres;
+	int		yres;
+	int		bits_per_pixel;
+};
+
+struct tegra_dc_platform_data {
+	unsigned long		flags;
+	struct tegra_dc_out	*default_out;
+	struct tegra_fb_data	*fb;
+};
+
+#define TEGRA_DC_FLAG_ENABLED		(1 << 0)
+
+struct tegra_dc *tegra_dc_get_dc(unsigned idx);
+struct tegra_dc_win *tegra_dc_get_window(struct tegra_dc *dc, unsigned win);
+
+/* tegra_dc_update_windows and tegra_dc_sync_windows do not support windows
+ * with differenct dcs in one call
+ */
+int tegra_dc_update_windows(struct tegra_dc_win *windows[], int n);
+int tegra_dc_sync_windows(struct tegra_dc_win *windows[], int n);
+
+/* will probably be replaced with an interface describing the window order */
+void tegra_dc_set_blending(struct tegra_dc *dc, struct tegra_dc_blend *blend);
+
+int tegra_dc_set_mode(struct tegra_dc *dc, struct tegra_dc_mode *mode);
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/fb.h b/arch/arm/mach-tegra/include/mach/fb.h
new file mode 100644
index 0000000..9e5f7f8
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/fb.h
@@ -0,0 +1,44 @@
+/*
+ * arch/arm/mach-tegra/include/mach/fb.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_FB_H
+#define __MACH_TEGRA_FB_H
+
+#ifdef CONFIG_FB_TEGRA
+struct tegra_fb_info *tegra_fb_register(struct platform_device *pdev,
+					struct tegra_dc *dc,
+					struct tegra_fb_data *fb_data,
+					struct resource *fb_mem);
+void tegra_fb_unregister(struct tegra_fb_info *fb_info);
+#else
+static inline
+struct tegra_fb_info *tegra_fb_register(struct platform_device *pdev,
+					struct tegra_dc *dc,
+					struct tegra_fb_data *fb_data,
+					struct resource *fb_mem)
+{
+	return NULL;
+}
+
+static inline void tegra_fb_unregister(struct tegra_fb_info *fb_info)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3d94a14..1eb0ac1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2231,6 +2231,7 @@ config FB_BROADSHEET
 
 source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
+source "drivers/video/tegra/Kconfig"
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ddc2af2..21b527d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
 obj-$(CONFIG_FB_MSM)              += msm/
 obj-$(CONFIG_FB_NUC900)           += nuc900fb.o
+obj-y                             += tegra/
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
new file mode 100644
index 0000000..b01dc95
--- /dev/null
+++ b/drivers/video/tegra/Kconfig
@@ -0,0 +1,15 @@
+config TEGRA_DC
+	tristate "Tegra Display Contoller"
+	depends on ARCH_TEGRA
+	help
+	  Tegra display controller support.
+
+config FB_TEGRA
+	tristate "Tegra Framebuffer driver"
+	depends on TEGRA_DC && FB = y
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	default FB
+	help
+	  Framebuffer device support for the Tegra display controller.
diff --git a/drivers/video/tegra/Makefile b/drivers/video/tegra/Makefile
new file mode 100644
index 0000000..8f9d0e2
--- /dev/null
+++ b/drivers/video/tegra/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_TEGRA_DC) += dc/
+obj-$(CONFIG_FB_TEGRA) += fb.o
diff --git a/drivers/video/tegra/dc/Makefile b/drivers/video/tegra/dc/Makefile
new file mode 100644
index 0000000..3ecb63c
--- /dev/null
+++ b/drivers/video/tegra/dc/Makefile
@@ -0,0 +1,2 @@
+obj-y += dc.o
+obj-y += rgb.o
\ No newline at end of file
diff --git a/drivers/video/tegra/dc/dc.c b/drivers/video/tegra/dc/dc.c
new file mode 100644
index 0000000..261bced
--- /dev/null
+++ b/drivers/video/tegra/dc/dc.c
@@ -0,0 +1,894 @@
+/*
+ * drivers/video/tegra/dc/dc.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Erik Gilling <konkers@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/workqueue.h>
+#include <linux/ktime.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include <mach/clk.h>
+#include <mach/dc.h>
+#include <mach/fb.h>
+
+#include "dc_reg.h"
+#include "dc_priv.h"
+
+struct tegra_dc_blend tegra_dc_blend_modes[][DC_N_WINDOWS] = {
+	{{.nokey = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .one_win = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .two_win_x = BLEND(NOKEY, FIX, 0x00, 0x00),
+	  .two_win_y = BLEND(NOKEY, DEPENDANT, 0x00, 0x00),
+	  .three_win_xy = BLEND(NOKEY, FIX, 0x00, 0x00)},
+	 {.nokey = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .one_win = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .two_win_x = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .two_win_y = BLEND(NOKEY, DEPENDANT, 0x00, 0x00),
+	  .three_win_xy = BLEND(NOKEY, DEPENDANT, 0x00, 0x00)},
+	 {.nokey = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .one_win = BLEND(NOKEY, FIX, 0xff, 0xff),
+	  .two_win_x = BLEND(NOKEY, ALPHA, 0xff, 0xff),
+	  .two_win_y = BLEND(NOKEY, ALPHA, 0xff, 0xff),
+	  .three_win_xy = BLEND(NOKEY, ALPHA, 0xff, 0xff)}
+	}
+};
+
+struct tegra_dc *tegra_dcs[TEGRA_MAX_DC];
+
+DEFINE_MUTEX(tegra_dc_lock);
+
+static inline int tegra_dc_fmt_bpp(int fmt)
+{
+	switch (fmt) {
+	case TEGRA_WIN_FMT_P1:
+		return 1;
+
+	case TEGRA_WIN_FMT_P2:
+		return 2;
+
+	case TEGRA_WIN_FMT_P4:
+		return 4;
+
+	case TEGRA_WIN_FMT_P8:
+		return 8;
+
+	case TEGRA_WIN_FMT_B4G4R4A4:
+	case TEGRA_WIN_FMT_B5G5R5A:
+	case TEGRA_WIN_FMT_B5G6R5:
+	case TEGRA_WIN_FMT_AB5G5R5:
+		return 16;
+
+	case TEGRA_WIN_FMT_B8G8R8A8:
+	case TEGRA_WIN_FMT_R8G8B8A8:
+	case TEGRA_WIN_FMT_B6x2G6x2R6x2A8:
+	case TEGRA_WIN_FMT_R6x2G6x2B6x2A8:
+		return 32;
+
+	case TEGRA_WIN_FMT_YCbCr422:
+	case TEGRA_WIN_FMT_YUV422:
+	case TEGRA_WIN_FMT_YCbCr420P:
+	case TEGRA_WIN_FMT_YUV420P:
+	case TEGRA_WIN_FMT_YCbCr422P:
+	case TEGRA_WIN_FMT_YUV422P:
+	case TEGRA_WIN_FMT_YCbCr422R:
+	case TEGRA_WIN_FMT_YUV422R:
+	case TEGRA_WIN_FMT_YCbCr422RA:
+	case TEGRA_WIN_FMT_YUV422RA:
+		/* FIXME: need to know the bpp of these formats */
+		return 0;
+	}
+	return 0;
+}
+
+#define DUMP_REG(a) do {			\
+	snprintf(buff, sizeof(buff), "%-32s\t%03x\t%08lx\n", \
+		 #a, a, tegra_dc_readl(dc, a));		      \
+	print(data, buff);				      \
+	} while (0)
+
+static void _dump_regs(struct tegra_dc *dc, void *data,
+		       void (* print)(void *data, const char *str))
+{
+	int i;
+	char buff[256];
+
+	DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT);
+	DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT_CNTRL);
+	DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT_ERROR);
+	DUMP_REG(DC_CMD_WIN_A_INCR_SYNCPT);
+	DUMP_REG(DC_CMD_WIN_A_INCR_SYNCPT_CNTRL);
+	DUMP_REG(DC_CMD_WIN_A_INCR_SYNCPT_ERROR);
+	DUMP_REG(DC_CMD_WIN_B_INCR_SYNCPT);
+	DUMP_REG(DC_CMD_WIN_B_INCR_SYNCPT_CNTRL);
+	DUMP_REG(DC_CMD_WIN_B_INCR_SYNCPT_ERROR);
+	DUMP_REG(DC_CMD_WIN_C_INCR_SYNCPT);
+	DUMP_REG(DC_CMD_WIN_C_INCR_SYNCPT_CNTRL);
+	DUMP_REG(DC_CMD_WIN_C_INCR_SYNCPT_ERROR);
+	DUMP_REG(DC_CMD_CONT_SYNCPT_VSYNC);
+	DUMP_REG(DC_CMD_DISPLAY_COMMAND_OPTION0);
+	DUMP_REG(DC_CMD_DISPLAY_COMMAND);
+	DUMP_REG(DC_CMD_SIGNAL_RAISE);
+	DUMP_REG(DC_CMD_INT_STATUS);
+	DUMP_REG(DC_CMD_INT_MASK);
+	DUMP_REG(DC_CMD_INT_ENABLE);
+	DUMP_REG(DC_CMD_INT_TYPE);
+	DUMP_REG(DC_CMD_INT_POLARITY);
+	DUMP_REG(DC_CMD_SIGNAL_RAISE1);
+	DUMP_REG(DC_CMD_SIGNAL_RAISE2);
+	DUMP_REG(DC_CMD_SIGNAL_RAISE3);
+	DUMP_REG(DC_CMD_STATE_ACCESS);
+	DUMP_REG(DC_CMD_STATE_CONTROL);
+	DUMP_REG(DC_CMD_DISPLAY_WINDOW_HEADER);
+	DUMP_REG(DC_CMD_REG_ACT_CONTROL);
+
+	DUMP_REG(DC_DISP_DISP_SIGNAL_OPTIONS0);
+	DUMP_REG(DC_DISP_DISP_SIGNAL_OPTIONS1);
+	DUMP_REG(DC_DISP_DISP_WIN_OPTIONS);
+	DUMP_REG(DC_DISP_MEM_HIGH_PRIORITY);
+	DUMP_REG(DC_DISP_MEM_HIGH_PRIORITY_TIMER);
+	DUMP_REG(DC_DISP_DISP_TIMING_OPTIONS);
+	DUMP_REG(DC_DISP_REF_TO_SYNC);
+	DUMP_REG(DC_DISP_SYNC_WIDTH);
+	DUMP_REG(DC_DISP_BACK_PORCH);
+	DUMP_REG(DC_DISP_DISP_ACTIVE);
+	DUMP_REG(DC_DISP_FRONT_PORCH);
+	DUMP_REG(DC_DISP_H_PULSE0_CONTROL);
+	DUMP_REG(DC_DISP_H_PULSE0_POSITION_A);
+	DUMP_REG(DC_DISP_H_PULSE0_POSITION_B);
+	DUMP_REG(DC_DISP_H_PULSE0_POSITION_C);
+	DUMP_REG(DC_DISP_H_PULSE0_POSITION_D);
+	DUMP_REG(DC_DISP_H_PULSE1_CONTROL);
+	DUMP_REG(DC_DISP_H_PULSE1_POSITION_A);
+	DUMP_REG(DC_DISP_H_PULSE1_POSITION_B);
+	DUMP_REG(DC_DISP_H_PULSE1_POSITION_C);
+	DUMP_REG(DC_DISP_H_PULSE1_POSITION_D);
+	DUMP_REG(DC_DISP_H_PULSE2_CONTROL);
+	DUMP_REG(DC_DISP_H_PULSE2_POSITION_A);
+	DUMP_REG(DC_DISP_H_PULSE2_POSITION_B);
+	DUMP_REG(DC_DISP_H_PULSE2_POSITION_C);
+	DUMP_REG(DC_DISP_H_PULSE2_POSITION_D);
+	DUMP_REG(DC_DISP_V_PULSE0_CONTROL);
+	DUMP_REG(DC_DISP_V_PULSE0_POSITION_A);
+	DUMP_REG(DC_DISP_V_PULSE0_POSITION_B);
+	DUMP_REG(DC_DISP_V_PULSE0_POSITION_C);
+	DUMP_REG(DC_DISP_V_PULSE1_CONTROL);
+	DUMP_REG(DC_DISP_V_PULSE1_POSITION_A);
+	DUMP_REG(DC_DISP_V_PULSE1_POSITION_B);
+	DUMP_REG(DC_DISP_V_PULSE1_POSITION_C);
+	DUMP_REG(DC_DISP_V_PULSE2_CONTROL);
+	DUMP_REG(DC_DISP_V_PULSE2_POSITION_A);
+	DUMP_REG(DC_DISP_V_PULSE3_CONTROL);
+	DUMP_REG(DC_DISP_V_PULSE3_POSITION_A);
+	DUMP_REG(DC_DISP_M0_CONTROL);
+	DUMP_REG(DC_DISP_M1_CONTROL);
+	DUMP_REG(DC_DISP_DI_CONTROL);
+	DUMP_REG(DC_DISP_PP_CONTROL);
+	DUMP_REG(DC_DISP_PP_SELECT_A);
+	DUMP_REG(DC_DISP_PP_SELECT_B);
+	DUMP_REG(DC_DISP_PP_SELECT_C);
+	DUMP_REG(DC_DISP_PP_SELECT_D);
+	DUMP_REG(DC_DISP_DISP_CLOCK_CONTROL);
+	DUMP_REG(DC_DISP_DISP_INTERFACE_CONTROL);
+	DUMP_REG(DC_DISP_DISP_COLOR_CONTROL);
+	DUMP_REG(DC_DISP_SHIFT_CLOCK_OPTIONS);
+	DUMP_REG(DC_DISP_DATA_ENABLE_OPTIONS);
+	DUMP_REG(DC_DISP_SERIAL_INTERFACE_OPTIONS);
+	DUMP_REG(DC_DISP_LCD_SPI_OPTIONS);
+	DUMP_REG(DC_DISP_BORDER_COLOR);
+	DUMP_REG(DC_DISP_COLOR_KEY0_LOWER);
+	DUMP_REG(DC_DISP_COLOR_KEY0_UPPER);
+	DUMP_REG(DC_DISP_COLOR_KEY1_LOWER);
+	DUMP_REG(DC_DISP_COLOR_KEY1_UPPER);
+	DUMP_REG(DC_DISP_CURSOR_FOREGROUND);
+	DUMP_REG(DC_DISP_CURSOR_BACKGROUND);
+	DUMP_REG(DC_DISP_CURSOR_START_ADDR);
+	DUMP_REG(DC_DISP_CURSOR_START_ADDR_NS);
+	DUMP_REG(DC_DISP_CURSOR_POSITION);
+	DUMP_REG(DC_DISP_CURSOR_POSITION_NS);
+	DUMP_REG(DC_DISP_INIT_SEQ_CONTROL);
+	DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_A);
+	DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_B);
+	DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_C);
+	DUMP_REG(DC_DISP_SPI_INIT_SEQ_DATA_D);
+	DUMP_REG(DC_DISP_DC_MCCIF_FIFOCTRL);
+	DUMP_REG(DC_DISP_MCCIF_DISPLAY0A_HYST);
+	DUMP_REG(DC_DISP_MCCIF_DISPLAY0B_HYST);
+	DUMP_REG(DC_DISP_MCCIF_DISPLAY0C_HYST);
+	DUMP_REG(DC_DISP_MCCIF_DISPLAY1B_HYST);
+	DUMP_REG(DC_DISP_DAC_CRT_CTRL);
+	DUMP_REG(DC_DISP_DISP_MISC_CONTROL);
+
+
+	for (i = 0; i < 3; i++) {
+		print(data, "\n");
+		snprintf(buff, sizeof(buff), "WINDOW %c:\n", 'A' + i);
+		print(data, buff);
+
+		tegra_dc_writel(dc, WINDOW_A_SELECT << i,
+				DC_CMD_DISPLAY_WINDOW_HEADER);
+		DUMP_REG(DC_CMD_DISPLAY_WINDOW_HEADER);
+		DUMP_REG(DC_WIN_WIN_OPTIONS);
+		DUMP_REG(DC_WIN_BYTE_SWAP);
+		DUMP_REG(DC_WIN_BUFFER_CONTROL);
+		DUMP_REG(DC_WIN_COLOR_DEPTH);
+		DUMP_REG(DC_WIN_POSITION);
+		DUMP_REG(DC_WIN_SIZE);
+		DUMP_REG(DC_WIN_PRESCALED_SIZE);
+		DUMP_REG(DC_WIN_H_INITIAL_DDA);
+		DUMP_REG(DC_WIN_V_INITIAL_DDA);
+		DUMP_REG(DC_WIN_DDA_INCREMENT);
+		DUMP_REG(DC_WIN_LINE_STRIDE);
+		DUMP_REG(DC_WIN_BUF_STRIDE);
+		DUMP_REG(DC_WIN_BLEND_NOKEY);
+		DUMP_REG(DC_WIN_BLEND_1WIN);
+		DUMP_REG(DC_WIN_BLEND_2WIN_X);
+		DUMP_REG(DC_WIN_BLEND_2WIN_Y);
+		DUMP_REG(DC_WIN_BLEND_3WIN_XY);
+		DUMP_REG(DC_WINBUF_START_ADDR);
+		DUMP_REG(DC_WINBUF_ADDR_H_OFFSET);
+		DUMP_REG(DC_WINBUF_ADDR_V_OFFSET);
+	}
+}
+
+#undef DUMP_REG
+
+#ifdef DEBUG
+static void dump_regs_print(void *data, const char *str)
+{
+	struct tegra_dc *dc = data;
+	dev_dbg(&dc->pdev->dev, "%s", str);
+}
+
+static void dump_regs(struct tegra_dc *dc)
+{
+	_dump_regs(dc, dc, dump_regs_print);
+}
+#else
+
+static void dump_regs(struct tegra_dc *dc) {}
+
+#endif
+
+#ifdef CONFIG_DEBUG_FS
+
+static void dbg_regs_print(void *data, const char *str)
+{
+	struct seq_file *s = data;
+
+	seq_printf(s, "%s", str);
+}
+
+#undef DUMP_REG
+
+static int dbg_dc_show(struct seq_file *s, void *unused)
+{
+	struct tegra_dc *dc = s->private;
+
+	_dump_regs(dc, s, dbg_regs_print);
+
+	return 0;
+}
+
+
+static int dbg_dc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dbg_dc_show, inode->i_private);
+}
+
+static const struct file_operations dbg_fops = {
+	.open		= dbg_dc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void tegra_dc_dbg_add(struct tegra_dc *dc)
+{
+	char name[32];
+
+	snprintf(name, sizeof(name), "tegra_dc%d_regs", dc->pdev->id);
+	(void) debugfs_create_file(name, S_IRUGO, NULL, dc, &dbg_fops);
+}
+#else
+static void tegra_dc_dbg_add(struct tegra_dc *dc) {}
+
+#endif
+
+
+static int tegra_dc_add(struct tegra_dc *dc, int index)
+{
+	int ret = 0;
+
+	mutex_lock(&tegra_dc_lock);
+	if (index >= TEGRA_MAX_DC) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tegra_dcs[index] != NULL) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	tegra_dcs[index] = dc;
+
+out:
+	mutex_unlock(&tegra_dc_lock);
+
+	return ret;
+}
+
+struct tegra_dc *tegra_dc_get_dc(unsigned idx)
+{
+	if (idx < TEGRA_MAX_DC)
+		return tegra_dcs[idx];
+	else
+		return NULL;
+}
+EXPORT_SYMBOL(tegra_dc_get_dc);
+
+struct tegra_dc_win *tegra_dc_get_window(struct tegra_dc *dc, unsigned win)
+{
+	if (win >= dc->n_windows)
+		return NULL;
+
+	return &dc->windows[win];
+}
+EXPORT_SYMBOL(tegra_dc_get_window);
+
+/* does not support updating windows on multiple dcs in one call */
+int tegra_dc_update_windows(struct tegra_dc_win *windows[], int n)
+{
+	struct tegra_dc *dc;
+	unsigned long update_mask = GENERAL_ACT_REQ;
+	unsigned long val;
+	unsigned long flags;
+	int i;
+
+	dc = windows[0]->dc;
+
+	spin_lock_irqsave(&dc->lock, flags);
+	for (i = 0; i < n; i++) {
+		struct tegra_dc_win *win = windows[i];
+		unsigned h_dda;
+		unsigned v_dda;
+		unsigned stride;
+
+		tegra_dc_writel(dc, WINDOW_A_SELECT << win->idx,
+				DC_CMD_DISPLAY_WINDOW_HEADER);
+
+		update_mask |= WIN_A_ACT_REQ << win->idx;
+
+		if (!(win->flags & TEGRA_WIN_FLAG_ENABLED)) {
+			tegra_dc_writel(dc, 0, DC_WIN_WIN_OPTIONS);
+			continue;
+		}
+
+		tegra_dc_writel(dc, win->fmt, DC_WIN_COLOR_DEPTH);
+		tegra_dc_writel(dc, 0, DC_WIN_BYTE_SWAP);
+
+		stride = win->w * tegra_dc_fmt_bpp(win->fmt) / 8;
+
+		/* TODO: implement filter on settings */
+		h_dda = (win->w * 0x1000) / (win->out_w - 1);
+		v_dda = (win->h * 0x1000) / (win->out_h - 1);
+
+		tegra_dc_writel(dc,
+				V_POSITION(win->y) | H_POSITION(win->x),
+				DC_WIN_POSITION);
+		tegra_dc_writel(dc,
+				V_SIZE(win->out_h) | H_SIZE(win->out_w),
+				DC_WIN_SIZE);
+		tegra_dc_writel(dc,
+				V_PRESCALED_SIZE(win->out_h) |
+				H_PRESCALED_SIZE(stride),
+				DC_WIN_PRESCALED_SIZE);
+		tegra_dc_writel(dc, 0, DC_WIN_H_INITIAL_DDA);
+		tegra_dc_writel(dc, 0, DC_WIN_V_INITIAL_DDA);
+		tegra_dc_writel(dc, V_DDA_INC(v_dda) | H_DDA_INC(h_dda),
+				DC_WIN_DDA_INCREMENT);
+		tegra_dc_writel(dc, stride, DC_WIN_LINE_STRIDE);
+		tegra_dc_writel(dc, 0, DC_WIN_BUF_STRIDE);
+
+		val = WIN_ENABLE;
+		if (win->flags & TEGRA_WIN_FLAG_COLOR_EXPAND)
+			val |= COLOR_EXPAND;
+		tegra_dc_writel(dc, val, DC_WIN_WIN_OPTIONS);
+
+		tegra_dc_writel(dc, (unsigned long)win->phys_addr,
+				DC_WINBUF_START_ADDR);
+		tegra_dc_writel(dc, 0, DC_WINBUF_ADDR_H_OFFSET);
+		tegra_dc_writel(dc, 0, DC_WINBUF_ADDR_V_OFFSET);
+
+		win->dirty = 1;
+
+	}
+
+	tegra_dc_writel(dc, update_mask << 8, DC_CMD_STATE_CONTROL);
+
+	val = tegra_dc_readl(dc, DC_CMD_INT_ENABLE);
+	val |= FRAME_END_INT;
+	tegra_dc_writel(dc, val, DC_CMD_INT_ENABLE);
+
+	val = tegra_dc_readl(dc, DC_CMD_INT_MASK);
+	val |= FRAME_END_INT;
+	tegra_dc_writel(dc, val, DC_CMD_INT_MASK);
+
+	tegra_dc_writel(dc, update_mask, DC_CMD_STATE_CONTROL);
+	spin_unlock_irqrestore(&dc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dc_update_windows);
+
+static bool tegra_dc_windows_are_clean(struct tegra_dc_win *windows[],
+					     int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (windows[i]->dirty)
+			return false;
+	}
+
+	return true;
+}
+
+/* does not support syncing windows on multiple dcs in one call */
+int tegra_dc_sync_windows(struct tegra_dc_win *windows[], int n)
+{
+	if (n < 1 || n > DC_N_WINDOWS)
+		return -EINVAL;
+
+	return wait_event_interruptible_timeout(windows[0]->dc->wq,
+					 tegra_dc_windows_are_clean(windows, n),
+					 HZ);
+}
+EXPORT_SYMBOL(tegra_dc_sync_windows);
+
+void tegra_dc_set_blending(struct tegra_dc *dc, struct tegra_dc_blend *blend)
+{
+	int i;
+
+	for (i = 0; i < DC_N_WINDOWS; i++) {
+		tegra_dc_writel(dc, WINDOW_A_SELECT << i,
+				DC_CMD_DISPLAY_WINDOW_HEADER);
+		tegra_dc_writel(dc, blend[i].nokey, DC_WIN_BLEND_NOKEY);
+		tegra_dc_writel(dc, blend[i].one_win, DC_WIN_BLEND_1WIN);
+		tegra_dc_writel(dc, blend[i].two_win_x, DC_WIN_BLEND_2WIN_X);
+		tegra_dc_writel(dc, blend[i].two_win_y, DC_WIN_BLEND_2WIN_Y);
+		tegra_dc_writel(dc, blend[i].three_win_xy,
+				DC_WIN_BLEND_3WIN_XY);
+	}
+}
+EXPORT_SYMBOL(tegra_dc_set_blending);
+
+int tegra_dc_set_mode(struct tegra_dc *dc, struct tegra_dc_mode *mode)
+{
+	unsigned long val;
+	unsigned long rate;
+	unsigned long div;
+
+	tegra_dc_writel(dc, 0x0, DC_DISP_DISP_TIMING_OPTIONS);
+	tegra_dc_writel(dc, mode->h_ref_to_sync | (mode->v_ref_to_sync << 16),
+			DC_DISP_REF_TO_SYNC);
+	tegra_dc_writel(dc, mode->h_sync_width | (mode->v_sync_width << 16),
+			DC_DISP_SYNC_WIDTH);
+	tegra_dc_writel(dc, mode->h_back_porch | (mode->v_back_porch << 16),
+			DC_DISP_BACK_PORCH);
+	tegra_dc_writel(dc, mode->h_active | (mode->v_active << 16),
+			DC_DISP_DISP_ACTIVE);
+	tegra_dc_writel(dc, mode->h_front_porch | (mode->v_front_porch << 16),
+			DC_DISP_FRONT_PORCH);
+
+	tegra_dc_writel(dc, DE_SELECT_ACTIVE | DE_CONTROL_NORMAL,
+			DC_DISP_DATA_ENABLE_OPTIONS);
+
+	/* TODO: MIPI/CRT/HDMI clock cals */
+
+	val = DISP_DATA_FORMAT_DF1P1C;
+
+	if (dc->out->align = TEGRA_DC_ALIGN_MSB)
+		val |= DISP_DATA_ALIGNMENT_MSB;
+	else
+		val |= DISP_DATA_ALIGNMENT_LSB;
+
+	if (dc->out->order = TEGRA_DC_ORDER_RED_BLUE)
+		val |= DISP_DATA_ORDER_RED_BLUE;
+	else
+		val |= DISP_DATA_ORDER_BLUE_RED;
+
+	tegra_dc_writel(dc, val, DC_DISP_DISP_INTERFACE_CONTROL);
+
+	rate = clk_get_rate(dc->clk);
+
+	div = ((rate * 2 + mode->pclk / 2) / mode->pclk) - 2;
+
+	if (rate * 2 / (div + 2) < (mode->pclk / 100 * 99) ||
+	    rate * 2 / (div + 2) > (mode->pclk / 100 * 109)) {
+		dev_err(&dc->pdev->dev,
+			"can't divide %ld clock to %d -1/+9%% %ld %d %d\n",
+			rate, mode->pclk,
+			rate / div, (mode->pclk / 100 * 99),
+			(mode->pclk / 100 * 109));
+		return -EINVAL;
+	}
+
+	tegra_dc_writel(dc, 0x00010001,
+			DC_DISP_SHIFT_CLOCK_OPTIONS);
+	tegra_dc_writel(dc, PIXEL_CLK_DIVIDER_PCD1 | SHIFT_CLK_DIVIDER(div),
+			DC_DISP_DISP_CLOCK_CONTROL);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dc_set_mode);
+
+static void tegra_dc_set_out(struct tegra_dc *dc, struct tegra_dc_out *out)
+{
+	dc->out = out;
+
+	if (out->n_modes > 0)
+		dc->mode = &dc->out->modes[0];
+	else
+		dev_err(&dc->pdev->dev,
+			"No default modes specified.  Leaving output disabled.\n");
+
+	switch (out->type) {
+	case TEGRA_DC_OUT_RGB:
+		dc->out_ops = &tegra_dc_rgb_ops;
+		break;
+
+	default:
+		dc->out_ops = NULL;
+		break;
+	}
+}
+
+
+static irqreturn_t tegra_dc_irq(int irq, void *ptr)
+{
+	struct tegra_dc *dc = ptr;
+	unsigned long status;
+	unsigned long flags;
+	unsigned long val;
+	int i;
+
+
+	status = tegra_dc_readl(dc, DC_CMD_INT_STATUS);
+	tegra_dc_writel(dc, status, DC_CMD_INT_STATUS);
+
+	if (status & FRAME_END_INT) {
+		int completed = 0;
+		int dirty = 0;
+
+		spin_lock_irqsave(&dc->lock, flags);
+		val = tegra_dc_readl(dc, DC_CMD_STATE_CONTROL);
+		for (i = 0; i < DC_N_WINDOWS; i++) {
+			if (!(val & (WIN_A_ACT_REQ << i))) {
+				dc->windows[i].dirty = 0;
+				completed = 1;
+			} else {
+				dirty = 1;
+			}
+		}
+
+		if (!dirty) {
+			val = tegra_dc_readl(dc, DC_CMD_INT_ENABLE);
+			val &= ~FRAME_END_INT;
+			tegra_dc_writel(dc, val, DC_CMD_INT_ENABLE);
+		}
+
+		spin_unlock_irqrestore(&dc->lock, flags);
+
+		if (completed)
+			wake_up(&dc->wq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void tegra_dc_init(struct tegra_dc *dc)
+{
+	tegra_dc_writel(dc, 0x00000100, DC_CMD_GENERAL_INCR_SYNCPT_CNTRL);
+	if (dc->pdev->id = 0)
+		tegra_dc_writel(dc, 0x0000011a, DC_CMD_CONT_SYNCPT_VSYNC);
+	else if (dc->pdev->id = 1)
+		tegra_dc_writel(dc, 0x0000011b, DC_CMD_CONT_SYNCPT_VSYNC);
+	tegra_dc_writel(dc, 0x00004700, DC_CMD_INT_TYPE);
+	tegra_dc_writel(dc, 0x0001c700, DC_CMD_INT_POLARITY);
+	tegra_dc_writel(dc, 0x00000020, DC_DISP_MEM_HIGH_PRIORITY);
+	tegra_dc_writel(dc, 0x00000001, DC_DISP_MEM_HIGH_PRIORITY_TIMER);
+
+	tegra_dc_writel(dc, 0x0001c702, DC_CMD_INT_MASK);
+	tegra_dc_writel(dc, 0x0001c700, DC_CMD_INT_ENABLE);
+
+	if (dc->mode)
+		tegra_dc_set_mode(dc, dc->mode);
+
+
+	if (dc->out_ops && dc->out_ops->init)
+		dc->out_ops->init(dc);
+}
+
+static int tegra_dc_probe(struct platform_device *pdev)
+{
+	struct tegra_dc *dc;
+	struct clk *clk;
+	struct clk *host1x_clk;
+	struct resource	*res;
+	struct resource *base_res;
+	struct resource *fb_mem = NULL;
+	int ret = 0;
+	void __iomem *base;
+	int irq;
+	int i;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -ENOENT;
+	}
+
+	dc = kzalloc(sizeof(struct tegra_dc), GFP_KERNEL);
+	if (!dc) {
+		dev_err(&pdev->dev, "can't allocate memory for tegra_dc\n");
+		return -ENOMEM;
+	}
+
+	irq = platform_get_irq_byname(pdev, "irq");
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "no irq\n");
+		ret = -ENOENT;
+		goto err_free;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!res) {
+		dev_err(&pdev->dev, "no mem resource\n");
+		ret = -ENOENT;
+		goto err_free;
+	}
+
+	base_res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (!base_res) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		ret = -EBUSY;
+		goto err_free;
+	}
+
+	base = ioremap(res->start, resource_size(res));
+	if (!base) {
+		dev_err(&pdev->dev, "registers can't be mapped\n");
+		ret = -EBUSY;
+		goto err_release_resource_reg;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fbmem");
+	if (res)
+		fb_mem = request_mem_region(res->start, resource_size(res), pdev->name);
+
+	host1x_clk = clk_get(&pdev->dev, "host1x");
+	if (IS_ERR_OR_NULL(host1x_clk)) {
+		dev_err(&pdev->dev, "can't get host1x clock\n");
+		ret = -ENOENT;
+		goto err_iounmap_reg;
+	}
+	clk_enable(host1x_clk);
+
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(clk)) {
+		dev_err(&pdev->dev, "can't get clock\n");
+		ret = -ENOENT;
+
+		goto err_put_host1x_clk;
+	}
+	clk_enable(clk);
+	tegra_periph_reset_deassert(clk);
+
+	dc->clk = clk;
+	dc->host1x_clk = host1x_clk;
+	dc->base_res = base_res;
+	dc->base = base;
+	dc->irq = irq;
+	dc->pdev = pdev;
+	dc->pdata = pdev->dev.platform_data;
+	spin_lock_init(&dc->lock);
+	init_waitqueue_head(&dc->wq);
+
+
+	dc->n_windows = DC_N_WINDOWS;
+	for (i = 0; i < dc->n_windows; i++) {
+		dc->windows[i].idx = i;
+		dc->windows[i].dc = dc;
+	}
+
+	if (request_irq(irq, tegra_dc_irq, IRQF_DISABLED,
+			dev_name(&pdev->dev), dc)) {
+		dev_err(&pdev->dev, "request_irq %d failed\n", irq);
+		ret = -EBUSY;
+		goto err_put_clk;
+	}
+
+	ret = tegra_dc_add(dc, pdev->id);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "can't add dc\n");
+		goto err_free_irq;
+	}
+
+	if (dc->pdata->flags & TEGRA_DC_FLAG_ENABLED) {
+		if (dc->pdata->default_out)
+			tegra_dc_set_out(dc, dc->pdata->default_out);
+		else
+			dev_err(&pdev->dev, "No default output specified.  Leaving output disabled.\n");
+	}
+
+	tegra_dc_init(dc);
+
+	tegra_dc_set_blending(dc, tegra_dc_blend_modes[0]);
+
+	platform_set_drvdata(pdev, dc);
+
+	tegra_dc_dbg_add(dc);
+
+	dev_info(&pdev->dev, "probed\n");
+
+	if (fb_mem && dc->pdata->fb) {
+		dc->fb = tegra_fb_register(pdev, dc, dc->pdata->fb, fb_mem);
+		if (IS_ERR_OR_NULL(dc->fb))
+			dc->fb = NULL;
+	}
+
+	return 0;
+
+err_free_irq:
+	free_irq(irq, dc);
+err_put_clk:
+	clk_disable(clk);
+	clk_put(clk);
+err_put_host1x_clk:
+	clk_disable(host1x_clk);
+	clk_put(host1x_clk);
+err_iounmap_reg:
+	iounmap(base);
+	if (fb_mem)
+		release_resource(fb_mem);
+err_release_resource_reg:
+	release_resource(base_res);
+err_free:
+	kfree(dc);
+
+	return ret;
+}
+
+static int tegra_dc_remove(struct platform_device *pdev)
+{
+	struct tegra_dc *dc = platform_get_drvdata(pdev);
+
+	if (dc->fb) {
+		tegra_fb_unregister(dc->fb);
+		release_resource(dc->fb_mem);
+	}
+
+	free_irq(dc->irq, dc);
+	tegra_periph_reset_assert(dc->clk);
+	clk_disable(dc->clk);
+	clk_put(dc->clk);
+	clk_disable(dc->host1x_clk);
+	clk_put(dc->host1x_clk);
+	iounmap(dc->base);
+	release_resource(dc->base_res);
+	kfree(dc);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tegra_dc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct tegra_dc *dc = platform_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "suspend\n");
+
+	disable_irq(dc->irq);
+	tegra_periph_reset_assert(dc->clk);
+	clk_disable(dc->clk);
+
+	return 0;
+}
+
+static int tegra_dc_resume(struct platform_device *pdev)
+{
+	struct tegra_dc *dc = platform_get_drvdata(pdev);
+	struct tegra_dc_win *wins[DC_N_WINDOWS];
+	int i;
+
+	dev_info(&pdev->dev, "resume\n");
+
+	clk_enable(dc->clk);
+	tegra_periph_reset_deassert(dc->clk);
+	enable_irq(dc->irq);
+
+	for (i = 0; i < dc->n_windows; i++)
+		wins[i] = &dc->windows[i];
+
+	tegra_dc_init(dc);
+
+	tegra_dc_set_blending(dc, tegra_dc_blend_modes[0]);
+	tegra_dc_update_windows(wins, dc->n_windows);
+
+	return 0;
+}
+
+#endif
+
+extern int suspend_set(const char *val, struct kernel_param *kp)
+{
+	if (!strcmp(val, "dump"))
+		dump_regs(tegra_dcs[0]);
+#ifdef CONFIG_PM
+	else if (!strcmp(val, "suspend"))
+		tegra_dc_suspend(tegra_dcs[0]->pdev, PMSG_SUSPEND);
+	else if (!strcmp(val, "resume"))
+		tegra_dc_resume(tegra_dcs[0]->pdev);
+#endif
+
+	return 0;
+}
+
+extern int suspend_get(char *buffer, struct kernel_param *kp)
+{
+	return 0;
+}
+
+int suspend;
+
+module_param_call(suspend, suspend_set, suspend_get, &suspend, 0644);
+
+struct platform_driver tegra_dc_driver = {
+	.driver = {
+		.name = "tegradc",
+		.owner = THIS_MODULE,
+	},
+	.probe = tegra_dc_probe,
+	.remove = tegra_dc_remove,
+#ifdef CONFIG_PM
+	.suspend = tegra_dc_suspend,
+	.resume = tegra_dc_resume,
+#endif
+};
+
+static int __init tegra_dc_module_init(void)
+{
+	return platform_driver_register(&tegra_dc_driver);
+}
+
+static void __exit tegra_dc_module_exit(void)
+{
+	platform_driver_unregister(&tegra_dc_driver);
+}
+
+module_exit(tegra_dc_module_exit);
+module_init(tegra_dc_module_init);
diff --git a/drivers/video/tegra/dc/dc_priv.h b/drivers/video/tegra/dc/dc_priv.h
new file mode 100644
index 0000000..b2351b1
--- /dev/null
+++ b/drivers/video/tegra/dc/dc_priv.h
@@ -0,0 +1,86 @@
+/*
+ * drivers/video/tegra/dc/dc_priv.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Erik Gilling <konkers@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __DRIVERS_VIDEO_TEGRA_DC_DC_PRIV_H
+#define __DRIVERS_VIDEO_TEGRA_DC_DC_PRIV_H
+
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/io.h>
+
+struct tegra_dc;
+
+struct tegra_dc_out_ops {
+	void (*init)(struct tegra_dc *dc);
+};
+
+struct tegra_dc {
+	struct list_head		list;
+
+	struct platform_device		*pdev;
+	struct tegra_dc_platform_data	*pdata;
+
+	struct resource			*base_res;
+	void __iomem			*base;
+	int				irq;
+
+	struct clk			*clk;
+	struct clk			*host1x_clk;
+
+	struct tegra_dc_out		*out;
+	struct tegra_dc_out_ops		*out_ops;
+
+	struct tegra_dc_mode		*mode;
+
+	struct tegra_dc_win		windows[DC_N_WINDOWS];
+	int				n_windows;
+
+	wait_queue_head_t		wq;
+
+	spinlock_t			lock;
+
+	struct resource			*fb_mem;
+	struct tegra_fb_info		*fb;
+};
+
+static inline unsigned long tegra_dc_readl(struct tegra_dc *dc,
+					   unsigned long reg)
+{
+	return readl(dc->base + reg * 4);
+}
+
+static inline void tegra_dc_writel(struct tegra_dc *dc, unsigned long val,
+				   unsigned long reg)
+{
+	writel(val, dc->base + reg * 4);
+}
+
+static inline void _tegra_dc_write_table(struct tegra_dc *dc, const u32 *table,
+					 unsigned len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		tegra_dc_writel(dc, table[i * 2 + 1], table[i * 2]);
+}
+
+#define tegra_dc_write_table(dc, table)		\
+	_tegra_dc_write_table(dc, table, ARRAY_SIZE(table) / 2)
+
+extern struct tegra_dc_out_ops tegra_dc_rgb_ops;
+
+#endif
diff --git a/drivers/video/tegra/dc/dc_reg.h b/drivers/video/tegra/dc/dc_reg.h
new file mode 100644
index 0000000..6d6b3ba
--- /dev/null
+++ b/drivers/video/tegra/dc/dc_reg.h
@@ -0,0 +1,342 @@
+/*
+ * drivers/video/tegra/dc/dc_reg.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Erik Gilling <konkers@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __DRIVERS_VIDEO_TEGRA_DC_DC_REG_H
+#define __DRIVERS_VIDEO_TEGRA_DC_DC_REG_H
+
+#define DC_CMD_GENERAL_INCR_SYNCPT		0x000
+#define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL	0x001
+#define DC_CMD_GENERAL_INCR_SYNCPT_ERROR	0x002
+#define DC_CMD_WIN_A_INCR_SYNCPT		0x008
+#define DC_CMD_WIN_A_INCR_SYNCPT_CNTRL		0x009
+#define DC_CMD_WIN_A_INCR_SYNCPT_ERROR		0x00a
+#define DC_CMD_WIN_B_INCR_SYNCPT		0x010
+#define DC_CMD_WIN_B_INCR_SYNCPT_CNTRL		0x011
+#define DC_CMD_WIN_B_INCR_SYNCPT_ERROR		0x012
+#define DC_CMD_WIN_C_INCR_SYNCPT		0x018
+#define DC_CMD_WIN_C_INCR_SYNCPT_CNTRL		0x019
+#define DC_CMD_WIN_C_INCR_SYNCPT_ERROR		0x01a
+#define DC_CMD_CONT_SYNCPT_VSYNC		0x028
+#define DC_CMD_DISPLAY_COMMAND_OPTION0		0x031
+#define DC_CMD_DISPLAY_COMMAND			0x032
+#define  DISP_COMMAND_RAISE		(1 << 0)
+#define  DISP_CTRL_MODE_STOP		(0 << 5)
+#define  DISP_CTRL_MODE_C_DISPLAY	(1 << 5)
+#define  DISP_CTRL_MODE_NC_DISPLAY	(2 << 5)
+#define  DISP_COMMAND_RAISE_VECTOR(x)	(((x) & 0x1f) << 22)
+#define  DISP_COMMAND_RAISE_CHANNEL_ID(x)	(((x) & 0xf) << 27)
+
+#define DC_CMD_SIGNAL_RAISE			0x033
+#define DC_CMD_DISPLAY_POWER_CONTROL		0x036
+#define  PW0_ENABLE		(1 << 0)
+#define  PW1_ENABLE		(1 << 2)
+#define  PW2_ENABLE		(1 << 4)
+#define  PW3_ENABLE		(1 << 6)
+#define  PW4_ENABLE		(1 << 8)
+#define  PM0_ENABLE		(1 << 16)
+#define  PM1_ENABLE		(1 << 18)
+#define  SPI_ENABLE		(1 << 24)
+#define  HSPI_ENABLE		(1 << 25)
+
+#define DC_CMD_INT_STATUS			0x037
+#define DC_CMD_INT_MASK				0x038
+#define DC_CMD_INT_ENABLE			0x039
+#define DC_CMD_INT_TYPE				0x03a
+#define DC_CMD_INT_POLARITY			0x03b
+#define  CTXSW_INT		(1 << 0)
+#define  FRAME_END_INT		(1 << 1)
+#define  V_BLANK_INT		(1 << 2)
+#define  H_BLANK_INT		(1 << 3)
+#define  V_PULSE3_INT		(1 << 4)
+#define  SPI_BUSY_INT		(1 << 7)
+#define  WIN_A_UF_INT		(1 << 8)
+#define  WIN_B_UF_INT		(1 << 9)
+#define  WIN_C_UF_INT		(1 << 10)
+#define  MSF_INT		(1 << 12)
+#define  SSF_INT		(1 << 13)
+#define  WIN_A_OF_INT		(1 << 14)
+#define  WIN_B_OF_INT		(1 << 15)
+#define  WIN_C_OF_INT		(1 << 16)
+#define  GPIO_0_INT		(1 << 18)
+#define  GPIO_1_INT		(1 << 19)
+#define  GPIO_2_INT		(1 << 20)
+
+#define DC_CMD_SIGNAL_RAISE1			0x03c
+#define DC_CMD_SIGNAL_RAISE2			0x03d
+#define DC_CMD_SIGNAL_RAISE3			0x03e
+#define DC_CMD_STATE_ACCESS			0x040
+#define DC_CMD_STATE_CONTROL			0x041
+#define  GENERAL_ACT_REQ	(1 << 0)
+#define  WIN_A_ACT_REQ		(1 << 1)
+#define  WIN_B_ACT_REQ		(1 << 2)
+#define  WIN_C_ACT_REQ		(1 << 3)
+
+#define DC_CMD_DISPLAY_WINDOW_HEADER		0x042
+#define  WINDOW_A_SELECT		(1 << 4)
+#define  WINDOW_B_SELECT		(1 << 5)
+#define  WINDOW_C_SELECT		(1 << 6)
+
+#define DC_CMD_REG_ACT_CONTROL			0x043
+
+#define DC_COM_CRC_CONTROL			0x300
+#define DC_COM_CRC_CHECKSUM			0x301
+#define DC_COM_PIN_OUTPUT_ENABLE0		0x302
+#define DC_COM_PIN_OUTPUT_ENABLE1		0x303
+#define DC_COM_PIN_OUTPUT_ENABLE2		0x304
+#define DC_COM_PIN_OUTPUT_ENABLE3		0x305
+#define DC_COM_PIN_OUTPUT_POLARITY0		0x306
+#define DC_COM_PIN_OUTPUT_POLARITY1		0x307
+#define DC_COM_PIN_OUTPUT_POLARITY2		0x308
+#define DC_COM_PIN_OUTPUT_POLARITY3		0x309
+#define DC_COM_PIN_OUTPUT_DATA0			0x30a
+#define DC_COM_PIN_OUTPUT_DATA1			0x30b
+#define DC_COM_PIN_OUTPUT_DATA2			0x30c
+#define DC_COM_PIN_OUTPUT_DATA3			0x30d
+#define DC_COM_PIN_INPUT_ENABLE0		0x30e
+#define DC_COM_PIN_INPUT_ENABLE1		0x30f
+#define DC_COM_PIN_INPUT_ENABLE2		0x310
+#define DC_COM_PIN_INPUT_ENABLE3		0x311
+#define DC_COM_PIN_INPUT_DATA0			0x312
+#define DC_COM_PIN_INPUT_DATA1			0x313
+#define DC_COM_PIN_OUTPUT_SELECT0		0x314
+#define DC_COM_PIN_OUTPUT_SELECT1		0x315
+#define DC_COM_PIN_OUTPUT_SELECT2		0x316
+#define DC_COM_PIN_OUTPUT_SELECT3		0x317
+#define DC_COM_PIN_OUTPUT_SELECT4		0x318
+#define DC_COM_PIN_OUTPUT_SELECT5		0x319
+#define DC_COM_PIN_OUTPUT_SELECT6		0x31a
+#define DC_COM_PIN_MISC_CONTROL			0x31b
+#define DC_COM_PM0_CONTROL			0x31c
+#define DC_COM_PM0_DUTY_CYCLE			0x31d
+#define DC_COM_PM1_CONTROL			0x31e
+#define DC_COM_PM1_DUTY_CYCLE			0x31f
+#define DC_COM_SPI_CONTROL			0x320
+#define DC_COM_SPI_START_BYTE			0x321
+#define DC_COM_HSPI_WRITE_DATA_AB		0x322
+#define DC_COM_HSPI_WRITE_DATA_CD		0x323
+#define DC_COM_HSPI_CS_DC			0x324
+#define DC_COM_SCRATCH_REGISTER_A		0x325
+#define DC_COM_SCRATCH_REGISTER_B		0x326
+#define DC_COM_GPIO_CTRL			0x327
+#define DC_COM_GPIO_DEBOUNCE_COUNTER		0x328
+#define DC_COM_CRC_CHECKSUM_LATCHED		0x329
+
+#define DC_DISP_DISP_SIGNAL_OPTIONS0		0x400
+#define DC_DISP_DISP_SIGNAL_OPTIONS1		0x401
+#define DC_DISP_DISP_WIN_OPTIONS		0x402
+#define DC_DISP_MEM_HIGH_PRIORITY		0x403
+#define DC_DISP_MEM_HIGH_PRIORITY_TIMER		0x404
+#define DC_DISP_DISP_TIMING_OPTIONS		0x405
+#define DC_DISP_REF_TO_SYNC			0x406
+#define DC_DISP_SYNC_WIDTH			0x407
+#define DC_DISP_BACK_PORCH			0x408
+#define DC_DISP_DISP_ACTIVE			0x409
+#define DC_DISP_FRONT_PORCH			0x40a
+#define DC_DISP_H_PULSE0_CONTROL		0x40b
+#define DC_DISP_H_PULSE0_POSITION_A		0x40c
+#define DC_DISP_H_PULSE0_POSITION_B		0x40d
+#define DC_DISP_H_PULSE0_POSITION_C		0x40e
+#define DC_DISP_H_PULSE0_POSITION_D		0x40f
+#define DC_DISP_H_PULSE1_CONTROL		0x410
+#define DC_DISP_H_PULSE1_POSITION_A		0x411
+#define DC_DISP_H_PULSE1_POSITION_B		0x412
+#define DC_DISP_H_PULSE1_POSITION_C		0x413
+#define DC_DISP_H_PULSE1_POSITION_D		0x414
+#define DC_DISP_H_PULSE2_CONTROL		0x415
+#define DC_DISP_H_PULSE2_POSITION_A		0x416
+#define DC_DISP_H_PULSE2_POSITION_B		0x417
+#define DC_DISP_H_PULSE2_POSITION_C		0x418
+#define DC_DISP_H_PULSE2_POSITION_D		0x419
+#define DC_DISP_V_PULSE0_CONTROL		0x41a
+#define DC_DISP_V_PULSE0_POSITION_A		0x41b
+#define DC_DISP_V_PULSE0_POSITION_B		0x41c
+#define DC_DISP_V_PULSE0_POSITION_C		0x41d
+#define DC_DISP_V_PULSE1_CONTROL		0x41e
+#define DC_DISP_V_PULSE1_POSITION_A		0x41f
+#define DC_DISP_V_PULSE1_POSITION_B		0x420
+#define DC_DISP_V_PULSE1_POSITION_C		0x421
+#define DC_DISP_V_PULSE2_CONTROL		0x422
+#define DC_DISP_V_PULSE2_POSITION_A		0x423
+#define DC_DISP_V_PULSE3_CONTROL		0x424
+#define DC_DISP_V_PULSE3_POSITION_A		0x425
+#define DC_DISP_M0_CONTROL			0x426
+#define DC_DISP_M1_CONTROL			0x427
+#define DC_DISP_DI_CONTROL			0x428
+#define DC_DISP_PP_CONTROL			0x429
+#define DC_DISP_PP_SELECT_A			0x42a
+#define DC_DISP_PP_SELECT_B			0x42b
+#define DC_DISP_PP_SELECT_C			0x42c
+#define DC_DISP_PP_SELECT_D			0x42d
+#define DC_DISP_DISP_CLOCK_CONTROL		0x42e
+#define  PIXEL_CLK_DIVIDER_PCD1		(0 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD1H	(1 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD2		(2 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD3		(3 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD4		(4 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD6		(5 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD8		(6 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD9		(7 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD12	(8 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD16	(9 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD18	(10 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD24	(11 << 8)
+#define  PIXEL_CLK_DIVIDER_PCD13	(12 << 8)
+#define  SHIFT_CLK_DIVIDER(x)		((x) & 0xff)
+
+#define DC_DISP_DISP_INTERFACE_CONTROL		0x42f
+#define  DISP_DATA_FORMAT_DF1P1C	(0 << 0)
+#define  DISP_DATA_FORMAT_DF1P2C24B	(1 << 0)
+#define  DISP_DATA_FORMAT_DF1P2C18B	(2 << 0)
+#define  DISP_DATA_FORMAT_DF1P2C16B	(3 << 0)
+#define  DISP_DATA_FORMAT_DF2S		(5 << 0)
+#define  DISP_DATA_FORMAT_DF3S		(6 << 0)
+#define  DISP_DATA_FORMAT_DFSPI		(7 << 0)
+#define  DISP_DATA_FORMAT_DF1P3C24B	(8 << 0)
+#define  DISP_DATA_FORMAT_DF1P3C18B	(9 << 0)
+#define  DISP_DATA_ALIGNMENT_MSB	(0 << 8)
+#define  DISP_DATA_ALIGNMENT_LSB	(1 << 8)
+#define  DISP_DATA_ORDER_RED_BLUE	(0 << 9)
+#define  DISP_DATA_ORDER_BLUE_RED	(1 << 9)
+
+#define DC_DISP_DISP_COLOR_CONTROL		0x430
+#define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
+#define DC_DISP_DATA_ENABLE_OPTIONS		0x432
+#define   DE_SELECT_ACTIVE_BLANK	0x0
+#define   DE_SELECT_ACTIVE		0x1
+#define   DE_SELECT_ACTIVE_IS		0x2
+#define   DE_CONTROL_ONECLK		(0 << 2)
+#define   DE_CONTROL_NORMAL		(1 << 2)
+#define   DE_CONTROL_EARLY_EXT		(2 << 2)
+#define   DE_CONTROL_EARLY		(3 << 2)
+#define   DE_CONTROL_ACTIVE_BLANK	(4 << 2)
+
+#define DC_DISP_SERIAL_INTERFACE_OPTIONS	0x433
+#define DC_DISP_LCD_SPI_OPTIONS			0x434
+#define DC_DISP_BORDER_COLOR			0x435
+#define DC_DISP_COLOR_KEY0_LOWER		0x436
+#define DC_DISP_COLOR_KEY0_UPPER		0x437
+#define DC_DISP_COLOR_KEY1_LOWER		0x438
+#define DC_DISP_COLOR_KEY1_UPPER		0x439
+#define DC_DISP_CURSOR_FOREGROUND		0x43c
+#define DC_DISP_CURSOR_BACKGROUND		0x43d
+#define DC_DISP_CURSOR_START_ADDR		0x43e
+#define DC_DISP_CURSOR_START_ADDR_NS		0x43f
+#define DC_DISP_CURSOR_POSITION			0x440
+#define DC_DISP_CURSOR_POSITION_NS		0x441
+#define DC_DISP_INIT_SEQ_CONTROL		0x442
+#define DC_DISP_SPI_INIT_SEQ_DATA_A		0x443
+#define DC_DISP_SPI_INIT_SEQ_DATA_B		0x444
+#define DC_DISP_SPI_INIT_SEQ_DATA_C		0x445
+#define DC_DISP_SPI_INIT_SEQ_DATA_D		0x446
+#define DC_DISP_DC_MCCIF_FIFOCTRL		0x480
+#define DC_DISP_MCCIF_DISPLAY0A_HYST		0x481
+#define DC_DISP_MCCIF_DISPLAY0B_HYST		0x482
+#define DC_DISP_MCCIF_DISPLAY0C_HYST		0x483
+#define DC_DISP_MCCIF_DISPLAY1B_HYST		0x484
+#define DC_DISP_DAC_CRT_CTRL			0x4c0
+#define DC_DISP_DISP_MISC_CONTROL		0x4c1
+
+#define DC_WINC_COLOR_PALETTE(x)		(0x500 + (x))
+
+#define DC_WINC_PALETTE_COLOR_EXT		0x600
+#define DC_WINC_H_FILTER_P(x)			(0x601 + (x))
+#define DC_WINC_CSC_YOF				0x611
+#define DC_WINC_CSC_KYRGB			0x612
+#define DC_WINC_CSC_KUR				0x613
+#define DC_WINC_CSC_KVR				0x614
+#define DC_WINC_CSC_KUG				0x615
+#define DC_WINC_CSC_KVG				0x616
+#define DC_WINC_CSC_KUB				0x617
+#define DC_WINC_CSC_KVB				0x618
+#define DC_WINC_V_FILTER_P(x)			(0x619 + (x))
+#define DC_WIN_WIN_OPTIONS			0x700
+#define  H_DIRECTION_INCREMENT		(0 << 0)
+#define  H_DIRECTION_DECREMENTT		(1 << 0)
+#define  V_DIRECTION_INCREMENT		(0 << 2)
+#define  V_DIRECTION_DECREMENTT		(1 << 2)
+#define  COLOR_EXPAND			(1 << 6)
+#define  CP_ENABLE			(1 << 16)
+#define  DV_ENABLE			(1 << 20)
+#define  WIN_ENABLE			(1 << 30)
+
+#define DC_WIN_BYTE_SWAP			0x701
+#define  BYTE_SWAP_NOSWAP		0
+#define  BYTE_SWAP_SWAP2		1
+#define  BYTE_SWAP_SWAP4		2
+#define  BYTE_SWAP_SWAP4HW		3
+
+#define DC_WIN_BUFFER_CONTROL			0x702
+#define  BUFFER_CONTROL_HOST		0
+#define  BUFFER_CONTROL_VI		1
+#define  BUFFER_CONTROL_EPP		2
+#define  BUFFER_CONTROL_MPEGE		3
+#define  BUFFER_CONTROL_SB2D		4
+
+#define DC_WIN_COLOR_DEPTH			0x703
+
+#define DC_WIN_POSITION				0x704
+#define  H_POSITION(x)		(((x) & 0xfff) << 0)
+#define  V_POSITION(x)		(((x) & 0xfff) << 16)
+
+#define DC_WIN_SIZE				0x705
+#define  H_SIZE(x)		(((x) & 0xfff) << 0)
+#define  V_SIZE(x)		(((x) & 0xfff) << 16)
+
+#define DC_WIN_PRESCALED_SIZE			0x706
+#define  H_PRESCALED_SIZE(x)	(((x) & 0x3fff) << 0)
+#define  V_PRESCALED_SIZE(x)	(((x) & 0xfff) << 16)
+
+#define DC_WIN_H_INITIAL_DDA			0x707
+#define DC_WIN_V_INITIAL_DDA			0x708
+#define DC_WIN_DDA_INCREMENT			0x709
+#define  H_DDA_INC(x)		(((x) & 0xffff) << 0)
+#define  V_DDA_INC(x)		(((x) & 0xffff) << 16)
+
+#define DC_WIN_LINE_STRIDE			0x70a
+#define DC_WIN_BUF_STRIDE			0x70b
+#define DC_WIN_UV_BUF_STRIDE			0x70c
+#define DC_WIN_BUFFER_ADDR_MODE			0x70d
+#define DC_WIN_DV_CONTROL			0x70e
+#define DC_WIN_BLEND_NOKEY			0x70f
+#define DC_WIN_BLEND_1WIN			0x710
+#define DC_WIN_BLEND_2WIN_X			0x711
+#define DC_WIN_BLEND_2WIN_Y			0x712
+#define DC_WIN_BLEND_3WIN_XY			0x713
+#define  CKEY_NOKEY			(0 << 0)
+#define  CKEY_KEY0			(1 << 0)
+#define  CKEY_KEY1			(2 << 0)
+#define  CKEY_KEY01			(3 << 0)
+#define  BLEND_CONTROL_FIX		(0 << 2)
+#define  BLEND_CONTROL_ALPHA		(1 << 2)
+#define  BLEND_CONTROL_DEPENDANT	(2 << 2)
+#define  BLEND_WEIGHT0(x)		(((x) & 0xff) << 8)
+#define  BLEND_WEIGHT1(x)		(((x) & 0xff) << 16)
+
+#define DC_WIN_HP_FETCH_CONTROL			0x714
+#define DC_WINBUF_START_ADDR			0x800
+#define DC_WINBUF_START_ADDR_NS			0x801
+#define DC_WINBUF_START_ADDR_U			0x802
+#define DC_WINBUF_START_ADDR_U_NS		0x803
+#define DC_WINBUF_START_ADDR_V			0x804
+#define DC_WINBUF_START_ADDR_V_NS		0x805
+#define DC_WINBUF_ADDR_H_OFFSET			0x806
+#define DC_WINBUF_ADDR_H_OFFSET_NS		0x807
+#define DC_WINBUF_ADDR_V_OFFSET			0x808
+#define DC_WINBUF_ADDR_V_OFFSET_NS		0x809
+#define DC_WINBUF_UFLOW_STATUS			0x80a
+
+#endif
diff --git a/drivers/video/tegra/dc/rgb.c b/drivers/video/tegra/dc/rgb.c
new file mode 100644
index 0000000..de1a8fa
--- /dev/null
+++ b/drivers/video/tegra/dc/rgb.c
@@ -0,0 +1,63 @@
+/*
+ * drivers/video/tegra/dc/rgb.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Erik Gilling <konkers@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+
+#include <mach/dc.h>
+
+#include "dc_reg.h"
+#include "dc_priv.h"
+
+
+static const u32 tegra_dc_rgb_pintable[] = {
+	DC_COM_PIN_OUTPUT_ENABLE0,	0x00000000,
+	DC_COM_PIN_OUTPUT_ENABLE1,	0x00000000,
+	DC_COM_PIN_OUTPUT_ENABLE2,	0x00000000,
+	DC_COM_PIN_OUTPUT_ENABLE3,	0x00000000,
+	DC_COM_PIN_OUTPUT_POLARITY0,	0x00000000,
+	DC_COM_PIN_OUTPUT_POLARITY1,	0x01000000,
+	DC_COM_PIN_OUTPUT_POLARITY2,	0x00000000,
+	DC_COM_PIN_OUTPUT_POLARITY3,	0x00000000,
+	DC_COM_PIN_OUTPUT_DATA0,	0x00000000,
+	DC_COM_PIN_OUTPUT_DATA1,	0x00000000,
+	DC_COM_PIN_OUTPUT_DATA2,	0x00000000,
+	DC_COM_PIN_OUTPUT_DATA3,	0x00000000,
+	DC_COM_PIN_OUTPUT_SELECT0,	0x00000000,
+	DC_COM_PIN_OUTPUT_SELECT1,	0x00000000,
+	DC_COM_PIN_OUTPUT_SELECT2,	0x00000000,
+	DC_COM_PIN_OUTPUT_SELECT3,	0x00000000,
+	DC_COM_PIN_OUTPUT_SELECT4,	0x00210222,
+	DC_COM_PIN_OUTPUT_SELECT5,	0x00002200,
+	DC_COM_PIN_OUTPUT_SELECT6,	0x00020000,
+};
+
+
+void tegra_dc_rgb_init(struct tegra_dc *dc)
+{
+	tegra_dc_writel(dc, PW0_ENABLE | PW1_ENABLE | PW2_ENABLE | PW3_ENABLE |
+			PW4_ENABLE | PM0_ENABLE | PM1_ENABLE,
+			DC_CMD_DISPLAY_POWER_CONTROL);
+
+	tegra_dc_writel(dc, DISP_CTRL_MODE_C_DISPLAY, DC_CMD_DISPLAY_COMMAND);
+
+	tegra_dc_write_table(dc, tegra_dc_rgb_pintable);
+}
+
+struct tegra_dc_out_ops tegra_dc_rgb_ops = {
+	.init = tegra_dc_rgb_init,
+};
+
diff --git a/drivers/video/tegra/fb.c b/drivers/video/tegra/fb.c
new file mode 100644
index 0000000..4db3958
--- /dev/null
+++ b/drivers/video/tegra/fb.c
@@ -0,0 +1,311 @@
+/*
+ * drivers/video/tegra/fb.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ * Author: Erik Gilling <konkers@android.com>
+ *         Colin Cross <ccross@android.com>
+ *         Travis Geiselbrecht <travis@palm.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/fb.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include <asm/atomic.h>
+
+#include <mach/dc.h>
+#include <mach/fb.h>
+
+struct tegra_fb_info {
+	struct tegra_dc_win	*win;
+	struct platform_device	*pdev;
+	struct fb_info		*info;
+
+	struct resource		*fb_mem;
+
+	int			xres;
+	int			yres;
+
+	atomic_t		in_use;
+};
+
+/* palette array used by the fbcon */
+static u32 pseudo_palette[16];
+
+static int tegra_fb_open(struct fb_info *info, int user)
+{
+	struct tegra_fb_info *tegra_fb = info->par;
+
+	if (atomic_xchg(&tegra_fb->in_use, 1))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int tegra_fb_release(struct fb_info *info, int user)
+{
+	struct tegra_fb_info *tegra_fb = info->par;
+
+	WARN_ON(!atomic_xchg(&tegra_fb->in_use, 0));
+
+	return 0;
+}
+
+static int tegra_fb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	if ((var->xres != info->var.xres) ||
+	    (var->yres != info->var.yres) ||
+	    (var->xres_virtual != info->var.xres_virtual) ||
+	    (var->yres_virtual != info->var.yres_virtual) ||
+	    (var->grayscale != info->var.grayscale))
+		return -EINVAL;
+	return 0;
+}
+
+static int tegra_fb_set_par(struct fb_info *info)
+{
+	struct tegra_fb_info *tegra_fb = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+
+	/* we only support RGB ordering for now */
+	switch (var->bits_per_pixel) {
+	case 32:
+	case 24:
+		var->red.offset = 0;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 16;
+		var->blue.length = 8;
+		tegra_fb->win->fmt = TEGRA_WIN_FMT_R8G8B8A8;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 5;
+		tegra_fb->win->fmt = TEGRA_WIN_FMT_B5G6R5;
+		break;
+	default:
+		return -EINVAL;
+	}
+	info->fix.line_length = var->xres * var->bits_per_pixel / 8;
+
+	tegra_dc_update_windows(&tegra_fb->win, 1);
+
+	return 0;
+}
+
+static int tegra_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
+	unsigned blue, unsigned transp, struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+
+	if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
+		u32 v;
+
+		if (regno >= 16)
+			return -EINVAL;
+
+		v = (red << var->red.offset) |
+			(green << var->green.offset) |
+			(blue << var->blue.offset);
+
+		((u32 *)info->pseudo_palette)[regno] = v;
+	}
+
+	return 0;
+}
+
+static int tegra_fb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info *info)
+{
+	struct tegra_fb_info *tegra_fb = info->par;
+	char __iomem *flush_start;
+	char __iomem *flush_end;
+	u32 addr;
+
+	flush_start = info->screen_base + (var->yoffset * info->fix.line_length);
+	flush_end = flush_start + (var->yres * info->fix.line_length);
+
+	info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
+
+	addr = info->fix.smem_start + (var->yoffset * info->fix.line_length) +
+		(var->xoffset * (var->bits_per_pixel/8));
+
+	tegra_fb->win->phys_addr = addr;
+	/* TODO: update virt_addr */
+
+	tegra_dc_update_windows(&tegra_fb->win, 1);
+	tegra_dc_sync_windows(&tegra_fb->win, 1);
+
+	return 0;
+}
+
+static void tegra_fb_fillrect(struct fb_info *info,
+			      const struct fb_fillrect *rect)
+{
+	cfb_fillrect(info, rect);
+}
+
+static void tegra_fb_copyarea(struct fb_info *info,
+			      const struct fb_copyarea *region)
+{
+	cfb_copyarea(info, region);
+}
+
+static void tegra_fb_imageblit(struct fb_info *info,
+			       const struct fb_image *image)
+{
+	cfb_imageblit(info, image);
+}
+
+static struct fb_ops tegra_fb_ops = {
+	.owner = THIS_MODULE,
+	.fb_open = tegra_fb_open,
+	.fb_release = tegra_fb_release,
+	.fb_check_var = tegra_fb_check_var,
+	.fb_set_par = tegra_fb_set_par,
+	.fb_setcolreg = tegra_fb_setcolreg,
+	.fb_pan_display = tegra_fb_pan_display,
+	.fb_fillrect = tegra_fb_fillrect,
+	.fb_copyarea = tegra_fb_copyarea,
+	.fb_imageblit = tegra_fb_imageblit,
+};
+
+struct tegra_fb_info *tegra_fb_register(struct platform_device *pdev,
+					struct tegra_dc *dc,
+					struct tegra_fb_data *fb_data,
+					struct resource *fb_mem)
+{
+	struct tegra_dc_win *win;
+	struct fb_info *info;
+	struct tegra_fb_info *tegra_fb;
+	void __iomem *fb_base;
+	unsigned long fb_size;
+	unsigned long fb_phys;
+	int ret = 0;
+
+	win = tegra_dc_get_window(dc, fb_data->win);
+	if (!win) {
+		dev_err(&pdev->dev, "dc does not have a window at index %d\n",
+			fb_data->win);
+		return ERR_PTR(-ENOENT);
+	}
+
+	info = framebuffer_alloc(sizeof(struct tegra_fb_info), &pdev->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	fb_size = resource_size(fb_mem);
+	fb_phys = fb_mem->start;
+	fb_base = ioremap_nocache(fb_phys, fb_size);
+	if (!fb_base) {
+		dev_err(&pdev->dev, "fb can't be mapped\n");
+		ret = -EBUSY;
+		goto err_free;
+	}
+
+	tegra_fb = info->par;
+	tegra_fb->win = win;
+	tegra_fb->pdev = pdev;
+	tegra_fb->fb_mem = fb_mem;
+	tegra_fb->xres = fb_data->xres;
+	tegra_fb->yres = fb_data->yres;
+	atomic_set(&tegra_fb->in_use, 0);
+
+	info->fbops = &tegra_fb_ops;
+	info->pseudo_palette = pseudo_palette;
+	info->screen_base = fb_base;
+	info->screen_size = fb_size;
+
+	strlcpy(info->fix.id, "tegra_fb", sizeof(info->fix.id));
+	info->fix.type		= FB_TYPE_PACKED_PIXELS;
+	info->fix.visual	= FB_VISUAL_TRUECOLOR;
+	info->fix.xpanstep	= 1;
+	info->fix.ypanstep	= 1;
+	info->fix.accel		= FB_ACCEL_NONE;
+	info->fix.smem_start	= fb_phys;
+	info->fix.smem_len	= fb_size;
+
+	info->var.xres			= fb_data->xres;
+	info->var.yres			= fb_data->yres;
+	info->var.xres_virtual		= fb_data->xres;
+	info->var.yres_virtual		= fb_data->yres*2;
+	info->var.bits_per_pixel	= fb_data->bits_per_pixel;
+	info->var.activate		= FB_ACTIVATE_VBL;
+	/* TODO: fill in the following by querying the DC */
+	info->var.height		= -1;
+	info->var.width			= -1;
+	info->var.pixclock		= 24500;
+	info->var.left_margin		= 0;
+	info->var.right_margin		= 0;
+	info->var.upper_margin		= 0;
+	info->var.lower_margin		= 0;
+	info->var.hsync_len		= 0;
+	info->var.vsync_len		= 0;
+	info->var.vmode			= FB_VMODE_NONINTERLACED;
+
+	win->x = 0;
+	win->y = 0;
+	win->w = fb_data->xres;
+	win->h = fb_data->yres;
+	/* TODO: set to output res dc */
+	win->out_w = fb_data->xres;
+	win->out_h = fb_data->yres;
+	win->phys_addr = fb_phys;
+	win->virt_addr = fb_base;
+	win->flags = TEGRA_WIN_FLAG_ENABLED | TEGRA_WIN_FLAG_COLOR_EXPAND;
+
+	tegra_fb_set_par(info);
+
+	if (register_framebuffer(info)) {
+		dev_err(&pdev->dev, "failed to register framebuffer\n");
+		ret = -ENODEV;
+		goto err_iounmap_fb;
+	}
+
+	tegra_fb->info = info;
+
+	dev_info(&pdev->dev, "probed\n");
+
+	return tegra_fb;
+
+err_iounmap_fb:
+	iounmap(fb_base);
+err_free:
+	framebuffer_release(info);
+err:
+	return ERR_PTR(ret);
+}
+
+void tegra_fb_unregister(struct tegra_fb_info *fb_info)
+{
+	struct fb_info *info = fb_info->info;
+
+	unregister_framebuffer(info);
+	iounmap(info->screen_base);
+	framebuffer_release(info);
+}
-- 
1.6.5.6

