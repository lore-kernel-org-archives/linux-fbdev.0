From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 15:34:16 +0000
Subject: [PATCH 3/3] S5PV210: Add MIPI-DSI Driver.
Message-Id: <alpine.LFD.2.00.1007061633430.3285@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1007061631580.3285@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1007061631580.3285@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


this patch addes MIPI-DSI Driver.

to use this driver, some structures below should be added to machine specific
file.

struct dsim_config
- define clock info, data lane count and video mode info for MIPI-DSI
Controller.

struct dsim_lcd_config
- define interface mode, channel ID, Pixel format and so on.

struct s5p_platform_dsim
- define callbacks for initializing D-PHY, MIPI reset and trigger releated
interfaces of s3c-fb.c file.

Signed-off-by: InKi Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
b/arch/arm/mach-s5pv210/include/mach/regs-clock.h

index 2a25ab4..f716678 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -162,6 +162,7 @@
 
 /* MIPI */
 #define S5P_MIPI_DPHY_EN		(3)
+#define S5P_MIPI_M_RESETN		(1 << 1)
 
 /* S5P_DAC_CONTROL */
 #define S5P_DAC_ENABLE			(1)
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..3cd43f2 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -49,6 +49,9 @@ obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
 obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
 
+# Device setup - MIPI-DSI
+obj-$(CONFIG_S5P_MIPI_DSI)  += setup-dsim.o
+
 # DMA support
 
 obj-$(CONFIG_S3C_DMA)		+= dma.o
