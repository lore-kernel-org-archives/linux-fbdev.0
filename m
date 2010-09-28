From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 28 Sep 2010 02:05:27 +0000
Subject: [PATCH v3 2/3] S5PV210: MIPI-DSI: add machine specific header files
Message-Id: <1285639527-22061-1-git-send-email-dh09.lee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds several machine specific header files that including
necessary structures and dsim device setup codes.

struct dsim_config
- define clock info, data lane count and video mode info for MIPI-DSI
Controller.

struct dsim_lcd_config
- define interface mode, channel ID, Pixel format and so on.

struct s5p_platform_dsim
- define callbacks for initializing D-PHY, MIPI reset and trigger
releated interfaces of s3c-fb.c file.

struct mipi_ddi_platform_data
- define following callbacks.
- a function for transferring and receiving command data to mipi based
  lcd panel.
- a function for getting framedone status of mipi-dsi controller.
- a function for clearing framedone interrupt of mipi-dsi controller.
- a function for checking i80 framedone status of display controller.(fimd)
- a function for triggering to display controller.(fimd)

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: InKi Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |    1 +
 arch/arm/plat-samsung/Makefile                  |    3 +
 arch/arm/plat-samsung/dev-dsim.c                |  149 ++++++++
 arch/arm/plat-samsung/include/plat/dsim.h       |  447 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/mipi_ddi.h   |   98 +++++
 arch/arm/plat-samsung/include/plat/regs-dsim.h  |  281 ++++++++++++++
 arch/arm/plat-samsung/setup-dsim.c              |  144 ++++++++
 7 files changed, 1123 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-dsim.c
 create mode 100644 arch/arm/plat-samsung/include/plat/dsim.h
 create mode 100644 arch/arm/plat-samsung/include/plat/mipi_ddi.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-dsim.h
 create mode 100644 arch/arm/plat-samsung/setup-dsim.c

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 499aef7..083c32d 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -164,6 +164,7 @@
 
 /* MIPI */
 #define S5P_MIPI_DPHY_EN		(3)
+#define S5P_MIPI_M_RESETN		(1 << 1)
 
 /* S5P_DAC_CONTROL */
 #define S5P_DAC_ENABLE			(1)
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4d8ff92..bb7e6e1 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -54,6 +54,9 @@ obj-$(CONFIG_SAMSUNG_DEV_IDE)	+= dev-ide.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
 obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)	+= dev-keypad.o
 
+# Device setup - MIPI-DSI
+obj-$(CONFIG_S5P_MIPI_DSI)	+= setup-dsim.o
+
 # DMA support
 
 obj-$(CONFIG_S3C_DMA)		+= dma.o
