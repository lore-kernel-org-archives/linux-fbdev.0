From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 08 Jul 2010 14:13:14 +0000
Subject: [PATCH 5/6 v2] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <Pine.LNX.4.64.1007081602570.32100@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some SH-Mobile SoCs have an HDMI controller and a PHY, attached to one of their
LCDC interfaces. This patch adds a preliminary static support for such
controllers, this means, that only the 720p mode is handled ATM. Support for
more modes and a dynamic switching between them will be added by a follow up
patch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:
1. Switched to using runtime pm in SH HDMI
2. Removed platform-specific clock configuration from the HDMI driver
3. Switched to using "clk_get(dev, "ick") for the interface clock
4. Removed accidental clk_enable / disable pair

 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 drivers/video/Kconfig                 |    8 +
 drivers/video/Makefile                |    1 +
 drivers/video/sh_mobile_hdmi.c        | 1028 +++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c      |  190 +++++--
 include/video/sh_mobile_hdmi.h        |   22 +
 6 files changed, 1200 insertions(+), 50 deletions(-)
 create mode 100644 drivers/video/sh_mobile_hdmi.c
 create mode 100644 include/video/sh_mobile_hdmi.h

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5d24d4e..3c61c9d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -792,6 +792,7 @@ static void __init ap4evb_init(void)
 
 static void __init ap4evb_timer_init(void)
 {
+	clk_set_rate(&dv_clki_clk, 27000000);
 	sh7372_clock_init();
 	shmobile_timer.init();
 }
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3dc1038..f00314f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1914,6 +1914,14 @@ config FB_SH_MOBILE_LCDC
 	---help---
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
 