diff --git a/arch/arm/plat-samsung/include/plat/dsim.h b/arch/arm/plat-samsung/i
nclude/plat/dsim.h
new file mode 100644
index 0000000..28bc595
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/dsim.h
@@ -0,0 +1,470 @@
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
+#define DSIM_PM_STABLE_TIME	10
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
+enum {
+	DSIM_NONE_STATE = 0,
+	DSIM_RESUME_COMPLETE = 1,
+	DSIM_FRAME_DONE = 2,
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
+enum dsim_data_id {
+	/* short packet types of packet types for command */
+	GEN_SHORT_WR_NO_PARA	= 0x03,
+	GEN_SHORT_WR_1_PARA	= 0x13,
+	GEN_SHORT_WR_2_PARA	= 0x23,
+	GEN_RD_NO_PARA		= 0x04,
+	GEN_RD_1_PARA		= 0x14,
+	GEN_RD_2_PARA		= 0x24,
+	DCS_WR_NO_PARA		= 0x05,
+	DCS_WR_1_PARA		= 0x15,
+	DCS_RD_NO_PARA		= 0x06,
+	SET_MAX_RTN_PKT_SIZE	= 0x37,
+
+	/* long packet types of packet types for command */
+	NULL_PKT		= 0x09,
+	BLANKING_PKT		= 0x19,
+	GEN_LONG_WR		= 0x29,
+	DCS_LONG_WR		= 0x39,
+
+	/* short packet types of generic command */
+	CMD_OFF			= 0x02,
+	CMD_ON			= 0x12,
+	SHUT_DOWN		= 0x22,
+	TURN_ON			= 0x32,
+
+	/* short packet types for video data */
+	VSYNC_START		= 0x01,
+	VSYNC_END		= 0x11,
+	HSYNC_START		= 0x21,
+	HSYNC_END		= 0x31,
+	EOT_PKT			= 0x08,
+
+	/* long packet types for video data */
+	RGB565_PACKED		= 0x0e,
+	RGB666_PACKED		= 0x1e,
+	RGB666_LOOSLY		= 0x2e,
+	RGB888_PACKED		= 0x3e,
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
+
+/**
+ * struct s5p_platform_dsim - interface to platform data for mipi-dsi driver.
+ *
+ * @clk_name: specifies clock name for mipi-dsi.
+ * @lcd_panel_name: specifies lcd panel name registered to mipi-dsi driver.
+ *	lcd panel driver searched would be actived.
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
+	char	lcd_panel_name[64];
+	unsigned int platform_rev;
+
+	struct dsim_config *dsim_info;
+	struct dsim_lcd_config *dsim_lcd_info;
+
+	unsigned int delay_for_stabilization;
+
+	int (*mipi_power) (struct dsim_global *dsim, void *p_mipi_1_1v,
+		void *p_mipi_1_8v, int enable);
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
+	unsigned int reg_base;
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
+	s8	name[64];
+
+	s32	(*init)(struct device *dev);
+	void	(*display_on)(struct device *dev);
+	s32	(*set_link)(struct mipi_ddi_platform_data *pd);
+	s32	(*probe)(struct device *dev);
+	s32	(*remove)(struct device *dev);
+	void	(*shutdown)(struct device *dev);
+	s32	(*suspend)(struct device *dev, pm_message_t mesg);
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
+/* enable MIPI D-PHY and DSI Master block. */
+extern int s5p_dsim_init_d_phy(struct dsim_global *dsim);
+
+/* enable regulators to MIPI-DSI power. */
+extern int s5p_dsim_mipi_power(struct dsim_global *dsim, void *p_mipi_1_1v,
+	void *p_mipi_1_8v, int enable);
+
+#endif /* _DSIM_H */
diff --git a/arch/arm/plat-samsung/include/plat/mipi_ddi.h b/arch/arm/plat-samsu
ng/include/plat/mipi_ddi.h
new file mode 100644
index 0000000..57ed613
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
+	int (*change_dsim_transfer_mode) (int mode);
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
diff --git a/arch/arm/plat-samsung/include/plat/regs-dsim.h b/arch/arm/plat-sams
ung/include/plat/regs-dsim.h
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
diff --git a/arch/arm/plat-samsung/setup-dsim.c b/arch/arm/plat-samsung/setup-ds
im.c
new file mode 100644
index 0000000..833ade2
--- /dev/null
+++ b/arch/arm/plat-samsung/setup-dsim.c
@@ -0,0 +1,161 @@
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
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim is NULL.\n");
+		return -EFAULT;
+	}
+
+	reg = (readl(S5P_MIPI_CONTROL)) & ~(1 << 0);
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
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim is NULL.\n");
+		return -EFAULT;
+	}
+
+	reg = (readl(S5P_MIPI_CONTROL)) & ~(1 << 2);
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
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim is NULL.\n");
+		return -EFAULT;
+	}
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
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim is NULL.\n");
+		return -EFAULT;
+	}
+
+	/* enable D-PHY */
+	s5p_dsim_enable_d_phy(dsim, 1);
+
+	/* enable DSI master block */
+	s5p_dsim_enable_dsi_master(dsim, 1);
+
+	dev_dbg(dsim->dev, "%s\n", __func__);
+
+	return 0;
+}
+
+int s5p_dsim_mipi_power(struct dsim_global *dsim, void *p_mipi_1_1v,
+	void *p_mipi_1_8v, int enable)
+{
+	struct regulator *r_mipi_1_1v = NULL, *r_mipi_1_8v = NULL;
+	int ret = -1;
+
+	r_mipi_1_1v = (struct regulator *) p_mipi_1_1v;
+	r_mipi_1_8v = (struct regulator *) p_mipi_1_8v;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (IS_ERR(r_mipi_1_1v) || IS_ERR(r_mipi_1_8v)) {
+		dev_err(dsim->dev, "r_mipi_1_1v or r_mipi_1_8v is NULL.\n");
+		return -EINVAL;
+	}
+
+	if (enable) {
+		if (r_mipi_1_1v)
+			ret = regulator_enable(r_mipi_1_1v);
+
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to enable regulator mipi_1_1v.\n");
+			return ret;
+		}
+
+		if (r_mipi_1_8v)
+			ret = regulator_enable(r_mipi_1_8v);
+
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to enable regulator mipi_1_8v.\n");
+			return ret;
+		}
+	} else {
+		if (r_mipi_1_1v)
+			ret = regulator_force_disable(r_mipi_1_1v);
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to disable regulator mipi_1_1v.\n");
+			return ret;
+		}
+
+		if (r_mipi_1_8v)
+			ret = regulator_force_disable(r_mipi_1_8v);
+		if (ret < 0) {
+			dev_err(dsim->dev,
+				"failed to disable regulator mipi_1_8v.\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3d94a14..c916ac1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1930,7 +1930,7 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && ARCH_S3C64XX
+	depends on FB && (ARCH_S3C64XX || ARCH_S5PV210)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1975,6 +1975,13 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
 
+config S5P_MIPI_DSI
+	tristate "Samsung SoC MIPI-DSI support."
+	depends on FB_S3C && ARCH_S5PV210
+	default n
+	---help---
+	  This enables support for MIPI-DSI device.
+
 config FB_NUC900
         bool "NUC900 LCD framebuffer support"
         depends on FB && ARCH_W90X900
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ddc2af2..d841433 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -115,6 +115,8 @@ obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o
 obj-$(CONFIG_FB_IMX)              += imxfb.o
 obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
+obj-$(CONFIG_S5P_MIPI_DSI)	  += s5p-dsim.o s5p_dsim_common.o \
+    					s5p_dsim_lowlevel.o
 obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
 obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
 obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/
diff --git a/drivers/video/s5p-dsim.c b/drivers/video/s5p-dsim.c
new file mode 100644
index 0000000..96893bc
--- /dev/null
+++ b/drivers/video/s5p-dsim.c
@@ -0,0 +1,483 @@
+/* linux/drivers/video/samsung/s5p-dsim.c
+ *
+ * Samsung MIPI-DSIM driver.
+ *
+ * InKi Dae, <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/fb.h>
+#include <linux/ctype.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/memory.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kthread.h>
+#include <linux/regulator/consumer.h>
+#include <linux/notifier.h>
+
+#include <plat/fb.h>
+#include <plat/regs-dsim.h>
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+
+#include <mach/map.h>
+
+#include "s5p_dsim_common.h"
+
+struct mipi_lcd_info {
+	struct list_head	list;
+	struct mipi_lcd_driver	*mipi_drv;
+};
+
+static LIST_HEAD(lcd_info_list);
+static DEFINE_MUTEX(mipi_lock);
+
+struct dsim_global dsim;
+
+struct s5p_platform_dsim *to_dsim_plat(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return (struct s5p_platform_dsim *)pdev->dev.platform_data;
+}
+
+/*
+ * notifier callback function for fb_blank
+ * - this function would be called by device specific fb_blank.
+ */
+static int s5p_dsim_notifier_callback(struct notifier_block *self,
+	unsigned long event, void *data)
+{
+	pm_message_t pm;
+
+	pm.event = 0;
+
+	switch (event) {
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
+		if (dsim.pd->mipi_power)
+			dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
+				(void *) dsim.r_mipi_1_8v, 1);
+
+		clk_enable(dsim.clock);
+
+		if (dsim.mipi_drv->resume)
+			dsim.mipi_drv->resume(dsim.dev);
+
+		s5p_dsim_init_dsim(&dsim);
+		s5p_dsim_init_link(&dsim);
+
+		s5p_dsim_set_hs_enable(&dsim);
+		s5p_dsim_set_data_transfer_mode(&dsim,
+			DSIM_TRANSFER_BYCPU, 1);
+
+		/* it needs delay for stabilization */
+		mdelay(dsim.pd->delay_for_stabilization);
+
+		if (dsim.mipi_drv->init)
+			dsim.mipi_drv->init(dsim.dev);
+		else
+			dev_warn(dsim.dev, "init func is null.\n");
+
+		s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
+
+		s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
+		dsim.mipi_ddi_pd->resume_complete = 1;
+
+		dev_dbg(dsim.dev, "FB_BLANK_NORMAL or UNBLANK.\n");
+
+		break;
+	case FB_BLANK_POWERDOWN:
+		dsim.mipi_ddi_pd->resume_complete = 0;
+
+		if (dsim.mipi_drv->suspend)
+			dsim.mipi_drv->suspend(dsim.dev, pm);
+
+		clk_disable(dsim.clock);
+
+		if (dsim.pd->mipi_power)
+			dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
+				(void *) dsim.r_mipi_1_8v, 0);
+
+		dev_dbg(dsim.dev, "FB_BLANK_POWERDOWN.\n");
+		break;
+	default:
+		dev_warn(dsim.dev, "unknown FB_BLANK command.\n");
+		break;
+	}
+
+	return 0;
+}
+
+static int s5p_dsim_register_notif(struct device *dev)
+{
+	memset(&dsim.s3cfb_notif, 0, sizeof(struct notifier_block));
+	dsim.s3cfb_notif.notifier_call = s5p_dsim_notifier_callback;
+
+	return 0/*s3cfb_register_client(&dsim.s3cfb_notif)*/;
+}
+
+static irqreturn_t s5p_dsim_interrupt_handler(int irq, void *dev_id)
+{
+	disable_irq(irq);
+
+	/* additional work. */
+
+	enable_irq(irq);
+
+	return IRQ_HANDLED;
+}
+
+int s5p_dsim_register_lcd_driver(struct mipi_lcd_driver *lcd_drv)
+{
+	struct mipi_lcd_info	*lcd_info = NULL;
+
+	lcd_info = kmalloc(sizeof(struct mipi_lcd_info), GFP_KERNEL);
+	if (lcd_info = NULL)
+		return -ENOMEM;
+
+	lcd_info->mipi_drv = kmalloc(sizeof(struct mipi_lcd_driver),
+		GFP_KERNEL);
+	if (lcd_info->mipi_drv = NULL)
+		return -ENOMEM;
+
+
+	memcpy(lcd_info->mipi_drv, lcd_drv, sizeof(struct mipi_lcd_driver));
+
+	mutex_lock(&mipi_lock);
+	list_add_tail(&lcd_info->list, &lcd_info_list);
+	mutex_unlock(&mipi_lock);
+
+	dev_dbg(dsim.dev, "registered panel driver(%s) to mipi-dsi driver.\n",
+		lcd_drv->name);
+
+	return 0;
+}
+
+/*
+ * This function is wrapper for changing transfer mode.
+ * It is used to in panel driver before and after changing gamma value.
+ */
+static int s5p_dsim_change_transfer_mode(int mode)
+{
+	if (mode < 0 || mode > 1) {
+		dev_err(dsim.dev, "mode range should be 0 or 1.\n");
+		return -EFAULT;
+	}
+
+	if (mode = 0)
+		s5p_dsim_set_data_transfer_mode(&dsim,
+			DSIM_TRANSFER_BYCPU, mode);
+	else
+		s5p_dsim_set_data_transfer_mode(&dsim,
+			DSIM_TRANSFER_BYLCDC, mode);
+
+	return 0;
+}
+
+struct mipi_lcd_driver *scan_mipi_driver(const char *name)
+{
+	struct mipi_lcd_info *lcd_info;
+	struct mipi_lcd_driver *mipi_drv = NULL;
+
+	mutex_lock(&mipi_lock);
+
+	dev_dbg(dsim.dev, "find lcd panel driver(%s).\n",
+		name);
+
+	list_for_each_entry(lcd_info, &lcd_info_list, list) {
+		mipi_drv = lcd_info->mipi_drv;
+
+		if ((strcmp(mipi_drv->name, name)) = 0) {
+			mutex_unlock(&mipi_lock);
+			dev_dbg(dsim.dev, "found!!!(%s).\n", mipi_drv->name);
+			return mipi_drv;
+		}
+	}
+
+	dev_warn(dsim.dev, "failed to find lcd panel driver(%s).\n",
+		name);
+
+	mutex_unlock(&mipi_lock);
+
+	return NULL;
+}
+
+static int s5p_dsim_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret = -1;
+
+	dsim.pd = to_dsim_plat(&pdev->dev);
+	dsim.dev = &pdev->dev;
+
+	/* set dsim config data, dsim lcd config data and lcd panel data. */
+	dsim.dsim_info = dsim.pd->dsim_info;
+	dsim.dsim_lcd_info = dsim.pd->dsim_lcd_info;
+	dsim.lcd_panel_info +		(struct fb_videomode *) dsim.dsim_lcd_info->lcd_panel_info;
+	dsim.mipi_ddi_pd +		(struct mipi_ddi_platform_data *)
+			dsim.dsim_lcd_info->mipi_ddi_pd;
+
+	dsim.mipi_ddi_pd->resume_complete = 0;
+
+	dsim.r_mipi_1_1v = regulator_get(&pdev->dev, "VMIPI_1.1V");
+	if (IS_ERR(dsim.r_mipi_1_1v)) {
+		dev_err(&pdev->dev, "failed to get regulator VMIPI_1.1V.\n");
+		goto regulator_get_err;
+	}
+
+	dsim.r_mipi_1_8v = regulator_get(&pdev->dev, "VMIPI_1.8V");
+	if (IS_ERR(dsim.r_mipi_1_8v)) {
+		dev_err(&pdev->dev, "failed to get regulator VMIPI_1.8V.\n");
+		goto regulator_get_err;
+	}
+
+	/* clock */
+	dsim.clock = clk_get(&pdev->dev, dsim.pd->clk_name);
+	if (IS_ERR(dsim.clock)) {
+		dev_err(&pdev->dev, "failed to get dsim clock source\n");
+		return -EINVAL;
+	}
+
+	clk_enable(dsim.clock);
+
+	/* io memory */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get io memory region\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* request mem region */
+	res = request_mem_region(res->start,
+				 res->end - res->start + 1, pdev->name);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request io memory region\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* ioremap for register block */
+	dsim.reg_base = (unsigned int) ioremap(res->start,
+		res->end - res->start + 1);
+	if (!dsim.reg_base) {
+		dev_err(&pdev->dev, "failed to remap io region\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* it is used for MIPI-DSI based lcd panel driver. */
+	dsim.mipi_ddi_pd->dsim_data = (void *)&dsim;
+
+	/*
+	 * it uses frame done interrupt handler
+	 * only in case of MIPI Video mode.
+	 */
+	if (dsim.dsim_lcd_info->e_interface = DSIM_VIDEO) {
+		dsim.irq = platform_get_irq(pdev, 0);
+		if (request_irq(dsim.irq, s5p_dsim_interrupt_handler,
+				IRQF_TRIGGER_RISING, "mipi-dsi", &dsim)) {
+			dev_err(&pdev->dev, "request_irq failed.\n");
+			goto err_trigger_irq;
+		}
+	}
+
+	if (dsim.pd->mipi_power)
+		dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
+			(void *) dsim.r_mipi_1_8v, 1);
+	else {
+		dev_err(&pdev->dev, "mipi_power is NULL.\n");
+		goto mipi_power_err;
+	}
+
+	/* find lcd panel driver registered to mipi-dsi driver. */
+	dsim.mipi_drv = scan_mipi_driver(dsim.pd->lcd_panel_name);
+	if (dsim.mipi_drv = NULL) {
+		dev_err(&pdev->dev, "mipi_drv is NULL.\n");
+		goto mipi_drv_err;
+	}
+
+	/* register callback functions that lcd panel driver needs. */
+	dsim.mipi_ddi_pd->cmd_write = s5p_dsim_wr_data;
+	dsim.mipi_ddi_pd->cmd_read = NULL;
+	dsim.mipi_ddi_pd->get_dsim_frame_done +		s5p_dsim_get_frame_done_status;
+	dsim.mipi_ddi_pd->clear_dsim_frame_done = s5p_dsim_clear_frame_done;
+	dsim.mipi_ddi_pd->change_dsim_transfer_mode +		s5p_dsim_change_transfer_mode;
+	dsim.mipi_ddi_pd->get_fb_frame_done = dsim.pd->get_fb_frame_done;
+	dsim.mipi_ddi_pd->trigger = dsim.pd->trigger;
+
+	/* set lcd panel driver link */
+	ret = dsim.mipi_drv->set_link(dsim.mipi_ddi_pd);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to set link.\n");
+		goto mipi_drv_err;
+	}
+
+	dsim.mipi_drv->probe(&pdev->dev);
+
+	s5p_dsim_init_dsim(&dsim);
+	s5p_dsim_init_link(&dsim);
+
+	s5p_dsim_set_hs_enable(&dsim);
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYCPU, 1);
+
+	/* it needs delay for stabilization */
+	mdelay(dsim.pd->delay_for_stabilization);
+
+	/* initialize lcd panel */
+	if (dsim.mipi_drv->init)
+		dsim.mipi_drv->init(&pdev->dev);
+	else
+		dev_warn(&pdev->dev, "init func is null.\n");
+
+	if (dsim.mipi_drv->display_on)
+		dsim.mipi_drv->display_on(&pdev->dev);
+	else
+		dev_warn(&pdev->dev, "display_on func is null.\n");
+
+	s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
+
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
+
+	s5p_dsim_register_notif(&pdev->dev);
+
+	/* in case of command mode, trigger. */
+	if (dsim.dsim_lcd_info->e_interface = DSIM_COMMAND) {
+		if (dsim.pd->trigger)
+			dsim.pd->trigger(registered_fb[0]);
+		else
+			dev_warn(&pdev->dev, "trigger is null.\n");
+	}
+
+	dev_info(&pdev->dev, "mipi-dsi driver(%s mode) has been probed.\n",
+		(dsim.dsim_lcd_info->e_interface = DSIM_COMMAND) ?
+			"CPU" : "RGB");
+
+	return 0;
+
+err_trigger_irq:
+mipi_drv_err:
+	dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
+		(void *) dsim.r_mipi_1_8v, 0);
+
+mipi_power_err:
+	iounmap((void __iomem *) dsim.reg_base);
+
+err_clk_disable:
+	clk_disable(dsim.clock);
+
+regulator_get_err:
+
+	return ret;
+
+}
+
+static int s5p_dsim_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM
+int s5p_dsim_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	dsim.mipi_ddi_pd->resume_complete = 0;
+
+	if (dsim.mipi_drv->suspend)
+		dsim.mipi_drv->suspend(&pdev->dev, state);
+
+	clk_disable(dsim.clock);
+
+	if (dsim.pd->mipi_power)
+		dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
+			(void *) dsim.r_mipi_1_8v, 0);
+
+	return 0;
+}
+
+int s5p_dsim_resume(struct platform_device *pdev)
+{
+	if (dsim.pd->mipi_power)
+		dsim.pd->mipi_power(&dsim, (void *) dsim.r_mipi_1_1v,
+			(void *) dsim.r_mipi_1_8v, 1);
+
+	clk_enable(dsim.clock);
+
+	if (dsim.mipi_drv->resume)
+		dsim.mipi_drv->resume(&pdev->dev);
+
+	s5p_dsim_init_dsim(&dsim);
+	s5p_dsim_init_link(&dsim);
+
+	s5p_dsim_set_hs_enable(&dsim);
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYCPU, 1);
+
+	/* it needs delay for stabilization */
+	mdelay(dsim.pd->delay_for_stabilization);
+
+	/* initialize lcd panel */
+	if (dsim.mipi_drv->init)
+		dsim.mipi_drv->init(&pdev->dev);
+	else
+		dev_warn(&pdev->dev, "init func is null.\n");
+
+	s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
+
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
+
+	dsim.mipi_ddi_pd->resume_complete = 1;
+
+	return 0;
+}
+#else
+#define s5p_dsim_suspend NULL
+#define s5p_dsim_resume NULL
+#endif
+
+static struct platform_driver s5p_dsim_driver = {
+	.probe = s5p_dsim_probe,
+	.remove = s5p_dsim_remove,
+	.suspend = s5p_dsim_suspend,
+	.resume = s5p_dsim_resume,
+	.driver = {
+		   .name = "s5p-dsim",
+		   .owner = THIS_MODULE,
+	},
+};
+
+static int s5p_dsim_register(void)
+{
+	platform_driver_register(&s5p_dsim_driver);
+
+	return 0;
+}
+
+static void s5p_dsim_unregister(void)
+{
+	platform_driver_unregister(&s5p_dsim_driver);
+}
+
+module_init(s5p_dsim_register);
+module_exit(s5p_dsim_unregister);
+
+MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samusung MIPI-DSIM driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s5p_dsim_common.c b/drivers/video/s5p_dsim_common.c
new file mode 100644
index 0000000..4d70e2c
--- /dev/null
+++ b/drivers/video/s5p_dsim_common.c
@@ -0,0 +1,754 @@
+/* linux/drivers/video/samsung/s5p_dsim_common.c
+ *
+ * Samsung MIPI-DSIM common driver.
+ *
+ * InKi Dae, <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/fb.h>
+#include <linux/ctype.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/memory.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+
+#include <plat/fb.h>
+#include <plat/regs-dsim.h>
+
+#include <mach/map.h>
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+
+#include "s5p_dsim_lowlevel.h"
+
+static void s5p_dsim_long_data_wr(struct dsim_global *dsim, unsigned int data0,
+	unsigned int data1)
+{
+	unsigned int data_cnt = 0, payload = 0;
+
+	/* in case that data count is more then 4 */
+	for (data_cnt = 0; data_cnt < data1; data_cnt += 4) {
+		/*
+		 * after sending 4bytes per one time,
+		 * send remainder data less then 4.
+		 */
+		if ((data1 - data_cnt) < 4) {
+			if ((data1 - data_cnt) = 3) {
+				payload = *(u8 *)(data0 + data_cnt) |
+				    (*(u8 *)(data0 + (data_cnt + 1))) << 8 |
+					(*(u8 *)(data0 + (data_cnt + 2))) << 16;
+			dev_dbg(dsim->dev, "count = 3 payload = %x, %x %x %x\n",
+				payload, *(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)));
+			} else if ((data1 - data_cnt) = 2) {
+				payload = *(u8 *)(data0 + data_cnt) |
+					(*(u8 *)(data0 + (data_cnt + 1))) << 8;
+			dev_dbg(dsim->dev,
+				"count = 2 payload = %x, %x %x\n", payload,
+				*(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)));
+			} else if ((data1 - data_cnt) = 1) {
+				payload = *(u8 *)(data0 + data_cnt);
+			}
+
+			s5p_dsim_wr_tx_data(dsim, payload);
+		/* send 4bytes per one time. */
+		} else {
+			payload = *(u8 *)(data0 + data_cnt) |
+				(*(u8 *)(data0 + (data_cnt + 1))) << 8 |
+				(*(u8 *)(data0 + (data_cnt + 2))) << 16 |
+				(*(u8 *)(data0 + (data_cnt + 3))) << 24;
+
+			dev_dbg(dsim->dev,
+				"count = 4 payload = %x, %x %x %x %x\n",
+				payload, *(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)),
+				*(u8 *)(data0 + (data_cnt + 3)));
+
+			s5p_dsim_wr_tx_data(dsim, payload);
+		}
+	}
+}
+
+int s5p_dsim_wr_data(void *dsim_data, unsigned int data_id,
+	unsigned int data0, unsigned int data1)
+{
+	struct dsim_global *dsim = NULL;
+	unsigned int timeout = 5000 * 2;
+	unsigned long delay_val, udelay;
+	unsigned char check_rx_ack = 0;
+
+	dsim = (struct dsim_global *)dsim_data;
+
+	if (dsim = NULL) {
+		dev_err(dsim->dev, "dsim_data is NULL.\n");
+		return -EFAULT;
+	}
+
+
+	if (dsim->state = DSIM_STATE_ULPS) {
+		dev_err(dsim->dev, "state is ULPS.\n");
+
+		return -EINVAL;
+	}
+
+	delay_val = 1000000 / dsim->dsim_info->esc_clk;
+	udelay = 10 * delay_val;
+
+	mdelay(udelay);
+
+	/* only if transfer mode is LPDT, wait SFR becomes empty. */
+	if (dsim->state = DSIM_STATE_STOP) {
+		while (!(s5p_dsim_get_fifo_state(dsim) &
+				SFR_HEADER_EMPTY)) {
+			if ((timeout--) > 0)
+				mdelay(1);
+			else {
+				dev_err(dsim->dev,
+					"SRF header fifo is not empty.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	switch (data_id) {
+	/* short packet types of packet types for command. */
+	case GEN_SHORT_WR_NO_PARA:
+	case GEN_SHORT_WR_1_PARA:
+	case GEN_SHORT_WR_2_PARA:
+	case DCS_WR_NO_PARA:
+	case DCS_WR_1_PARA:
+	case SET_MAX_RTN_PKT_SIZE:
+		s5p_dsim_wr_tx_header(dsim, (unsigned char) data_id,
+			(unsigned char) data0, (unsigned char) data1);
+		if (check_rx_ack)
+			/* process response func should be implemented */
+			return 0;
+		else
+			return -EINVAL;
+
+	/* general command */
+	case CMD_OFF:
+	case CMD_ON:
+	case SHUT_DOWN:
+	case TURN_ON:
+		s5p_dsim_wr_tx_header(dsim, (unsigned char) data_id,
+			(unsigned char) data0, (unsigned char) data1);
+		if (check_rx_ack)
+			/* process response func should be implemented. */
+			return 0;
+		else
+			return -EINVAL;
+
+	/* packet types for video data */
+	case VSYNC_START:
+	case VSYNC_END:
+	case HSYNC_START:
+	case HSYNC_END:
+	case EOT_PKT:
+		return 0;
+
+	/* short and response packet types for command */
+	case GEN_RD_1_PARA:
+	case GEN_RD_2_PARA:
+	case GEN_RD_NO_PARA:
+	case DCS_RD_NO_PARA:
+		s5p_dsim_clear_interrupt(dsim, 0xffffffff);
+		s5p_dsim_wr_tx_header(dsim, (unsigned char) data_id,
+			(unsigned char) data0, (unsigned char) data1);
+		/* process response func should be implemented. */
+		return 0;
+
+	/* long packet type and null packet */
+	case NULL_PKT:
+	case BLANKING_PKT:
+		return 0;
+	case GEN_LONG_WR:
+	case DCS_LONG_WR:
+	{
+		unsigned int size, data_cnt = 0, payload = 0;
+
+		size = data1 * 4;
+
+		/* if data count is less then 4, then send 3bytes data.  */
+		if (data1 < 4) {
+			payload = *(u8 *)(data0) |
+				*(u8 *)(data0 + 1) << 8 |
+				*(u8 *)(data0 + 2) << 16;
+
+			s5p_dsim_wr_tx_data(dsim, payload);
+
+			dev_dbg(dsim->dev, "count = %d payload = %x,%x %x %x\n",
+				data1, payload,
+				*(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)));
+		/* in case that data count is more then 4 */
+		} else
+			s5p_dsim_long_data_wr(dsim, data0, data1);
+
+		/* put data into header fifo */
+		s5p_dsim_wr_tx_header(dsim, (unsigned char) data_id,
+			(unsigned char) (((unsigned short) data1) & 0xff),
+			(unsigned char) ((((unsigned short) data1) & 0xff00) >>
+				8));
+
+	}
+	if (check_rx_ack)
+		/* process response func should be implemented. */
+		return 0;
+	else
+		return -EINVAL;
+
+	/* packet typo for video data */
+	case RGB565_PACKED:
+	case RGB666_PACKED:
+	case RGB666_LOOSLY:
+	case RGB888_PACKED:
+		if (check_rx_ack)
+			/* process response func should be implemented. */
+			return 0;
+		else
+			return -EINVAL;
+	default:
+		dev_warn(dsim->dev,
+			"data id %x is not supported current DSI spec.\n",
+			data_id);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int s5p_dsim_init_header_fifo(struct dsim_global *dsim)
+{
+	unsigned int cnt;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	for (cnt = 0; cnt < DSIM_HEADER_FIFO_SZ; cnt++)
+		dsim->header_fifo_index[cnt] = -1;
+	return 0;
+}
+
+int s5p_dsim_pll_on(struct dsim_global *dsim, unsigned char enable)
+{
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (enable) {
+		int sw_timeout = 1000;
+		s5p_dsim_clear_interrupt(dsim, DSIM_PLL_STABLE);
+		s5p_dsim_enable_pll(dsim, 1);
+		while (1) {
+			sw_timeout--;
+			if (s5p_dsim_is_pll_stable(dsim))
+				return 0;
+			if (sw_timeout = 0)
+				return -EINVAL;
+		}
+	} else
+		s5p_dsim_enable_pll(dsim, 0);
+
+	return 0;
+}
+
+unsigned long s5p_dsim_change_pll(struct dsim_global *dsim,
+	unsigned char pre_divider, unsigned short main_divider,
+	unsigned char scaler)
+{
+	unsigned long dfin_pll, dfvco, dpll_out;
+	unsigned char freq_band;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return 0;
+	}
+
+	dfin_pll = (MIPI_FIN / pre_divider);
+
+	if (dfin_pll < 6 * 1000 * 1000 || dfin_pll > 12 * 1000 * 1000) {
+		dev_warn(dsim->dev, "warning!!\n");
+		dev_warn(dsim->dev, "fin_pll range is 6MHz ~ 12MHz\n");
+		dev_warn(dsim->dev, "fin_pll of mipi dphy pll is %luMHz\n",
+			(dfin_pll / 1000000));
+
+		s5p_dsim_enable_afc(dsim, 0, 0);
+	} else {
+		if (dfin_pll < 7 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x1);
+		else if (dfin_pll < 8 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x0);
+		else if (dfin_pll < 9 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x3);
+		else if (dfin_pll < 10 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x2);
+		else if (dfin_pll < 11 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x5);
+		else
+			s5p_dsim_enable_afc(dsim, 1, 0x4);
+	}
+
+	dfvco = dfin_pll * main_divider;
+	dev_dbg(dsim->dev, "dfvco = %lu, dfin_pll = %lu, main_divider = %d\n",
+		dfvco, dfin_pll, main_divider);
+	if (dfvco < 500000000 || dfvco > 1000000000) {
+		dev_warn(dsim->dev, "Caution!!\n");
+		dev_warn(dsim->dev, "fvco range is 500MHz ~ 1000MHz\n");
+		dev_warn(dsim->dev, "fvco of mipi dphy pll is %luMHz\n",
+			(dfvco / 1000000));
+	}
+
+	dpll_out = dfvco / (1 << scaler);
+	dev_dbg(dsim->dev, "dpll_out = %lu, dfvco = %lu, scaler = %d\n",
+		dpll_out, dfvco, scaler);
+	if (dpll_out < 100 * 1000000)
+		freq_band = 0x0;
+	else if (dpll_out < 120 * 1000000)
+		freq_band = 0x1;
+	else if (dpll_out < 170 * 1000000)
+		freq_band = 0x2;
+	else if (dpll_out < 220 * 1000000)
+		freq_band = 0x3;
+	else if (dpll_out < 270 * 1000000)
+		freq_band = 0x4;
+	else if (dpll_out < 320 * 1000000)
+		freq_band = 0x5;
+	else if (dpll_out < 390 * 1000000)
+		freq_band = 0x6;
+	else if (dpll_out < 450 * 1000000)
+		freq_band = 0x7;
+	else if (dpll_out < 510 * 1000000)
+		freq_band = 0x8;
+	else if (dpll_out < 560 * 1000000)
+		freq_band = 0x9;
+	else if (dpll_out < 640 * 1000000)
+		freq_band = 0xa;
+	else if (dpll_out < 690 * 1000000)
+		freq_band = 0xb;
+	else if (dpll_out < 770 * 1000000)
+		freq_band = 0xc;
+	else if (dpll_out < 870 * 1000000)
+		freq_band = 0xd;
+	else if (dpll_out < 950 * 1000000)
+		freq_band = 0xe;
+	else
+		freq_band = 0xf;
+
+	dev_dbg(dsim->dev, "freq_band = %d\n", freq_band);
+
+	s5p_dsim_pll_freq(dsim, pre_divider, main_divider, scaler);
+
+	{
+	    unsigned char temp0, temp1;
+
+	    temp0 = 0;
+	    s5p_dsim_hs_zero_ctrl(dsim, temp0);
+	    temp1 = 0;
+	    s5p_dsim_prep_ctrl(dsim, temp1);
+	}
+
+	/* Freq Band */
+	s5p_dsim_pll_freq_band(dsim, freq_band);
+
+	/* Stable time */
+	s5p_dsim_pll_stable_time(dsim,
+		dsim->dsim_info->pll_stable_time);
+
+	/* Enable PLL */
+	dev_dbg(dsim->dev, "FOUT of mipi dphy pll is %luMHz\n",
+		(dpll_out / 1000000));
+
+	return dpll_out;
+}
+
+int s5p_dsim_set_clock(struct dsim_global *dsim,
+	unsigned char byte_clk_sel, unsigned char enable)
+{
+	unsigned int esc_div;
+	unsigned long esc_clk_error_rate;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EINVAL;
+	}
+
+	if (enable) {
+		dsim->e_clk_src = byte_clk_sel;
+
+		/* Escape mode clock and byte clock source */
+		s5p_dsim_set_byte_clock_src(dsim, byte_clk_sel);
+
+		/* DPHY, DSIM Link : D-PHY clock out */
+		if (byte_clk_sel = DSIM_PLL_OUT_DIV8) {
+			dsim->hs_clk = s5p_dsim_change_pll(dsim,
+				dsim->dsim_info->p, dsim->dsim_info->m,
+				dsim->dsim_info->s);
+			if (dsim->hs_clk = 0) {
+				dev_err(dsim->dev,
+					"failed to get hs clock.\n");
+				return -EINVAL;
+			}
+
+			dsim->byte_clk = dsim->hs_clk / 8;
+			s5p_dsim_enable_pll_bypass(dsim, 0);
+			s5p_dsim_pll_on(dsim, 1);
+		/* DPHY : D-PHY clock out, DSIM link : external clock out */
+		} else if (byte_clk_sel = DSIM_EXT_CLK_DIV8)
+			dev_warn(dsim->dev,
+				"this project is not support \
+				external clock source for MIPI DSIM\n");
+		else if (byte_clk_sel = DSIM_EXT_CLK_BYPASS)
+			dev_warn(dsim->dev,
+				"this project is not support \
+				external clock source for MIPI DSIM\n");
+
+		/* escape clock divider */
+		esc_div = dsim->byte_clk / (dsim->dsim_info->esc_clk);
+		dev_dbg(dsim->dev,
+			"esc_div = %d, byte_clk = %lu, esc_clk = %lu\n",
+			esc_div, dsim->byte_clk, dsim->dsim_info->esc_clk);
+		if ((dsim->byte_clk / esc_div) >= 20000000 ||
+			(dsim->byte_clk / esc_div) > dsim->dsim_info->esc_clk)
+			esc_div += 1;
+
+		dsim->escape_clk = dsim->byte_clk / esc_div;
+		dev_dbg(dsim->dev,
+			"escape_clk = %lu, byte_clk = %lu, esc_div = %d\n",
+			dsim->escape_clk, dsim->byte_clk, esc_div);
+
+		/*
+		 * enable escclk on lane
+		 *
+		 * in case of evt0, DSIM_TRUE is enable and
+		 * DSIM_FALSE is enable for evt1.
+		 */
+		if (dsim->pd->platform_rev = 1)
+			s5p_dsim_enable_byte_clock(dsim, DSIM_FALSE);
+		else
+			s5p_dsim_enable_byte_clock(dsim, DSIM_TRUE);
+
+		/* enable byte clk and escape clock */
+		s5p_dsim_set_esc_clk_prs(dsim, 1, esc_div);
+		/* escape clock on lane */
+		s5p_dsim_enable_esc_clk_on_lane(dsim,
+			(DSIM_LANE_CLOCK | dsim->data_lane), 1);
+
+		dev_dbg(dsim->dev, "byte clock is %luMHz\n",
+			(dsim->byte_clk / 1000000));
+		dev_dbg(dsim->dev, "escape clock that user's need is %lu\n",
+			(dsim->dsim_info->esc_clk / 1000000));
+		dev_dbg(dsim->dev, "escape clock divider is %x\n", esc_div);
+		dev_dbg(dsim->dev, "escape clock is %luMHz\n",
+			((dsim->byte_clk / esc_div) / 1000000));
+
+		if ((dsim->byte_clk / esc_div) > dsim->escape_clk) {
+			esc_clk_error_rate = dsim->escape_clk /
+				(dsim->byte_clk / esc_div);
+			dev_warn(dsim->dev, "error rate is %lu over.\n",
+				(esc_clk_error_rate / 100));
+		} else if ((dsim->byte_clk / esc_div) < (dsim->escape_clk)) {
+			esc_clk_error_rate = (dsim->byte_clk / esc_div) /
+				dsim->escape_clk;
+			dev_warn(dsim->dev, "error rate is %lu under.\n",
+				(esc_clk_error_rate / 100));
+		}
+	} else {
+		s5p_dsim_enable_esc_clk_on_lane(dsim,
+			(DSIM_LANE_CLOCK | dsim->data_lane), 0);
+		s5p_dsim_set_esc_clk_prs(dsim, 0, 0);
+
+		/*
+		 * in case of evt0, DSIM_FALSE is disable and
+		 * DSIM_TRUE is disable for evt1.
+		 */
+		if (dsim->pd->platform_rev = 1)
+			s5p_dsim_enable_byte_clock(dsim, DSIM_TRUE);
+		else
+			s5p_dsim_enable_byte_clock(dsim, DSIM_FALSE);
+
+		if (byte_clk_sel = DSIM_PLL_OUT_DIV8)
+			s5p_dsim_pll_on(dsim, 0);
+	}
+
+	return 0;
+}
+
+int s5p_dsim_init_dsim(struct dsim_global *dsim)
+{
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (dsim->pd->init_d_phy)
+		dsim->pd->init_d_phy(dsim);
+
+	dsim->state = DSIM_STATE_RESET;
+
+	switch (dsim->dsim_info->e_no_data_lane) {
+	case DSIM_DATA_LANE_1:
+		dsim->data_lane = DSIM_LANE_DATA0;
+		break;
+	case DSIM_DATA_LANE_2:
+		dsim->data_lane = DSIM_LANE_DATA0 | DSIM_LANE_DATA1;
+		break;
+	case DSIM_DATA_LANE_3:
+		dsim->data_lane = DSIM_LANE_DATA0 | DSIM_LANE_DATA1 |
+			DSIM_LANE_DATA2;
+		break;
+	case DSIM_DATA_LANE_4:
+		dsim->data_lane = DSIM_LANE_DATA0 | DSIM_LANE_DATA1 |
+			DSIM_LANE_DATA2 | DSIM_LANE_DATA3;
+		break;
+	default:
+		dev_info(dsim->dev, "data lane is invalid.\n");
+		return -EINVAL;
+	};
+
+	s5p_dsim_init_header_fifo(dsim);
+	s5p_dsim_sw_reset(dsim);
+	s5p_dsim_dp_dn_swap(dsim, dsim->dsim_info->e_lane_swap);
+
+	return 0;
+}
+
+int s5p_dsim_enable_frame_done_int(struct dsim_global *dsim, int enable)
+{
+	/* enable only frame done interrupt */
+	s5p_dsim_set_interrupt_mask(dsim, INTMSK_FRAME_DONE, enable);
+
+	return 0;
+}
+
+int s5p_dsim_set_display_mode(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd)
+{
+	struct fb_videomode *mlcd_video = NULL;
+	struct fb_cmdmode *mlcd_command = NULL;
+	struct s3c_fb_pd_win *pd;
+	unsigned int width = 0, height = 0;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	pd = (struct s3c_fb_pd_win *)main_lcd->lcd_panel_info;
+
+	/* in case of VIDEO MODE (RGB INTERFACE) */
+	if (dsim->dsim_lcd_info->e_interface = (u32) DSIM_VIDEO) {
+		mlcd_video = (struct fb_videomode *)&pd->win_mode;
+		width = mlcd_video->xres;
+		height = mlcd_video->yres;
+
+		if (dsim->dsim_info->auto_vertical_cnt = DSIM_FALSE) {
+			s5p_dsim_set_main_disp_vporch(dsim,
+				mlcd_video->upper_margin,
+				mlcd_video->lower_margin,
+				mlcd_video->cmd_allow_len);
+			s5p_dsim_set_main_disp_hporch(dsim,
+				mlcd_video->left_margin,
+				mlcd_video->right_margin);
+			s5p_dsim_set_main_disp_sync_area(dsim,
+				mlcd_video->vsync_len,
+				mlcd_video->hsync_len);
+		}
+	} else {	/* in case of COMMAND MODE (CPU or I80 INTERFACE) */
+		mlcd_command = (struct fb_cmdmode *)&pd->cmd_mode;
+		width = mlcd_command->xres;
+		height = mlcd_command->yres;
+	}
+
+	s5p_dsim_set_main_disp_resol(dsim, height, width);
+
+	if (sub_lcd != NULL)
+			dev_warn(dsim->dev, "sub lcd isn't supported yet.\n");
+
+	s5p_dsim_display_config(dsim, dsim->dsim_lcd_info, NULL);
+
+	return 0;
+}
+
+int s5p_dsim_init_link(struct dsim_global *dsim)
+{
+	unsigned int time_out = 100;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	switch (dsim->state) {
+	case DSIM_STATE_RESET:
+		s5p_dsim_sw_reset(dsim);
+	case DSIM_STATE_INIT:
+		s5p_dsim_init_fifo_pointer(dsim, 0x1f);
+
+		/* dsi configuration */
+		s5p_dsim_init_config(dsim, dsim->dsim_lcd_info,
+			NULL, dsim->dsim_info);
+		s5p_dsim_enable_lane(dsim, DSIM_LANE_CLOCK, 1);
+		s5p_dsim_enable_lane(dsim, dsim->data_lane, 1);
+
+		/* set clock configuration */
+		s5p_dsim_set_clock(dsim, dsim->dsim_info->e_byte_clk,
+			1);
+
+		/* check clock and data lane state is stop state */
+		while (!(s5p_dsim_is_lane_state(dsim, DSIM_LANE_CLOCK)
+			    = DSIM_LANE_STATE_STOP) &&
+			!(s5p_dsim_is_lane_state(dsim,
+				dsim->data_lane) = DSIM_LANE_STATE_STOP)) {
+			time_out--;
+			if (time_out = 0) {
+				dev_info(dsim->dev,
+					"DSI Master is not stop state.\n");
+				dev_info(dsim->dev,
+					"Check initialization process\n");
+
+				return -EINVAL;
+			}
+		}
+
+		if (time_out != 0) {
+			dev_info(dsim->dev,
+				"initialization of DSI Master is successful\n");
+			dev_info(dsim->dev, "DSI Master state is stop state\n");
+		}
+
+		dsim->state = DSIM_STATE_STOP;
+
+		/* BTA sequence counters */
+		s5p_dsim_set_stop_state_counter(dsim,
+			dsim->dsim_info->stop_holding_cnt);
+		s5p_dsim_set_bta_timeout(dsim,
+			dsim->dsim_info->bta_timeout);
+		s5p_dsim_set_lpdr_timeout(dsim,
+			dsim->dsim_info->rx_timeout);
+
+		/* default LPDT by both cpu and lcd controller */
+		s5p_dsim_set_data_mode(dsim, DSIM_TRANSFER_BOTH,
+			DSIM_STATE_STOP);
+
+		return 0;
+	default:
+		dev_info(dsim->dev, "DSI Master is already init.\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+int s5p_dsim_set_hs_enable(struct dsim_global *dsim)
+{
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (dsim->state = DSIM_STATE_STOP) {
+		if (dsim->e_clk_src != DSIM_EXT_CLK_BYPASS) {
+			dsim->state = DSIM_STATE_HSCLKEN;
+			s5p_dsim_set_data_mode(dsim,
+				DSIM_TRANSFER_BOTH, DSIM_STATE_HSCLKEN);
+			s5p_dsim_enable_hs_clock(dsim, 1);
+
+			return 0;
+		} else
+			dev_warn(dsim->dev,
+				"clock source is external bypass.\n");
+	} else
+		dev_warn(dsim->dev, "DSIM is not stop state.\n");
+
+	return 0;
+}
+
+int s5p_dsim_set_data_transfer_mode(struct dsim_global *dsim,
+	unsigned char data_path, unsigned char hs_enable)
+{
+	int ret = -1;
+
+	if (dsim = NULL) {
+		printk(KERN_ERR "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (hs_enable) {
+		if (dsim->state = DSIM_STATE_HSCLKEN) {
+			s5p_dsim_set_data_mode(dsim, data_path,
+				DSIM_STATE_HSCLKEN);
+			ret = 0;
+		} else {
+			dev_err(dsim->dev, "HS Clock lane is not enabled.\n");
+			ret = -EINVAL;
+		}
+	} else {
+		if (dsim->state = DSIM_STATE_INIT || dsim->state =
+			DSIM_STATE_ULPS) {
+			dev_err(dsim->dev,
+				"DSI Master is not STOP or HSDT state.\n");
+			ret = -EINVAL;
+		} else {
+			s5p_dsim_set_data_mode(dsim, data_path,
+				DSIM_STATE_STOP);
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+int s5p_dsim_get_frame_done_status(void *dsim_data)
+{
+	struct dsim_global *dsim = NULL;
+
+	dsim = (struct dsim_global *)dsim_data;
+
+	if (dsim = NULL) {
+		dev_err(dsim->dev, "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	return _s5p_dsim_get_frame_done_status(dsim);
+}
+
+int s5p_dsim_clear_frame_done(void *dsim_data)
+{
+	struct dsim_global *dsim = NULL;
+
+	dsim = (struct dsim_global *)dsim_data;
+
+	if (dsim = NULL) {
+		dev_err(dsim->dev, "dsim_global pointer is NULL.\n");
+		return -EFAULT;
+	}
+
+	_s5p_dsim_clear_frame_done(dsim);
+
+	return 0;
+}
+
+MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samusung MIPI-DSIM common driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s5p_dsim_common.h b/drivers/video/s5p_dsim_common.h
new file mode 100644
index 0000000..deefca1
--- /dev/null
+++ b/drivers/video/s5p_dsim_common.h
@@ -0,0 +1,38 @@
+/* linux/drivers/video/samsung/s5p_dsim_common.h
+ *
+ * Header file for Samsung MIPI-DSI common driver.
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ * InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _S5P_DSIM_COMMON_H
+#define _S5P_DSIM_COMMON_H
+
+extern int s5p_dsim_wr_data(void *dsim_data, unsigned int data_id,
+	unsigned int data0, unsigned int data1);
+extern int s5p_dsim_init_header_fifo(struct dsim_global *dsim);
+extern int s5p_dsim_pll_on(struct dsim_global *dsim, unsigned char enable);
+extern unsigned long s5p_dsim_change_pll(struct dsim_global *dsim,
+	unsigned char pre_divider, unsigned short main_divider,
+	unsigned char scaler);
+extern int s5p_dsim_set_clock(struct dsim_global *dsim,
+	unsigned char byte_clk_sel, unsigned char enable);
+extern int s5p_dsim_init_dsim(struct dsim_global *dsim);
+extern int s5p_dsim_set_display_mode(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd);
+extern int s5p_dsim_init_link(struct dsim_global *dsim);
+extern int s5p_dsim_set_hs_enable(struct dsim_global *dsim);
+extern int s5p_dsim_set_data_transfer_mode(struct dsim_global *dsim,
+	unsigned char data_path, unsigned char hs_enable);
+extern int s5p_dsim_get_frame_done_status(void *dsim_data);
+extern int s5p_dsim_clear_frame_done(void *dsim_data);
+extern int s5p_dsim_enable_frame_done_int(struct dsim_global *dsim, int enable)
;
+
+extern struct fb_info *registered_fb[FB_MAX] __read_mostly;
+
+#endif /* _S5P_DSIM_COMMON_H */
diff --git a/drivers/video/s5p_dsim_lowlevel.c b/drivers/video/s5p_dsim_lowlevel
.c
new file mode 100644
index 0000000..6a27395
--- /dev/null
+++ b/drivers/video/s5p_dsim_lowlevel.c
@@ -0,0 +1,562 @@
+/* linux/drivers/video/samsung/s5p-dsim.c
+ *
+ * Samsung MIPI-DSIM lowlevel driver.
+ *
+ * InKi Dae, <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/ctype.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+#include <plat/regs-dsim.h>
+
+void s5p_dsim_func_reset(struct dsim_global *dsim)
+{
+	unsigned int cfg = 0;
+
+	cfg = DSIM_FUNCRST;
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_SWRST);
+}
+
+void s5p_dsim_sw_reset(struct dsim_global *dsim)
+{
+	unsigned int cfg = 0;
+
+	cfg = DSIM_SWRST;
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_SWRST);
+}
+
+void s5p_dsim_set_interrupt_mask(struct dsim_global *dsim, unsigned int mode,
+	unsigned int mask)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTMSK);
+
+	if (mask)
+		reg |= mode;
+	else
+		reg &= ~(mode);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_INTMSK);
+}
+
+void s5p_dsim_init_fifo_pointer(struct dsim_global *dsim, unsigned char cfg)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_FIFOCTRL);
+
+	writel(reg & ~(cfg), dsim->reg_base + S5P_DSIM_FIFOCTRL);
+	mdelay(10);
+	reg |= cfg;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_FIFOCTRL);
+}
+
+/*
+ * this function set PLL P, M and S value in D-PHY
+ */
+void s5p_dsim_set_phy_tunning(struct dsim_global *dsim, unsigned int value)
+{
+	writel(DSIM_AFC_CTL(value), dsim->reg_base + S5P_DSIM_PHYACCHR);
+}
+
+void s5p_dsim_set_main_disp_resol(struct dsim_global *dsim,
+	unsigned short vert_resol, unsigned short hori_resol)
+{
+	unsigned int reg;
+
+	/* standby should be set after configuration so set to not ready*/
+	reg = (readl(dsim->reg_base + S5P_DSIM_MDRESOL)) &
+		~(DSIM_MAIN_STAND_BY);
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+
+	reg &= ~(0x7ff << 16) & ~(0x7ff << 0);
+	reg |= DSIM_MAIN_VRESOL(vert_resol) | DSIM_MAIN_HRESOL(hori_resol);
+
+	reg |= DSIM_MAIN_STAND_BY;
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+}
+
+void s5p_dsim_set_main_disp_vporch(struct dsim_global *dsim,
+	unsigned int cmd_allow, unsigned int vfront, unsigned int vback)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MVPORCH)) &
+		~(DSIM_CMD_ALLOW_MASK) & ~(DSIM_STABLE_VFP_MASK) &
+		~(DSIM_MAIN_VBP_MASK);
+
+	reg |= ((cmd_allow & 0xf) << DSIM_CMD_ALLOW_SHIFT) |
+		((vfront & 0x7ff) << DSIM_STABLE_VFP_SHIFT) |
+		((vback & 0x7ff) << DSIM_MAIN_VBP_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MVPORCH);
+}
+
+void s5p_dsim_set_main_disp_hporch(struct dsim_global *dsim,
+	unsigned short front, unsigned short back)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MHPORCH)) &
+		~(DSIM_MAIN_HFP_MASK) & ~(DSIM_MAIN_HBP_MASK);
+
+	reg |= (front << DSIM_MAIN_HFP_SHIFT) | (back << DSIM_MAIN_HBP_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MHPORCH);
+}
+
+void s5p_dsim_set_main_disp_sync_area(struct dsim_global *dsim,
+	unsigned short vert, unsigned short hori)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MSYNC)) &
+		~(DSIM_MAIN_VSA_MASK) & ~(DSIM_MAIN_HSA_MASK);
+
+	reg |= ((vert & 0x3ff) << DSIM_MAIN_VSA_SHIFT) |
+		(hori << DSIM_MAIN_HSA_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MSYNC);
+}
+
+void s5p_dsim_set_sub_disp_resol(struct dsim_global *dsim,
+	unsigned short vert, unsigned short hori)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_SDRESOL)) &
+		~(DSIM_SUB_STANDY_MASK);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
+
+	reg &= ~(DSIM_SUB_VRESOL_MASK) | ~(DSIM_SUB_HRESOL_MASK);
+	reg |= ((vert & 0x7ff) << DSIM_SUB_VRESOL_SHIFT) |
+		((hori & 0x7ff) << DSIM_SUB_HRESOL_SHIFT);
+	writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
+
+	reg |= (1 << DSIM_SUB_STANDY_SHIFT);
+	writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
+}
+
+void s5p_dsim_init_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd_info,
+	struct dsim_lcd_config *sub_lcd_info, struct dsim_config *dsim_info)
+{
+	unsigned int cfg = (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
+		~(1 << 28) & ~(0x1f << 20) & ~(0x3 << 5);
+
+	cfg =	(dsim_info->auto_flush << 29) |
+		(dsim_info->eot_disable << 28) |
+		(dsim_info->auto_vertical_cnt << DSIM_AUTO_MODE_SHIFT) |
+		(dsim_info->hse << DSIM_HSE_MODE_SHIFT) |
+		(dsim_info->hfp << DSIM_HFP_MODE_SHIFT) |
+		(dsim_info->hbp << DSIM_HBP_MODE_SHIFT) |
+		(dsim_info->hsa << DSIM_HSA_MODE_SHIFT) |
+		(dsim_info->e_no_data_lane << DSIM_NUM_OF_DATALANE_SHIFT);
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_dsim_display_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd)
+{
+	u32 reg = (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
+		~(0x3 << 26) & ~(1 << 25) & ~(0x3 << 18) & ~(0x7 << 12) &
+		~(0x3 << 16) & ~(0x7 << 8);
+
+	if (main_lcd->e_interface = DSIM_VIDEO)
+		reg |= (1 << 25);
+	else if (main_lcd->e_interface = DSIM_COMMAND)
+		reg &= ~(1 << 25);
+	else {
+		dev_err(dsim->dev, "this ddi is not MIPI interface.\n");
+		return;
+	}
+
+	/* main lcd */
+	reg |= ((u8) (main_lcd->parameter[DSI_VIDEO_MODE_SEL]) & 0x3) << 26 |
+		((u8) (main_lcd->parameter[DSI_VIRTUAL_CH_ID]) & 0x3) << 18 |
+		((u8) (main_lcd->parameter[DSI_FORMAT]) & 0x7) << 12;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_dsim_enable_lane(struct dsim_global *dsim, unsigned char lane,
+	unsigned char enable)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_CONFIG);
+
+	if (lane = DSIM_LANE_CLOCK) {
+		if (enable)
+			reg |= (1 << 0);
+		else
+			reg &= ~(1 << 0);
+	} else {
+		if (enable)
+			reg |= (lane << 1);
+		else
+			reg &= ~(lane << 1);
+	}
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+
+void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
+	unsigned char count)
+{
+	unsigned int cfg = 0;
+
+	/* get the data lane number. */
+	cfg = DSIM_NUM_OF_DATA_LANE(count);
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_dsim_enable_afc(struct dsim_global *dsim, unsigned char enable,
+	unsigned char afc_code)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PHYACCHR);
+
+	if (enable) {
+		reg |= (1 << 14);
+		reg &= ~(0x7 << 5);
+		reg |= (afc_code & 0x7) << 5;
+	} else
+		reg &= ~(1 << 14);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR);
+}
+
+void s5p_dsim_enable_pll_bypass(struct dsim_global *dsim,
+	unsigned char enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(DSIM_PLL_BYPASS_EXTERNAL);
+
+	reg |= enable << DSIM_PLL_BYPASS_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_set_pll_pms(struct dsim_global *dsim, unsigned char p,
+	unsigned short m, unsigned short s)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PLLCTRL);
+
+	reg |= ((p & 0x3f) << 13) | ((m & 0x1ff) << 4) | ((s & 0x7) << 1);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_pll_freq_band(struct dsim_global *dsim, unsigned char freq_band)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x1f << DSIM_FREQ_BAND_SHIFT);
+
+	reg |= ((freq_band & 0x1f) << DSIM_FREQ_BAND_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_pll_freq(struct dsim_global *dsim, unsigned char pre_divider,
+	unsigned short main_divider, unsigned char scaler)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x7ffff << 1);
+
+	reg |= (pre_divider & 0x3f) << 13 | (main_divider & 0x1ff) << 4 |
+		(scaler & 0x7) << 1;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_pll_stable_time(struct dsim_global *dsim,
+	unsigned int lock_time)
+{
+	writel(lock_time, dsim->reg_base + S5P_DSIM_PLLTMR);
+}
+
+void s5p_dsim_enable_pll(struct dsim_global *dsim, unsigned char enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x1 << DSIM_PLL_EN_SHIFT);
+
+	reg |= ((enable & 0x1) << DSIM_PLL_EN_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_set_byte_clock_src(struct dsim_global *dsim, unsigned char src)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(0x3 << DSIM_BYTE_CLK_SRC_SHIFT);
+
+	reg |= ((unsigned int) src) << DSIM_BYTE_CLK_SRC_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_enable_byte_clock(struct dsim_global *dsim,
+	unsigned char enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_BYTE_CLKEN_SHIFT);
+
+	reg |= enable << DSIM_BYTE_CLKEN_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_set_esc_clk_prs(struct dsim_global *dsim, unsigned char enable,
+	unsigned short prs_val)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_ESC_CLKEN_SHIFT) & ~(0xffff);
+
+	reg |= enable << DSIM_ESC_CLKEN_SHIFT;
+	if (enable)
+		reg |= prs_val;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_enable_esc_clk_on_lane(struct dsim_global *dsim,
+	unsigned char lane_sel, unsigned char enable)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_CLKCTRL);
+
+	if (enable) {
+		if (lane_sel & DSIM_LANE_CLOCK)
+			reg |= 1 << DSIM_LANE_ESC_CLKEN_SHIFT;
+		if (lane_sel & DSIM_LANE_DATA0)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 1);
+		if (lane_sel & DSIM_LANE_DATA1)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 2);
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 3);
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 4);
+	} else {
+		if (lane_sel & DSIM_LANE_CLOCK)
+			reg &= ~(1 << DSIM_LANE_ESC_CLKEN_SHIFT);
+		if (lane_sel & DSIM_LANE_DATA0)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 1));
+		if (lane_sel & DSIM_LANE_DATA1)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 2));
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 3));
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 4));
+	}
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_force_dphy_stop_state(struct dsim_global *dsim,
+	unsigned char enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_ESCMODE)) &
+		~(0x1 << DSIM_FORCE_STOP_STATE_SHIFT);
+
+	reg |= ((enable & 0x1) << DSIM_FORCE_STOP_STATE_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+unsigned char s5p_dsim_is_lane_state(struct dsim_global *dsim,
+	unsigned char lane)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_STATUS);
+
+	if ((lane & DSIM_LANE_ALL) > DSIM_LANE_CLOCK) { /* all lane state */
+		if ((reg & 0x7ff) ^ (((lane & 0xf) << 4) | (1 << 9)))
+			return DSIM_LANE_STATE_ULPS;
+		else if ((reg & 0x7ff) ^ (((lane & 0xf) << 0) | (1 << 8)))
+			return DSIM_LANE_STATE_STOP;
+		else {
+			dev_err(dsim->dev, "land state is unknown.\n");
+			return -1;
+		}
+	} else if (lane & DSIM_LANE_DATA_ALL) {	/* data lane */
+		if (reg & (lane << 4))
+			return DSIM_LANE_STATE_ULPS;
+		else if (reg & (lane << 0))
+			return DSIM_LANE_STATE_STOP;
+		else {
+			dev_err(dsim->dev, "data lane state is unknown.\n");
+			return -1;
+		}
+	} else if (lane & DSIM_LANE_CLOCK) { /* clock lane */
+		if (reg & (1 << 9))
+			return DSIM_LANE_STATE_ULPS;
+		else if (reg & (1 << 8))
+			return DSIM_LANE_STATE_STOP;
+		else if (reg & (1 << 10))
+			return DSIM_LANE_STATE_HS_READY;
+		else {
+			dev_err(dsim->dev, "data lane state is unknown.\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+void s5p_dsim_set_stop_state_counter(struct dsim_global *dsim,
+	unsigned short cnt_val)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_ESCMODE)) &
+		~(0x7ff << DSIM_STOP_STATE_CNT_SHIFT);
+
+	reg |= ((cnt_val & 0x7ff) << DSIM_STOP_STATE_CNT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_dsim_set_bta_timeout(struct dsim_global *dsim, unsigned char timeout)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)) &
+		~(0xff << DSIM_BTA_TOUT_SHIFT);
+
+	reg |= (timeout << DSIM_BTA_TOUT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
+}
+
+void s5p_dsim_set_lpdr_timeout(struct dsim_global *dsim,
+	unsigned short timeout)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)) &
+		~(0xffff << DSIM_LPDR_TOUT_SHIFT);
+
+	reg |= (timeout << DSIM_LPDR_TOUT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
+}
+
+void s5p_dsim_set_data_mode(struct dsim_global *dsim, unsigned char data,
+	unsigned char state)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_ESCMODE);
+
+	if (state = DSIM_STATE_HSCLKEN)
+		reg &= ~data;
+	else
+		reg |= data;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_dsim_enable_hs_clock(struct dsim_global *dsim, unsigned char enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_TX_REQUEST_HSCLK_SHIFT);
+
+	reg |= enable << DSIM_TX_REQUEST_HSCLK_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_dp_dn_swap(struct dsim_global *dsim, unsigned char swap_en)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PHYACCHR1);
+
+	reg &= ~(0x3 << 0);
+	reg |= (swap_en & 0x3) << 0;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR1);
+}
+
+void s5p_dsim_hs_zero_ctrl(struct dsim_global *dsim, unsigned char hs_zero)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0xf << 28);
+
+	reg |= ((hs_zero & 0xf) << 28);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_prep_ctrl(struct dsim_global *dsim, unsigned char prep)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x7 << 20);
+
+	reg |= ((prep & 0x7) << 20);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_clear_interrupt(struct dsim_global *dsim, unsigned int int_src)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	reg |= int_src;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
+}
+
+unsigned char s5p_dsim_is_pll_stable(struct dsim_global *dsim)
+{
+	return (unsigned char) ((readl(dsim->reg_base + S5P_DSIM_STATUS) &
+		    (1 << 31)) >> 31);
+}
+
+unsigned int s5p_dsim_get_fifo_state(struct dsim_global *dsim)
+{
+	unsigned int ret = 0;
+
+	ret = (readl(dsim->reg_base + S5P_DSIM_FIFOCTRL) & ~(0x1f));
+
+	return ret;
+}
+
+void s5p_dsim_wr_tx_header(struct dsim_global *dsim,
+	unsigned char di, unsigned char data0, unsigned char data1)
+{
+	unsigned int reg = (data1 << 16) | (data0 << 8) | ((di & 0x3f) << 0);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PKTHDR);
+}
+
+unsigned int _s5p_dsim_get_frame_done_status(struct dsim_global *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	return (reg & INTSRC_FRAME_DONE) ? 1 : 0;
+}
+
+void _s5p_dsim_clear_frame_done(struct dsim_global *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	writel(reg | INTSRC_FRAME_DONE, dsim->reg_base +
+		S5P_DSIM_INTSRC);
+}
+
+void s5p_dsim_wr_tx_data(struct dsim_global *dsim, unsigned int tx_data)
+{
+	writel(tx_data, dsim->reg_base + S5P_DSIM_PAYLOAD);
+}
diff --git a/drivers/video/s5p_dsim_lowlevel.h b/drivers/video/s5p_dsim_lowlevel
.h
new file mode 100644
index 0000000..ff950ba
--- /dev/null
+++ b/drivers/video/s5p_dsim_lowlevel.h
@@ -0,0 +1,101 @@
+/* linux/drivers/video/samsung/s5p_dsim_lowlevel.h
+ *
+ * Header file for Samsung MIPI-DSIM lowlevel driver.
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ * InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _S5P_DSIM_LOWLEVEL_H
+#define _S5P_DSIM_LOWLEVEL_H
+
+struct dsim_global;
+
+extern void s5p_dsim_func_reset(struct dsim_global *dsim);
+extern void s5p_dsim_sw_reset(struct dsim_global *dsim);
+extern void s5p_dsim_set_interrupt_mask(struct dsim_global *dsim,
+	unsigned int mode, unsigned int mask);
+extern void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
+	unsigned char count);
+extern void s5p_dsim_init_fifo_pointer(struct dsim_global *dsim,
+	unsigned char cfg);
+extern void s5p_dsim_set_phy_tunning(struct dsim_global *dsim,
+	unsigned int value);
+extern void s5p_dsim_set_phy_tunning(struct dsim_global *dsim,
+	unsigned int value);
+extern void s5p_dsim_set_main_disp_resol(struct dsim_global *dsim,
+	unsigned short vert_resol, unsigned short hori_resol);
+extern void s5p_dsim_set_main_disp_vporch(struct dsim_global *dsim,
+	unsigned short cmd_allow, unsigned short vfront, unsigned short vback);
+extern void s5p_dsim_set_main_disp_hporch(struct dsim_global *dsim,
+	unsigned short front, unsigned short back);
+extern void s5p_dsim_set_main_disp_sync_area(struct dsim_global *dsim,
+	unsigned short vert, unsigned short hori);
+extern void s5p_dsim_set_sub_disp_resol(struct dsim_global *dsim,
+	unsigned short vert, unsigned short hori);
+extern void s5p_dsim_init_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd_info,
+	struct dsim_lcd_config *sub_lcd_info, struct dsim_config *dsim_info);
+extern void s5p_dsim_display_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd);
+extern void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
+	unsigned char count);
+extern void s5p_dsim_enable_lane(struct dsim_global *dsim, unsigned char lane,
+	unsigned char enable);
+extern void s5p_dsim_enable_afc(struct dsim_global *dsim, unsigned char enable,
+	unsigned char afc_code);
+extern void s5p_dsim_enable_pll_bypass(struct dsim_global *dsim,
+	unsigned char enable);
+extern void s5p_dsim_set_pll_pms(struct dsim_global *dsim, unsigned char p,
+	unsigned short m, unsigned short s);
+extern void s5p_dsim_pll_freq_band(struct dsim_global *dsim,
+	unsigned char freq_band);
+extern void s5p_dsim_pll_freq(struct dsim_global *dsim,
+	unsigned char pre_divider, unsigned short main_divider,
+	unsigned char scaler);
+extern void s5p_dsim_pll_stable_time(struct dsim_global *dsim,
+	unsigned int lock_time);
+extern void s5p_dsim_enable_pll(struct dsim_global *dsim,
+	unsigned char enable);
+extern void s5p_dsim_set_byte_clock_src(struct dsim_global *dsim,
+	unsigned char src);
+extern void s5p_dsim_enable_byte_clock(struct dsim_global *dsim,
+	unsigned char enable);
+extern void s5p_dsim_set_esc_clk_prs(struct dsim_global *dsim,
+	unsigned char enable, unsigned short prs_val);
+extern void s5p_dsim_enable_esc_clk_on_lane(struct dsim_global *dsim,
+	unsigned char lane_sel, unsigned char enable);
+extern void s5p_dsim_force_dphy_stop_state(struct dsim_global *dsim,
+	unsigned char enable);
+extern unsigned char s5p_dsim_is_lane_state(struct dsim_global *dsim,
+	unsigned char lane);
+extern void s5p_dsim_set_stop_state_counter(struct dsim_global *dsim,
+	unsigned short cnt_val);
+extern void s5p_dsim_set_bta_timeout(struct dsim_global *dsim,
+	unsigned char timeout);
+extern void s5p_dsim_set_lpdr_timeout(struct dsim_global *dsim,
+	unsigned short timeout);
+extern void s5p_dsim_set_data_mode(struct dsim_global *dsim,
+	unsigned char data, unsigned char state);
+extern void s5p_dsim_enable_hs_clock(struct dsim_global *dsim,
+	unsigned char enable);
+extern void s5p_dsim_dp_dn_swap(struct dsim_global *dsim,
+	unsigned char swap_en);
+extern void s5p_dsim_hs_zero_ctrl(struct dsim_global *dsim,
+	unsigned char hs_zero);
+extern void s5p_dsim_prep_ctrl(struct dsim_global *dsim, unsigned char prep);
+extern void s5p_dsim_clear_interrupt(struct dsim_global *dsim,
+	unsigned int int_src);
+extern unsigned char s5p_dsim_is_pll_stable(struct dsim_global *dsim);
+extern unsigned int s5p_dsim_get_fifo_state(struct dsim_global *dsim);
+extern unsigned int _s5p_dsim_get_frame_done_status(struct dsim_global *dsim);
+extern void _s5p_dsim_clear_frame_done(struct dsim_global *dsim);
+extern void s5p_dsim_wr_tx_header(struct dsim_global *dsim,
+	unsigned char di, unsigned char data0, unsigned char data1);
+extern void s5p_dsim_wr_tx_data(struct dsim_global *dsim, unsigned int tx_data)
;
+
+#endif /* _S5P_DSIM_LOWLEVEL_H */