diff --git a/arch/arm/plat-samsung/dev-dsim.c b/arch/arm/plat-samsung/dev-dsim.c
new file mode 100644
index 0000000..5bac5ef
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-dsim.c
@@ -0,0 +1,149 @@
+/* linux/arch/arm/plat-s5pc11x/dev-dsim.c
+ *
+ * Copyright 2009 Samsung Electronics
+ *	InKi Dae <inki.dae@samsung.com>
+ *
+ * S5PC1XX series device definition for MIPI-DSIM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/fb.h>
+
+#include <mach/map.h>
+#include <asm/irq.h>
+
+#include <plat/devs.h>
+#include <plat/cpu.h>
+#include <plat/fb.h>
+
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+
+static struct dsim_config dsim_info = {
+	/* main frame fifo auto flush at VSYNC pulse */
+	.auto_flush = false,
+	.eot_disable = false,
+
+	.auto_vertical_cnt = false,
+	.hse = false,
+	.hfp = false,
+	.hbp = false,
+	.hsa = false,
+
+	.e_no_data_lane = DSIM_DATA_LANE_2,
+	.e_byte_clk = DSIM_PLL_OUT_DIV8,
+
+	/*
+	 * =====================+	 * |    P    |    M    |    S    |    MHz    |
+	 * -------------------------------------------
+	 * |    3    |   100   |    3    |    100    |
+	 * |    3    |   100   |    2    |    200    |
+	 * |    3    |    63   |    1    |    252    |
+	 * |    4    |   100   |    1    |    300    |
+	 * |    4    |   110   |    1    |    330    |
+	 * |   12    |   350   |    1    |    350    |
+	 * |    3    |   100   |    1    |    400    |
+	 * |    4    |   150   |    1    |    450    |
+	 * |    3    |   118   |    1    |    472    |
+	 * |   12    |   250   |    0    |    500    |
+	 * |    4    |   100   |    0    |    600    |
+	 * |    3    |    81   |    0    |    648    |
+	 * |    3    |    88   |    0    |    704    |
+	 * |    3    |    90   |    0    |    720    |
+	 * |    3    |   100   |    0    |    800    |
+	 * |   12    |   425   |    0    |    850    |
+	 * |    4    |   150   |    0    |    900    |
+	 * |   12    |   475   |    0    |    950    |
+	 * |    6    |   250   |    0    |   1000    |
+	 * -------------------------------------------
+	 */
+
+	/* 472MHz: LSI Recommended */
+	.p = 3,
+	.m = 118,
+	.s = 1,
+
+	/* D-PHY PLL stable time spec :min = 200usec ~ max 400usec */
+	.pll_stable_time = 500,
+
+	.esc_clk = 10 * 1000000,	/* escape clk : 10MHz */
+
+	/* stop state holding counter after bta change count 0 ~ 0xfff */
+	.stop_holding_cnt = 0x0f,
+	.bta_timeout = 0xff,		/* bta timeout 0 ~ 0xff */
+	.rx_timeout = 0xffff,		/* lp rx timeout 0 ~ 0xffff */
+
+	.e_lane_swap = DSIM_NO_CHANGE,
+};
+
+/* define ddi platform data based on MIPI-DSI. */
+static struct mipi_ddi_platform_data mipi_ddi_pd = {
+	.cmd_write			= s5p_dsim_wr_data,
+	.cmd_read			= NULL,
+	.get_dsim_frame_done		= s5p_dsim_get_frame_done_status,
+	.clear_dsim_frame_done		= s5p_dsim_clear_frame_done,
+	.change_dsim_transfer_mode	= s5p_dsim_change_transfer_mode,
+	.get_fb_frame_done		= s3c_fb_is_i80_frame_done,
+	.trigger			= s3c_fb_set_trigger,
+};
+
+static struct dsim_lcd_config dsim_lcd_info = {
+	.e_interface			= DSIM_COMMAND,
+	.parameter[DSI_VIRTUAL_CH_ID]	= (unsigned int)DSIM_VIRTUAL_CH_0,
+	.parameter[DSI_FORMAT]		= (unsigned int)DSIM_24BPP_888,
+	.parameter[DSI_VIDEO_MODE_SEL]	= (unsigned int)DSIM_BURST,
+	.mipi_ddi_pd			= (void *)&mipi_ddi_pd,
+};
+
+static struct resource s5p_dsim_resource[] = {
+	[0] = {
+		.start = S5PV210_PA_DSIM,
+		.end   = S5PV210_PA_DSIM + S5PV210_SZ_DSIM - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_MIPI_DSI,
+		.end   = IRQ_MIPI_DSI,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s5p_platform_dsim dsim_platform_data = {
+	.clk_name		= "dsim",
+	.mipi_1_1v_name		= "VMIPI_1.1V",
+	.mipi_1_8v_name		= "VMIPI_1.8V",
+	.dsim_info		= &dsim_info,
+	.dsim_lcd_info		= &dsim_lcd_info,
+
+	.mipi_power		= s5p_dsim_mipi_power,
+	.part_reset		= s5p_dsim_part_reset,
+	.init_d_phy		= s5p_dsim_init_d_phy,
+	.get_fb_frame_done	= s3c_fb_is_i80_frame_done,
+	.trigger		= s3c_fb_set_trigger,
+
+	.platform_rev		= 1,
+
+	/*
+	 * the stable time of needing to write data on SFR
+	 * when the mipi mode becomes LP mode.
+	 */
+	.delay_for_stabilization = 600,
+};
+
+struct platform_device s5p_device_dsim = {
+	.name			= "s5p-dsim",
+	.id			= 0,
+	.num_resources		= ARRAY_SIZE(s5p_dsim_resource),
+	.resource		= s5p_dsim_resource,
+	.dev			= {
+		.platform_data = (void *)&dsim_platform_data,
+	},
+};
diff --git a/arch/arm/plat-samsung/include/plat/dsim.h b/arch/arm/plat-samsung/include/plat/dsim.h
new file mode 100644
index 0000000..9c1d6a3
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/dsim.h
@@ -0,0 +1,447 @@
+/* linux/arm/arch/mach-s5pc110/include/mach/dsim.h
+ *
+ * Platform data header for Samsung MIPI-DSIM.
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ * InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _DSIM_H
+#define _DSIM_H
+
+#include <linux/device.h>
+
+/* h/w configuration */
+#define MIPI_FIN		24000000
+#define DSIM_TIMEOUT_MS		5000
+#define DSIM_NO_OF_INTERRUPT	26
+
+#define DSIM_TRUE		1
+#define DSIM_FALSE		0
+
+#define DSIM_HEADER_FIFO_SZ	16
+
+enum dsim_interface_type {
+	DSIM_COMMAND = 0,
+	DSIM_VIDEO = 1,
+};
+
+enum dsim_state {
+	DSIM_STATE_RESET = 0,
+	DSIM_STATE_INIT = 1,
+	DSIM_STATE_STOP = 2,
+	DSIM_STATE_HSCLKEN = 3,
+	DSIM_STATE_ULPS = 4,
+};
+
+enum dsim_virtual_ch_no {
+	DSIM_VIRTUAL_CH_0 = 0,
+	DSIM_VIRTUAL_CH_1 = 1,
+	DSIM_VIRTUAL_CH_2 = 2,
+	DSIM_VIRTUAL_CH_3 = 3,
+};
+
+enum dsim_video_mode_type {
+	DSIM_NON_BURST_SYNC_EVENT = 0,
+	DSIM_NON_BURST_SYNC_PULSE = 2,
+	DSIM_BURST = 3,
+	DSIM_NON_VIDEO_MODE = 4,
+};
+
+enum dsim_fifo_state {
+	DSIM_RX_DATA_FULL = (1 << 25),
+	DSIM_RX_DATA_EMPTY = (1 << 24),
+	SFR_HEADER_FULL = (1 << 23),
+	SFR_HEADER_EMPTY = (1 << 22),
+	SFR_PAYLOAD_FULL = (1 << 21),
+	SFR_PAYLOAD_EMPTY = (1 << 20),
+	I80_HEADER_FULL = (1 << 19),
+	I80_HEADER_EMPTY = (1 << 18),
+	I80_PALOAD_FULL = (1 << 17),
+	I80_PALOAD_EMPTY = (1 << 16),
+	SUB_DISP_HEADER_FULL = (1 << 15),
+	SUB_DISP_HEADER_EMPTY = (1 << 14),
+	SUB_DISP_PAYLOAD_FULL = (1 << 13),
+	SUB_DISP_PAYLOAD_EMPTY = (1 << 12),
+	MAIN_DISP_HEADER_FULL = (1 << 11),
+	MAIN_DISP_HEADER_EMPTY = (1 << 10),
+	MAIN_DISP_PAYLOAD_FULL = (1 << 9),
+	MAIN_DISP_PAYLOAD_EMPTY = (1 << 8),
+};
+
+enum dsim_no_of_data_lane {
+	DSIM_DATA_LANE_1 = 0,
+	DSIM_DATA_LANE_2 = 1,
+	DSIM_DATA_LANE_3 = 2,
+	DSIM_DATA_LANE_4 = 3,
+};
+
+enum dsim_byte_clk_src {
+	DSIM_PLL_OUT_DIV8 = 0,
+	DSIM_EXT_CLK_DIV8 = 1,
+	DSIM_EXT_CLK_BYPASS = 2,
+};
+
+enum dsim_lane {
+	DSIM_LANE_DATA0 = (1 << 0),
+	DSIM_LANE_DATA1 = (1 << 1),
+	DSIM_LANE_DATA2 = (1 << 2),
+	DSIM_LANE_DATA3 = (1 << 3),
+	DSIM_LANE_DATA_ALL = 0xf,
+	DSIM_LANE_CLOCK = (1 << 4),
+	DSIM_LANE_ALL = DSIM_LANE_CLOCK | DSIM_LANE_DATA_ALL,
+};
+
+enum dsim_pixel_format {
+	DSIM_CMD_3BPP = 0,
+	DSIM_CMD_8BPP = 1,
+	DSIM_CMD_12BPP = 2,
+	DSIM_CMD_16BPP = 3,
+	DSIM_VID_16BPP_565 = 4,
+	DSIM_VID_18BPP_666PACKED = 5,
+	DSIM_18BPP_666LOOSELYPACKED = 6,
+	DSIM_24BPP_888 = 7,
+};
+
+enum dsim_lane_state {
+	DSIM_LANE_STATE_HS_READY,
+	DSIM_LANE_STATE_ULPS,
+	DSIM_LANE_STATE_STOP,
+	DSIM_LANE_STATE_LPDT,
+};
+
+enum dsim_transfer {
+	DSIM_TRANSFER_NEITHER	= 0,
+	DSIM_TRANSFER_BYCPU	= (1 << 7),
+	DSIM_TRANSFER_BYLCDC	= (1 << 6),
+	DSIM_TRANSFER_BOTH	= (0x3 << 6)
+};
+
+enum dsim_lane_change {
+	DSIM_NO_CHANGE = 0,
+	DSIM_DATA_LANE_CHANGE = 1,
+	DSIM_CLOCK_NALE_CHANGE = 2,
+	DSIM_ALL_LANE_CHANGE = 3,
+};
+
+enum dsim_int_src {
+	DSIM_ALL_OF_INTR = 0xffffffff,
+	DSIM_PLL_STABLE = (1 << 31),
+};
+
+/**
+ * struct dsim_config - interface for configuring mipi-dsi controller.
+ *
+ * @auto_flush: enable or disable Auto flush of MD FIFO using VSYNC pulse.
+ * @eot_disable: enable or disable EoT packet in HS mode.
+ * @auto_vertical_cnt: specifies auto vertical count mode.
+ *	in Video mode, the vertical line transition uses line counter
+ *	configured by VSA, VBP, and Vertical resolution.
+ *	If this bit is set to '1', the line counter does not use VSA and VBP
+ *	registers.(in command mode, this variable is ignored)
+ * @hse: set horizontal sync event mode.
+ *	In VSYNC pulse and Vporch area, MIPI DSI master transfers only HSYNC
+ *	start packet to MIPI DSI slave at MIPI DSI spec1.1r02.
+ *	this bit transfers HSYNC end packet in VSYNC pulse and Vporch area
+ *	(in mommand mode, this variable is ignored)
+ * @hfp: specifies HFP disable mode.
+ *	if this variable is set, DSI master ignores HFP area in VIDEO mode.
+ *	(in command mode, this variable is ignored)
+ * @hbp: specifies HBP disable mode.
+ *	if this variable is set, DSI master ignores HBP area in VIDEO mode.
+ *	(in command mode, this variable is ignored)
+ * @hsa: specifies HSA disable mode.
+ *	if this variable is set, DSI master ignores HSA area in VIDEO mode.
+ *	(in command mode, this variable is ignored)
+ * @e_no_data_lane: specifies data lane count to be used by Master.
+ * @e_byte_clk: select byte clock source. (it must be DSIM_PLL_OUT_DIV8)
+ *	DSIM_EXT_CLK_DIV8 and DSIM_EXT_CLK_BYPASSS are not supported.
+ * @pll_stable_time: specifies the PLL Timer for stability of the ganerated
+ *	clock(System clock cycle base)
+ *	if the timer value goes to 0x00000000, the clock stable bit of status
+ *	and interrupt register is set.
+ * @esc_clk: specifies escape clock frequency for getting the escape clock
+ *	prescaler value.
+ * @stop_holding_cnt: specifies the interval value between transmitting
+ *	read packet(or write "set_tear_on" command) and BTA request.
+ *	after transmitting read packet or write "set_tear_on" command,
+ *	BTA requests to D-PHY automatically. this counter value specifies
+ *	the interval between them.
+ * @bta_timeout: specifies the timer for BTA.
+ *	this register specifies time out from BTA request to change
+ *	the direction with respect to Tx escape clock.
+ * @rx_timeout: specifies the timer for LP Rx mode timeout.
+ *	this register specifies time out on how long RxValid deasserts,
+ *	after RxLpdt asserts with respect to Tx escape clock.
+ *	- RxValid specifies Rx data valid indicator.
+ *	- RxLpdt specifies an indicator that D-PHY is under RxLpdt mode.
+ *	- RxValid and RxLpdt specifies signal from D-PHY.
+ * @e_lane_swap: swaps Dp/Dn channel of Clock lane or Data lane.
+ *	if this bit is set, Dp and Dn channel would be swapped each other.
+ */
+struct dsim_config {
+	unsigned char auto_flush;
+	unsigned char eot_disable;
+
+	unsigned char auto_vertical_cnt;
+	unsigned char hse;
+	unsigned char hfp;
+	unsigned char hbp;
+	unsigned char hsa;
+
+	enum dsim_no_of_data_lane e_no_data_lane;
+	enum dsim_byte_clk_src e_byte_clk;
+
+	/*
+	 * =====================+	 * |    P    |    M    |    S    |    MHz    |
+	 * -------------------------------------------
+	 * |    3    |   100   |    3    |    100    |
+	 * |    3    |   100   |    2    |    200    |
+	 * |    3    |    63   |    1    |    252    |
+	 * |    4    |   100   |    1    |    300    |
+	 * |    4    |   110   |    1    |    330    |
+	 * |   12    |   350   |    1    |    350    |
+	 * |    3    |   100   |    1    |    400    |
+	 * |    4    |   150   |    1    |    450    |
+	 * |    3    |   118   |    1    |    472    |
+	 * |   12    |   250   |    0    |    500    |
+	 * |    4    |   100   |    0    |    600    |
+	 * |    3    |    81   |    0    |    648    |
+	 * |    3    |    88   |    0    |    704    |
+	 * |    3    |    90   |    0    |    720    |
+	 * |    3    |   100   |    0    |    800    |
+	 * |   12    |   425   |    0    |    850    |
+	 * |    4    |   150   |    0    |    900    |
+	 * |   12    |   475   |    0    |    950    |
+	 * |    6    |   250   |    0    |   1000    |
+	 * -------------------------------------------
+	 */
+	unsigned char p;
+	unsigned short m;
+	unsigned char s;
+
+	unsigned int pll_stable_time;
+	unsigned long esc_clk;
+
+	unsigned short stop_holding_cnt;
+	unsigned char bta_timeout;
+	unsigned short rx_timeout;
+	enum dsim_video_mode_type e_lane_swap;
+};
+
+/**
+ * struct dsim_lcd_config - interface for configuring mipi-dsi based lcd panel.
+ *
+ * @e_interface: specifies interface to be used.(CPU or RGB interface)
+ * @parameter[0]: specifies virtual channel number
+ *	that main or sub diaplsy uses.
+ * @parameter[1]: specifies pixel stream format for main or sub display.
+ * @parameter[2]: selects Burst mode in Video mode.
+ *	in Non-burst mode, RGB data area is filled with RGB data and NULL
+ *	packets, according to input bandwidth of RGB interface.
+ *	In Burst mode, RGB data area is filled with RGB data only.
+ * @lcd_panel_info: pointer for lcd panel specific structure.
+ *	this structure specifies width, height, timing and polarity and so on.
+ * @mipi_ddi_pd: pointer for lcd panel platform data.
+ */
+struct dsim_lcd_config {
+	enum dsim_interface_type e_interface;
+	unsigned int parameter[3];
+
+	void *lcd_panel_info;
+	void *mipi_ddi_pd;
+};
+
+struct dsim_global;
+struct fb_info;
+struct regulator;
+
+/**
+ * struct s5p_platform_dsim - interface to platform data for mipi-dsi driver.
+ *
+ * @clk_name: specifies clock name for mipi-dsi.
+ * @lcd_panel_name: specifies lcd panel name registered to mipi-dsi driver.
+ *	lcd panel driver searched would be actived.
+ * @mipi_1_1v_name: specifies mipi 1.1v regulator name.
+ * @mipi_1_8v_name: specifies mipi 1.8v regulator name.
+ * @platfrom_rev: specifies platform revision number.
+ *	revision number should become 1.
+ * @dsim_config: pointer of structure for configuring mipi-dsi controller.
+ * @dsim_lcd_info: pointer to structure for configuring
+ *	mipi-dsi based lcd panel.
+ * @mipi_power: callback pointer for enabling or disabling mipi power.
+ * @part_reset: callback pointer for reseting mipi phy.
+ * @init_d_phy: callback pointer for enabing d_phy of dsi master.
+ * @get_fb_frame_done: callback pointer for getting frame done status of the
+ *	display controller(FIMD).
+ * @trigger: callback pointer for triggering display controller(FIMD)
+ *	in case of CPU mode.
+ * @delay_for_stabilization: specifies stable time.
+ *	this delay needs when writing data on SFR
+ *	after mipi mode became LP mode.
+ */
+struct s5p_platform_dsim {
+	char	*clk_name;
+	char	*mipi_1_1v_name;
+	char	*mipi_1_8v_name;
+	char	lcd_panel_name[64];
+	unsigned int platform_rev;
+
+	struct dsim_config *dsim_info;
+	struct dsim_lcd_config *dsim_lcd_info;
+
+	unsigned int delay_for_stabilization;
+
+	int (*mipi_power) (struct dsim_global *dsim,
+		struct regulator *p_mipi_1_1v,
+		struct regulator *p_mipi_1_8v, unsigned int enable);
+	int (*part_reset) (struct dsim_global *dsim);
+	int (*init_d_phy) (struct dsim_global *dsim);
+	int (*get_fb_frame_done) (struct fb_info *info);
+	void (*trigger) (struct fb_info *info);
+};
+
+/**
+ * struct dsim_global - global interface for mipi-dsi driver.
+ *
+ * @dev: driver model representation of the device.
+ * @clock: pointer to MIPI-DSI clock of clock framework.
+ * @irq: interrupt number to MIPI-DSI controller.
+ * @reg_base: base address to memory mapped SRF of MIPI-DSI controller.
+ *	(virtual address)
+ * @r_mipi_1_1v: pointer to regulator for MIPI 1.1v power.
+ * @r_mipi_1_8v: pointer to regulator for MIPI 1.8v power.
+ * @pd: pointer to MIPI-DSI driver platform data.
+ * @dsim_lcd_info: pointer to structure for configuring
+ *	mipi-dsi based lcd panel.
+ * @lcd_panel_info: pointer for lcd panel specific structure.
+ *	this structure specifies width, height, timing and polarity and so on.
+ * @mipi_ddi_pd: pointer for lcd panel platform data.
+ * @mipi_drv: pointer to driver structure for mipi-dsi based lcd panel.
+ * @s3cfb_notif: kernel notifier structure to be registered
+ *	by device specific framebuffer driver.
+ *	this notifier could be used by fb_blank of device specifiec
+ *	framebuffer driver.
+ * @state: specifies status of MIPI-DSI controller.
+ *	the status could be RESET, INIT, STOP, HSCLKEN and ULPS.
+ * @data_lane: specifiec enabled data lane number.
+ *	this variable would be set by driver according to e_no_data_lane
+ *	automatically.
+ * @e_clk_src: select byte clock source.
+ *	this variable would be set by driver according to e_byte_clock
+ *	automatically.
+ * @hs_clk: HS clock rate.
+ *	this variable would be set by driver automatically.
+ * @byte_clk: Byte clock rate.
+ *	this variable would be set by driver automatically.
+ * @escape_clk: ESCAPE clock rate.
+ *	this variable would be set by driver automatically.
+ * @freq_band: indicates Bitclk frequency band for D-PHY global timing.
+ *	Serial Clock(=ByteClk X 8)		FreqBand[3:0]
+ *		~ 99.99 MHz				0000
+ *		100 ~ 119.99 MHz			0001
+ *		120 ~ 159.99 MHz			0010
+ *		160 ~ 199.99 MHz			0011
+ *		200 ~ 239.99 MHz			0100
+ *		140 ~ 319.99 MHz			0101
+ *		320 ~ 389.99 MHz			0110
+ *		390 ~ 449.99 MHz			0111
+ *		450 ~ 509.99 MHz			1000
+ *		510 ~ 559.99 MHz			1001
+ *		560 ~ 639.99 MHz			1010
+ *		640 ~ 689.99 MHz			1011
+ *		690 ~ 769.99 MHz			1100
+ *		770 ~ 869.99 MHz			1101
+ *		870 ~ 949.99 MHz			1110
+ *		950 ~ 1000 MHz				1111
+ *	this variable would be calculated by driver automatically.
+ *
+ * @header_fifo_index: specifies header fifo index.
+ *	this variable is not used yet.
+ */
+struct dsim_global {
+	struct device *dev;
+	struct clk *clock;
+	unsigned int irq;
+	void __iomem *reg_base;
+
+	struct regulator *r_mipi_1_1v;
+	struct regulator *r_mipi_1_8v;
+
+	struct s5p_platform_dsim *pd;
+	struct dsim_config *dsim_info;
+	struct dsim_lcd_config *dsim_lcd_info;
+	struct fb_videomode *lcd_panel_info;
+	struct mipi_ddi_platform_data *mipi_ddi_pd;
+	struct mipi_lcd_driver *mipi_drv;
+	struct notifier_block s3cfb_notif;
+
+	unsigned char state;
+	unsigned int data_lane;
+	enum dsim_byte_clk_src e_clk_src;
+	unsigned long hs_clk;
+	unsigned long byte_clk;
+	unsigned long escape_clk;
+	unsigned char freq_band;
+
+	char header_fifo_index[DSIM_HEADER_FIFO_SZ];
+};
+
+/*
+ * driver structure for mipi-dsi based lcd panel.
+ *
+ * this structure should be registered by lcd panel driver.
+ * mipi-dsi driver seeks lcd panel registered through name field
+ * and calls these callback functions in appropriate time.
+ */
+struct mipi_lcd_driver {
+	s8	*name;
+
+	s32	(*init)(struct device *dev);
+	void	(*display_on)(struct device *dev);
+	s32	(*set_link)(struct mipi_ddi_platform_data *pd);
+	s32	(*probe)(struct device *dev);
+	s32	(*remove)(struct device *dev);
+	void	(*shutdown)(struct device *dev);
+	s32	(*suspend)(struct device *dev);
+	s32	(*resume)(struct device *dev);
+};
+
+/*
+ * register mipi_lcd_driver object defined by lcd panel driver
+ * to mipi-dsi driver.
+ */
+extern int s5p_dsim_register_lcd_driver(struct mipi_lcd_driver *lcd_drv);
+
+/* reset MIPI PHY through MIPI PHY CONTROL REGISTER. */
+extern int s5p_dsim_part_reset(struct dsim_global *dsim);
+
+/* enable MIPI D-PHY and DSI Master block. */
+extern int s5p_dsim_init_d_phy(struct dsim_global *dsim);
+
+struct regulator;
+
+/* enable regulators to MIPI-DSI power. */
+extern int s5p_dsim_mipi_power(struct dsim_global *dsim,
+	struct regulator *p_mipi_1_1v, struct regulator *p_mipi_1_8v,
+	unsigned int enable);
+
+/* send commands to mipi based lcd panel. */
+extern int s5p_dsim_wr_data(void *dsim_data, unsigned int data_id,
+	unsigned int data0, unsigned int data1);
+
+/* get framedone status of mipi-dsi controller. */
+extern int s5p_dsim_get_frame_done_status(void *dsim_data);
+
+/* clear framedone interrupt of mipi-dsi controller. */
+extern int s5p_dsim_clear_frame_done(void *dsim_data);
+
+/* wrapper function for changing transfer mode. */
+extern int s5p_dsim_change_transfer_mode(unsigned int mode);
+
+#endif /* _DSIM_H */
diff --git a/arch/arm/plat-samsung/include/plat/mipi_ddi.h b/arch/arm/plat-samsung/include/plat/mipi_ddi.h
new file mode 100644
index 0000000..d9a82b7
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/mipi_ddi.h
@@ -0,0 +1,98 @@
+/* linux/arm/arch/mach-s5pc110/include/mach/mipi_ddi.h
+ *
+ * definitions for DDI based MIPI-DSI.
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ * InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _MIPI_DDI_H
+#define _MIPI_DDI_H
+
+enum mipi_ddi_interface {
+	RGB_IF = 0x4000,
+	I80_IF = 0x8000,
+	YUV_601 = 0x10000,
+	YUV_656 = 0x20000,
+	MIPI_VIDEO = 0x1000,
+	MIPI_COMMAND = 0x2000,
+};
+
+enum mipi_ddi_panel_select {
+	DDI_MAIN_LCD = 0,
+	DDI_SUB_LCD = 1,
+};
+
+enum mipi_ddi_model {
+	S6DR117 = 0,
+};
+
+enum mipi_ddi_parameter {
+	/* DSIM video interface parameter */
+	DSI_VIRTUAL_CH_ID = 0,
+	DSI_FORMAT = 1,
+	DSI_VIDEO_MODE_SEL = 2,
+};
+
+struct lcd_device;
+struct fb_info;
+
+struct mipi_ddi_platform_data {
+	void *dsim_data;
+	/*
+	 * it is used for command mode lcd panel and
+	 * when all contents of framebuffer in panel module are transfered
+	 * to lcd panel it occurs te signal.
+	 *
+	 * note:
+	 * - in case of command mode(cpu mode), it should be triggered only
+	 *   when TE signal of lcd panel and frame done interrupt of display
+	 *   controller or mipi controller occurs.
+	 */
+	unsigned int te_irq;
+
+	/*
+	 * it is used for PM stable time at te interrupt handler and
+	 * could be used according to lcd panel characteristic or not.
+	 */
+	unsigned int resume_complete;
+
+	int (*lcd_reset) (struct lcd_device *ld);
+	int (*lcd_power_on) (struct lcd_device *ld, int enable);
+	int (*backlight_on) (int enable);
+
+	/* transfer command to lcd panel at LP mode. */
+	int (*cmd_write) (void *dsim_data, unsigned int data_id,
+		unsigned int data0, unsigned int data1);
+	int (*cmd_read) (void *dsim_data, unsigned int data_id,
+		unsigned int data0, unsigned int data1);
+	/*
+	 * get the status that all screen data have been transferred
+	 * to mipi-dsi.
+	 */
+	int (*get_dsim_frame_done) (void *dsim_data);
+	int (*clear_dsim_frame_done) (void *dsim_data);
+
+	/*
+	 * changes mipi transfer mode to LP or HS mode.
+	 *
+	 * LP mode needs when some commands like gamma values transfers
+	 * to lcd panel.
+	 */
+	int (*change_dsim_transfer_mode) (unsigned int mode);
+
+	/* get frame done status of display controller. */
+	int (*get_fb_frame_done) (struct fb_info *info);
+	/* trigger display controller in case of cpu mode. */
+	void (*trigger) (struct fb_info *info);
+
+	unsigned int reset_delay;
+	unsigned int power_on_delay;
+	unsigned int power_off_delay;
+};
+
+#endif /* _MIPI_DDI_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-dsim.h b/arch/arm/plat-samsung/include/plat/regs-dsim.h
new file mode 100644
index 0000000..dc83089
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-dsim.h
@@ -0,0 +1,281 @@
+/* linux/arch/arm/plat-s5pc11x/include/plat/regs-dsim.h
+ *
+ * Register definition file for Samsung MIPI-DSIM driver
+ *
+ * InKi Dae <inki.dae@samsung.com>, Copyright (c) 2009 Samsung Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _REGS_DSIM_H
+#define _REGS_DSIM_H
+
+#define S5P_DSIM_STATUS		(0x0)	/* Status register */
+#define S5P_DSIM_SWRST		(0x4)	/* Software reset register */
+#define S5P_DSIM_CLKCTRL	(0x8)	/* Clock control register */
+#define S5P_DSIM_TIMEOUT	(0xc)	/* Time out register */
+#define S5P_DSIM_CONFIG		(0x10)	/* Configuration register */
+#define S5P_DSIM_ESCMODE	(0x14)	/* Escape mode register */
+
+/* Main display image resolution register */
+#define S5P_DSIM_MDRESOL	(0x18)
+#define S5P_DSIM_MVPORCH	(0x1c)	/* Main display Vporch register */
+#define S5P_DSIM_MHPORCH	(0x20)	/* Main display Hporch register */
+#define S5P_DSIM_MSYNC		(0x24)	/* Main display sync area register */
+
+/* Sub display image resolution register */
+#define S5P_DSIM_SDRESOL	(0x28)
+#define S5P_DSIM_INTSRC		(0x2c)	/* Interrupt source register */
+#define S5P_DSIM_INTMSK		(0x30)	/* Interrupt mask register */
+#define S5P_DSIM_PKTHDR		(0x34)	/* Packet Header FIFO register */
+#define S5P_DSIM_PAYLOAD	(0x38)	/* Payload FIFO register */
+#define S5P_DSIM_RXFIFO		(0x3c)	/* Read FIFO register */
+#define S5P_DSIM_FIFOTHLD	(0x40)	/* FIFO threshold level register */
+#define S5P_DSIM_FIFOCTRL	(0x44)	/* FIFO status and control register */
+
+/* FIFO memory AC characteristic register */
+#define S5P_DSIM_MEMACCHR	(0x48)
+#define S5P_DSIM_PLLCTRL	(0x4c)	/* PLL control register */
+#define S5P_DSIM_PLLTMR		(0x50)	/* PLL timer register */
+#define S5P_DSIM_PHYACCHR	(0x54)	/* D-PHY AC characteristic register */
+#define S5P_DSIM_PHYACCHR1	(0x58)	/* D-PHY AC characteristic register1 */
+
+/* DSIM_SWRST */
+#define DSIM_FUNCRST		(1 << 16)
+#define DSIM_SWRST		(1 << 0)
+
+/* S5P_DSIM_TIMEOUT */
+#define DSIM_LPDR_TOUT_SHIFT	(0)
+#define DSIM_BTA_TOUT_SHIFT	(16)
+#define DSIM_LPDR_TOUT(x)	(((x) & 0xffff) << DSIM_LPDR_TOUT_SHIFT)
+#define DSIM_BTA_TOUT(x)	(((x) & 0xff) << DSIM_BTA_TOUT_SHIFT)
+
+/* S5P_DSIM_CLKCTRL */
+#define DSIM_ESC_PRESCALER_SHIFT	(0)
+#define DSIM_LANE_ESC_CLKEN_SHIFT	(19)
+#define DSIM_BYTE_CLKEN_SHIFT		(24)
+#define DSIM_BYTE_CLK_SRC_SHIFT		(25)
+#define DSIM_PLL_BYPASS_SHIFT		(27)
+#define DSIM_ESC_CLKEN_SHIFT		(28)
+#define DSIM_TX_REQUEST_HSCLK_SHIFT	(31)
+#define DSIM_ESC_PRESCALER(x)		(((x) & 0xffff) << \
+						DSIM_ESC_PRESCALER_SHIFT)
+#define DSIM_LANE_ESC_CLKEN(x)		(((x) & 0x1f) << \
+						DSIM_LANE_ESC_CLKEN_SHIFT)
+#define DSIM_BYTE_CLK_ENABLE		(1 << DSIM_BYTE_CLKEN_SHIFT)
+#define DSIM_BYTE_CLK_DISABLE		(0 << DSIM_BYTE_CLKEN_SHIFT)
+#define DSIM_BYTE_CLKSRC(x)		(((x) & 0x3) << DSIM_BYTE_CLK_SRC_SHIFT)
+#define DSIM_PLL_BYPASS_PLL		(0 << DSIM_PLL_BYPASS_SHIFT)
+#define DSIM_PLL_BYPASS_EXTERNAL	(1 << DSIM_PLL_BYPASS_SHIFT)
+#define DSIM_ESC_CLKEN_ENABLE		(1 << DSIM_ESC_CLKEN_SHIFT)
+#define DSIM_ESC_CLKEN_DISABLE		(0 << DSIM_ESC_CLKEN_SHIFT)
+
+/* S5P_DSIM_CONFIG */
+#define DSIM_LANE_EN_SHIFT		(0)
+#define DSIM_NUM_OF_DATALANE_SHIFT	(5)
+#define DSIM_SUB_PIX_FORMAT_SHIFT	(8)
+#define DSIM_MAIN_PIX_FORMAT_SHIFT	(12)
+#define DSIM_SUB_VC_SHIFT		(16)
+#define DSIM_MAIN_VC_SHIFT		(18)
+#define DSIM_HSA_MODE_SHIFT		(20)
+#define DSIM_HBP_MODE_SHIFT		(21)
+#define DSIM_HFP_MODE_SHIFT		(22)
+#define DSIM_HSE_MODE_SHIFT		(23)
+#define DSIM_AUTO_MODE_SHIFT		(24)
+#define DSIM_VIDEO_MODE_SHIFT		(25)
+#define DSIM_BURST_MODE_SHIFT		(26)
+#define DSIM_SYNC_INFORM_SHIFT		(27)
+#define DSIM_EOT_R03_SHIFT		(28)
+#define DSIM_LANE_ENx(x)		((1) << x)
+
+/* in case of Gemunus, it should be 0x1. */
+#define DSIM_NUM_OF_DATA_LANE(x)	((x) << 5)
+#define DSIM_SUB_PIX_FORMAT_3BPP	(0 << 8)	/* command mode only */
+#define DSIM_SUB_PIX_FORMAT_8BPP	(1 << 8)	/* command mode only */
+#define DSIM_SUB_PIX_FORMAT_12BPP	(2 << 8)	/* command mode only */
+#define DSIM_SUB_PIX_FORMAT_16BPP	(3 << 8)	/* command mode only */
+#define DSIM_SUB_PIX_FORMAT_16BPP_RGB	(4 << 8)	/* video mode only */
+#define DSIM_SUB_PIX_FORMAT_18BPP_PRGB	(5 << 8)	/* video mode only */
+#define DSIM_SUB_PIX_FORMAT_18BPP_LRGB	(6 << 8)	/* common */
+#define DSIM_SUB_PIX_FORMAT_24BPP_RGB	(7 << 8)	/* common */
+#define DSIM_MAIN_PIX_FORMAT_3BPP	(0 << 12)	/* command mode only */
+#define DSIM_MAIN_PIX_FORMAT_8BPP	(1 << 12)	/* command mode only */
+#define DSIM_MAIN_PIX_FORMAT_12BPP	(2 << 12)	/* command mode only */
+#define DSIM_MAIN_PIX_FORMAT_16BPP	(3 << 12)	/* command mode only */
+#define DSIM_MAIN_PIX_FORMAT_16BPP_RGB	(4 << 12)	/* video mode only */
+#define DSIM_MAIN_PIX_FORMAT_18BPP_PRGB	(5 << 12)	/* video mode only */
+#define DSIM_MAIN_PIX_FORMAT_18BPP_LRGB	(6 << 12)	/* common */
+#define DSIM_MAIN_PIX_FORMAT_24BPP_RGB	(7 << 12)	/* common */
+
+/* Virtual channel number for sub display */
+#define DSIM_SUB_VC(x)			(((x) & 0x3) << 16)
+/* Virtual channel number for main display */
+#define DSIM_MAIN_VC(x)			(((x) & 0x3) << 18)
+#define DSIM_HSA_MODE_ENABLE		(1 << 20)
+#define DSIM_HSA_MODE_DISABLE		(0 << 20)
+#define DSIM_HBP_MODE_ENABLE		(1 << 21)
+#define DSIM_HBP_MODE_DISABLE		(0 << 21)
+#define DSIM_HFP_MODE_ENABLE		(1 << 22)
+#define DSIM_HFP_MODE_DISABLE		(0 << 22)
+#define DSIM_HSE_MODE_ENABLE		(1 << 23)
+#define DSIM_HSE_MODE_DISABLE		(0 << 23)
+#define DSIM_AUTO_MODE			(1 << 24)
+#define DSIM_CONFIGURATION_MODE		(0 << 24)
+#define DSIM_VIDEO_MODE			(1 << 25)
+#define DSIM_COMMAND_MODE		(0 << 25)
+#define DSIM_BURST_MODE			(1 << 26)
+#define DSIM_NON_BURST_MODE		(0 << 26)
+#define DSIM_SYNC_INFORM_PULSE		(1 << 27)
+#define DSIM_SYNC_INFORM_EVENT		(0 << 27)
+/* enable EoT packet generation for V1.01r11 */
+#define DSIM_EOT_R03_ENABLE		(0 << 28)
+/* disable EoT packet generation for V1.01r03 */
+#define DSIM_EOT_R03_DISABLE		(1 << 28)
+
+/* S5P_DSIM_ESCMODE */
+#define DSIM_STOP_STATE_CNT_SHIFT	(21)
+#define DSIM_STOP_STATE_CNT(x)		(((x) & 0x3ff) << \
+						DSIM_STOP_STATE_CNT_SHIFT)
+#define DSIM_FORCE_STOP_STATE_SHIFT	(20)
+#define DSIM_FORCE_BTA_SHIFT		(16)
+#define DSIM_CMD_LPDT_HS_MODE		(0 << 7)
+#define DSIM_CMD_LPDT_LP_MODE		(1 << 7)
+#define DSIM_TX_LPDT_HS_MODE		(0 << 6)
+#define DSIM_TX_LPDT_LP_MODE		(1 << 6)
+#define DSIM_TX_TRIGGER_RST_SHIFT	(4)
+#define DSIM_TX_UIPS_DAT_SHIFT		(3)
+#define DSIM_TX_UIPS_EXIT_SHIFT		(2)
+#define DSIM_TX_UIPS_CLK_SHIFT		(1)
+#define DSIM_TX_UIPS_CLK_EXIT_SHIFT	(0)
+
+/* S5P_DSIM_MDRESOL */
+#define DSIM_MAIN_STAND_BY		(1 << 31)
+#define DSIM_MAIN_NOT_READY		(0 << 31)
+#define DSIM_MAIN_VRESOL(x)		(((x) & 0x7ff) << 16)
+#define DSIM_MAIN_HRESOL(x)		(((x) & 0X7ff) << 0)
+
+/* S5P_DSIM_MVPORCH */
+#define DSIM_CMD_ALLOW_SHIFT		(28)
+#define DSIM_STABLE_VFP_SHIFT		(16)
+#define DSIM_MAIN_VBP_SHIFT		(0)
+#define DSIM_CMD_ALLOW_MASK		(0xf << DSIM_CMD_ALLOW_SHIFT)
+#define DSIM_STABLE_VFP_MASK		(0x7ff << DSIM_STABLE_VFP_SHIFT)
+#define DSIM_MAIN_VBP_MASK		(0x7ff << DSIM_MAIN_VBP_SHIFT)
+#define DSIM_CMD_ALLOW(x)		(((x) & 0xf) << DSIM_CMD_ALLOW_SHIFT)
+#define DSIM_STABLE_VFP(x)		(((x) & 0x7ff) << DSIM_STABLE_VFP_SHIFT)
+#define DSIM_MAIN_VBP(x)		(((x) & 0x7ff) << DSIM_MAIN_VBP_SHIFT)
+
+/* S5P_DSIM_MHPORCH */
+#define DSIM_MAIN_HFP_SHIFT		(16)
+#define DSIM_MAIN_HBP_SHIFT		(0)
+#define DSIM_MAIN_HFP_MASK		((0xffff) << DSIM_MAIN_HFP_SHIFT)
+#define DSIM_MAIN_HBP_MASK		((0xffff) << DSIM_MAIN_HBP_SHIFT)
+#define DSIM_MAIN_HFP(x)		(((x) & 0xffff) << DSIM_MAIN_HFP_SHIFT)
+#define DSIM_MAIN_HBP(x)		(((x) & 0xffff) << DSIM_MAIN_HBP_SHIFT)
+
+/* S5P_DSIM_MSYNC */
+#define DSIM_MAIN_VSA_SHIFT		(22)
+#define DSIM_MAIN_HSA_SHIFT		(0)
+#define DSIM_MAIN_VSA_MASK		((0x3ff) << DSIM_MAIN_VSA_SHIFT)
+#define DSIM_MAIN_HSA_MASK		((0xffff) << DSIM_MAIN_HSA_SHIFT)
+#define DSIM_MAIN_VSA(x)		(((x) & 0x3ff) << DSIM_MAIN_VSA_SHIFT)
+#define DSIM_MAIN_HSA(x)		(((x) & 0xffff) << DSIM_MAIN_HSA_SHIFT)
+
+/* S5P_DSIM_SDRESOL */
+#define DSIM_SUB_STANDY_SHIFT		(31)
+#define DSIM_SUB_VRESOL_SHIFT		(16)
+#define DSIM_SUB_HRESOL_SHIFT		(0)
+#define DSIM_SUB_STANDY_MASK		((0x1) << DSIM_SUB_STANDY_SHIFT)
+#define DSIM_SUB_VRESOL_MASK		((0x7ff) << DSIM_SUB_VRESOL_SHIFT)
+#define DSIM_SUB_HRESOL_MASK		((0x7ff) << DSIM_SUB_HRESOL_SHIFT)
+#define DSIM_SUB_STANDY			(1 << DSIM_SUB_STANDY_SHIFT)
+#define DSIM_SUB_NOT_READY		(0 << DSIM_SUB_STANDY_SHIFT)
+#define DSIM_SUB_VRESOL(x)		(((x) & 0x7ff) << DSIM_SUB_VRESOL_SHIFT)
+#define DSIM_SUB_HRESOL(x)		(((x) & 0x7ff) << DSIM_SUB_HRESOL_SHIFT)
+
+/* S5P_DSIM_INTSRC */
+#define INTSRC_ERR_CONTENT_LP1		(1 << 0)
+#define INTSRC_ERR_CONTENT_LP0		(1 << 1)
+#define INTSRC_ERR_CONTROL0		(1 << 2)
+#define INTSRC_ERR_CONTROL1		(1 << 3)
+#define INTSRC_ERR_CONTROL2		(1 << 4)
+#define INTSRC_ERR_CONTROL3		(1 << 5)
+#define INTSRC_ERR_SYNC0		(1 << 6)
+#define INTSRC_ERR_SYNC1		(1 << 7)
+#define INTSRC_ERR_SYNC2		(1 << 8)
+#define INTSRC_ERR_SYNC3		(1 << 9)
+#define INTSRC_ERR_ESC0			(1 << 10)
+#define INTSRC_ERR_ESC1			(1 << 11)
+#define INTSRC_ERR_ESC2			(1 << 12)
+#define INTSRC_ERR_ESC3			(1 << 13)
+#define INTSRC_ERR_RX_CRC		(1 << 14)
+#define INTSRC_ERR_RX_ECC		(1 << 15)
+#define INTSRC_RX_ACK			(1 << 16)
+#define INTSRC_RX_TE			(1 << 17)
+#define INTSRC_RX_DAT_DONE		(1 << 18)
+#define INTSRC_TA_TOUT			(1 << 20)
+#define INTSRC_LPDR_TOUT		(1 << 21)
+#define INTSRC_FRAME_DONE		(1 << 24)
+#define INTSRC_BUS_TURN_OVER		(1 << 25)
+#define INTSRC_SYNC_OVERRIDE		(1 << 28)
+#define INTSRC_SFR_FIFO_EMPTY		(1 << 29)
+#define INTSRC_SW_RST_RELEASE		(1 << 30)
+#define INTSRC_PLL_STABLE		(1 << 31)
+
+/* S5P_DSIM_INTMSK */
+#define INTMSK_ERR_CONTENT_LP1		(1 << 0)
+#define INTMSK_ERR_CONTENT_LP0		(1 << 1)
+#define INTMSK_ERR_CONTROL0		(1 << 2)
+#define INTMSK_ERR_CONTROL1		(1 << 3)
+#define INTMSK_ERR_CONTROL2		(1 << 4)
+#define INTMSK_ERR_CONTROL3		(1 << 5)
+#define INTMSK_ERR_SYNC0		(1 << 6)
+#define INTMSK_ERR_SYNC1		(1 << 7)
+#define INTMSK_ERR_SYNC2		(1 << 8)
+#define INTMSK_ERR_SYNC3		(1 << 9)
+#define INTMSK_ERR_ESC0			(1 << 10)
+#define INTMSK_ERR_ESC1			(1 << 11)
+#define INTMSK_ERR_ESC2			(1 << 12)
+#define INTMSK_ERR_ESC3			(1 << 13)
+#define INTMSK_ERR_RX_CRC		(1 << 14)
+#define INTMSK_ERR_RX_ECC		(1 << 15)
+#define INTMSK_RX_ACK			(1 << 16)
+#define INTMSK_RX_TE			(1 << 17)
+#define INTMSK_RX_DAT_DONE		(1 << 18)
+#define INTMSK_TA_TOUT			(1 << 20)
+#define INTMSK_LPDR_TOUT		(1 << 21)
+#define INTMSK_FRAME_DONE		(1 << 24)
+#define INTMSK_BUS_TURN_OVER		(1 << 25)
+#define INTMSK_SFR_FIFO_EMPTY		(1 << 29)
+#define INTMSK_SW_RST_RELEASE		(1 << 30)
+#define INTMSK_PLL_STABLE		(1 << 31)
+
+/* S5P_DSIM_PKTHDR */
+#define DSIM_PACKET_HEADER_DI(x)	(((x) & 0xff) << 0)
+/* Word count lower byte for long packet */
+#define DSIM_PACKET_HEADER_DAT0(x)	(((x) & 0xff) << 8)
+/* Word count upper byte for long packet */
+#define DSIM_PACKET_HEADER_DAT1(x)	(((x) & 0xff) << 16)
+
+/* S5P_DSIM_FIFOCTRL */
+#define DSIM_RX_FIFO			(1 << 4)
+#define DSIM_TX_SFR_FIFO		(1 << 3)
+#define DSIM_I80_FIFO			(1 << 2)
+#define DSIM_SUB_DISP_FIFO		(1 << 1)
+#define DSIM_MAIN_DISP_FIFO		(1 << 0)
+
+/* S5P_DSIM_PHYACCHR */
+#define DSIM_AFC_CTL(x)			(((x) & 0x7) << 5)
+#define DSIM_AFC_ENABLE			(1 << 14)
+#define DSIM_AFC_DISABLE		(0 << 14)
+
+/* S5P_DSIM_PLLCTRL */
+#define DSIM_PMS_SHIFT			(1)
+#define DSIM_PLL_EN_SHIFT		(23)
+#define DSIM_FREQ_BAND_SHIFT		(24)
+#define DSIM_PMS(x)			(((x) & 0x7ffff) << DSIM_PMS_SHIFT)
+#define DSIM_FREQ_BAND(x)		(((x) & 0xf) << DSIM_FREQ_BAND_SHIFT)
+
+#endif /* _REGS_DSIM_H */
diff --git a/arch/arm/plat-samsung/setup-dsim.c b/arch/arm/plat-samsung/setup-dsim.c
new file mode 100644
index 0000000..874efa0
--- /dev/null
+++ b/arch/arm/plat-samsung/setup-dsim.c
@@ -0,0 +1,144 @@
+/*
+ * S5PC110 MIPI-DSIM driver.
+ *
+ * Author: InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/dsim.h>
+#include <plat/clock.h>
+#include <plat/regs-dsim.h>
+
+static int s5p_dsim_enable_d_phy(struct dsim_global *dsim, unsigned int enable)
+{
+	unsigned int reg;
+
+	WARN_ON(dsim = NULL);
+
+	reg = readl(S5P_MIPI_CONTROL) & ~(1 << 0);
+	reg |= (enable << 0);
+	writel(reg, S5P_MIPI_CONTROL);
+
+	dev_dbg(dsim->dev, "%s : %x\n", __func__, reg);
+
+	return 0;
+}
+
+static int s5p_dsim_enable_dsi_master(struct dsim_global *dsim,
+	unsigned int enable)
+{
+	unsigned int reg;
+
+	WARN_ON(dsim = NULL);
+
+	reg = readl(S5P_MIPI_CONTROL) & ~(1 << 2);
+	reg |= (enable << 2);
+	writel(reg, S5P_MIPI_CONTROL);
+
+	dev_dbg(dsim->dev, "%s : %x\n", __func__, reg);
+
+	return 0;
+}
+
+int s5p_dsim_part_reset(struct dsim_global *dsim)
+{
+	WARN_ON(dsim = NULL);
+
+	writel(S5P_MIPI_M_RESETN, S5P_MIPI_PHY_CON0);
+
+	dev_dbg(dsim->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+int s5p_dsim_init_d_phy(struct dsim_global *dsim)
+{
+	WARN_ON(dsim = NULL);
+
+	/**
+	 * DPHY and Master block must be enabled at the system initialization
+	 * step before data access from/to DPHY begins.
+	 */
+	s5p_dsim_enable_d_phy(dsim, 1);
+
+	s5p_dsim_enable_dsi_master(dsim, 1);
+
+	dev_dbg(dsim->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+int s5p_dsim_mipi_power(struct dsim_global *dsim, struct regulator *p_mipi_1_1v,
+	struct regulator *p_mipi_1_8v, unsigned int enable)
+{
+	int ret = -1;
+
+	WARN_ON(dsim = NULL);
+
+	if (IS_ERR(p_mipi_1_1v) || IS_ERR(p_mipi_1_8v)) {
+		dev_err(dsim->dev, "p_mipi_1_1v or p_mipi_1_8v is NULL.\n");
+		return -EINVAL;
+	}
+
+	if (enable) {
+		if (p_mipi_1_1v)
+			ret = regulator_enable(p_mipi_1_1v);
+
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to enable regulator mipi_1_1v.\n");
+			return ret;
+		}
+
+		if (p_mipi_1_8v)
+			ret = regulator_enable(p_mipi_1_8v);
+
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to enable regulator mipi_1_8v.\n");
+			return ret;
+		}
+	} else {
+		if (p_mipi_1_1v)
+			ret = regulator_force_disable(p_mipi_1_1v);
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to disable regulator mipi_1_1v.\n");
+			return ret;
+		}
+
+		if (p_mipi_1_8v)
+			ret = regulator_force_disable(p_mipi_1_8v);
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to disable regulator mipi_1_8v.\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
-- 
1.6.0.4