+config FB_SH_MOBILE_HDMI
+	tristate "SuperH Mobile HDMI controller support"
+	depends on FB_SH_MOBILE_LCDC
+	select FB_MODE_HELPERS
+	select PM_RUNTIME
+	---help---
+	  Driver for the on-chip SH-Mobile HDMI controller.
+
 config FB_TMIO
 	tristate "Toshiba Mobile IO FrameBuffer support"
 	depends on FB && MFD_CORE
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 3c3bf86..e525827 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_FB_PS3)		  += ps3fb.o
 obj-$(CONFIG_FB_SM501)            += sm501fb.o
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_SH_MIPI_DSI)	  += sh_mipi_dsi.o
+obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  += sh_mobile_hdmi.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-y                             += omap2/
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
new file mode 100644
index 0000000..2fde08c
--- /dev/null
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -0,0 +1,1028 @@
+/*
+ * SH-Mobile High-Definition Multimedia Interface (HDMI) driver
+ * for SLISHDMI13T and SLIPHDMIT IP cores
+ *
+ * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <video/sh_mobile_hdmi.h>
+#include <video/sh_mobile_lcdc.h>
+
+#define HDMI_SYSTEM_CTRL			0x00 /* System control */
+#define HDMI_L_R_DATA_SWAP_CTRL_RPKT		0x01 /* L/R data swap control,
+							bits 19..16 of 20-bit N for Audio Clock Regeneration packet */
+#define HDMI_20_BIT_N_FOR_AUDIO_RPKT_15_8	0x02 /* bits 15..8 of 20-bit N for Audio Clock Regeneration packet */
+#define HDMI_20_BIT_N_FOR_AUDIO_RPKT_7_0	0x03 /* bits 7..0 of 20-bit N for Audio Clock Regeneration packet */
+#define HDMI_SPDIF_AUDIO_SAMP_FREQ_CTS		0x04 /* SPDIF audio sampling frequency,
+							bits 19..16 of Internal CTS */
+#define HDMI_INTERNAL_CTS_15_8			0x05 /* bits 15..8 of Internal CTS */
+#define HDMI_INTERNAL_CTS_7_0			0x06 /* bits 7..0 of Internal CTS */
+#define HDMI_EXTERNAL_CTS_19_16			0x07 /* External CTS */
+#define HDMI_EXTERNAL_CTS_15_8			0x08 /* External CTS */
+#define HDMI_EXTERNAL_CTS_7_0			0x09 /* External CTS */
+#define HDMI_AUDIO_SETTING_1			0x0A /* Audio setting.1 */
+#define HDMI_AUDIO_SETTING_2			0x0B /* Audio setting.2 */
+#define HDMI_I2S_AUDIO_SET			0x0C /* I2S audio setting */
+#define HDMI_DSD_AUDIO_SET			0x0D /* DSD audio setting */
+#define HDMI_DEBUG_MONITOR_1			0x0E /* Debug monitor.1 */
+#define HDMI_DEBUG_MONITOR_2			0x0F /* Debug monitor.2 */
+#define HDMI_I2S_INPUT_PIN_SWAP			0x10 /* I2S input pin swap */
+#define HDMI_AUDIO_STATUS_BITS_SETTING_1	0x11 /* Audio status bits setting.1 */
+#define HDMI_AUDIO_STATUS_BITS_SETTING_2	0x12 /* Audio status bits setting.2 */
+#define HDMI_CATEGORY_CODE			0x13 /* Category code */
+#define HDMI_SOURCE_NUM_AUDIO_WORD_LEN		0x14 /* Source number/Audio word length */
+#define HDMI_AUDIO_VIDEO_SETTING_1		0x15 /* Audio/Video setting.1 */
+#define HDMI_VIDEO_SETTING_1			0x16 /* Video setting.1 */
+#define HDMI_DEEP_COLOR_MODES			0x17 /* Deep Color Modes */
+
+/* 12 16- and 10-bit Color space conversion parameters: 0x18..0x2f */
+#define HDMI_COLOR_SPACE_CONVERSION_PARAMETERS	0x18
+
+#define HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS	0x30 /* External video parameter settings */
+#define HDMI_EXTERNAL_H_TOTAL_7_0		0x31 /* External horizontal total (LSB) */
+#define HDMI_EXTERNAL_H_TOTAL_11_8		0x32 /* External horizontal total (MSB) */
+#define HDMI_EXTERNAL_H_BLANK_7_0		0x33 /* External horizontal blank (LSB) */
+#define HDMI_EXTERNAL_H_BLANK_9_8		0x34 /* External horizontal blank (MSB) */
+#define HDMI_EXTERNAL_H_DELAY_7_0		0x35 /* External horizontal delay (LSB) */
+#define HDMI_EXTERNAL_H_DELAY_9_8		0x36 /* External horizontal delay (MSB) */
+#define HDMI_EXTERNAL_H_DURATION_7_0		0x37 /* External horizontal duration (LSB) */
+#define HDMI_EXTERNAL_H_DURATION_9_8		0x38 /* External horizontal duration (MSB) */
+#define HDMI_EXTERNAL_V_TOTAL_7_0		0x39 /* External vertical total (LSB) */
+#define HDMI_EXTERNAL_V_TOTAL_9_8		0x3A /* External vertical total (MSB) */
+#define HDMI_AUDIO_VIDEO_SETTING_2		0x3B /* Audio/Video setting.2 */
+#define HDMI_EXTERNAL_V_BLANK			0x3D /* External vertical blank */
+#define HDMI_EXTERNAL_V_DELAY			0x3E /* External vertical delay */
+#define HDMI_EXTERNAL_V_DURATION		0x3F /* External vertical duration */
+#define HDMI_CTRL_PKT_MANUAL_SEND_CONTROL	0x40 /* Control packet manual send control */
+#define HDMI_CTRL_PKT_AUTO_SEND			0x41 /* Control packet auto send with VSYNC control */
+#define HDMI_AUTO_CHECKSUM_OPTION		0x42 /* Auto checksum option */
+#define HDMI_VIDEO_SETTING_2			0x45 /* Video setting.2 */
+#define HDMI_OUTPUT_OPTION			0x46 /* Output option */
+#define HDMI_SLIPHDMIT_PARAM_OPTION		0x51 /* SLIPHDMIT parameter option */
+#define HDMI_HSYNC_PMENT_AT_EMB_7_0		0x52 /* HSYNC placement at embedded sync (LSB) */
+#define HDMI_HSYNC_PMENT_AT_EMB_15_8		0x53 /* HSYNC placement at embedded sync (MSB) */
+#define HDMI_VSYNC_PMENT_AT_EMB_7_0		0x54 /* VSYNC placement at embedded sync (LSB) */
+#define HDMI_VSYNC_PMENT_AT_EMB_14_8		0x55 /* VSYNC placement at embedded sync (MSB) */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_1		0x56 /* SLIPHDMIT parameter settings.1 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_2		0x57 /* SLIPHDMIT parameter settings.2 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_3		0x58 /* SLIPHDMIT parameter settings.3 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_5		0x59 /* SLIPHDMIT parameter settings.5 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_6		0x5A /* SLIPHDMIT parameter settings.6 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_7		0x5B /* SLIPHDMIT parameter settings.7 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_8		0x5C /* SLIPHDMIT parameter settings.8 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_9		0x5D /* SLIPHDMIT parameter settings.9 */
+#define HDMI_SLIPHDMIT_PARAM_SETTINGS_10	0x5E /* SLIPHDMIT parameter settings.10 */
+#define HDMI_CTRL_PKT_BUF_INDEX			0x5F /* Control packet buffer index */
+#define HDMI_CTRL_PKT_BUF_ACCESS_HB0		0x60 /* Control packet data buffer access window - HB0 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_HB1		0x61 /* Control packet data buffer access window - HB1 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_HB2		0x62 /* Control packet data buffer access window - HB2 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB0		0x63 /* Control packet data buffer access window - PB0 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB1		0x64 /* Control packet data buffer access window - PB1 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB2		0x65 /* Control packet data buffer access window - PB2 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB3		0x66 /* Control packet data buffer access window - PB3 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB4		0x67 /* Control packet data buffer access window - PB4 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB5		0x68 /* Control packet data buffer access window - PB5 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB6		0x69 /* Control packet data buffer access window - PB6 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB7		0x6A /* Control packet data buffer access window - PB7 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB8		0x6B /* Control packet data buffer access window - PB8 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB9		0x6C /* Control packet data buffer access window - PB9 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB10		0x6D /* Control packet data buffer access window - PB10 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB11		0x6E /* Control packet data buffer access window - PB11 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB12		0x6F /* Control packet data buffer access window - PB12 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB13		0x70 /* Control packet data buffer access window - PB13 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB14		0x71 /* Control packet data buffer access window - PB14 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB15		0x72 /* Control packet data buffer access window - PB15 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB16		0x73 /* Control packet data buffer access window - PB16 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB17		0x74 /* Control packet data buffer access window - PB17 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB18		0x75 /* Control packet data buffer access window - PB18 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB19		0x76 /* Control packet data buffer access window - PB19 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB20		0x77 /* Control packet data buffer access window - PB20 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB21		0x78 /* Control packet data buffer access window - PB21 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB22		0x79 /* Control packet data buffer access window - PB22 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB23		0x7A /* Control packet data buffer access window - PB23 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB24		0x7B /* Control packet data buffer access window - PB24 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB25		0x7C /* Control packet data buffer access window - PB25 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB26		0x7D /* Control packet data buffer access window - PB26 */
+#define HDMI_CTRL_PKT_BUF_ACCESS_PB27		0x7E /* Control packet data buffer access window - PB27 */
+#define HDMI_EDID_KSV_FIFO_ACCESS_WINDOW	0x80 /* EDID/KSV FIFO access window */
+#define HDMI_DDC_BUS_ACCESS_FREQ_CTRL_7_0	0x81 /* DDC bus access frequency control (LSB) */
+#define HDMI_DDC_BUS_ACCESS_FREQ_CTRL_15_8	0x82 /* DDC bus access frequency control (MSB) */
+#define HDMI_INTERRUPT_MASK_1			0x92 /* Interrupt mask.1 */
+#define HDMI_INTERRUPT_MASK_2			0x93 /* Interrupt mask.2 */
+#define HDMI_INTERRUPT_STATUS_1			0x94 /* Interrupt status.1 */
+#define HDMI_INTERRUPT_STATUS_2			0x95 /* Interrupt status.2 */
+#define HDMI_INTERRUPT_MASK_3			0x96 /* Interrupt mask.3 */
+#define HDMI_INTERRUPT_MASK_4			0x97 /* Interrupt mask.4 */
+#define HDMI_INTERRUPT_STATUS_3			0x98 /* Interrupt status.3 */
+#define HDMI_INTERRUPT_STATUS_4			0x99 /* Interrupt status.4 */
+#define HDMI_SOFTWARE_HDCP_CONTROL_1		0x9A /* Software HDCP control.1 */
+#define HDMI_FRAME_COUNTER			0x9C /* Frame counter */
+#define HDMI_FRAME_COUNTER_FOR_RI_CHECK		0x9D /* Frame counter for Ri check */
+#define HDMI_HDCP_CONTROL			0xAF /* HDCP control */
+#define HDMI_RI_FRAME_COUNT_REGISTER		0xB2 /* Ri frame count register */
+#define HDMI_DDC_BUS_CONTROL			0xB7 /* DDC bus control */
+#define HDMI_HDCP_STATUS			0xB8 /* HDCP status */
+#define HDMI_SHA0				0xB9 /* sha0 */
+#define HDMI_SHA1				0xBA /* sha1 */
+#define HDMI_SHA2				0xBB /* sha2 */
+#define HDMI_SHA3				0xBC /* sha3 */
+#define HDMI_SHA4				0xBD /* sha4 */
+#define HDMI_BCAPS_READ				0xBE /* BCAPS read / debug */
+#define HDMI_AKSV_BKSV_7_0_MONITOR		0xBF /* AKSV/BKSV[7:0] monitor */
+#define HDMI_AKSV_BKSV_15_8_MONITOR		0xC0 /* AKSV/BKSV[15:8] monitor */
+#define HDMI_AKSV_BKSV_23_16_MONITOR		0xC1 /* AKSV/BKSV[23:16] monitor */
+#define HDMI_AKSV_BKSV_31_24_MONITOR		0xC2 /* AKSV/BKSV[31:24] monitor */
+#define HDMI_AKSV_BKSV_39_32_MONITOR		0xC3 /* AKSV/BKSV[39:32] monitor */
+#define HDMI_EDID_SEGMENT_POINTER		0xC4 /* EDID segment pointer */
+#define HDMI_EDID_WORD_ADDRESS			0xC5 /* EDID word address */
+#define HDMI_EDID_DATA_FIFO_ADDRESS		0xC6 /* EDID data FIFO address */
+#define HDMI_NUM_OF_HDMI_DEVICES		0xC7 /* Number of HDMI devices */
+#define HDMI_HDCP_ERROR_CODE			0xC8 /* HDCP error code */
+#define HDMI_100MS_TIMER_SET			0xC9 /* 100ms timer setting */
+#define HDMI_5SEC_TIMER_SET			0xCA /* 5sec timer setting */
+#define HDMI_RI_READ_COUNT			0xCB /* Ri read count */
+#define HDMI_AN_SEED				0xCC /* An seed */
+#define HDMI_MAX_NUM_OF_RCIVRS_ALLOWED		0xCD /* Maximum number of receivers allowed */
+#define HDMI_HDCP_MEMORY_ACCESS_CONTROL_1	0xCE /* HDCP memory access control.1 */
+#define HDMI_HDCP_MEMORY_ACCESS_CONTROL_2	0xCF /* HDCP memory access control.2 */
+#define HDMI_HDCP_CONTROL_2			0xD0 /* HDCP Control 2 */
+#define HDMI_HDCP_KEY_MEMORY_CONTROL		0xD2 /* HDCP Key Memory Control */
+#define HDMI_COLOR_SPACE_CONV_CONFIG_1		0xD3 /* Color space conversion configuration.1 */
+#define HDMI_VIDEO_SETTING_3			0xD4 /* Video setting.3 */
+#define HDMI_RI_7_0				0xD5 /* Ri[7:0] */
+#define HDMI_RI_15_8				0xD6 /* Ri[15:8] */
+#define HDMI_PJ					0xD7 /* Pj */
+#define HDMI_SHA_RD				0xD8 /* sha_rd */
+#define HDMI_RI_7_0_SAVED			0xD9 /* Ri[7:0] saved */
+#define HDMI_RI_15_8_SAVED			0xDA /* Ri[15:8] saved */
+#define HDMI_PJ_SAVED				0xDB /* Pj saved */
+#define HDMI_NUM_OF_DEVICES			0xDC /* Number of devices */
+#define HDMI_HOT_PLUG_MSENS_STATUS		0xDF /* Hot plug/MSENS status */
+#define HDMI_BCAPS_WRITE			0xE0 /* bcaps */
+#define HDMI_BSTAT_7_0				0xE1 /* bstat[7:0] */
+#define HDMI_BSTAT_15_8				0xE2 /* bstat[15:8] */
+#define HDMI_BKSV_7_0				0xE3 /* bksv[7:0] */
+#define HDMI_BKSV_15_8				0xE4 /* bksv[15:8] */
+#define HDMI_BKSV_23_16				0xE5 /* bksv[23:16] */
+#define HDMI_BKSV_31_24				0xE6 /* bksv[31:24] */
+#define HDMI_BKSV_39_32				0xE7 /* bksv[39:32] */
+#define HDMI_AN_7_0				0xE8 /* An[7:0] */
+#define HDMI_AN_15_8				0xE9 /* An [15:8] */
+#define HDMI_AN_23_16				0xEA /* An [23:16] */
+#define HDMI_AN_31_24				0xEB /* An [31:24] */
+#define HDMI_AN_39_32				0xEC /* An [39:32] */
+#define HDMI_AN_47_40				0xED /* An [47:40] */
+#define HDMI_AN_55_48				0xEE /* An [55:48] */
+#define HDMI_AN_63_56				0xEF /* An [63:56] */
+#define HDMI_PRODUCT_ID				0xF0 /* Product ID */
+#define HDMI_REVISION_ID			0xF1 /* Revision ID */
+#define HDMI_TEST_MODE				0xFE /* Test mode */
+
+enum hotplug_state {
+	HDMI_HOTPLUG_DISCONNECTED,
+	HDMI_HOTPLUG_CONNECTED,
+	HDMI_HOTPLUG_EDID_DONE,
+};
+
+struct sh_hdmi {
+	void __iomem *base;
+	enum hotplug_state hp_state;
+	struct clk *hdmi_clk;
+	struct device *dev;
+	struct fb_info *info;
+	struct delayed_work edid_work;
+	struct fb_var_screeninfo var;
+};
+
+static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
+{
+	iowrite8(data, hdmi->base + reg);
+}
+
+static u8 hdmi_read(struct sh_hdmi *hdmi, u8 reg)
+{
+	return ioread8(hdmi->base + reg);
+}
+
+/* External video parameter settings */
+static void hdmi_external_video_param(struct sh_hdmi *hdmi)
+{
+	struct fb_var_screeninfo *var = &hdmi->var;
+	u16 htotal, hblank, hdelay, vtotal, vblank, vdelay, voffset;
+	u8 sync = 0;
+
+	htotal = var->xres + var->right_margin + var->left_margin + var->hsync_len;
+
+	hdelay = var->hsync_len + var->left_margin;
+	hblank = var->right_margin + hdelay;
+
+	/*
+	 * Vertical timing looks a bit different in Figure 18,
+	 * but let's try the same first by setting offset = 0
+	 */
+	vtotal = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
+
+	vdelay = var->vsync_len + var->upper_margin;
+	vblank = var->lower_margin + vdelay;
+	voffset = min(var->upper_margin / 2, 6U);
+
+	/*
+	 * [3]: VSYNC polarity: Positive
+	 * [2]: HSYNC polarity: Positive
+	 * [1]: Interlace/Progressive: Progressive
+	 * [0]: External video settings enable: used.
+	 */
+	if (var->sync & FB_SYNC_HOR_HIGH_ACT)
+		sync |= 4;
+	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
+		sync |= 8;
+
+	pr_debug("H: %u, %u, %u, %u; V: %u, %u, %u, %u; sync 0x%x\n",
+		 htotal, hblank, hdelay, var->hsync_len,
+		 vtotal, vblank, vdelay, var->vsync_len, sync);
+
+	hdmi_write(hdmi, sync | (voffset << 4), HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS);
+
+	hdmi_write(hdmi, htotal, HDMI_EXTERNAL_H_TOTAL_7_0);
+	hdmi_write(hdmi, htotal >> 8, HDMI_EXTERNAL_H_TOTAL_11_8);
+
+	hdmi_write(hdmi, hblank, HDMI_EXTERNAL_H_BLANK_7_0);
+	hdmi_write(hdmi, hblank >> 8, HDMI_EXTERNAL_H_BLANK_9_8);
+
+	hdmi_write(hdmi, hdelay, HDMI_EXTERNAL_H_DELAY_7_0);
+	hdmi_write(hdmi, hdelay >> 8, HDMI_EXTERNAL_H_DELAY_9_8);
+
+	hdmi_write(hdmi, var->hsync_len, HDMI_EXTERNAL_H_DURATION_7_0);
+	hdmi_write(hdmi, var->hsync_len >> 8, HDMI_EXTERNAL_H_DURATION_9_8);
+
+	hdmi_write(hdmi, vtotal, HDMI_EXTERNAL_V_TOTAL_7_0);
+	hdmi_write(hdmi, vtotal >> 8, HDMI_EXTERNAL_V_TOTAL_9_8);
+
+	hdmi_write(hdmi, vblank, HDMI_EXTERNAL_V_BLANK);
+
+	hdmi_write(hdmi, vdelay, HDMI_EXTERNAL_V_DELAY);
+
+	hdmi_write(hdmi, var->vsync_len, HDMI_EXTERNAL_V_DURATION);
+
+	/* Set bit 0 of HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS here for manual mode */
+}
+
+/**
+ * sh_hdmi_video_config()
+ */
+static void sh_hdmi_video_config(struct sh_hdmi *hdmi)
+{
+	/*
+	 * [7:4]: Audio sampling frequency: 48kHz
+	 * [3:1]: Input video format: RGB and YCbCr 4:4:4 (Y on Green)
+	 * [0]: Internal/External DE select: internal
+	 */
+	hdmi_write(hdmi, 0x20, HDMI_AUDIO_VIDEO_SETTING_1);
+
+	/*
+	 * [7:6]: Video output format: RGB 4:4:4
+	 * [5:4]: Input video data width: 8 bit
+	 * [3:1]: EAV/SAV location: channel 1
+	 * [0]: Video input color space: RGB
+	 */
+	hdmi_write(hdmi, 0x34, HDMI_VIDEO_SETTING_1);
+
+	/*
+	 * [7:6]: Together with bit [6] of HDMI_AUDIO_VIDEO_SETTING_2, which is
+	 * left at 0 by default, this configures 24bpp and sets the Color Depth
+	 * (CD) field in the General Control Packet
+	 */
+	hdmi_write(hdmi, 0x20, HDMI_DEEP_COLOR_MODES);
+}
+
+/**
+ * sh_hdmi_audio_config()
+ */
+static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
+{
+	/*
+	 * [7:4] L/R data swap control
+	 * [3:0] appropriate N[19:16]
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_L_R_DATA_SWAP_CTRL_RPKT);
+	/* appropriate N[15:8] */
+	hdmi_write(hdmi, 0x18, HDMI_20_BIT_N_FOR_AUDIO_RPKT_15_8);
+	/* appropriate N[7:0] */
+	hdmi_write(hdmi, 0x00, HDMI_20_BIT_N_FOR_AUDIO_RPKT_7_0);
+
+	/* [7:4] 48 kHz	SPDIF not used */
+	hdmi_write(hdmi, 0x20, HDMI_SPDIF_AUDIO_SAMP_FREQ_CTS);
+
+	/*
+	 * [6:5] set required down sampling rate if required
+	 * [4:3] set required audio source
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_AUDIO_SETTING_1);
+
+	/* [3:0] set sending channel number for channel status */
+	hdmi_write(hdmi, 0x40, HDMI_AUDIO_SETTING_2);
+
+	/*
+	 * [5:2] set valid I2S source input pin
+	 * [1:0] set input I2S source mode
+	 */
+	hdmi_write(hdmi, 0x04, HDMI_I2S_AUDIO_SET);
+
+	/* [7:4] set valid DSD source input pin */
+	hdmi_write(hdmi, 0x00, HDMI_DSD_AUDIO_SET);
+
+	/* [7:0] set appropriate I2S input pin swap settings if required */
+	hdmi_write(hdmi, 0x00, HDMI_I2S_INPUT_PIN_SWAP);
+
+	/*
+	 * [7] set validity bit for channel status
+	 * [3:0] set original sample frequency for channel status
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_AUDIO_STATUS_BITS_SETTING_1);
+
+	/*
+	 * [7] set value for channel status
+	 * [6] set value for channel status
+	 * [5] set copyright bit for channel status
+	 * [4:2] set additional information for channel status
+	 * [1:0] set clock accuracy for channel status
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_AUDIO_STATUS_BITS_SETTING_2);
+
+	/* [7:0] set category code for channel status */
+	hdmi_write(hdmi, 0x00, HDMI_CATEGORY_CODE);
+
+	/*
+	 * [7:4] set source number for channel status
+	 * [3:0] set word length for channel status
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_SOURCE_NUM_AUDIO_WORD_LEN);
+
+	/* [7:4] set sample frequency for channel status */
+	hdmi_write(hdmi, 0x20, HDMI_AUDIO_VIDEO_SETTING_1);
+}
+
+/**
+ * sh_hdmi_phy_config()
+ */
+static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
+{
+	/* 720p, 8bit, 74.25MHz. Might need to be adjusted for other formats */
+	hdmi_write(hdmi, 0x19, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
+	hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_2);
+	hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_3);
+	/* PLLA_CONFIG[7:0]: VCO gain, VCO offset, LPF resistance[0] */
+	hdmi_write(hdmi, 0x44, HDMI_SLIPHDMIT_PARAM_SETTINGS_5);
+	hdmi_write(hdmi, 0x32, HDMI_SLIPHDMIT_PARAM_SETTINGS_6);
+	hdmi_write(hdmi, 0x4A, HDMI_SLIPHDMIT_PARAM_SETTINGS_7);
+	hdmi_write(hdmi, 0x0E, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
+	hdmi_write(hdmi, 0x25, HDMI_SLIPHDMIT_PARAM_SETTINGS_9);
+	hdmi_write(hdmi, 0x04, HDMI_SLIPHDMIT_PARAM_SETTINGS_10);
+}
+
+/**
+ * sh_hdmi_avi_infoframe_setup() - Auxiliary Video Information InfoFrame CONTROL PACKET
+ */
+static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
+{
+	/* AVI InfoFrame */
+	hdmi_write(hdmi, 0x06, HDMI_CTRL_PKT_BUF_INDEX);
+
+	/* Packet Type = 0x82 */
+	hdmi_write(hdmi, 0x82, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
+
+	/* Version = 0x02 */
+	hdmi_write(hdmi, 0x02, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
+
+	/* Length = 13 (0x0D) */
+	hdmi_write(hdmi, 0x0D, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
+
+	/* N. A. Checksum */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0);
+
+	/*
+	 * Y = RGB
+	 * A0 = No Data
+	 * B = Bar Data not valid
+	 * S = No Data
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB1);
+
+	/*
+	 * C = No Data
+	 * M = 16:9 Picture Aspect Ratio
+	 * R = Same as picture aspect ratio
+	 */
+	hdmi_write(hdmi, 0x28, HDMI_CTRL_PKT_BUF_ACCESS_PB2);
+
+	/*
+	 * ITC = No Data
+	 * EC = xvYCC601
+	 * Q = Default (depends on video format)
+	 * SC = No Known non_uniform Scaling
+	 */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB3);
+
+	/*
+	 * VIC = 1280 x 720p: ignored if external config is used
+	 * Send 2 for 720 x 480p, 16 for 1080p
+	 */
+	hdmi_write(hdmi, 4, HDMI_CTRL_PKT_BUF_ACCESS_PB4);
+
+	/* PR = No Repetition */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB5);
+
+	/* Line Number of End of Top Bar (lower 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB6);
+
+	/* Line Number of End of Top Bar (upper 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB7);
+
+	/* Line Number of Start of Bottom Bar (lower 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB8);
+
+	/* Line Number of Start of Bottom Bar (upper 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB9);
+
+	/* Pixel Number of End of Left Bar (lower 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB10);
+
+	/* Pixel Number of End of Left Bar (upper 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB11);
+
+	/* Pixel Number of Start of Right Bar (lower 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB12);
+
+	/* Pixel Number of Start of Right Bar (upper 8 bits) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB13);
+}
+
+/**
+ * sh_hdmi_audio_infoframe_setup() - Audio InfoFrame of CONTROL PACKET
+ */
+static void sh_hdmi_audio_infoframe_setup(struct sh_hdmi *hdmi)
+{
+	/* Audio InfoFrame */
+	hdmi_write(hdmi, 0x08, HDMI_CTRL_PKT_BUF_INDEX);
+
+	/* Packet Type = 0x84 */
+	hdmi_write(hdmi, 0x84, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
+
+	/* Version Number = 0x01 */
+	hdmi_write(hdmi, 0x01, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
+
+	/* 0 Length = 10 (0x0A) */
+	hdmi_write(hdmi, 0x0A, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
+
+	/* n. a. Checksum */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0);
+
+	/* Audio Channel Count = Refer to Stream Header */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB1);
+
+	/* Refer to Stream Header */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB2);
+
+	/* Format depends on coding type (i.e. CT0...CT3) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB3);
+
+	/* Speaker Channel Allocation = Front Right + Front Left */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB4);
+
+	/* Level Shift Value = 0 dB, Down - mix is permitted or no information */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB5);
+
+	/* Reserved (0) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB6);
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB7);
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB8);
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB9);
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB10);
+}
+
+/**
+ * sh_hdmi_gamut_metadata_setup() - Gamut Metadata Packet of CONTROL PACKET
+ */
+static void sh_hdmi_gamut_metadata_setup(struct sh_hdmi *hdmi)
+{
+	int i;
+
+	/* Gamut Metadata Packet */
+	hdmi_write(hdmi, 0x04, HDMI_CTRL_PKT_BUF_INDEX);
+
+	/* Packet Type = 0x0A */
+	hdmi_write(hdmi, 0x0A, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
+	/* Gamut Packet is not used, so default value */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
+	/* Gamut Packet is not used, so default value */
+	hdmi_write(hdmi, 0x10, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
+
+	/* GBD bytes 0 through 27 */
+	for (i = 0; i <= 27; i++)
+		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0_63H - PB27_7EH */
+		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
+}
+
+/**
+ * sh_hdmi_acp_setup() - Audio Content Protection Packet (ACP)
+ */
+static void sh_hdmi_acp_setup(struct sh_hdmi *hdmi)
+{
+	int i;
+
+	/* Audio Content Protection Packet (ACP) */
+	hdmi_write(hdmi, 0x01, HDMI_CTRL_PKT_BUF_INDEX);
+
+	/* Packet Type = 0x04 */
+	hdmi_write(hdmi, 0x04, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
+	/* ACP_Type */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
+	/* Reserved (0) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
+
+	/* GBD bytes 0 through 27 */
+	for (i = 0; i <= 27; i++)
+		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0 - PB27 */
+		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
+}
+
+/**
+ * sh_hdmi_isrc1_setup() - ISRC1 Packet
+ */
+static void sh_hdmi_isrc1_setup(struct sh_hdmi *hdmi)
+{
+	int i;
+
+	/* ISRC1 Packet */
+	hdmi_write(hdmi, 0x02, HDMI_CTRL_PKT_BUF_INDEX);
+
+	/* Packet Type = 0x05 */
+	hdmi_write(hdmi, 0x05, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
+	/* ISRC_Cont, ISRC_Valid, Reserved (0), ISRC_Status */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
+	/* Reserved (0) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
+
+	/* PB0 UPC_EAN_ISRC_0-15 */
+	/* Bytes PB16-PB27 shall be set to a value of 0. */
+	for (i = 0; i <= 27; i++)
+		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0 - PB27 */
+		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
+}
+
+/**
+ * sh_hdmi_isrc2_setup() - ISRC2 Packet
+ */
+static void sh_hdmi_isrc2_setup(struct sh_hdmi *hdmi)
+{
+	int i;
+
+	/* ISRC2 Packet */
+	hdmi_write(hdmi, 0x03, HDMI_CTRL_PKT_BUF_INDEX);
+
+	/* HB0 Packet Type = 0x06 */
+	hdmi_write(hdmi, 0x06, HDMI_CTRL_PKT_BUF_ACCESS_HB0);
+	/* Reserved (0) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB1);
+	/* Reserved (0) */
+	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_HB2);
+
+	/* PB0 UPC_EAN_ISRC_16-31 */
+	/* Bytes PB16-PB27 shall be set to a value of 0. */
+	for (i = 0; i <= 27; i++)
+		/* HDMI_CTRL_PKT_BUF_ACCESS_PB0 - PB27 */
+		hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB0 + i);
+}
+
+/**
+ * sh_hdmi_configure() - Initialise HDMI for output
+ */
+static void sh_hdmi_configure(struct sh_hdmi *hdmi)
+{
+	/* Configure video format */
+	sh_hdmi_video_config(hdmi);
+
+	/* Configure audio format */
+	sh_hdmi_audio_config(hdmi);
+
+	/* Configure PHY */
+	sh_hdmi_phy_config(hdmi);
+
+	/* Auxiliary Video Information (AVI) InfoFrame */
+	sh_hdmi_avi_infoframe_setup(hdmi);
+
+	/* Audio InfoFrame */
+	sh_hdmi_audio_infoframe_setup(hdmi);
+
+	/* Gamut Metadata packet */
+	sh_hdmi_gamut_metadata_setup(hdmi);
+
+	/* Audio Content Protection (ACP) Packet */
+	sh_hdmi_acp_setup(hdmi);
+
+	/* ISRC1 Packet */
+	sh_hdmi_isrc1_setup(hdmi);
+
+	/* ISRC2 Packet */
+	sh_hdmi_isrc2_setup(hdmi);
+
+	/*
+	 * Control packet auto send with VSYNC control: auto send
+	 * General control, Gamut metadata, ISRC, and ACP packets
+	 */
+	hdmi_write(hdmi, 0x8E, HDMI_CTRL_PKT_AUTO_SEND);
+
+	/* FIXME */
+	msleep(10);
+
+	/* PS mode b->d, reset PLLA and PLLB */
+	hdmi_write(hdmi, 0x4C, HDMI_SYSTEM_CTRL);
+
+	udelay(10);
+
+	hdmi_write(hdmi, 0x40, HDMI_SYSTEM_CTRL);
+}
+
+static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
+{
+	struct fb_var_screeninfo *var = &hdmi->var;
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+	struct fb_videomode *lcd_cfg = &pdata->lcd_chan->lcd_cfg;
+	unsigned long height = var->height, width = var->width;
+	int i;
+	u8 edid[128];
+
+	/* Read EDID */
+	pr_debug("Read back EDID code:");
+	for (i = 0; i < 128; i++) {
+		edid[i] = hdmi_read(hdmi, HDMI_EDID_KSV_FIFO_ACCESS_WINDOW);
+#ifdef DEBUG
+		if ((i % 16) = 0) {
+			printk(KERN_CONT "\n");
+			printk(KERN_DEBUG "%02X | %02X", i, edid[i]);
+		} else {
+			printk(KERN_CONT " %02X", edid[i]);
+		}
+#endif
+	}
+#ifdef DEBUG
+	printk(KERN_CONT "\n");
+#endif
+	fb_parse_edid(edid, var);
+	pr_debug("%u-%u-%u-%u x %u-%u-%u-%u @ %lu kHz monitor detected\n",
+		 var->left_margin, var->xres, var->right_margin, var->hsync_len,
+		 var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
+		 PICOS2KHZ(var->pixclock));
+
+	/* FIXME: Use user-provided configuration instead of EDID */
+	var->width		= width;
+	var->xres		= lcd_cfg->xres;
+	var->xres_virtual	= lcd_cfg->xres;
+	var->left_margin	= lcd_cfg->left_margin;
+	var->right_margin	= lcd_cfg->right_margin;
+	var->hsync_len		= lcd_cfg->hsync_len;
+	var->height		= height;
+	var->yres		= lcd_cfg->yres;
+	var->yres_virtual	= lcd_cfg->yres * 2;
+	var->upper_margin	= lcd_cfg->upper_margin;
+	var->lower_margin	= lcd_cfg->lower_margin;
+	var->vsync_len		= lcd_cfg->vsync_len;
+	var->sync		= lcd_cfg->sync;
+	var->pixclock		= lcd_cfg->pixclock;
+
+	hdmi_external_video_param(hdmi);
+}
+
+static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
+{
+	struct sh_hdmi *hdmi = dev_id;
+	u8 status1, status2, mask1, mask2;
+
+	/* mode_b and PLLA and PLLB reset */
+	hdmi_write(hdmi, 0x2C, HDMI_SYSTEM_CTRL);
+
+	/* How long shall reset be held? */
+	udelay(10);
+
+	/* mode_b and PLLA and PLLB reset release */
+	hdmi_write(hdmi, 0x20, HDMI_SYSTEM_CTRL);
+
+	status1 = hdmi_read(hdmi, HDMI_INTERRUPT_STATUS_1);
+	status2 = hdmi_read(hdmi, HDMI_INTERRUPT_STATUS_2);
+
+	mask1 = hdmi_read(hdmi, HDMI_INTERRUPT_MASK_1);
+	mask2 = hdmi_read(hdmi, HDMI_INTERRUPT_MASK_2);
+
+	/* Correct would be to ack only set bits, but the datasheet requires 0xff */
+	hdmi_write(hdmi, 0xFF, HDMI_INTERRUPT_STATUS_1);
+	hdmi_write(hdmi, 0xFF, HDMI_INTERRUPT_STATUS_2);
+
+	if (printk_ratelimit())
+		pr_debug("IRQ #%d: Status #1: 0x%x & 0x%x, #2: 0x%x & 0x%x\n",
+			 irq, status1, mask1, status2, mask2);
+
+	if (!((status1 & mask1) | (status2 & mask2))) {
+		return IRQ_NONE;
+	} else if (status1 & 0xc0) {
+		u8 msens;
+
+		/* Datasheet specifies 10ms... */
+		udelay(500);
+
+		msens = hdmi_read(hdmi, HDMI_HOT_PLUG_MSENS_STATUS);
+		pr_debug("MSENS 0x%x\n", msens);
+		/* Check, if hot plug & MSENS pin status are both high */
+		if ((msens & 0xC0) = 0xC0) {
+			/* Display plug in */
+			hdmi->hp_state = HDMI_HOTPLUG_CONNECTED;
+
+			/* Set EDID word address  */
+			hdmi_write(hdmi, 0x00, HDMI_EDID_WORD_ADDRESS);
+			/* Set EDID segment pointer */
+			hdmi_write(hdmi, 0x00, HDMI_EDID_SEGMENT_POINTER);
+			/* Enable EDID interrupt */
+			hdmi_write(hdmi, 0xC6, HDMI_INTERRUPT_MASK_1);
+		} else if (!(status1 & 0x80)) {
+			/* Display unplug, beware multiple interrupts */
+			if (hdmi->hp_state != HDMI_HOTPLUG_DISCONNECTED)
+				schedule_delayed_work(&hdmi->edid_work, 0);
+
+			hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
+			/* display_off will switch back to mode_a */
+		}
+	} else if (status1 & 2) {
+		/* EDID error interrupt: retry */
+		/* Set EDID word address  */
+		hdmi_write(hdmi, 0x00, HDMI_EDID_WORD_ADDRESS);
+		/* Set EDID segment pointer */
+		hdmi_write(hdmi, 0x00, HDMI_EDID_SEGMENT_POINTER);
+	} else if (status1 & 4) {
+		/* Disable EDID interrupt */
+		hdmi_write(hdmi, 0xC0, HDMI_INTERRUPT_MASK_1);
+		hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE;
+		schedule_delayed_work(&hdmi->edid_work, msecs_to_jiffies(10));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void hdmi_display_on(void *arg, struct fb_info *info)
+{
+	struct sh_hdmi *hdmi = arg;
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+
+	if (info->var.xres != 1280 || info->var.yres != 720) {
+		dev_warn(info->device, "Unsupported framebuffer geometry %ux%u\n",
+			 info->var.xres, info->var.yres);
+		return;
+	}
+
+	pr_debug("%s(%p): state %x\n", __func__, pdata->lcd_dev, info->state);
+	/*
+	 * FIXME: not a good place to store fb_info. And we cannot nullify it
+	 * even on monitor disconnect. What should the lifecycle be?
+	 */
+	hdmi->info = info;
+	switch (hdmi->hp_state) {
+	case HDMI_HOTPLUG_EDID_DONE:
+		/* PS mode d->e. All functions are active */
+		hdmi_write(hdmi, 0x80, HDMI_SYSTEM_CTRL);
+		pr_debug("HDMI running\n");
+		break;
+	case HDMI_HOTPLUG_DISCONNECTED:
+		info->state = FBINFO_STATE_SUSPENDED;
+	default:
+		hdmi->var = info->var;
+	}
+}
+
+static void hdmi_display_off(void *arg)
+{
+	struct sh_hdmi *hdmi = arg;
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+
+	pr_debug("%s(%p)\n", __func__, pdata->lcd_dev);
+	/* PS mode e->a */
+	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
+}
+
+/* Hotplug interrupt occurred, read EDID */
+static void edid_work_fn(struct work_struct *work)
+{
+	struct sh_hdmi *hdmi = container_of(work, struct sh_hdmi, edid_work.work);
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+
+	pr_debug("%s(%p): begin, hotplug status %d\n", __func__,
+		 pdata->lcd_dev, hdmi->hp_state);
+
+	if (!pdata->lcd_dev)
+		return;
+
+	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
+		pm_runtime_get_sync(hdmi->dev);
+		/* A device has been plugged in */
+		sh_hdmi_read_edid(hdmi);
+		msleep(10);
+		sh_hdmi_configure(hdmi);
+		/* Switched to another (d) power-save mode */
+		msleep(10);
+
+		if (!hdmi->info)
+			return;
+
+		acquire_console_sem();
+
+		/* HDMI plug in */
+		hdmi->info->var = hdmi->var;
+		if (hdmi->info->state != FBINFO_STATE_RUNNING)
+			fb_set_suspend(hdmi->info, 0);
+		else
+			hdmi_display_on(hdmi, hdmi->info);
+
+		release_console_sem();
+	} else {
+		if (!hdmi->info)
+			return;
+
+		acquire_console_sem();
+
+		/* HDMI disconnect */
+		fb_set_suspend(hdmi->info, 1);
+
+		release_console_sem();
+		pm_runtime_put(hdmi->dev);
+	}
+
+	pr_debug("%s(%p): end\n", __func__, pdata->lcd_dev);
+}
+
+static int __init sh_hdmi_probe(struct platform_device *pdev)
+{
+	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int irq = platform_get_irq(pdev, 0), ret;
+	struct sh_hdmi *hdmi;
+	long rate;
+
+	if (!res || !pdata || irq < 0)
+		return -ENODEV;
+
+	hdmi = kzalloc(sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi) {
+		dev_err(&pdev->dev, "Cannot allocate device data\n");
+		return -ENOMEM;
+	}
+
+	hdmi->dev = &pdev->dev;
+
+	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
+	if (IS_ERR(hdmi->hdmi_clk)) {
+		ret = PTR_ERR(hdmi->hdmi_clk);
+		dev_err(&pdev->dev, "Unable to get clock: %d\n", ret);
+		goto egetclk;
+	}
+
+	rate = PICOS2KHZ(pdata->lcd_chan->lcd_cfg.pixclock) * 1000;
+
+	rate = clk_round_rate(hdmi->hdmi_clk, rate);
+	if (rate < 0) {
+		ret = rate;
+		dev_err(&pdev->dev, "Cannot get suitable rate: %ld\n", rate);
+		goto erate;
+	}
+
+	ret = clk_set_rate(hdmi->hdmi_clk, rate);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot set rate %ld: %d\n", rate, ret);
+		goto erate;
+	}
+
+	pr_debug("HDMI set frequency %lu\n", rate);
+
+	ret = clk_enable(hdmi->hdmi_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot enable clock: %d\n", ret);
+		goto eclkenable;
+	}
+
+	dev_info(&pdev->dev, "Enabled HDMI clock at %luHz\n", rate);
+
+	if (!request_mem_region(res->start, resource_size(res), dev_name(&pdev->dev))) {
+		dev_err(&pdev->dev, "HDMI register region already claimed\n");
+		ret = -EBUSY;
+		goto ereqreg;
+	}
+
+	hdmi->base = ioremap(res->start, resource_size(res));
+	if (!hdmi->base) {
+		dev_err(&pdev->dev, "HDMI register region already claimed\n");
+		ret = -ENOMEM;
+		goto emap;
+	}
+
+	platform_set_drvdata(pdev, hdmi);
+
+#if 1
+	/* Product and revision IDs are 0 in sh-mobile version */
+	dev_info(&pdev->dev, "Detected HDMI controller 0x%x:0x%x\n",
+		 hdmi_read(hdmi, HDMI_PRODUCT_ID), hdmi_read(hdmi, HDMI_REVISION_ID));
+#endif
+
+	/* Set up LCDC callbacks */
+	pdata->lcd_chan->board_cfg.board_data = hdmi;
+	pdata->lcd_chan->board_cfg.display_on = hdmi_display_on;
+	pdata->lcd_chan->board_cfg.display_off = hdmi_display_off;
+
+	INIT_DELAYED_WORK(&hdmi->edid_work, edid_work_fn);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume(&pdev->dev);
+
+	ret = request_irq(irq, sh_hdmi_hotplug, 0,
+			  dev_name(&pdev->dev), hdmi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to request irq: %d\n", ret);
+		goto ereqirq;
+	}
+
+	return 0;
+
+ereqirq:
+	pm_runtime_disable(&pdev->dev);
+	iounmap(hdmi->base);
+emap:
+	release_mem_region(res->start, resource_size(res));
+ereqreg:
+	clk_disable(hdmi->hdmi_clk);
+eclkenable:
+erate:
+	clk_put(hdmi->hdmi_clk);
+egetclk:
+	kfree(hdmi);
+
+	return ret;
+}
+
+static int __exit sh_hdmi_remove(struct platform_device *pdev)
+{
+	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
+	struct sh_hdmi *hdmi = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int irq = platform_get_irq(pdev, 0);
+
+	pdata->lcd_chan->board_cfg.display_on = NULL;
+	pdata->lcd_chan->board_cfg.display_off = NULL;
+	pdata->lcd_chan->board_cfg.board_data = NULL;
+
+	free_irq(irq, hdmi);
+	pm_runtime_disable(&pdev->dev);
+	cancel_delayed_work_sync(&hdmi->edid_work);
+	clk_disable(hdmi->hdmi_clk);
+	clk_put(hdmi->hdmi_clk);
+	iounmap(hdmi->base);
+	release_mem_region(res->start, resource_size(res));
+	kfree(hdmi);
+
+	return 0;
+}
+
+static struct platform_driver sh_hdmi_driver = {
+	.remove		= __exit_p(sh_hdmi_remove),
+	.driver = {
+		.name	= "sh-mobile-hdmi",
+	},
+};
+
+static int __init sh_hdmi_init(void)
+{
+	return platform_driver_probe(&sh_hdmi_driver, sh_hdmi_probe);
+}
+module_init(sh_hdmi_init);
+
+static void __exit sh_hdmi_exit(void)
+{
+	platform_driver_unregister(&sh_hdmi_driver);
+}
+module_exit(sh_hdmi_exit);
+
+MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
+MODULE_DESCRIPTION("SuperH / ARM-shmobile HDMI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 060674a..fb58d40 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -56,6 +56,7 @@ static int lcdc_shared_regs[] = {
 /* per-channel registers */
 enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
        LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR,
+       LDHAJR,
        NR_CH_REGS };
 
 static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
@@ -74,6 +75,7 @@ static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDVLNR] = 0x450,
 	[LDVSYNR] = 0x454,
 	[LDPMR] = 0x460,
+	[LDHAJR] = 0x4a0,
 };
 
 static unsigned long lcdc_offs_sublcd[NR_CH_REGS] = {
@@ -137,6 +139,7 @@ struct sh_mobile_lcdc_priv {
 	struct clk *dot_clk;
 	unsigned long lddckr;
 	struct sh_mobile_lcdc_chan ch[2];
+	struct notifier_block notifier;
 	unsigned long saved_shared_regs[NR_SHARED_REGS];
 	int started;
 };
@@ -404,6 +407,56 @@ static void sh_mobile_lcdc_start_stop(struct sh_mobile_lcdc_priv *priv,
 		lcdc_write(priv, _LDDCKSTPR, 1); /* stop dotclock */
 }
 
+static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
+{
+	struct fb_var_screeninfo *var = &ch->info->var;
+	unsigned long h_total, hsync_pos;
+	u32 tmp;
+
+	tmp = ch->ldmt1r_value;
+	tmp |= (var->sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 1 << 28;
+	tmp |= (var->sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 1 << 27;
+	tmp |= (ch->cfg.flags & LCDC_FLAGS_DWPOL) ? 1 << 26 : 0;
+	tmp |= (ch->cfg.flags & LCDC_FLAGS_DIPOL) ? 1 << 25 : 0;
+	tmp |= (ch->cfg.flags & LCDC_FLAGS_DAPOL) ? 1 << 24 : 0;
+	tmp |= (ch->cfg.flags & LCDC_FLAGS_HSCNT) ? 1 << 17 : 0;
+	tmp |= (ch->cfg.flags & LCDC_FLAGS_DWCNT) ? 1 << 16 : 0;
+	lcdc_write_chan(ch, LDMT1R, tmp);
+
+	/* setup SYS bus */
+	lcdc_write_chan(ch, LDMT2R, ch->cfg.sys_bus_cfg.ldmt2r);
+	lcdc_write_chan(ch, LDMT3R, ch->cfg.sys_bus_cfg.ldmt3r);
+
+	/* horizontal configuration */
+	h_total = var->xres + var->hsync_len +
+		var->left_margin + var->right_margin;
+	tmp = h_total / 8; /* HTCN */
+	tmp |= (var->xres / 8) << 16; /* HDCN */
+	lcdc_write_chan(ch, LDHCNR, tmp);
+
+	hsync_pos = var->xres + var->right_margin;
+	tmp = hsync_pos / 8; /* HSYNP */
+	tmp |= (var->hsync_len / 8) << 16; /* HSYNW */
+	lcdc_write_chan(ch, LDHSYNR, tmp);
+
+	/* vertical configuration */
+	tmp = var->yres + var->vsync_len +
+		var->upper_margin + var->lower_margin; /* VTLN */
+	tmp |= var->yres << 16; /* VDLN */
+	lcdc_write_chan(ch, LDVLNR, tmp);
+
+	tmp = var->yres + var->lower_margin; /* VSYNP */
+	tmp |= var->vsync_len << 16; /* VSYNW */
+	lcdc_write_chan(ch, LDVSYNR, tmp);
+
+	/* Adjust horizontal synchronisation for HDMI */
+	tmp = ((var->xres & 7) << 24) |
+		((h_total & 7) << 16) |
+		((var->hsync_len & 7) << 8) |
+		hsync_pos;
+	lcdc_write_chan(ch, LDHAJR, tmp);
+}
+
 static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 {
 	struct sh_mobile_lcdc_chan *ch;
@@ -470,49 +523,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		if (!ch->enabled)
 			continue;
 
-		tmp = ch->ldmt1r_value;
-		tmp |= (lcd_cfg->sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 1 << 28;
-		tmp |= (lcd_cfg->sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 1 << 27;
-		tmp |= (ch->cfg.flags & LCDC_FLAGS_DWPOL) ? 1 << 26 : 0;
-		tmp |= (ch->cfg.flags & LCDC_FLAGS_DIPOL) ? 1 << 25 : 0;
-		tmp |= (ch->cfg.flags & LCDC_FLAGS_DAPOL) ? 1 << 24 : 0;
-		tmp |= (ch->cfg.flags & LCDC_FLAGS_HSCNT) ? 1 << 17 : 0;
-		tmp |= (ch->cfg.flags & LCDC_FLAGS_DWCNT) ? 1 << 16 : 0;
-		lcdc_write_chan(ch, LDMT1R, tmp);
-
-		/* setup SYS bus */
-		lcdc_write_chan(ch, LDMT2R, ch->cfg.sys_bus_cfg.ldmt2r);
-		lcdc_write_chan(ch, LDMT3R, ch->cfg.sys_bus_cfg.ldmt3r);
-
-		/* horizontal configuration */
-		tmp = lcd_cfg->xres + lcd_cfg->hsync_len;
-		tmp += lcd_cfg->left_margin;
-		tmp += lcd_cfg->right_margin;
-		tmp /= 8; /* HTCN */
-		tmp |= (lcd_cfg->xres / 8) << 16; /* HDCN */
-		lcdc_write_chan(ch, LDHCNR, tmp);
-
-		tmp = lcd_cfg->xres;
-		tmp += lcd_cfg->right_margin;
-		tmp /= 8; /* HSYNP */
-		tmp |= (lcd_cfg->hsync_len / 8) << 16; /* HSYNW */
-		lcdc_write_chan(ch, LDHSYNR, tmp);
+		sh_mobile_lcdc_geometry(ch);
 
 		/* power supply */
 		lcdc_write_chan(ch, LDPMR, 0);
 
-		/* vertical configuration */
-		tmp = lcd_cfg->yres + lcd_cfg->vsync_len;
-		tmp += lcd_cfg->upper_margin;
-		tmp += lcd_cfg->lower_margin; /* VTLN */
-		tmp |= lcd_cfg->yres << 16; /* VDLN */
-		lcdc_write_chan(ch, LDVLNR, tmp);
-
-		tmp = lcd_cfg->yres;
-		tmp += lcd_cfg->lower_margin; /* VSYNP */
-		tmp |= lcd_cfg->vsync_len << 16; /* VSYNW */
-		lcdc_write_chan(ch, LDVSYNR, tmp);
-
 		board_cfg = &ch->cfg.board_cfg;
 		if (board_cfg->setup_sys)
 			ret = board_cfg->setup_sys(board_cfg->board_data, ch,
@@ -892,6 +907,7 @@ static int sh_mobile_lcdc_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sh_mobile_lcdc_priv *p = platform_get_drvdata(pdev);
+	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	struct sh_mobile_lcdc_chan *ch;
 	int k, n;
 
@@ -900,6 +916,9 @@ static int sh_mobile_lcdc_runtime_suspend(struct device *dev)
 		ch = &p->ch[k];
 		if (!ch->enabled)
 			continue;
+		board_cfg = &ch->cfg.board_cfg;
+		if (board_cfg->display_off)
+			board_cfg->display_off(board_cfg->board_data);
 		for (n = 0; n < NR_CH_REGS; n++)
 			ch->saved_ch_regs[n] = lcdc_read_chan(ch, n);
 	}
@@ -917,16 +936,47 @@ static int sh_mobile_lcdc_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sh_mobile_lcdc_priv *p = platform_get_drvdata(pdev);
+	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	struct sh_mobile_lcdc_chan *ch;
 	int k, n;
 
 	/* restore per-channel registers */
 	for (k = 0; k < ARRAY_SIZE(p->ch); k++) {
+		struct fb_var_screeninfo *var;
+
 		ch = &p->ch[k];
-		if (!ch->enabled)
+		if (!ch->enabled || !ch->info)
 			continue;
+
+		board_cfg = &ch->cfg.board_cfg;
+		var = &ch->info->var;
+
+		/* HDMI must be enabled before LCDC configuration */
+		if (board_cfg->display_on)
+			board_cfg->display_on(board_cfg->board_data, ch->info);
+
+		/* Check if the new display is not in our modelist */
+		if (ch->info->modelist.next &&
+		    !fb_match_mode(var, &ch->info->modelist)) {
+			struct fb_videomode mode;
+			int ret;
+
+			/* Can we handle this display? */
+			if (var->xres > ch->cfg.lcd_cfg.xres ||
+			    var->yres > ch->cfg.lcd_cfg.yres)
+				return -ENOMEM;
+
+			/* Add to the modelist */
+			fb_var_to_videomode(&mode, var);
+			ret = fb_add_videomode(&mode, &ch->info->modelist);
+			if (ret < 0)
+				return ret;
+		}
+
 		for (n = 0; n < NR_CH_REGS; n++)
 			lcdc_write_chan(ch, n, ch->saved_ch_regs[n]);
+
+		sh_mobile_lcdc_geometry(ch);
 	}
 
 	/* restore shared registers */
@@ -943,6 +993,27 @@ static const struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
 	.runtime_resume = sh_mobile_lcdc_runtime_resume,
 };
 
+static int sh_mobile_lcdc_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct fb_event *event = data;
+	struct fb_info *info = event->info;
+
+	dev_dbg(info->dev, "%s(): action = %lu, data = %p\n",
+		__func__, action, event->data);
+
+	switch(action) {
+	case FB_EVENT_SUSPEND:
+		pm_runtime_put(info->device);
+		break;
+	case FB_EVENT_RESUME:
+		pm_runtime_get_sync(info->device);
+		break;
+	}
+
+	return 0;
+}
+
 static int sh_mobile_lcdc_remove(struct platform_device *pdev);
 
 static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
@@ -1031,6 +1102,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < j; i++) {
+		struct fb_var_screeninfo *var;
+		struct fb_videomode *lcd_cfg;
 		cfg = &priv->ch[i].cfg;
 
 		priv->ch[i].info = framebuffer_alloc(0, &pdev->dev);
@@ -1041,22 +1114,33 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		}
 
 		info = priv->ch[i].info;
+		var = &info->var;
+		lcd_cfg = &cfg->lcd_cfg;
 		info->fbops = &sh_mobile_lcdc_ops;
-		info->var.xres = info->var.xres_virtual = cfg->lcd_cfg.xres;
-		info->var.yres = cfg->lcd_cfg.yres;
+		var->xres = var->xres_virtual = lcd_cfg->xres;
+		var->yres = lcd_cfg->yres;
 		/* Default Y virtual resolution is 2x panel size */
-		info->var.yres_virtual = info->var.yres * 2;
-		info->var.width = cfg->lcd_size_cfg.width;
-		info->var.height = cfg->lcd_size_cfg.height;
-		info->var.activate = FB_ACTIVATE_NOW;
-		error = sh_mobile_lcdc_set_bpp(&info->var, cfg->bpp);
+		var->yres_virtual = var->yres * 2;
+		var->width = cfg->lcd_size_cfg.width;
+		var->height = cfg->lcd_size_cfg.height;
+		var->activate = FB_ACTIVATE_NOW;
+		var->left_margin = lcd_cfg->left_margin;
+		var->right_margin = lcd_cfg->right_margin;
+		var->upper_margin = lcd_cfg->upper_margin;
+		var->lower_margin = lcd_cfg->lower_margin;
+		var->hsync_len = lcd_cfg->hsync_len;
+		var->vsync_len = lcd_cfg->vsync_len;
+		var->sync = lcd_cfg->sync;
+		var->pixclock = lcd_cfg->pixclock;
+
+		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
 		if (error)
 			break;
 
 		info->fix = sh_mobile_lcdc_fix;
-		info->fix.line_length = cfg->lcd_cfg.xres * (cfg->bpp / 8);
+		info->fix.line_length = lcd_cfg->xres * (cfg->bpp / 8);
 		info->fix.smem_len = info->fix.line_length *
-			info->var.yres_virtual;
+			var->yres_virtual;
 
 		buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
 					 &priv->ch[i].dma_handle, GFP_KERNEL);
@@ -1121,10 +1205,14 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			 ch->cfg.bpp);
 
 		/* deferred io mode: disable clock to save power */
-		if (info->fbdefio)
+		if (info->fbdefio || info->state = FBINFO_STATE_SUSPENDED)
 			sh_mobile_lcdc_clk_off(priv);
 	}
 
+	/* Failure ignored */
+	priv->notifier.notifier_call = sh_mobile_lcdc_notify;
+	fb_register_client(&priv->notifier);
+
 	return 0;
 err1:
 	sh_mobile_lcdc_remove(pdev);
@@ -1138,6 +1226,8 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	struct fb_info *info;
 	int i;
 
+	fb_unregister_client(&priv->notifier);
+
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
 		if (priv->ch[i].info && priv->ch[i].info->dev)
 			unregister_framebuffer(priv->ch[i].info);
diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
new file mode 100644
index 0000000..577cf18
--- /dev/null
+++ b/include/video/sh_mobile_hdmi.h
@@ -0,0 +1,22 @@
+/*
+ * SH-Mobile High-Definition Multimedia Interface (HDMI)
+ *
+ * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef SH_MOBILE_HDMI_H
+#define SH_MOBILE_HDMI_H
+
+struct sh_mobile_lcdc_chan_cfg;
+struct device;
+
+struct sh_mobile_hdmi_info {
+	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
+	struct device			*lcd_dev;
+};
+
+#endif
-- 
1.6.2.4

