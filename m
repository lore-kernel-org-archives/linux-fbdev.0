From: cailiwei <cailiwei@hisilicon.com>
Date: Tue, 07 Feb 2017 02:35:53 +0000
Subject: [PATCH 2/8] fb: hisilicon: Add framebuffer driver for hi3660 SoC
Message-Id: <20170207023559.79455-2-cailiwei@hisilicon.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170207023559.79455-1-cailiwei@hisilicon.com>
In-Reply-To: <20170207023559.79455-1-cailiwei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, guodong.xu@linaro.org
Cc: suzhuangluan@hisilicon.com, dengqingshan@hisilicon.com, xuhongtao8@hisilicon.com, zhengwanchun@hisilicon.com, shizongxuan@huawei.com, cailiwei@hisilicon.com

From: Levy-Cai <cailiwei@hisilicon.com>

Add framebuffer driver for hi3660 SoC, this driver include lcd
driver & Hdmi adv7533/adv7535 driver, support lcd display at
1080p@60 and hdmi display at 1080p@60.

Signed-off-by: cailiwei <cailiwei@hisilicon.com>
---
 drivers/video/fbdev/hisi/dss/hdmi/adv75xx.c        | 1522 ++++++++++++++++++++
 drivers/video/fbdev/hisi/dss/hdmi/adv75xx.h        |  496 +++++++
 drivers/video/fbdev/hisi/dss/hdmi/adv75xx_audio.c  |  310 ++++
 drivers/video/fbdev/hisi/dss/hdmi/mipi_adi_hdmi.c  |  314 ++++
 .../fbdev/hisi/dss/panel/mipi_hikey_nte300nts.c    |  525 +++++++
 5 files changed, 3167 insertions(+)
 create mode 100755 drivers/video/fbdev/hisi/dss/hdmi/adv75xx.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hdmi/adv75xx.h
 create mode 100755 drivers/video/fbdev/hisi/dss/hdmi/adv75xx_audio.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hdmi/mipi_adi_hdmi.c
 create mode 100755 drivers/video/fbdev/hisi/dss/panel/mipi_hikey_nte300nts.c

diff --git a/drivers/video/fbdev/hisi/dss/hdmi/adv75xx.c b/drivers/video/fbdev/hisi/dss/hdmi/adv75xx.c
new file mode 100755
index 000000000000..328cd6869149
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hdmi/adv75xx.c
@@ -0,0 +1,1522 @@
+/**
+ *
+ *
+ **/
+
+#include "adv75xx.h"
+#define HPD_ENABLE	0
+/* #define TEST_COLORBAR_DISPLAY */
+
+static void adv75xx_power_on(struct adi_hdmi *adv75xx);
+static void adv75xx_power_off(struct adi_hdmi *adv75xx);
+
+/* ADI recommended values for proper operation. */
+static const struct reg_sequence adv7511_fixed_registers[] = {
+	{0x98, 0x03},
+	{0x9a, 0xe0},
+	{0x9c, 0x30},
+	{0x9d, 0x61},
+	{0xa2, 0xa4},
+	{0xa3, 0xa4},
+	{0xe0, 0xd0},
+	{0xf9, 0x00},
+	{0x55, 0x02},
+};
+
+/* ADI recommended values for proper operation. */
+static const struct reg_sequence adv7533_fixed_registers[] = {
+	{0x16, 0x20},
+	{0x9a, 0xe0},
+	{0xba, 0x70},
+	{0xde, 0x82},
+	{0xe4, 0x40},
+	{0xe5, 0x80},
+};
+
+static const struct reg_sequence adv7533_cec_fixed_registers[] = {
+	{0x15, 0xd0},
+	{0x17, 0xd0},
+	{0x24, 0x20},
+	{0x57, 0x11},
+	{0x05, 0xc8},
+};
+
+/* -----------------------------------------------------------------------------
+ * Register access
+ */
+
+static const uint8_t adv75xx_register_defaults[] = {
+	0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 00 */
+	0x00, 0x00, 0x01, 0x0e, 0xbc, 0x18, 0x01, 0x13,
+	0x25, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 10 */
+	0x46, 0x62, 0x04, 0xa8, 0x00, 0x00, 0x1c, 0x84,
+	0x1c, 0xbf, 0x04, 0xa8, 0x1e, 0x70, 0x02, 0x1e,	/* 20 */
+	0x00, 0x00, 0x04, 0xa8, 0x08, 0x12, 0x1b, 0xac,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 30 */
+	0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0xb0,
+	0x00, 0x50, 0x90, 0x7e, 0x79, 0x70, 0x00, 0x00,	/* 40 */
+	0x00, 0xa8, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x02, 0x0d, 0x00, 0x00, 0x00, 0x00,	/* 50 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 60 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 70 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 80 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00,	/* 90 */
+	0x0b, 0x02, 0x00, 0x18, 0x5a, 0x60, 0x00, 0x00,
+	0x00, 0x00, 0x80, 0x80, 0x08, 0x04, 0x00, 0x00,	/* a0 */
+	0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x40, 0x14,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* b0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* c0 */
+	0x00, 0x03, 0x00, 0x00, 0x02, 0x00, 0x01, 0x04,
+	0x30, 0xff, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00,	/* d0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x01,
+	0x80, 0x75, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00,	/* e0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0x11, 0x00,	/* f0 */
+	0x00, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static bool adv7511_register_volatile(struct device *dev, unsigned int reg)
+{
+	int ret = 0;
+
+	switch (reg) {
+	case ADV7533_REG_CHIP_REVISION:
+	case ADV7533_REG_SPDIF_FREQ:
+	case ADV7533_REG_CTS_AUTOMATIC1:
+	case ADV7533_REG_CTS_AUTOMATIC2:
+	case ADV7533_REG_VIC_DETECTED:
+	case ADV7533_REG_VIC_SEND:
+	case ADV7533_REG_AUX_VIC_DETECTED:
+	case ADV7533_REG_STATUS:
+	case ADV7533_REG_GC(1):
+	case ADV7533_REG_INT(0):
+	case ADV7533_REG_INT(1):
+	case ADV7533_REG_PLL_STATUS:
+	case ADV7533_REG_AN(0):
+	case ADV7533_REG_AN(1):
+	case ADV7533_REG_AN(2):
+	case ADV7533_REG_AN(3):
+	case ADV7533_REG_AN(4):
+	case ADV7533_REG_AN(5):
+	case ADV7533_REG_AN(6):
+	case ADV7533_REG_AN(7):
+	case ADV7533_REG_HDCP_STATUS:
+	case ADV7533_REG_BCAPS:
+	case ADV7533_REG_BKSV(0):
+	case ADV7533_REG_BKSV(1):
+	case ADV7533_REG_BKSV(2):
+	case ADV7533_REG_BKSV(3):
+	case ADV7533_REG_BKSV(4):
+	case ADV7533_REG_DDC_STATUS:
+	case ADV7533_REG_BSTATUS(0):
+	case ADV7533_REG_BSTATUS(1):
+	case ADV7533_REG_CHIP_ID_HIGH:
+	case ADV7533_REG_CHIP_ID_LOW:
+		ret = 1;
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret ? true : false;
+}
+
+static const struct regmap_config adv75xx_regmap_config = {
+	.name = "adv75xx",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults_raw = adv75xx_register_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(adv75xx_register_defaults),
+	.volatile_reg = adv7511_register_volatile,
+};
+
+static const struct regmap_config adv7533_cec_regmap_config = {
+	.name = "adv7533_cec",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct regmap_config adv7533_packet_regmap_config = {
+	.name = "adv7533_packet",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/* -----------------------------------------------------------------------------
+ * Hardware configuration
+ */
+static void adv75xx_set_colormap(struct adi_hdmi *adv75xx, bool enable,
+				 const u16 *coeff, unsigned int scaling_factor)
+{
+	unsigned int i;
+
+	HISI_FB_INFO("+.\n");
+
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_CSC_UPPER(1),
+			   ADV7533_CSC_UPDATE_MODE, ADV7533_CSC_UPDATE_MODE);
+
+	if (enable) {
+		for (i = 0; i < 12; ++i) {
+			regmap_update_bits(adv75xx->regmap,
+					   ADV7533_REG_CSC_UPPER(i),
+					   0x1f, coeff[i] >> 8);
+			regmap_write(adv75xx->regmap,
+				     ADV7533_REG_CSC_LOWER(i), coeff[i] & 0xff);
+		}
+	}
+
+	if (enable)
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_CSC_UPPER(0),
+				   0xe0, 0x80 | (scaling_factor << 5));
+	else
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_CSC_UPPER(0),
+				   0x80, 0x00);
+
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_CSC_UPPER(1),
+			   ADV7533_CSC_UPDATE_MODE, 0);
+
+	HISI_FB_INFO("-.\n");
+}
+
+int adv75xx_packet_enable(struct adi_hdmi *adv75xx, unsigned int packet)
+{
+	HISI_FB_INFO("+.\n");
+
+	if (packet & 0xff)
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_PACKET_ENABLE0,
+				   packet, 0xff);
+
+	if (packet & 0xff00) {
+		packet >>= 8;
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_PACKET_ENABLE1,
+				   packet, 0xff);
+	}
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+}
+
+int adv75xx_packet_disable(struct adi_hdmi *adv75xx, unsigned int packet)
+{
+	HISI_FB_INFO("+.\n");
+
+	if (packet & 0xff)
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_PACKET_ENABLE0,
+				   packet, 0x00);
+
+	if (packet & 0xff00) {
+		packet >>= 8;
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_PACKET_ENABLE1,
+				   packet, 0x00);
+	}
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+}
+
+/* Coefficients for adv75xx color space conversion */
+static const uint16_t adv75xx_csc_ycbcr_to_rgb[] = {
+	0x0734, 0x04ad, 0x0000, 0x1c1b,
+	0x1ddc, 0x04ad, 0x1f24, 0x0135,
+	0x0000, 0x04ad, 0x087c, 0x1b77,
+};
+
+static void adv75xx_set_config_csc(struct adi_hdmi *adv75xx, bool rgb)
+{
+	struct adv75xx_video_config config;
+	bool output_format_422, output_format_ycbcr;
+	unsigned int mode;
+	uint8_t infoframe[17];
+
+	HISI_FB_INFO("+.\n");
+
+	if (adv75xx->edid)
+		config.hdmi_mode = true;
+	else
+		config.hdmi_mode = false;
+
+	config.avi_infoframe.scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
+
+	HISI_FB_INFO("adv75xx->rgb is %d\n", adv75xx->rgb);
+
+	if (rgb) {
+		config.csc_enable = false;
+		config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
+	} else {
+		config.csc_scaling_factor = ADV75xx_CSC_SCALING_4;
+		config.csc_coefficents = adv75xx_csc_ycbcr_to_rgb;
+	}
+
+	HISI_FB_INFO("config.avi_infoframe.colorspace = %d\n",
+		     config.avi_infoframe.colorspace);
+
+	if (config.hdmi_mode) {
+		mode = ADV7533_HDMI_CFG_MODE_HDMI;
+
+		switch (config.avi_infoframe.colorspace) {
+		case HDMI_COLORSPACE_YUV444:
+			output_format_422 = false;
+			output_format_ycbcr = true;
+			break;
+		case HDMI_COLORSPACE_YUV422:
+			output_format_422 = true;
+			output_format_ycbcr = true;
+			break;
+		default:
+			output_format_422 = false;
+			output_format_ycbcr = false;
+			break;
+		}
+	} else {
+		mode = ADV7533_HDMI_CFG_MODE_DVI;
+		output_format_422 = false;
+		output_format_ycbcr = false;
+	}
+
+	adv75xx_packet_disable(adv75xx, ADV7533_PACKET_ENABLE_AVI_INFOFRAME);
+
+	adv75xx_set_colormap(adv75xx, config.csc_enable,
+			     config.csc_coefficents, config.csc_scaling_factor);
+
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_VIDEO_INPUT_CFG1, 0x81,
+			   (output_format_422 << 7) | output_format_ycbcr);
+
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_HDCP_HDMI_CFG,
+			   ADV7533_HDMI_CFG_MODE_MASK, mode);
+
+	/* The AVI infoframe id is not configurable */
+	regmap_bulk_write(adv75xx->regmap, ADV7533_REG_AVI_INFOFRAME_VERSION,
+			  infoframe + 1, sizeof(infoframe) - 1);
+
+	adv75xx_packet_enable(adv75xx, ADV7533_PACKET_ENABLE_AVI_INFOFRAME);
+
+	HISI_FB_INFO("-.\n");
+}
+
+static void adv75xx_dsi_config_tgen(struct adi_hdmi *adv75xx)
+{
+	u8 clock_div_by_lanes[] = { 6, 4, 3 };	/* 2, 3, 4 lanes */
+	unsigned int hsw, hfp, hbp, vsw, vfp, vbp;
+
+	HISI_FB_INFO("+.\n");
+
+	hsw = adv75xx->mode->hsync_pulse_width;
+	hfp = adv75xx->mode->hsync_offset;
+	hbp = adv75xx->mode->htotal - adv75xx->mode->hsync_end;
+	vsw = adv75xx->mode->vsync_pulse_width;
+	vfp = adv75xx->mode->vsync_offset;
+	vbp = adv75xx->mode->vtotal - adv75xx->mode->vsync_end;
+
+	HISI_FB_INFO
+	    ("hsw = %d, hfp = %d, hbp = %d, vsw = %d, vfp= %d, vbp = %d\n",
+	     hsw, hfp, hbp, vsw, vfp, vbp);
+
+#ifdef TEST_COLORBAR_DISPLAY
+	/* set pixel clock auto mode */
+	regmap_write(adv75xx->regmap_cec, ADV7533_REG_CEC_PIXEL_CLOCK_DIV, 0x00);
+#else
+	/* set pixel clock divider mode */
+	regmap_write(adv75xx->regmap_cec, ADV7533_REG_CEC_PIXEL_CLOCK_DIV,
+		     clock_div_by_lanes[adv75xx->num_dsi_lanes - 2] << 3);
+#endif
+
+	HISI_FB_INFO("dsi->lanes = %d, htotal = %d, vtotal = %d\n",
+		     adv75xx->num_dsi_lanes, adv75xx->mode->htotal,
+		     adv75xx->mode->vtotal);
+
+	/* horizontal porch params */
+	regmap_write(adv75xx->regmap_cec, 0x28, adv75xx->mode->htotal >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x29,
+		     (adv75xx->mode->htotal << 4) & 0xff);
+	regmap_write(adv75xx->regmap_cec, 0x2a, hsw >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x2b, (hsw << 4) & 0xff);
+	regmap_write(adv75xx->regmap_cec, 0x2c, hfp >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x2d, (hfp << 4) & 0xff);
+	regmap_write(adv75xx->regmap_cec, 0x2e, hbp >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x2f, (hbp << 4) & 0xff);
+
+	/* vertical porch params */
+	regmap_write(adv75xx->regmap_cec, 0x30, adv75xx->mode->vtotal >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x31,
+		     (adv75xx->mode->vtotal << 4) & 0xff);
+	regmap_write(adv75xx->regmap_cec, 0x32, vsw >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x33, (vsw << 4) & 0xff);
+	regmap_write(adv75xx->regmap_cec, 0x34, vfp >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x35, (vfp << 4) & 0xff);
+	regmap_write(adv75xx->regmap_cec, 0x36, vbp >> 4);
+	regmap_write(adv75xx->regmap_cec, 0x37, (vbp << 4) & 0xff);
+
+	/* 30Hz Low Refresh Rate (VIC Detection) */
+
+
+	HISI_FB_INFO("-.\n");
+}
+
+static void adv75xx_dsi_receiver_dpms(struct adi_hdmi *adv75xx)
+{
+	HISI_FB_INFO("+.\n");
+
+	if (adv75xx->type != ADV7533)
+		return;
+
+	if (adv75xx->powered) {
+		adv75xx_dsi_config_tgen(adv75xx);
+
+		/* set number of dsi lanes */
+		regmap_write(adv75xx->regmap_cec, ADV7533_REG_DSI_DATA_LANES,
+			     adv75xx->num_dsi_lanes << 4);
+
+#ifdef TEST_COLORBAR_DISPLAY
+		/* reset internal timing generator */
+		regmap_write(adv75xx->regmap_cec, 0x27, 0xcb);
+		regmap_write(adv75xx->regmap_cec, 0x27, 0x8b);
+		regmap_write(adv75xx->regmap_cec, 0x27, 0xcb);
+#else
+		/* disable internal timing generator */
+		regmap_write(adv75xx->regmap_cec, 0x27, 0x0b);
+#endif
+
+		/* 09-03 AVI Infoframe - RGB - 16-9 Aspect Ratio */
+		regmap_write(adv75xx->regmap, 0x55, 0x10);
+		regmap_write(adv75xx->regmap, 0x56, 0x28);
+
+		/* 04-04 GC Packet Enable */
+		regmap_write(adv75xx->regmap, 0x40, 0x80);
+
+		/* 04-06 GC Colour Depth - 24 Bit */
+		regmap_write(adv75xx->regmap, 0x4c, 0x04);
+
+		/* 04-09 Down Dither Output Colour Depth - 8 Bit (default) */
+		regmap_write(adv75xx->regmap, 0x49, 0x00);
+
+		/* 07-01 CEC Power Mode - Always Active */
+		regmap_write(adv75xx->regmap_cec, 0xbe, 0x3d);
+
+		/* enable hdmi */
+		regmap_write(adv75xx->regmap_cec, 0x03, 0x89);
+
+#ifdef TEST_COLORBAR_DISPLAY
+		/*enable test mode */
+		regmap_write(adv75xx->regmap_cec, 0x55, 0x80);
+#else
+		/* disable test mode */
+		regmap_write(adv75xx->regmap_cec, 0x55, 0x00);
+#endif
+		/* SPD */
+		{
+			static const unsigned char spd_if[] = {
+				0x83, 0x01, 25, 0x00,
+				'L', 'i', 'n', 'a', 'r', 'o', 0, 0,
+				'9', '6', 'b', 'o', 'a', 'r', 'd', 's',
+				':', 'H', 'i', 'k', 'e', 'y', 0, 0,
+			};
+			int n;
+
+			for (n = 0; n < sizeof(spd_if); n++)
+				regmap_write(adv75xx->regmap_packet, n,
+					     spd_if[n]);
+
+			/* enable send SPD */
+			regmap_update_bits(adv75xx->regmap, 0x40, BIT(6), BIT(6));
+		}
+
+		/* force audio */
+		/* hide Audio infoframe updates */
+		regmap_update_bits(adv75xx->regmap, 0x4a, BIT(5), BIT(5));
+
+		/* i2s, internal mclk, mclk-256 */
+		regmap_update_bits(adv75xx->regmap, 0x0a, 0x1f, 1);
+		regmap_update_bits(adv75xx->regmap, 0x0b, 0xe0, 0);
+		/* enable i2s, use i2s format, sample rate from i2s */
+		regmap_update_bits(adv75xx->regmap, 0x0c, 0xc7, BIT(2));
+		/* 16 bit audio */
+		regmap_update_bits(adv75xx->regmap, 0x0d, 0xff, 16);
+		/* 16-bit audio */
+		regmap_update_bits(adv75xx->regmap, 0x14, 0x0f, 2 << 4);
+		/* 48kHz */
+		regmap_update_bits(adv75xx->regmap, 0x15, 0xf0, 2 << 4);
+		/* enable N/CTS, enable Audio sample packets */
+		regmap_update_bits(adv75xx->regmap, 0x44, BIT(5), BIT(5));
+		/* N = 6144 */
+		regmap_write(adv75xx->regmap, 1, (6144 >> 16) & 0xf);
+		regmap_write(adv75xx->regmap, 2, (6144 >> 8) & 0xff);
+		regmap_write(adv75xx->regmap, 3, (6144) & 0xff);
+		/* automatic cts */
+		regmap_update_bits(adv75xx->regmap, 0x0a, BIT(7), 0);
+		/* enable N/CTS */
+		regmap_update_bits(adv75xx->regmap, 0x44, BIT(6), BIT(6));
+		/* not copyrighted */
+		regmap_update_bits(adv75xx->regmap, 0x12, BIT(5), BIT(5));
+
+		/* left source */
+		regmap_update_bits(adv75xx->regmap, 0x0e, 7 << 3, 0);
+		/* right source */
+		regmap_update_bits(adv75xx->regmap, 0x0e, 7 << 0, 1);
+		/* number of channels: sect 4.5.4: set to 0 */
+		regmap_update_bits(adv75xx->regmap, 0x73, 7, 1);
+		/* number of channels: sect 4.5.4: set to 0 */
+		regmap_update_bits(adv75xx->regmap, 0x73, 0xf0, 1 << 4);
+		/* sample rate: 48kHz */
+		regmap_update_bits(adv75xx->regmap, 0x74, 7 << 2, 3 << 2);
+		/* channel allocation reg: sect 4.5.4: set to 0 */
+		regmap_update_bits(adv75xx->regmap, 0x76, 0xff, 0);
+		/* enable audio infoframes */
+		regmap_update_bits(adv75xx->regmap, 0x44, BIT(3), BIT(3));
+
+		/* AV mute disable */
+		regmap_update_bits(adv75xx->regmap, 0x4b, BIT(7) | BIT(6), BIT(7));
+
+		/* use Audio infoframe updated info */
+		regmap_update_bits(adv75xx->regmap, 0x4a, BIT(5), 0);
+	} else {
+		regmap_write(adv75xx->regmap_cec, 0x03, 0x0b);
+		regmap_write(adv75xx->regmap_cec, 0x27, 0x0b);
+	}
+
+	HISI_FB_INFO("-.\n");
+}
+
+/* -----------------------------------------------------------------------------
+ * Interrupt and hotplug detection
+ */
+
+#if HPD_ENABLE
+static bool adv75xx_hpd(struct adi_hdmi *adv75xx)
+{
+	unsigned int irq0;
+	int ret;
+
+	HISI_FB_INFO("+.\n");
+
+	ret = regmap_read(adv75xx->regmap, ADV7533_REG_INT(0), &irq0);
+	if (ret < 0)
+		return false;
+
+	HISI_FB_INFO("irq0 = 0x%x\n", irq0);
+
+	if (irq0 & ADV7533_INT0_HDP) {
+		HISI_FB_INFO("HPD interrupt detected!\n");
+		regmap_write(adv75xx->regmap, ADV7533_REG_INT(0),
+			     ADV7533_INT0_HDP);
+		return true;
+	}
+
+	HISI_FB_INFO("-.\n");
+
+	return false;
+}
+#endif
+
+static int adv75xx_irq_process(struct adi_hdmi *adv75xx, bool process_hpd)
+{
+	unsigned int irq0, irq1;
+	int ret;
+
+	HISI_FB_INFO("+.\n");
+
+	ret = regmap_read(adv75xx->regmap, ADV7533_REG_INT(0), &irq0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(adv75xx->regmap, ADV7533_REG_INT(1), &irq1);
+	if (ret < 0)
+		return ret;
+
+	regmap_write(adv75xx->regmap, ADV7533_REG_INT(0), irq0);
+	regmap_write(adv75xx->regmap, ADV7533_REG_INT(1), irq1);
+
+	HISI_FB_INFO("adv7511_irq_process --> irq0 = 0x%x \n", irq0);
+	HISI_FB_INFO("adv7511_irq_process --> irq1 = 0x%x \n", irq1);
+
+	if (irq0 & ADV7533_INT0_EDID_READY || irq1 & ADV7533_INT1_DDC_ERROR) {
+		adv75xx->edid_read = true;
+		if (adv75xx->i2c_main->irq)
+			HISI_FB_INFO("adv7511_irq_process -->get i2c_main irq \n");
+
+		wake_up_all(&adv75xx->wq);
+	}
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+}
+
+static irqreturn_t adv75xx_irq_handler(int irq, void *devid)
+{
+	struct adi_hdmi *adv75xx = devid;
+	int ret;
+
+	HISI_FB_INFO("+.\n");
+
+	ret = adv75xx_irq_process(adv75xx, true);
+
+	HISI_FB_INFO("-.\n");
+
+	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
+}
+
+/* -----------------------------------------------------------------------------
+ * EDID retrieval
+ */
+
+static int adv75xx_wait_for_edid(struct adi_hdmi *adv75xx, int timeout)
+{
+	int ret;
+
+	HISI_FB_INFO("+.\n");
+
+	if (adv75xx->i2c_main->irq) {
+		ret = wait_event_interruptible_timeout(adv75xx->wq,
+						       adv75xx->edid_read,
+						       msecs_to_jiffies(timeout));
+	} else {
+		for (; timeout > 0; timeout -= 25) {
+			ret = adv75xx_irq_process(adv75xx, false);
+			if (ret < 0)
+				break;
+
+			if (adv75xx->edid_read)
+				break;
+
+			msleep(25);
+		}
+	}
+
+	HISI_FB_INFO("-.\n");
+
+	return adv75xx->edid_read ? 0 : -EIO;
+}
+
+static void print_edid_info(u8 *block)
+{
+	int step, count;
+
+	count = 0x0;
+	while (count < EDID_LENGTH) {
+		step = 0;
+		do {
+			if (step = 0) {
+				HISI_FB_INFO("------ edid[%d]: 0x%2x \t", count,
+					     block[count]);
+			} else {
+				HISI_FB_INFO(" 0x%2x \t", block[count]);
+			}
+			step++;
+			count++;
+		} while (step < 8);
+
+		HISI_FB_INFO("\n");
+	}
+}
+
+struct hisi_display_mode *hisi_set_mode_info(void)
+{
+	struct hisi_display_mode *mode;
+	unsigned int hsw, hfp, hbp, vsw, vfp, vbp;
+
+	mode = kzalloc(sizeof(struct hisi_display_mode), GFP_KERNEL);
+	if (!mode)
+		return NULL;
+
+	mode->width_mm = 160 * 100;
+	mode->height_mm = 90 * 100;
+	mode->clock = 148500;
+	mode->hdisplay = 1920;
+	mode->vdisplay = 1080;
+	mode->hsync_offset = 88;
+	mode->hsync_pulse_width = 44;
+	mode->hsync_start = 2008;
+	mode->hsync_end = 2052;
+	mode->htotal = 2200;
+
+	mode->vsync_offset = 4;
+	mode->vsync_pulse_width = 5;
+	mode->vsync_start = 1084;
+	mode->vsync_end = 1089;
+	mode->vtotal = 1125;
+
+	hsw = mode->hsync_pulse_width;
+	hfp = mode->hsync_offset;
+	hbp = mode->htotal - mode->hsync_end;
+	vsw = mode->vsync_pulse_width;
+	vfp = mode->vsync_offset;
+	vbp = mode->vtotal - mode->vsync_end;
+
+	HISI_FB_INFO("The pixel clock is %d!!\n", mode->clock);
+	HISI_FB_INFO("The resolution is %d x %d !!\n", mode->hdisplay,
+		     mode->vdisplay);
+	HISI_FB_INFO
+	    ("hsw = %d, hfp = %d, hbp = %d, vsw = %d, vfp= %d, vbp = %d\n",
+	     hsw, hfp, hbp, vsw, vfp, vbp);
+
+
+	return mode;
+}
+
+struct hisi_display_mode *hisi_parse_edid_base_info(u8 *block)
+{
+	struct hisi_display_mode *mode;
+	char edid_vendor[3];
+	unsigned hblank;
+	unsigned vblank;
+	unsigned int hsw, hfp, hbp, vsw, vfp, vbp;
+
+	mode = kzalloc(sizeof(struct hisi_display_mode), GFP_KERNEL);
+	if (!mode)
+		return NULL;
+
+	edid_vendor[0] = ((block[8] & 0x7c) >> 2) + '@';
+	edid_vendor[1] = (((block[8] & 0x3) << 3) |
+			  ((block[1] & 0xe0) >> 5)) + '@';
+	edid_vendor[2] = (block[9] & 0x1f) + '@';
+
+	mode->width_mm = block[21] * 100;
+	mode->height_mm = block[22] * 100;
+	HISI_FB_INFO("The product vender is %c%c%c !!!\n", edid_vendor[0],
+		     edid_vendor[1], edid_vendor[2]);
+	HISI_FB_INFO
+	    ("The screen supported max width is %d cm, max height is %d cm !!\n",
+	     block[21], block[22]);
+	HISI_FB_INFO("The display gamma is %d !!\n", block[23]);
+	HISI_FB_INFO("The display is RGB or YCbCr is 0x%x !!\n",
+		     (block[24] & 0x18) >> 3);
+	/******** Detailed Timing Descriptor **********/
+	mode->clock = (block[55] << 8 | block[54]) * 10;
+	mode->hdisplay = ((block[58] & 0xf0) << 4) | block[56];
+	hblank = ((block[58] & 0x0f) << 8) | block[57];
+	mode->vdisplay = ((block[61] & 0xf0) << 4) | block[59];
+	vblank = ((block[61] & 0x0f) << 8) | block[60];
+	mode->hsync_offset = block[62];
+	mode->hsync_pulse_width = block[63];
+	mode->vsync_offset = (block[64] & 0xf0) >> 4;
+	mode->vsync_pulse_width = block[64] & 0x0f;
+
+	mode->hsync_start = mode->hdisplay + mode->hsync_offset;
+	mode->hsync_end = mode->hsync_start + mode->hsync_pulse_width;
+	mode->htotal = mode->hdisplay + hblank;
+	mode->vsync_start = mode->vdisplay + mode->vsync_offset;
+	mode->vsync_end = mode->vsync_start + mode->vsync_pulse_width;
+	mode->vtotal = mode->vdisplay + vblank;
+
+	hsw = mode->hsync_pulse_width;
+	hfp = mode->hsync_offset;
+	hbp = mode->htotal - mode->hsync_end;
+	vsw = mode->vsync_pulse_width;
+	vfp = mode->vsync_offset;
+	vbp = mode->vtotal - mode->vsync_end;
+
+	HISI_FB_INFO("The pixel clock is %d!!\n", mode->clock);
+	HISI_FB_INFO("The resolution is %d x %d !!\n", mode->hdisplay,
+		     mode->vdisplay);
+	HISI_FB_INFO
+	    ("hsw = %d, hfp = %d, hbp = %d, vsw = %d, vfp= %d, vbp = %d\n",
+	     hsw, hfp, hbp, vsw, vfp, vbp);
+
+
+	return mode;
+}
+
+static int adv75xx_get_edid_block(void *data, u8 *buf, unsigned int block,
+				  size_t len)
+{
+	struct adi_hdmi *adv75xx = data;
+	struct i2c_msg xfer[2];
+	uint8_t offset, edid_buf[256];
+	unsigned int i;
+	int ret;
+
+	if (len > EDID_LENGTH)
+		return -EINVAL;
+
+	HISI_FB_INFO("+.\n");
+
+	if (adv75xx->current_edid_segment != block) {
+		unsigned int status;
+
+		ret = regmap_read(adv75xx->regmap, ADV7533_REG_DDC_STATUS,
+				  &status);
+		if (ret < 0)
+			return ret;
+
+		if (status != IDLE) {
+			adv75xx->edid_read = false;
+			regmap_write(adv75xx->regmap, ADV7533_REG_EDID_SEGMENT,
+				     block);
+			ret = adv75xx_wait_for_edid(adv75xx, 200);
+			if (ret < 0)
+				return ret;
+		}
+
+		/* Break this apart, hopefully more I2C controllers will
+		 * support 64 byte transfers than 256 byte transfers
+		 */
+
+		xfer[0].addr = adv75xx->i2c_edid->addr;
+		xfer[0].flags = 0;
+		xfer[0].len = 1;
+		xfer[0].buf = &offset;
+		xfer[1].addr = adv75xx->i2c_edid->addr;
+		xfer[1].flags = I2C_M_RD;
+		xfer[1].len = 64;
+		xfer[1].buf = edid_buf;
+
+		offset = 0;
+
+		for (i = 0; i < 4; ++i) {
+			ret = i2c_transfer(adv75xx->i2c_edid->adapter, xfer,
+					   ARRAY_SIZE(xfer));
+			if (ret < 0)
+				return ret;
+			else if (ret != 2)
+				return -EIO;
+
+			xfer[1].buf += 64;
+			offset += 64;
+		}
+
+		adv75xx->current_edid_segment = block;
+	}
+
+	if (block % 2 = 0)
+		memcpy(buf, edid_buf, len);
+	else
+		memcpy(buf, edid_buf + EDID_LENGTH, len);
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+}
+
+static bool edid_is_zero(const u8 *in_edid, int length)
+{
+	if (memchr_inv(in_edid, 0, length))
+		return false;
+
+	return true;
+}
+
+/**
+ * hisi_do_get_edid - get EDID data using a custom EDID block read function
+ * @get_edid_block: EDID block read function
+ * @data: private data passed to the block read function
+ *
+ * When the I2C adapter connected to the DDC bus is hidden behind a device that
+ * exposes a different interface to read EDID blocks this function can be used
+ * to get EDID data using a custom block read function.
+ *
+ * As in the general case the DDC bus is accessible by the kernel at the I2C
+ * level, drivers must make all reasonable efforts to expose it as an I2C
+ * adapter and use drm_get_edid() instead of abusing this function.
+ *
+ * Return: Pointer to valid EDID or NULL if we couldn't find any.
+ */
+struct edid *hisi_do_get_edid(int (*get_edid_block) (void *data, u8 *buf,
+						     unsigned int block,
+						     size_t len), void *data)
+{
+	u8 *block;
+	bool print_bad_edid = true;
+
+	HISI_FB_INFO("+.\n");
+
+	if ((block = kmalloc(EDID_LENGTH, GFP_KERNEL)) = NULL)
+		return NULL;
+
+	HISI_FB_INFO("EDID_LENGTH = %d \n", EDID_LENGTH);
+	/* base block fetch */
+	if (get_edid_block(data, block, 0, EDID_LENGTH))
+		goto out;
+
+	if (edid_is_zero(block, EDID_LENGTH))
+		goto carp;
+
+	HISI_FB_INFO("edid_block read success!!!\n");
+
+	print_edid_info(block);
+
+	return (struct edid *)block;
+
+ carp:
+	if (print_bad_edid)
+		HISI_FB_ERR("EDID block invalid.\n");
+ out:
+	kfree(block);
+	return NULL;
+}
+
+struct hisi_display_mode *adv75xx_get_modes(struct adi_hdmi *adv75xx)
+{
+	struct edid *edid;
+	struct hisi_display_mode *mode;
+
+	HISI_FB_INFO("+.\n");
+
+	/* Reading the EDID only works if the device is powered */
+	if (!adv75xx->powered) {
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER2,
+				ADV7533_REG_POWER2_HDP_SRC_MASK,
+				ADV7533_REG_POWER2_HDP_SRC_NONE);	/* 0xc0 */
+
+		regmap_write(adv75xx->regmap, ADV7533_REG_INT(0),
+				ADV7533_INT0_EDID_READY);
+		regmap_write(adv75xx->regmap, ADV7533_REG_INT(1),
+				ADV7533_INT1_DDC_ERROR);
+
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER,
+				ADV7533_POWER_POWER_DOWN, 0);	/* 0x41 0x10 */
+
+		adv75xx->current_edid_segment = -1;
+		/* wait some time for edid is ready */
+		msleep(200);
+	}
+
+	edid = hisi_do_get_edid(adv75xx_get_edid_block, adv75xx);
+
+	if (!adv75xx->powered)
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER,
+				   ADV7533_POWER_POWER_DOWN,
+				   ADV7533_POWER_POWER_DOWN);
+
+	kfree(adv75xx->edid);
+	adv75xx->edid = edid;
+	if (!edid) {
+		HISI_FB_ERR("Fail to get really edid info !!!\n");
+		mode = hisi_set_mode_info();
+		return mode;
+	}
+
+	mode = hisi_parse_edid_base_info((u8 *) adv75xx->edid);
+
+	adv75xx_set_config_csc(adv75xx, adv75xx->rgb);
+
+	HISI_FB_INFO("-.\n");
+
+	return mode;
+}
+
+/*=============================*/
+static enum connector_status adv75xx_detect(struct adi_hdmi *adv75xx)
+{
+	enum connector_status status;
+	unsigned int val;
+#if HPD_ENABLE
+	bool hpd;
+#endif
+	int ret;
+
+	HISI_FB_INFO("+.\n");
+
+	ret = regmap_read(adv75xx->regmap, ADV7533_REG_STATUS, &val);
+	if (ret < 0) {
+		HISI_FB_INFO("HDMI connector status is disconnected !!!\n");
+		return connector_status_disconnected;
+	}
+
+	if (val & ADV7533_STATUS_HPD)
+		status = connector_status_connected;
+	else
+		status = connector_status_disconnected;
+
+#if HPD_ENABLE
+	hpd = adv75xx_hpd(adv75xx);
+
+	/* The chip resets itself when the cable is disconnected, so in case
+	 * there is a pending HPD interrupt and the cable is connected there was
+	 * at least one transition from disconnected to connected and the chip
+	 * has to be reinitialized. */
+	if (status = connector_status_connected && hpd && adv75xx->powered) {
+		regcache_mark_dirty(adv75xx->regmap);
+		adv75xx_power_on(adv75xx);
+		adv75xx_get_modes(adv75xx);
+		if (adv75xx->status = connector_status_connected)
+			status = connector_status_disconnected;
+	} else {
+		/* Renable HDP sensing */
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER2,
+				   ADV7533_REG_POWER2_HDP_SRC_MASK,
+				   ADV7533_REG_POWER2_HDP_SRC_BOTH);
+	}
+#endif
+
+	adv75xx->status = status;
+
+	HISI_FB_INFO("adv7511->status = %d <1-connected,2-disconnected>\n",
+		     status);
+	HISI_FB_INFO("-.\n");
+
+	return status;
+}
+
+/**
+ * mode_vrefresh - get the vrefresh of a mode
+ * @mode: mode
+ *
+ * Returns:
+ * @modes's vrefresh rate in Hz, rounded to the nearest integer. Calculates the
+ * value first if it is not yet set.
+ */
+static int mode_vrefresh(const struct hisi_display_mode *mode)
+{
+	int refresh = 0;
+	unsigned int calc_val;
+
+	if (mode->vrefresh > 0)
+		refresh = mode->vrefresh;
+	else if (mode->htotal > 0 && mode->vtotal > 0) {
+		int vtotal;
+		vtotal = mode->vtotal;
+		/* work out vrefresh the value will be x1000 */
+		calc_val = (mode->clock * 1000);
+		calc_val /= mode->htotal;
+		refresh = (calc_val + vtotal / 2) / vtotal;
+	}
+	return refresh;
+}
+
+static int adv75xx_mode_valid(struct hisi_display_mode *mode)
+{
+	if (NULL = mode) {
+		HISI_FB_ERR("mode is null\n");
+		return MODE_NOMODE;
+	}
+
+	if (mode->clock > 165000)
+		return MODE_CLOCK_HIGH;
+	/*
+	 * some work well modes which want to put in the front of the mode list.
+	 */
+	HISI_FB_INFO("Checking mode %ix%i@%i clock: %i...",
+		     mode->hdisplay, mode->vdisplay, mode_vrefresh(mode),
+		     mode->clock);
+	if ((mode->hdisplay = 1920 && mode->vdisplay = 1080
+	     	&& mode->clock = 148500)
+		|| (mode->hdisplay = 1280 && mode->vdisplay = 800
+			&& mode->clock = 83496)
+		|| (mode->hdisplay = 1280 && mode->vdisplay = 720
+			&& mode->clock = 74440)
+		|| (mode->hdisplay = 1280 && mode->vdisplay = 720
+			&& mode->clock = 74250)
+	    || (mode->hdisplay = 1024 && mode->vdisplay = 768
+			&& mode->clock = 75000)
+		|| (mode->hdisplay = 1024 && mode->vdisplay = 768
+			&& mode->clock = 81833)
+	    || (mode->hdisplay = 800 && mode->vdisplay = 600
+			&& mode->clock = 40000)) {
+		HISI_FB_INFO("OK\n");
+		return MODE_OK;
+	}
+	HISI_FB_INFO("BAD\n");
+
+	return MODE_BAD;
+}
+
+static void adv75xx_mode_set(struct adi_hdmi *adv75xx,
+			     struct hisi_display_mode *mode)
+{
+	unsigned int low_refresh_rate;
+	unsigned int hsync_polarity = 0;
+	unsigned int vsync_polarity = 0;
+
+	HISI_FB_INFO("+.\n");
+
+	if (adv75xx->embedded_sync) {
+		unsigned int hsync_offset, hsync_len;
+		unsigned int vsync_offset, vsync_len;
+
+		hsync_offset = mode->hsync_offset;
+		vsync_offset = mode->vsync_offset;
+		hsync_len = mode->hsync_end - mode->hsync_start;
+		vsync_len = mode->vsync_end - mode->vsync_start;
+
+		/* The hardware vsync generator has a off-by-one bug */
+		vsync_offset += 1;
+
+		regmap_write(adv75xx->regmap, ADV7533_REG_HSYNC_PLACEMENT_MSB,
+			     ((hsync_offset >> 10) & 0x7) << 5);
+		regmap_write(adv75xx->regmap, ADV7533_REG_SYNC_DECODER(0),
+			     (hsync_offset >> 2) & 0xff);
+		regmap_write(adv75xx->regmap, ADV7533_REG_SYNC_DECODER(1),
+			     ((hsync_offset & 0x3) << 6) |
+			     ((hsync_len >> 4) & 0x3f));
+		regmap_write(adv75xx->regmap, ADV7533_REG_SYNC_DECODER(2),
+			     ((hsync_len & 0xf) << 4) |
+			     ((vsync_offset >> 6) & 0xf));
+		regmap_write(adv75xx->regmap, ADV7533_REG_SYNC_DECODER(3),
+			     ((vsync_offset & 0x3f) << 2) |
+			     ((vsync_len >> 8) & 0x3));
+		regmap_write(adv75xx->regmap, ADV7533_REG_SYNC_DECODER(4),
+			     vsync_len & 0xff);
+
+		hsync_polarity = !(mode->flags & MODE_FLAG_PHSYNC);
+		vsync_polarity = !(mode->flags & MODE_FLAG_PVSYNC);
+	} else {
+		/**
+		 * If the input signal is always low or always high we want to
+		 * invert or let it passthrough depending on the polarity of the
+		 * current mode.
+		 **/
+		adv75xx->hsync_polarity = ADV7533_SYNC_POLARITY_PASSTHROUGH;
+		adv75xx->vsync_polarity = ADV7533_SYNC_POLARITY_PASSTHROUGH;
+
+		hsync_polarity = adv75xx->hsync_polarity;
+		vsync_polarity = adv75xx->vsync_polarity;
+	}
+	mode->vrefresh = mode_vrefresh(mode);
+	HISI_FB_INFO("hsync_polarity = %d; vsync_polarity = %d\n",
+		     hsync_polarity, vsync_polarity);
+	HISI_FB_INFO("mode->vrefresh = %d \n", mode->vrefresh);
+
+	if (mode->vrefresh <= 24000)
+		low_refresh_rate = ADV7533_LOW_REFRESH_RATE_24HZ;
+	else if (mode->vrefresh <= 25000)
+		low_refresh_rate = ADV7533_LOW_REFRESH_RATE_25HZ;
+	else if (mode->vrefresh <= 30000)
+		low_refresh_rate = ADV7533_LOW_REFRESH_RATE_30HZ;
+	else
+		low_refresh_rate = ADV7533_LOW_REFRESH_RATE_NONE;
+
+	HISI_FB_INFO("low_refresh_rate = %d \n", low_refresh_rate);
+
+	regmap_update_bits(adv75xx->regmap, 0xfb, 0x6, low_refresh_rate << 1);
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_SYNC_POLARITY,
+			   0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
+
+	/*
+	 * TODO Test first order 4:2:2 to 4:4:4 up conversion method, which is
+	 * supposed to give better results.
+	 */
+
+	adv75xx->f_tmds = mode->clock;
+
+	HISI_FB_INFO("-.\n");
+}
+
+static void adv75xx_power_on(struct adi_hdmi *adv75xx)
+{
+	HISI_FB_INFO("+.\n");
+
+	adv75xx->current_edid_segment = -1;
+
+	regmap_write(adv75xx->regmap, ADV7533_REG_INT(0),
+		     ADV7533_INT0_EDID_READY);
+	regmap_write(adv75xx->regmap, ADV7533_REG_INT(1),
+		     ADV7533_INT1_DDC_ERROR);
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER,
+			   ADV7533_POWER_POWER_DOWN, 0);
+
+	/*
+	 * Per spec it is allowed to pulse the HDP signal to indicate that the
+	 * EDID information has changed. Some monitors do this when they wakeup
+	 * from standby or are enabled. When the HDP goes low the adv7511 is
+	 * reset and the outputs are disabled which might cause the monitor to
+	 * go to standby again. To avoid this we ignore the HDP pin for the
+	 * first few seconds after enabling the output.
+	 */
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER2,
+			   ADV7533_REG_POWER2_HDP_SRC_MASK,
+			   ADV7533_REG_POWER2_HDP_SRC_NONE);
+
+	/*
+	 * Most of the registers are reset during power down or when HPD is low.
+	 */
+	regcache_sync(adv75xx->regmap);
+
+	regmap_register_patch(adv75xx->regmap_cec,
+			      adv7533_cec_fixed_registers,
+			      ARRAY_SIZE(adv7533_cec_fixed_registers));
+	adv75xx->powered = true;
+
+	adv75xx_dsi_receiver_dpms(adv75xx);
+
+	HISI_FB_INFO("-.\n");
+}
+
+static void adv75xx_power_off(struct adi_hdmi *adv75xx)
+{
+	HISI_FB_INFO("+.\n");
+
+	/* TODO: setup additional power down modes */
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_POWER,
+			   ADV7533_POWER_POWER_DOWN,
+			   ADV7533_POWER_POWER_DOWN);
+	regcache_mark_dirty(adv75xx->regmap);
+
+	adv75xx->powered = false;
+
+	adv75xx_dsi_receiver_dpms(adv75xx);
+
+	HISI_FB_INFO("-.\n");
+}
+
+/* =============================*/
+static int adv7533_init_regulators(struct adi_hdmi *adv75xx)
+{
+	int ret;
+	struct device *dev = &adv75xx->i2c_main->dev;
+
+	adv75xx->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(adv75xx->vdd)) {
+		ret = PTR_ERR(adv75xx->vdd);
+		dev_err(dev, "failed to get vdd regulator %d\n", ret);
+		return ret;
+	}
+
+	adv75xx->v1p2 = devm_regulator_get(dev, "v1p2");
+	if (IS_ERR(adv75xx->v1p2)) {
+		ret = PTR_ERR(adv75xx->v1p2);
+		dev_err(dev, "failed to get v1p2 regulator %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_set_voltage(adv75xx->vdd, 1800000, 1800000);
+	if (ret) {
+		dev_err(dev, "failed to set avdd voltage %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_set_voltage(adv75xx->v1p2, 1200000, 1200000);
+	if (ret) {
+		dev_err(dev, "failed to set v1p2 voltage %d\n", ret);
+		return ret;
+	}
+
+	/* keep the regulators always on */
+	ret = regulator_enable(adv75xx->vdd);
+	if (ret) {
+		dev_err(dev, "failed to enable vdd %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(adv75xx->v1p2);
+	if (ret) {
+		dev_err(dev, "failed to enable v1p2 %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adv7533_parse_dt(struct device_node *np, struct adi_hdmi *adv75xx)
+{
+	int ret;
+	u32 num_lanes;
+
+	ret = of_property_read_u32(np, "adi,dsi-lanes", &num_lanes);
+	if (ret) {
+		HISI_FB_WARNING("get 'adi,dsi-lanes' resource failed!\n");
+		return ret;
+	}
+
+	if (num_lanes < 1 || num_lanes > 4)
+		return -EINVAL;
+
+	adv75xx->num_dsi_lanes = num_lanes;
+
+	/* TODO: Check if these need to be parsed by DT or not */
+	adv75xx->rgb = true;
+	adv75xx->embedded_sync = false;
+
+	return 0;
+}
+
+static const int edid_i2c_addr = 0x7e;
+static const int packet_i2c_addr = 0x70;
+static const int cec_i2c_addr = 0x78;
+
+static const struct of_device_id adv75xx_of_ids[] = {
+	{.compatible = "adi,adv7511", .data = (void *)ADV7511},
+	{.compatible = "adi,adv7511w", .data = (void *)ADV7511},
+	{.compatible = "adi,adv7513", .data = (void *)ADV7511},
+	{.compatible = "adi,adv7533", .data = (void *)ADV7533},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, adv75xx_of_ids);
+
+static const struct i2c_device_id adv75xx_i2c_ids[] = {
+	{"adv7511", ADV7511},
+	{"adv7511w", ADV7511},
+	{"adv7513", ADV7511},
+	{"adv7533", ADV7533},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, adv75xx_i2c_ids);
+
+static struct adi_operation_funcs opt_funcs = {
+	.power_on = adv75xx_power_on,
+	.power_off = adv75xx_power_off,
+	.mode_set = adv75xx_mode_set,
+};
+
+static int adv75xx_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct adi_hdmi *adv75xx;
+	struct device *dev = &i2c->dev;
+	enum connector_status status;
+	struct hisi_display_mode *mode;
+	struct platform_device *hdmi_pdev = NULL;
+	unsigned int val;
+	int ret;
+
+	if (!dev) {
+		HISI_FB_ERR("dev is  NULL!\n");
+		return -ENOMEM;
+	}
+
+	adv75xx = devm_kzalloc(dev, sizeof(struct adi_hdmi), GFP_KERNEL);
+	if (!adv75xx) {
+		HISI_FB_ERR("adv75xx alloc  failed!\n");
+		return -ENOMEM;
+	}
+	adv75xx->powered = false;
+	adv75xx->status = connector_status_disconnected;
+
+	if (dev->of_node) {
+		const struct of_device_id *of_id;
+
+		of_id = of_match_node(adv75xx_of_ids, dev->of_node);
+		adv75xx->type = (enum adv75xx_type)of_id->data;
+	} else {
+		adv75xx->type = ADV7533;
+	}
+
+	ret = adv7533_parse_dt(dev->of_node, adv75xx);
+	if (ret) {
+		HISI_FB_ERR("parse dts error!\n");
+		goto err_return;
+	}
+
+	adv75xx->i2c_main = i2c;
+
+	if (adv75xx->type = ADV7533) {
+		ret = adv7533_init_regulators(adv75xx);	/* adv7533 vdd--1.8v  v1p2--1.2v */
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * The power down GPIO is optional. If present, toggle it from active(1) to
+	 * inactive(0) to wake up the encoder.
+	 */
+	adv75xx->gpio_pd = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_HIGH);
+	if (IS_ERR(adv75xx->gpio_pd)) {
+		HISI_FB_ERR("get gpio pd error!\n");
+		return PTR_ERR(adv75xx->gpio_pd);
+	}
+	HISI_FB_INFO("adv75xx->gpio_pd = %s!\n", adv75xx->gpio_pd->label);
+
+	if (adv75xx->gpio_pd) {
+		mdelay(5);
+		gpiod_set_value_cansleep(adv75xx->gpio_pd, 0);
+	}
+
+	adv75xx->regmap = devm_regmap_init_i2c(i2c, &adv75xx_regmap_config);
+	if (IS_ERR(adv75xx->regmap)) {
+		HISI_FB_ERR("regmap init i2c failed!\n");
+		return PTR_ERR(adv75xx->regmap);
+	}
+
+	ret = regmap_read(adv75xx->regmap, ADV7533_REG_CHIP_REVISION, &val);
+	if (ret) {
+		HISI_FB_ERR("regmap read failed, ret = %d!\n", ret);
+		goto err_return;
+	}
+	/* the corect val is 20. */
+	HISI_FB_INFO("%s of the Chip reversion is %d\n", dev_name(dev), val);
+	dev_err(dev, "Rev. %d\n", val);
+
+	ret = regmap_register_patch(adv75xx->regmap,
+				    adv7533_fixed_registers,
+				    ARRAY_SIZE(adv7533_fixed_registers));
+	if (ret) {
+		HISI_FB_ERR("regmap register failed!\n");
+		goto err_return;
+	}
+
+	regmap_write(adv75xx->regmap, ADV7533_REG_EDID_I2C_ADDR, edid_i2c_addr);
+	regmap_write(adv75xx->regmap, ADV7533_REG_PACKET_I2C_ADDR,
+		     packet_i2c_addr);
+	regmap_write(adv75xx->regmap, ADV7533_REG_CEC_I2C_ADDR, cec_i2c_addr);
+	adv75xx_packet_disable(adv75xx, 0xffff);
+
+	adv75xx->i2c_packet = i2c_new_dummy(i2c->adapter, packet_i2c_addr >> 1);
+	if (!adv75xx->i2c_packet) {
+		HISI_FB_ERR("i2c_new_dummy i2c_packet failed!\n");
+		return -ENOMEM;
+	}
+
+	adv75xx->i2c_edid = i2c_new_dummy(i2c->adapter, edid_i2c_addr >> 1);
+	if (!adv75xx->i2c_edid) {
+		HISI_FB_ERR("i2c_new_dummy i2c_edid failed!\n");
+		goto err_i2c_unregister_packet;
+	}
+
+	adv75xx->i2c_cec = i2c_new_dummy(i2c->adapter, cec_i2c_addr >> 1);
+	if (!adv75xx->i2c_cec) {
+		ret = -ENOMEM;
+		HISI_FB_ERR("i2c_new_dummy i2c_cec failed!\n");
+		goto err_i2c_unregister_edid;
+	}
+
+	adv75xx->regmap_cec = devm_regmap_init_i2c(adv75xx->i2c_cec,
+						   &adv7533_cec_regmap_config);
+	if (IS_ERR(adv75xx->regmap_cec)) {
+		ret = PTR_ERR(adv75xx->regmap_cec);
+		HISI_FB_ERR("devm_regmap_init_i2c regmap_cec failed!\n");
+		goto err_i2c_unregister_cec;
+	}
+
+	adv75xx->regmap_packet = devm_regmap_init_i2c(adv75xx->i2c_packet,
+						      &adv7533_packet_regmap_config);
+	if (IS_ERR(adv75xx->regmap_packet)) {
+		ret = PTR_ERR(adv75xx->regmap_packet);
+		HISI_FB_ERR("devm_regmap_init_i2c regmap_packet failed!\n");
+		goto err_i2c_unregister_cec;
+	}
+
+	if (adv75xx->type = ADV7533) {
+		ret = regmap_register_patch(adv75xx->regmap_cec,
+					    adv7533_cec_fixed_registers,
+					    ARRAY_SIZE(adv7533_cec_fixed_registers));
+		if (ret) {
+			HISI_FB_ERR
+			    ("regmap_register_patch cec_fixed_registers failed!\n");
+			goto err_return;
+		}
+	}
+
+	HISI_FB_INFO("i2c->irq = %d!\n", i2c->irq);
+	if (i2c->irq) {
+		init_waitqueue_head(&adv75xx->wq);
+		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+						adv75xx_irq_handler,
+						IRQF_ONESHOT, dev_name(dev), adv75xx);
+		if (ret) {
+			HISI_FB_ERR("adv7511_irq_handler registers failed!\n");
+			goto err_i2c_unregister_cec;
+		}
+	}
+
+	/* CEC is unused for now */
+	regmap_write(adv75xx->regmap, ADV7533_REG_CEC_CTRL,
+		     ADV7533_CEC_CTRL_POWER_DOWN);
+
+	adv75xx_power_off(adv75xx);
+
+	i2c_set_clientdata(i2c, adv75xx);
+
+	/* adv7511_audio_init(dev); */
+	status = adv75xx_detect(adv75xx);
+	if (status != connector_status_connected) {
+		HISI_FB_ERR("adv75xx connector not connected !\n");
+	}
+
+	mode = adv75xx_get_modes(adv75xx);
+
+	ret = adv75xx_mode_valid(mode);
+	if (ret) {
+		HISI_FB_ERR("adv75xx not supported this mode !!\n");
+		kfree(mode);
+		mode = hisi_set_mode_info();
+	}
+	adv75xx->mode = mode;
+	adv75xx->opt_funcs = &opt_funcs;
+
+	hdmi_pdev +	    platform_device_alloc("adi_hdmi",
+				  (((uint32_t) PANEL_MIPI_VIDEO << 16) |
+				    (uint32_t) 1));
+	if (hdmi_pdev) {
+		if (platform_device_add_data
+		    (hdmi_pdev, adv75xx, sizeof(struct adi_hdmi))) {
+			HISI_FB_ERR("failed to platform_device_add_data!\n");
+			platform_device_put(hdmi_pdev);
+		}
+	}
+	HISI_FB_INFO("platform_device_add_data ok !\n");
+
+	/* set driver data */
+	platform_set_drvdata(hdmi_pdev, adv75xx);
+	if (platform_device_add(hdmi_pdev)) {
+		HISI_FB_ERR("platform_device_add failed!\n");
+		goto err_device_put;
+	}
+
+	return 0;
+
+ err_i2c_unregister_cec:
+	i2c_unregister_device(adv75xx->i2c_cec);
+ err_i2c_unregister_edid:
+	i2c_unregister_device(adv75xx->i2c_edid);
+ err_i2c_unregister_packet:
+	i2c_unregister_device(adv75xx->i2c_packet);
+ err_device_put:
+	platform_device_put(hdmi_pdev);
+ err_return:
+	kfree(adv75xx);
+	return ret;
+}
+
+static int adv75xx_remove(struct i2c_client *i2c)
+{
+	struct adi_hdmi *adv75xx = i2c_get_clientdata(i2c);
+
+	i2c_unregister_device(adv75xx->i2c_cec);
+	i2c_unregister_device(adv75xx->i2c_edid);
+
+	kfree(adv75xx->edid);
+	kfree(adv75xx->mode);
+	kfree(adv75xx);
+
+	return 0;
+}
+
+static struct i2c_driver adv75xx_driver = {
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = "adv75xx",
+		   .of_match_table = adv75xx_of_ids,
+		   },
+	.id_table = adv75xx_i2c_ids,
+	.probe = adv75xx_probe,
+	.remove = adv75xx_remove,
+};
+
+static int __init adv75xx_init(void)
+{
+	int ret = 0;
+
+	ret = i2c_add_driver(&adv75xx_driver);
+	if (ret) {
+		HISI_FB_ERR("i2c_add_driver error!\n");
+	}
+	return ret;
+}
+
+module_init(adv75xx_init);
+
+static void __exit adv75xx_exit(void)
+{
+	i2c_del_driver(&adv75xx_driver);
+}
+
+module_exit(adv75xx_exit);
+
+MODULE_AUTHOR("Hisilicon Inc");
+MODULE_DESCRIPTION("ADV75XX HDMI transmitter driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/hisi/dss/hdmi/adv75xx.h b/drivers/video/fbdev/hisi/dss/hdmi/adv75xx.h
new file mode 100755
index 000000000000..d2f84d846271
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hdmi/adv75xx.h
@@ -0,0 +1,496 @@
+/**
+ *
+ *
+ **/
+
+#ifndef __ADV75XX_H__
+#define __ADV75XX_H__
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/hdmi.h>
+
+#include "../hisi_fb.h"
+
+#define DISPLAY_MODE_LEN	32
+
+#define ADV7533_REG_CHIP_REVISION		0x00
+#define ADV7533_REG_N0					0x01
+#define ADV7533_REG_N1					0x02
+#define ADV7533_REG_N2					0x03
+#define ADV7533_REG_SPDIF_FREQ			0x04
+#define ADV7533_REG_CTS_AUTOMATIC1		0x05
+#define ADV7533_REG_CTS_AUTOMATIC2		0x06
+#define ADV7533_REG_CTS_MANUAL0			0x07
+#define ADV7533_REG_CTS_MANUAL1			0x08
+#define ADV7533_REG_CTS_MANUAL2			0x09
+#define ADV7533_REG_AUDIO_SOURCE		0x0a
+#define ADV7533_REG_AUDIO_CONFIG		0x0b
+#define ADV7533_REG_I2S_CONFIG			0x0c
+#define ADV7533_REG_I2S_WIDTH			0x0d
+#define ADV7533_REG_AUDIO_SUB_SRC0		0x0e
+#define ADV7533_REG_AUDIO_SUB_SRC1		0x0f
+#define ADV7533_REG_AUDIO_SUB_SRC2		0x10
+#define ADV7533_REG_AUDIO_SUB_SRC3		0x11
+#define ADV7533_REG_AUDIO_CFG1			0x12
+#define ADV7533_REG_AUDIO_CFG2			0x13
+#define ADV7533_REG_AUDIO_CFG3			0x14
+#define ADV7533_REG_I2C_FREQ_ID_CFG		0x15
+#define ADV7533_REG_VIDEO_INPUT_CFG1		0x16
+#define ADV7533_REG_CEC_PIXEL_CLOCK_DIV		0x16
+#define ADV7533_REG_SYNC_POLARITY		0x17
+#define ADV7533_REG_DSI_DATA_LANES		0x1c
+#define ADV7533_REG_CSC_UPPER(x)		(0x18 + (x) * 2)
+#define ADV7533_REG_CSC_LOWER(x)		(0x19 + (x) * 2)
+#define ADV7533_REG_SYNC_DECODER(x)		(0x30 + (x))
+#define ADV7533_REG_DE_GENERATOR		(0x35 + (x))
+#define ADV7533_REG_PIXEL_REPETITION		0x3b
+#define ADV7533_REG_VIC_MANUAL			0x3c
+#define ADV7533_REG_VIC_SEND			0x3d
+#define ADV7533_REG_VIC_DETECTED		0x3e
+#define ADV7533_REG_AUX_VIC_DETECTED		0x3f
+#define ADV7533_REG_PACKET_ENABLE0		0x40
+#define ADV7533_REG_POWER			0x41
+#define ADV7533_REG_STATUS			0x42
+#define ADV7533_REG_EDID_I2C_ADDR		0x43
+#define ADV7533_REG_PACKET_ENABLE1		0x44
+#define ADV7533_REG_PACKET_I2C_ADDR		0x45
+#define ADV7533_REG_DSD_ENABLE			0x46
+#define ADV7533_REG_VIDEO_INPUT_CFG2		0x48
+#define ADV7533_REG_INFOFRAME_UPDATE		0x4a
+#define ADV7533_REG_GC(x)			(0x4b + (x))	/* 0x4b - 0x51 */
+#define ADV7533_REG_AVI_INFOFRAME_VERSION	0x52
+#define ADV7533_REG_AVI_INFOFRAME_LENGTH	0x53
+#define ADV7533_REG_AVI_INFOFRAME_CHECKSUM	0x54
+#define ADV7533_REG_AVI_INFOFRAME(x)		(0x55 + (x))	/* 0x55 - 0x6f */
+#define ADV7533_REG_AUDIO_INFOFRAME_VERSION	0x70
+#define ADV7533_REG_AUDIO_INFOFRAME_LENGTH	0x71
+#define ADV7533_REG_AUDIO_INFOFRAME_CHECKSUM	0x72
+#define ADV7533_REG_AUDIO_INFOFRAME(x)		(0x73 + (x))	/* 0x73 - 0x7c */
+#define ADV7533_REG_INT_ENABLE(x)		(0x94 + (x))
+#define ADV7533_REG_INT(x)			(0x96 + (x))
+#define ADV7533_REG_INPUT_CLK_DIV		0x9d
+#define ADV7533_REG_PLL_STATUS			0x9e
+#define ADV7533_REG_HDMI_POWER			0xa1
+#define ADV7533_REG_HDCP_HDMI_CFG		0xaf
+#define ADV7533_REG_AN(x)			(0xb0 + (x))	/* 0xb0 - 0xb7 */
+#define ADV7533_REG_HDCP_STATUS			0xb8
+#define ADV7533_REG_BCAPS			0xbe
+#define ADV7533_REG_BKSV(x)			(0xc0 + (x))	/* 0xc0 - 0xc3 */
+#define ADV7533_REG_EDID_SEGMENT		0xc4
+#define ADV7533_REG_DDC_STATUS			0xc8
+#define ADV7533_REG_EDID_READ_CTRL		0xc9
+#define ADV7533_REG_BSTATUS(x)			(0xca + (x))	/* 0xca - 0xcb */
+#define ADV7533_REG_TIMING_GEN_SEQ		0xd0
+#define ADV7533_REG_POWER2			0xd6
+#define ADV7533_REG_HSYNC_PLACEMENT_MSB		0xfa
+
+#define ADV7533_REG_SYNC_ADJUSTMENT(x)		(0xd7 + (x))	/* 0xd7 - 0xdc */
+#define ADV7533_REG_TMDS_CLOCK_INV		0xde
+#define ADV7533_REG_ARC_CTRL			0xdf
+#define ADV7533_REG_CEC_I2C_ADDR		0xe1
+#define ADV7533_REG_CEC_CTRL			0xe2
+#define ADV7533_REG_CHIP_ID_HIGH		0xf5
+#define ADV7533_REG_CHIP_ID_LOW			0xf6
+
+#define ADV7533_CSC_ENABLE			BIT(7)
+#define ADV7533_CSC_UPDATE_MODE			BIT(5)
+
+#define ADV7533_INT0_HDP			BIT(7)
+#define ADV7533_INT0_VSYNC			BIT(5)
+#define ADV7533_INT0_AUDIO_FIFO_FULL		BIT(4)
+#define ADV7533_INT0_EDID_READY			BIT(2)
+#define ADV7533_INT0_HDCP_AUTHENTICATED		BIT(1)
+
+#define ADV7533_INT1_DDC_ERROR			BIT(7)
+#define ADV7533_INT1_BKSV			BIT(6)
+#define ADV7533_INT1_CEC_TX_READY		BIT(5)
+#define ADV7533_INT1_CEC_TX_ARBIT_LOST		BIT(4)
+#define ADV7533_INT1_CEC_TX_RETRY_TIMEOUT	BIT(3)
+#define ADV7533_INT1_CEC_RX_READY3		BIT(2)
+#define ADV7533_INT1_CEC_RX_READY2		BIT(1)
+#define ADV7533_INT1_CEC_RX_READY1		BIT(0)
+
+#define ADV7533_ARC_CTRL_POWER_DOWN		BIT(0)
+
+#define ADV7533_CEC_CTRL_POWER_DOWN		BIT(0)
+
+#define ADV7533_POWER_POWER_DOWN		BIT(6)
+
+#define ADV7533_HDMI_CFG_MODE_MASK		0x2
+#define ADV7533_HDMI_CFG_MODE_DVI		0x0
+#define ADV7533_HDMI_CFG_MODE_HDMI		0x2
+
+#define ADV7533_AUDIO_SELECT_I2C		0x0
+#define ADV7533_AUDIO_SELECT_SPDIF		0x1
+#define ADV7533_AUDIO_SELECT_DSD		0x2
+#define ADV7533_AUDIO_SELECT_HBR		0x3
+#define ADV7533_AUDIO_SELECT_DST		0x4
+
+#define ADV7533_I2S_SAMPLE_LEN_16		0x2
+#define ADV7533_I2S_SAMPLE_LEN_20		0x3
+#define ADV7533_I2S_SAMPLE_LEN_18		0x4
+#define ADV7533_I2S_SAMPLE_LEN_22		0x5
+#define ADV7533_I2S_SAMPLE_LEN_19		0x8
+#define ADV7533_I2S_SAMPLE_LEN_23		0x9
+#define ADV7533_I2S_SAMPLE_LEN_24		0xb
+#define ADV7533_I2S_SAMPLE_LEN_17		0xc
+#define ADV7533_I2S_SAMPLE_LEN_21		0xd
+
+#define ADV7533_SAMPLE_FREQ_44100		0x0
+#define ADV7533_SAMPLE_FREQ_48000		0x2
+#define ADV7533_SAMPLE_FREQ_32000		0x3
+#define ADV7533_SAMPLE_FREQ_88200		0x8
+#define ADV7533_SAMPLE_FREQ_96000		0xa
+#define ADV7533_SAMPLE_FREQ_176400		0xc
+#define ADV7533_SAMPLE_FREQ_192000		0xe
+
+#define ADV7533_STATUS_POWER_DOWN_POLARITY	BIT(7)
+#define ADV7533_STATUS_HPD			BIT(6)
+#define ADV7533_STATUS_MONITOR_SENSE		BIT(5)
+#define ADV7533_STATUS_I2S_32BIT_MODE		BIT(3)
+
+#define ADV7533_PACKET_ENABLE_N_CTS		BIT(8+6)
+#define ADV7533_PACKET_ENABLE_AUDIO_SAMPLE	BIT(8+5)
+#define ADV7533_PACKET_ENABLE_AVI_INFOFRAME	BIT(8+4)
+#define ADV7533_PACKET_ENABLE_AUDIO_INFOFRAME	BIT(8+3)
+#define ADV7533_PACKET_ENABLE_GC		BIT(7)
+#define ADV7533_PACKET_ENABLE_SPD		BIT(6)
+#define ADV7533_PACKET_ENABLE_MPEG		BIT(5)
+#define ADV7533_PACKET_ENABLE_ACP		BIT(4)
+#define ADV7533_PACKET_ENABLE_ISRC		BIT(3)
+#define ADV7533_PACKET_ENABLE_GM		BIT(2)
+#define ADV7533_PACKET_ENABLE_SPARE2		BIT(1)
+#define ADV7533_PACKET_ENABLE_SPARE1		BIT(0)
+
+#define ADV7533_REG_POWER2_HDP_SRC_MASK		0xc0
+#define ADV7533_REG_POWER2_HDP_SRC_BOTH		0x00
+#define ADV7533_REG_POWER2_HDP_SRC_HDP		0x40
+#define ADV7533_REG_POWER2_HDP_SRC_CEC		0x80
+#define ADV7533_REG_POWER2_HDP_SRC_NONE		0xc0
+#define ADV7533_REG_POWER2_TDMS_ENABLE		BIT(4)
+#define ADV7533_REG_POWER2_GATE_INPUT_CLK	BIT(0)
+
+#define ADV7533_LOW_REFRESH_RATE_NONE		0x0
+#define ADV7533_LOW_REFRESH_RATE_24HZ		0x1
+#define ADV7533_LOW_REFRESH_RATE_25HZ		0x2
+#define ADV7533_LOW_REFRESH_RATE_30HZ		0x3
+
+#define ADV7533_AUDIO_CFG3_LEN_MASK		0x0f
+#define ADV7533_I2C_FREQ_ID_CFG_RATE_MASK	0xf0
+
+#define ADV7533_AUDIO_SOURCE_I2S		0
+#define ADV7533_AUDIO_SOURCE_SPDIF		1
+
+#define ADV7533_I2S_FORMAT_I2S			0
+#define ADV7533_I2S_FORMAT_RIGHT_J		1
+#define ADV7533_I2S_FORMAT_LEFT_J		2
+
+#define ADV7533_PACKET(p, x)	    ((p) * 0x20 + (x))
+#define ADV7533_PACKET_SDP(x)	    ADV7533_PACKET(0, x)
+#define ADV7533_PACKET_MPEG(x)	    ADV7533_PACKET(1, x)
+#define ADV7533_PACKET_ACP(x)	    ADV7533_PACKET(2, x)
+#define ADV7533_PACKET_ISRC1(x)	    ADV7533_PACKET(3, x)
+#define ADV7533_PACKET_ISRC2(x)	    ADV7533_PACKET(4, x)
+#define ADV7533_PACKET_GM(x)	    ADV7533_PACKET(5, x)
+#define ADV7533_PACKET_SPARE(x)	    ADV7533_PACKET(6, x)
+
+#define EDID_LENGTH				0x80
+#define EDID_EXTENSION_NUM				0x7e
+
+/* Video mode flags */
+/* bit compatible with the xorg definitions. */
+#define MODE_FLAG_PHSYNC			(1<<0)
+#define MODE_FLAG_NHSYNC			(1<<1)
+#define MODE_FLAG_PVSYNC			(1<<2)
+#define MODE_FLAG_NVSYNC			(1<<3)
+#define MODE_FLAG_INTERLACE			(1<<4)
+#define MODE_FLAG_DBLSCAN			(1<<5)
+#define MODE_FLAG_CSYNC			(1<<6)
+#define MODE_FLAG_PCSYNC			(1<<7)
+#define MODE_FLAG_NCSYNC			(1<<8)
+#define MODE_FLAG_HSKEW			(1<<9)	/* hskew provided */
+#define MODE_FLAG_BCAST			(1<<10)
+#define MODE_FLAG_PIXMUX			(1<<11)
+#define MODE_FLAG_DBLCLK			(1<<12)
+#define MODE_FLAG_CLKDIV2			(1<<13)
+
+/*
+ * Note on terminology:  here, for brevity and convenience, we refer to connector
+ * control chips as 'CRTCs'.  They can control any type of connector, VGA, LVDS,
+ * DVI, etc.  And 'screen' refers to the whole of the visible display, which
+ * may span multiple monitors (and therefore multiple CRTC and connector
+ * structures).
+ */
+
+enum mode_status {
+	MODE_OK = 0,		/* Mode OK */
+	MODE_HSYNC,		/* hsync out of range */
+	MODE_VSYNC,		/* vsync out of range */
+	MODE_H_ILLEGAL,		/* mode has illegal horizontal timings */
+	MODE_V_ILLEGAL,		/* mode has illegal horizontal timings */
+	MODE_BAD_WIDTH,		/* requires an unsupported linepitch */
+	MODE_NOMODE,		/* no mode with a matching name */
+	MODE_NO_INTERLACE,	/* interlaced mode not supported */
+	MODE_NO_DBLESCAN,	/* doublescan mode not supported */
+	MODE_NO_VSCAN,		/* multiscan mode not supported */
+	MODE_MEM,		/* insufficient video memory */
+	MODE_VIRTUAL_X,		/* mode width too large for specified virtual size */
+	MODE_VIRTUAL_Y,		/* mode height too large for specified virtual size */
+	MODE_MEM_VIRT,		/* insufficient video memory given virtual size */
+	MODE_NOCLOCK,		/* no fixed clock available */
+	MODE_CLOCK_HIGH,	/* clock required is too high */
+	MODE_CLOCK_LOW,		/* clock required is too low */
+	MODE_CLOCK_RANGE,	/* clock/mode isn't in a ClockRange */
+	MODE_BAD_HVALUE,	/* horizontal timing was out of range */
+	MODE_BAD_VVALUE,	/* vertical timing was out of range */
+	MODE_BAD_VSCAN,		/* VScan value out of range */
+	MODE_HSYNC_NARROW,	/* horizontal sync too narrow */
+	MODE_HSYNC_WIDE,	/* horizontal sync too wide */
+	MODE_HBLANK_NARROW,	/* horizontal blanking too narrow */
+	MODE_HBLANK_WIDE,	/* horizontal blanking too wide */
+	MODE_VSYNC_NARROW,	/* vertical sync too narrow */
+	MODE_VSYNC_WIDE,	/* vertical sync too wide */
+	MODE_VBLANK_NARROW,	/* vertical blanking too narrow */
+	MODE_VBLANK_WIDE,	/* vertical blanking too wide */
+	MODE_PANEL,		/* exceeds panel dimensions */
+	MODE_INTERLACE_WIDTH,	/* width too large for interlaced mode */
+	MODE_ONE_WIDTH,		/* only one width is supported */
+	MODE_ONE_HEIGHT,	/* only one height is supported */
+	MODE_ONE_SIZE,		/* only one resolution is supported */
+	MODE_NO_REDUCED,	/* monitor doesn't accept reduced blanking */
+	MODE_NO_STEREO,		/* stereo modes not supported */
+	MODE_UNVERIFIED = -3,	/* mode needs to reverified */
+	MODE_BAD = -2,		/* unspecified reason */
+	MODE_ERROR = -1		/* error condition */
+};
+
+enum DDC_controller_status {
+	IN_RESET = 0,		/* In Reset (No Hot Plug Detected) */
+	READING_EDID,		/* Reading EDID */
+	IDLE,			/* IDLE (Waiting for HDCP Requested) */
+	INIT_HDCP,		/* Initializing HDCP */
+	HDCP_ENABLE,		/* HDCP Enabled */
+	INIT_HDCP_REPEAT	/* Initializing HDCP Repeater */
+};
+
+/* If detailed data is pixel timing */
+struct detailed_pixel_timing {
+	u8 hactive_lo;
+	u8 hblank_lo;
+	u8 hactive_hblank_hi;
+	u8 vactive_lo;
+	u8 vblank_lo;
+	u8 vactive_vblank_hi;
+	u8 hsync_offset_lo;
+	u8 hsync_pulse_width_lo;
+	u8 vsync_offset_pulse_width_lo;
+	u8 hsync_vsync_offset_pulse_width_hi;
+	u8 width_mm_lo;
+	u8 height_mm_lo;
+	u8 width_height_mm_hi;
+	u8 hborder;
+	u8 vborder;
+	u8 misc;
+} __attribute__ ((packed));
+
+struct est_timings {
+	u8 t1;
+	u8 t2;
+	u8 mfg_rsvd;
+} __attribute__ ((packed));
+
+struct std_timing {
+	u8 hsize;		/* need to multiply by 8 then add 248 */
+	u8 vfreq_aspect;
+} __attribute__ ((packed));
+
+struct detailed_timing {
+	__le16 pixel_clock;	/* need to multiply by 10 KHz */
+	union {
+		struct detailed_pixel_timing pixel_data;
+		/* struct detailed_non_pixel other_data;*/
+	} data;
+} __attribute__ ((packed));
+
+struct edid {
+	u8 header[8];
+	/* Vendor & product info */
+	u8 mfg_id[2];
+	u8 prod_code[2];
+	u32 serial;		/* FIXME: byte order */
+	u8 mfg_week;
+	u8 mfg_year;
+	/* EDID version */
+	u8 version;
+	u8 revision;
+	/* Display info: */
+	u8 input;
+	u8 width_cm;
+	u8 height_cm;
+	u8 gamma;
+	u8 features;
+	/* Color characteristics */
+	u8 red_green_lo;
+	u8 black_white_lo;
+	u8 red_x;
+	u8 red_y;
+	u8 green_x;
+	u8 green_y;
+	u8 blue_x;
+	u8 blue_y;
+	u8 white_x;
+	u8 white_y;
+	/* Est. timings and mfg rsvd timings */
+	struct est_timings established_timings;
+	/* Standard timings 1-8 */
+	struct std_timing standard_timings[8];
+	/* Detailing timings 1-4 */
+	struct detailed_timing detailed_timings[4];
+	/* Number of 128 byte ext. blocks */
+	u8 extensions;
+	/* Checksum */
+	u8 checksum;
+} __attribute__ ((packed));
+
+/**
+ * enum adv75xx_csc_scaling - Scaling factor for the ADV75xx CSC
+ * @ADV75xx_CSC_SCALING_1: CSC results are not scaled
+ * @ADV75xx_CSC_SCALING_2: CSC results are scaled by a factor of two
+ * @ADV75xx_CSC_SCALING_4: CSC results are scalled by a factor of four
+ */
+enum adv75xx_csc_scaling {
+	ADV75xx_CSC_SCALING_1 = 0,
+	ADV75xx_CSC_SCALING_2 = 1,
+	ADV75xx_CSC_SCALING_4 = 2,
+};
+
+/**
+ * struct adv75xx_video_config - Describes adv75xx hardware configuration
+ * @csc_enable:			Whether to enable color space conversion
+ * @csc_scaling_factor:		Color space conversion scaling factor
+ * @csc_coefficents:		Color space conversion coefficents
+ * @hdmi_mode:			Whether to use HDMI or DVI output mode
+ * @avi_infoframe:		HDMI infoframe
+ */
+struct adv75xx_video_config {
+	bool csc_enable;
+	enum adv75xx_csc_scaling csc_scaling_factor;
+	const uint16_t *csc_coefficents;
+
+	bool hdmi_mode;
+	struct hdmi_avi_infoframe avi_infoframe;
+};
+
+struct hisi_display_mode {
+
+	unsigned int type;
+
+	/* Proposed mode values */
+	int clock;		/* in kHz */
+	int hdisplay;
+	int hsync_start;
+	int hsync_end;
+	int hsync_pulse_width;
+	int hsync_offset;
+	int htotal;
+
+	int vdisplay;
+	int vsync_start;
+	int vsync_end;
+	int vsync_pulse_width;
+	int vsync_offset;
+	int vtotal;
+	int vscan;
+	unsigned int flags;
+
+	/* Addressable image size (may be 0 for projectors, etc.) */
+	int width_mm;
+	int height_mm;
+
+	int vrefresh;		/* in Hz */
+	int hsync;		/* in kHz */
+	enum hdmi_picture_aspect picture_aspect_ratio;
+};
+
+/**
+ * enum adv7511_sync_polarity - Polarity for the input sync signals
+ * @ADV7533_SYNC_POLARITY_PASSTHROUGH:  Sync polarity matches that of
+ *				       the currently configured mode.
+ * @ADV7533_SYNC_POLARITY_LOW:	    Sync polarity is low
+ * @ADV7533_SYNC_POLARITY_HIGH:	    Sync polarity is high
+ *
+ * If the polarity is set to either LOW or HIGH the driver will configure the
+ * ADV7533 to internally invert the sync signal if required to match the sync
+ * polarity setting for the currently selected output mode.
+ *
+ * If the polarity is set to PASSTHROUGH, the ADV7533 will route the signal
+ * unchanged. This is used when the upstream graphics core already generates
+ * the sync signals with the correct polarity.
+ */
+enum adi_sync_polarity {
+	ADV7533_SYNC_POLARITY_PASSTHROUGH,
+	ADV7533_SYNC_POLARITY_LOW,
+	ADV7533_SYNC_POLARITY_HIGH,
+};
+
+enum adv75xx_type {
+	ADV7511,
+	ADV7533,
+	ADV7535,
+};
+
+enum connector_status {
+	connector_status_connected = 1,
+	connector_status_disconnected = 2,
+	connector_status_unknown = 3,
+};
+
+struct adi_hdmi {
+	enum adv75xx_type type;
+	bool powered;
+
+	struct regulator *vdd;
+	struct regulator *v1p2;
+
+	struct i2c_client *i2c_main;
+	struct i2c_client *i2c_edid;
+	struct i2c_client *i2c_cec;
+	struct i2c_client *i2c_packet;
+
+	struct regmap *regmap;
+	struct regmap *regmap_cec;
+	struct regmap *regmap_packet;
+	enum connector_status status;
+
+	unsigned int f_tmds;
+	unsigned int f_audio;
+	unsigned int audio_source;
+
+	bool edid_read;
+	unsigned int current_edid_segment;
+
+	wait_queue_head_t wq;
+
+	bool rgb;
+	bool embedded_sync;
+	enum adi_sync_polarity vsync_polarity;
+	enum adi_sync_polarity hsync_polarity;
+	uint8_t num_dsi_lanes;
+
+	struct edid *edid;
+	struct gpio_desc *gpio_pd;
+
+	struct hisi_display_mode *mode;
+	struct adi_operation_funcs *opt_funcs;
+};
+
+struct adi_operation_funcs {
+	void (*power_on)(struct adi_hdmi *adv75xx);
+	void (*power_off)(struct adi_hdmi *adv75xx);
+	void (*mode_set)(struct adi_hdmi *adv75xx,
+			  struct hisi_display_mode *mode);
+};
+
+#endif				/* __ADV75XX_H__ */
diff --git a/drivers/video/fbdev/hisi/dss/hdmi/adv75xx_audio.c b/drivers/video/fbdev/hisi/dss/hdmi/adv75xx_audio.c
new file mode 100755
index 000000000000..8242579107b2
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hdmi/adv75xx_audio.c
@@ -0,0 +1,310 @@
+/*
+ * Analog Devices ADV7511 HDMI transmitter driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "adv75xx.h"
+
+static const struct snd_soc_dapm_widget adv75xx_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TMDS"),
+	SND_SOC_DAPM_AIF_IN("AIFIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route adv75xx_routes[] = {
+	{"TMDS", NULL, "AIFIN"},
+};
+
+static void adv75xx_calc_cts_n(unsigned int f_tmds, unsigned int fs,
+			       unsigned int *cts, unsigned int *n)
+{
+	switch (fs) {
+	case 32000:
+		*n = 4096;
+		break;
+	case 44100:
+		*n = 6272;
+		break;
+	case 48000:
+		*n = 6144;
+		break;
+	}
+
+	*cts = ((f_tmds * *n) / (128 * fs)) * 1000;
+}
+
+static int adv75xx_update_cts_n(struct adi_hdmi *adv75xx)
+{
+	unsigned int cts = 0;
+	unsigned int n = 0;
+
+	adv75xx_calc_cts_n(adv75xx->f_tmds, adv75xx->f_audio, &cts, &n);
+
+	regmap_write(adv75xx->regmap, ADV7533_REG_N0, (n >> 16) & 0xf);
+	regmap_write(adv75xx->regmap, ADV7533_REG_N1, (n >> 8) & 0xff);
+	regmap_write(adv75xx->regmap, ADV7533_REG_N2, n & 0xff);
+
+	regmap_write(adv75xx->regmap, ADV7533_REG_CTS_MANUAL0,
+		     (cts >> 16) & 0xf);
+	regmap_write(adv75xx->regmap, ADV7533_REG_CTS_MANUAL1,
+		     (cts >> 8) & 0xff);
+	regmap_write(adv75xx->regmap, ADV7533_REG_CTS_MANUAL2, cts & 0xff);
+
+	return 0;
+}
+
+static int adv75xx_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct adi_hdmi *adv75xx = snd_soc_codec_get_drvdata(codec);
+	unsigned int rate;
+	unsigned int len;
+	switch (params_rate(params)) {
+	case 32000:
+		rate = ADV7533_SAMPLE_FREQ_32000;
+		break;
+	case 44100:
+		rate = ADV7533_SAMPLE_FREQ_44100;
+		break;
+	case 48000:
+		rate = ADV7533_SAMPLE_FREQ_48000;
+		break;
+	case 88200:
+		rate = ADV7533_SAMPLE_FREQ_88200;
+		break;
+	case 96000:
+		rate = ADV7533_SAMPLE_FREQ_96000;
+		break;
+	case 176400:
+		rate = ADV7533_SAMPLE_FREQ_176400;
+		break;
+	case 192000:
+		rate = ADV7533_SAMPLE_FREQ_192000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		len = ADV7533_I2S_SAMPLE_LEN_16;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		len = ADV7533_I2S_SAMPLE_LEN_18;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		len = ADV7533_I2S_SAMPLE_LEN_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		len = ADV7533_I2S_SAMPLE_LEN_24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	adv75xx->f_audio = params_rate(params);
+
+	adv75xx_update_cts_n(adv75xx);
+
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_AUDIO_CFG3,
+			   ADV7533_AUDIO_CFG3_LEN_MASK, len);
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_I2C_FREQ_ID_CFG,
+			   ADV7533_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
+	regmap_write(adv75xx->regmap, 0x73, 0x1);
+
+	return 0;
+}
+
+static int adv75xx_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct adi_hdmi *adv75xx = snd_soc_codec_get_drvdata(codec);
+	unsigned int audio_source, i2s_format = 0;
+	unsigned int invert_clock;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		audio_source = ADV7533_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7533_I2S_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		audio_source = ADV7533_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7533_I2S_FORMAT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		audio_source = ADV7533_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7533_I2S_FORMAT_LEFT_J;
+		break;
+	/*
+	case SND_SOC_DAIFMT_SPDIF:
+	   audio_source = ADV7533_AUDIO_SOURCE_SPDIF;
+	   break;
+	*/
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		invert_clock = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		invert_clock = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_AUDIO_SOURCE, 0x70,
+			   audio_source << 4);
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_AUDIO_CONFIG, BIT(6),
+			   invert_clock << 6);
+	regmap_update_bits(adv75xx->regmap, ADV7533_REG_I2S_CONFIG, 0x03,
+			   i2s_format);
+
+	adv75xx->audio_source = audio_source;
+
+	return 0;
+}
+
+static int adv75xx_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	struct adi_hdmi *adv75xx = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		switch (adv75xx->audio_source) {
+		case ADV7533_AUDIO_SOURCE_I2S:
+			break;
+		case ADV7533_AUDIO_SOURCE_SPDIF:
+			regmap_update_bits(adv75xx->regmap,
+					   ADV7533_REG_AUDIO_CONFIG, BIT(7),
+					   BIT(7));
+			break;
+		}
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		if (dapm->bias_level = SND_SOC_BIAS_STANDBY) {
+			adv75xx_packet_enable(adv75xx,
+					      ADV7533_PACKET_ENABLE_AUDIO_SAMPLE);
+			adv75xx_packet_enable(adv75xx,
+					      ADV7533_PACKET_ENABLE_AUDIO_INFOFRAME);
+			adv75xx_packet_enable(adv75xx,
+					      ADV7533_PACKET_ENABLE_N_CTS);
+		} else {
+			adv75xx_packet_disable(adv75xx,
+					       ADV7533_PACKET_ENABLE_AUDIO_SAMPLE);
+			adv75xx_packet_disable(adv75xx,
+					       ADV7533_PACKET_ENABLE_AUDIO_INFOFRAME);
+			adv75xx_packet_disable(adv75xx,
+					       ADV7533_PACKET_ENABLE_N_CTS);
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regmap_update_bits(adv75xx->regmap, ADV7533_REG_AUDIO_CONFIG,
+				   BIT(7), 0);
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+	dapm->bias_level = level;
+	return 0;
+}
+
+#define ADV7533_RATES (SNDRV_PCM_RATE_32000 |\
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |\
+		SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
+#define ADV7533_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |\
+		SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+static const struct snd_soc_dai_ops adv75xx_dai_ops = {
+	.hw_params = adv75xx_hw_params,
+	/*.set_sysclk   = adv75xx_set_dai_sysclk, */
+	.set_fmt = adv75xx_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver adv75xx_dai = {
+	.name = "adv75xx",
+	.playback = {
+		     .stream_name = "Playback",
+		     .channels_min = 2,
+		     .channels_max = 2,
+		     .rates = ADV7533_RATES,
+		     .formats = ADV7533_FORMATS,
+		     },
+	.ops = &adv75xx_dai_ops,
+};
+
+static int adv75xx_suspend(struct snd_soc_codec *codec)
+{
+	return adv75xx_set_bias_level(codec, SND_SOC_BIAS_OFF);
+}
+
+static int adv75xx_resume(struct snd_soc_codec *codec)
+{
+	return adv75xx_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+}
+
+static int adv75xx_probe(struct snd_soc_codec *codec)
+{
+	return adv75xx_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+}
+
+static int adv75xx_remove(struct snd_soc_codec *codec)
+{
+	adv75xx_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static struct snd_soc_codec_driver adv75xx_codec_driver = {
+	.probe = adv75xx_probe,
+	.remove = adv75xx_remove,
+	.suspend = adv75xx_suspend,
+	.resume = adv75xx_resume,
+	.set_bias_level = adv75xx_set_bias_level,
+
+	.dapm_widgets = adv75xx_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(adv75xx_dapm_widgets),
+	.dapm_routes = adv75xx_routes,
+	.num_dapm_routes = ARRAY_SIZE(adv75xx_routes),
+};
+
+int adv75xx_audio_init(struct device *dev)
+{
+	return snd_soc_register_codec(dev, &adv75xx_codec_driver,
+				      &adv75xx_dai, 1);
+}
+
+void adv75xx_audio_exit(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
diff --git a/drivers/video/fbdev/hisi/dss/hdmi/mipi_adi_hdmi.c b/drivers/video/fbdev/hisi/dss/hdmi/mipi_adi_hdmi.c
new file mode 100755
index 000000000000..65313f54878d
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hdmi/mipi_adi_hdmi.c
@@ -0,0 +1,314 @@
+/* Copyright (c) 2008-2011, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *	 * Redistributions of source code must retain the above copyright
+ *	   notice, this list of conditions and the following disclaimer.
+ *	 * Redistributions in binary form must reproduce the above
+ *	   copyright notice, this list of conditions and the following
+ *	   disclaimer in the documentation and/or other materials provided
+ *	   with the distribution.
+ *	 * Neither the name of Code Aurora Forum, Inc. nor the names of its
+ *	   contributors may be used to endorse or promote products derived
+ *	   from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include "../hisi_fb.h"
+#include "adv75xx.h"
+
+/*******************************************************************************
+ **
+ */
+static int mipi_adi_hdmi_on(struct platform_device *pdev)
+{
+	struct adi_hdmi *adv75xx = NULL;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisi_panel_info *pinfo = NULL;
+
+	HISI_FB_INFO("+.\n");
+
+	if (pdev = NULL) {
+		HISI_FB_ERR("pdev is NULL!\n");
+		return -1;
+	}
+
+	HISI_FB_INFO("pdev->name = %s, pdev->id = %d\n", pdev->name, pdev->id);
+
+	hisifd = platform_get_drvdata(pdev);
+	if (hisifd = NULL) {
+		HISI_FB_ERR("platform get drivre data failed!!\n");
+		return -1;
+	}
+
+	HISI_FB_INFO("fb%d, +!\n", hisifd->index);
+
+	pinfo = &(hisifd->panel_info);
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (pdata = NULL) {
+		HISI_FB_ERR("devices get platform data failed!!\n");
+		return -1;
+	}
+
+	if (pdata->next) {
+		adv75xx = platform_get_drvdata(pdata->next);
+		if (!adv75xx) {
+			HISI_FB_ERR("platform get drivre data failed!\n");
+			return -1;
+		}
+	} else {
+		HISI_FB_ERR("pdata->next is NULL!!\n");
+		return -1;
+	}
+
+	HISI_FB_INFO("adv75xx->i2c_main->name is %s!\n",
+		     adv75xx->i2c_main->name);
+	HISI_FB_INFO("adv75xx->mode->vdisplay is %d!\n",
+		     adv75xx->mode->vdisplay);
+
+	if (pinfo->lcd_init_step = LCD_INIT_POWER_ON) {
+		pinfo->lcd_init_step = LCD_INIT_MIPI_LP_SEND_SEQUENCE;
+	} else if (pinfo->lcd_init_step = LCD_INIT_MIPI_LP_SEND_SEQUENCE) {
+		pinfo->lcd_init_step = LCD_INIT_MIPI_HS_SEND_SEQUENCE;
+	} else if (pinfo->lcd_init_step = LCD_INIT_MIPI_HS_SEND_SEQUENCE) {
+		adv75xx->opt_funcs->mode_set(adv75xx, adv75xx->mode);
+		adv75xx->opt_funcs->power_on(adv75xx);
+	} else {
+		HISI_FB_ERR("failed to init hdmi!\n");
+	}
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+}
+
+static int mipi_adi_hdmi_off(struct platform_device *pdev)
+{
+	struct adi_hdmi *adv75xx = NULL;
+	struct hisi_fb_panel_data *pdata = NULL;
+
+	HISI_FB_INFO("+.\n");
+
+	BUG_ON(pdev = NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	HISI_FB_INFO("pdev->name = %s, pdev->id = %d +.\n", pdev->name,
+		     pdev->id);
+
+	if (pdata->next) {
+		adv75xx = platform_get_drvdata(pdata->next);
+		if (!adv75xx) {
+			HISI_FB_ERR("platform get drivre data failed!\n");
+			return -1;
+		}
+	}
+
+	HISI_FB_INFO("adv75xx->i2c_main->name is %s!\n",
+		     adv75xx->i2c_main->name);
+	HISI_FB_INFO("adv75xx->mode->vdisplay is %d!\n",
+		     adv75xx->mode->vdisplay);
+
+	adv75xx->opt_funcs->power_off(adv75xx);
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+}
+
+static int mipi_adi_hdmi_remove(struct platform_device *pdev)
+{
+
+	return 0;
+}
+
+/*******************************************************************************
+ **
+ */
+static struct hisi_panel_info g_adi_hdmi_info = { 0 };
+
+static struct hisi_fb_panel_data g_adi_hdmi_data = {
+	.panel_info = &g_adi_hdmi_info,
+	.on = mipi_adi_hdmi_on,
+	.off = mipi_adi_hdmi_off,
+};
+
+/*******************************************************************************
+ **
+ */
+static int mipi_adi_hdmi_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct adi_hdmi *adv75xx = NULL;
+	struct hisi_panel_info *pinfo = NULL;
+	struct hisi_display_mode *mode = NULL;
+
+	if (pdev = NULL)
+		HISI_FB_ERR("platform device is NULL!\n");
+
+	HISI_FB_INFO("pdev->name = %s, pdev->id = %d +.\n", pdev->name,
+		     pdev->id);
+
+	adv75xx = platform_get_drvdata(pdev);
+	if (!adv75xx) {
+		HISI_FB_ERR("platform get drivre data failed!\n");
+		goto err_probe_defer;
+	}
+
+	HISI_FB_INFO("adv75xx->i2c_main->name is %s!\n",
+		     adv75xx->i2c_main->name);
+
+	HISI_FB_INFO("adv75xx->mode->vdisplay is %d!\n",
+		     adv75xx->mode->vdisplay);
+
+	if (adv75xx->mode) {
+		mode = adv75xx->mode;
+		/* init hdmi display info */
+		pinfo = g_adi_hdmi_data.panel_info;
+		pinfo->xres = mode->hdisplay;
+		pinfo->yres = mode->vdisplay;
+		pinfo->width = mode->width_mm;
+		pinfo->height = mode->height_mm;
+		pinfo->orientation = LCD_PORTRAIT;
+		pinfo->bpp = LCD_RGB888;
+		pinfo->bgr_fmt = LCD_RGB;
+		pinfo->bl_set_type = BL_SET_BY_MIPI;
+
+		pinfo->type = PANEL_MIPI_VIDEO;
+
+		pinfo->bl_min = 1;
+		pinfo->bl_max = 255;
+		pinfo->bl_default = 102;
+
+		pinfo->pxl_clk_rate = mode->clock * 1000UL;
+		pinfo->ldi.h_back_porch = mode->htotal - mode->hsync_end;
+		pinfo->ldi.h_front_porch = mode->hsync_offset;
+		pinfo->ldi.h_pulse_width = mode->hsync_pulse_width;
+		pinfo->ldi.v_back_porch = mode->vtotal - mode->vsync_end;
+		pinfo->ldi.v_front_porch = mode->vsync_offset;
+		pinfo->ldi.v_pulse_width = mode->vsync_pulse_width;
+	} else {
+		/* init hdmi display info */
+		pinfo = g_adi_hdmi_data.panel_info;
+		pinfo->xres = 1920;
+		pinfo->yres = 1080;
+		pinfo->width = 16000;
+		pinfo->height = 9000;
+
+		pinfo->orientation = LCD_PORTRAIT;
+		pinfo->bpp = LCD_RGB888;
+		pinfo->bgr_fmt = LCD_RGB;
+		pinfo->bl_set_type = BL_SET_BY_MIPI;
+
+		pinfo->type = PANEL_MIPI_VIDEO;
+
+		pinfo->bl_min = 1;
+		pinfo->bl_max = 255;
+		pinfo->bl_default = 102;
+
+		pinfo->ldi.h_back_porch = 148;
+		pinfo->ldi.h_front_porch = 88;
+		pinfo->ldi.h_pulse_width = 44;
+		pinfo->ldi.v_back_porch = 36;
+		pinfo->ldi.v_front_porch = 4;
+		pinfo->ldi.v_pulse_width = 5;
+	}
+
+
+	pinfo->mipi.dsi_bit_clk = 480;
+
+
+	pinfo->dsi_bit_clk_upt_support = 0;
+	pinfo->mipi.dsi_bit_clk_upt = pinfo->mipi.dsi_bit_clk;
+
+	pinfo->mipi.non_continue_en = 0;
+
+	pinfo->pxl_clk_rate = 160 * 1000000UL;
+
+
+	pinfo->mipi.lane_nums = DSI_4_LANES;
+	pinfo->mipi.color_mode = DSI_24BITS_1;
+	pinfo->mipi.vc = 0;
+	pinfo->mipi.max_tx_esc_clk = 10 * 1000000;
+	pinfo->mipi.burst_mode = DSI_NON_BURST_SYNC_PULSES;
+
+	pinfo->mipi.clk_post_adjust = 120;
+	pinfo->mipi.clk_pre_adjust = 0;
+	pinfo->mipi.clk_t_hs_prepare_adjust = 0;
+	pinfo->mipi.clk_t_lpx_adjust = 0;
+	pinfo->mipi.clk_t_hs_trial_adjust = 0;
+	pinfo->mipi.clk_t_hs_exit_adjust = 0;
+	pinfo->mipi.clk_t_hs_zero_adjust = 0;
+
+	pinfo->pxl_clk_rate_div = 1;
+
+	g_adi_hdmi_data.next = pdev;
+	HISI_FB_INFO("The pixel clock is %llu !\n", pinfo->pxl_clk_rate);
+	HISI_FB_INFO("The resolution is %d x %d !\n", pinfo->xres, pinfo->yres);
+	HISI_FB_INFO
+	    ("hsw = %d, hfp = %d, hbp = %d, vsw = %d, vfp= %d, vbp = %d\n",
+	     pinfo->ldi.h_pulse_width, pinfo->ldi.h_front_porch,
+	     pinfo->ldi.h_back_porch, pinfo->ldi.v_pulse_width,
+	     pinfo->ldi.v_front_porch, pinfo->ldi.v_back_porch);
+
+
+	ret = platform_device_add_data(pdev, &g_adi_hdmi_data,
+				       sizeof(struct hisi_fb_panel_data));
+	if (ret) {
+		HISI_FB_ERR("platform_device_add_data failed!\n");
+		goto err_device_put;
+	}
+
+	hisi_fb_add_device(pdev);
+
+	HISI_FB_INFO("-.\n");
+
+	return 0;
+
+ err_device_put:
+	platform_device_put(pdev);
+ err_probe_defer:
+	return -EPROBE_DEFER;
+}
+
+static struct platform_driver this_driver = {
+	.probe = mipi_adi_hdmi_probe,
+	.remove = mipi_adi_hdmi_remove,
+	.suspend = NULL,
+	.resume = NULL,
+	.shutdown = NULL,
+	.driver = {
+		   .name = "adi_hdmi",
+		   }
+};
+
+static int __init mipi_adi_hdmi_init(void)
+{
+	int ret = 0;
+
+	ret = platform_driver_register(&this_driver);
+	if (ret) {
+		HISI_FB_ERR("platform_driver_register failed, error=%d!\n",
+			    ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+module_init(mipi_adi_hdmi_init);
diff --git a/drivers/video/fbdev/hisi/dss/panel/mipi_hikey_nte300nts.c b/drivers/video/fbdev/hisi/dss/panel/mipi_hikey_nte300nts.c
new file mode 100755
index 000000000000..7e1fbd0ee5c6
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/panel/mipi_hikey_nte300nts.c
@@ -0,0 +1,525 @@
+/* Copyright (c) 2008-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "../hisi_fb.h"
+
+#define DTS_COMP_MIPI_HIKEY	"hisilicon,mipi_hikey"
+
+/********************************Hikey start***********************
+ **Power ON Sequence(sleep mode to Normal mode)
+ */
+static char hikey_power_on_param1[] = {
+	0x01,
+};
+
+static char hikey_power_on_param2[] = {
+	0xB0,
+	0x00,
+};
+
+static char hikey_power_on_param3[] = {
+	0xD6,
+	0x01,
+};
+
+static char hikey_power_on_param4[] = {
+	0xB3,
+	0x14, 0x08, 0x00, 0x22, 0x00,
+};
+
+static char hikey_power_on_param5[] = {
+	0xB4,
+	0x0C,
+};
+
+static char hikey_power_on_param6[] = {
+	0xB6,
+	0x3A, 0xC3,
+};
+
+static char hikey_power_on_param7[] = {
+	0x2A,
+	0x00, 0x00, 0X04, 0XAF,
+};
+
+static char hikey_power_on_param8[] = {
+	0x2B,
+	0x00, 0x00, 0X07, 0X7F,
+};
+
+static char hikey_power_on_param9[] = {
+	0x51,
+	0xA6,
+};
+
+static char hikey_power_on_param10[] = {
+	0x53,
+	0x2C,
+};
+
+static char hikey_power_on_param11[] = {
+	0x3A,
+	0x66,
+};
+
+static char hikey_power_on_param12[] = {
+	0x29,
+};
+
+static char hikey_power_on_param13[] = {
+	0x11,
+};
+
+static char hikey_display_off[] = {
+	0x28,
+};
+
+static char hikey_enter_sleep[] = {
+	0x10,
+};
+
+static struct dsi_cmd_desc hikey_display_off_cmds[] = {
+	{DTYPE_DCS_WRITE, 0, 20, WAIT_TYPE_MS,
+	 sizeof(hikey_display_off), hikey_display_off}
+	,
+	{DTYPE_DCS_WRITE, 0, 80, WAIT_TYPE_MS,
+	 sizeof(hikey_enter_sleep), hikey_enter_sleep}
+	,
+};
+
+/*short or long packet*/
+static struct dsi_cmd_desc hikey_display_on_cmds[] = {
+	{DTYPE_DCS_WRITE, 0, 5, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param1), hikey_power_on_param1}
+	,
+	{DTYPE_DCS_WRITE1, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param2), hikey_power_on_param2}
+	,
+	{DTYPE_DCS_WRITE1, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param3), hikey_power_on_param3}
+	,
+	{DTYPE_DCS_LWRITE, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param4), hikey_power_on_param4}
+	,
+	{DTYPE_DCS_WRITE1, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param5), hikey_power_on_param5}
+	,
+	{DTYPE_DCS_LWRITE, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param6), hikey_power_on_param6}
+	,
+	{DTYPE_DCS_LWRITE, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param7), hikey_power_on_param7}
+	,
+	{DTYPE_DCS_LWRITE, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param8), hikey_power_on_param8}
+	,
+	{DTYPE_DCS_WRITE1, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param9), hikey_power_on_param9}
+	,
+	{DTYPE_DCS_WRITE1, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param10), hikey_power_on_param10}
+	,
+	{DTYPE_DCS_WRITE1, 0, 2, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param11), hikey_power_on_param11}
+	,
+	{DTYPE_DCS_WRITE, 0, 20, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param12), hikey_power_on_param12}
+	,
+	{DTYPE_DCS_WRITE, 0, 150, WAIT_TYPE_MS,
+	 sizeof(hikey_power_on_param13), hikey_power_on_param13}
+	,
+};
+
+/********************************hikey end*************************/
+
+/*******************************************************************************
+ ** LCD GPIO
+ */
+#define GPIO_LCD_PWR_ENABLE_NAME "gpio_lcd_pwr_enable"
+#define GPIO_LCD_BL_ENABLE_NAME "gpio_lcd_bl_enable"
+#define GPIO_LCD_PWM_NAME "gpio_lcd_pwm"
+#define GPIO_SWITCH_DSI_HDMI "gpio_switch_dsi_hdmi"
+
+static uint32_t gpio_lcd_pwr_enable;
+static uint32_t gpio_lcd_bl_enable;
+static uint32_t gpio_lcd_pwm;
+static uint32_t gpio_switch_dsi_hdmi;
+
+static struct gpio_desc hikey_lcd_gpio_request_cmds[] = {
+	{DTYPE_GPIO_REQUEST, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWR_ENABLE_NAME, &gpio_lcd_pwr_enable, 0},
+	{DTYPE_GPIO_REQUEST, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_BL_ENABLE_NAME, &gpio_lcd_bl_enable, 0},
+	{DTYPE_GPIO_REQUEST, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWM_NAME, &gpio_lcd_pwm, 0},
+	{DTYPE_GPIO_REQUEST, WAIT_TYPE_MS, 0,
+	 GPIO_SWITCH_DSI_HDMI, &gpio_switch_dsi_hdmi, 0},
+};
+
+static struct gpio_desc hikey_lcd_gpio_free_cmds[] = {
+	{DTYPE_GPIO_FREE, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWR_ENABLE_NAME, &gpio_lcd_pwr_enable, 0},
+	{DTYPE_GPIO_FREE, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_BL_ENABLE_NAME, &gpio_lcd_bl_enable, 0},
+	{DTYPE_GPIO_FREE, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWM_NAME, &gpio_lcd_pwm, 0},
+	{DTYPE_GPIO_FREE, WAIT_TYPE_MS, 0,
+	 GPIO_SWITCH_DSI_HDMI, &gpio_switch_dsi_hdmi, 0},
+};
+
+static struct gpio_desc hikey_lcd_gpio_normal_cmds[] = {
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWR_ENABLE_NAME, &gpio_lcd_pwr_enable, 1},
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_SWITCH_DSI_HDMI, &gpio_switch_dsi_hdmi, 1},
+};
+
+static struct gpio_desc hikey_lcd_gpio_off_cmds[] = {
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWR_ENABLE_NAME, &gpio_lcd_pwr_enable, 0},
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_SWITCH_DSI_HDMI, &gpio_switch_dsi_hdmi, 0},
+};
+
+static struct gpio_desc hikey_lcd_backlight_enable_cmds[] = {
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_BL_ENABLE_NAME, &gpio_lcd_bl_enable, 1},
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWM_NAME, &gpio_lcd_pwm, 1},
+};
+
+static struct gpio_desc hikey_lcd_backlight_disable_cmds[] = {
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_BL_ENABLE_NAME, &gpio_lcd_bl_enable, 0},
+	{DTYPE_GPIO_OUTPUT, WAIT_TYPE_MS, 0,
+	 GPIO_LCD_PWM_NAME, &gpio_lcd_pwm, 0},
+};
+
+static struct hisi_fb_panel_data g_panel_data;
+
+static void hikey_set_backlight_on(void)
+{
+	msleep(200);
+	gpio_cmds_tx(hikey_lcd_backlight_enable_cmds,
+		     ARRAY_SIZE(hikey_lcd_backlight_enable_cmds));
+	return;
+}
+
+static void hikey_set_backlight_off(void)
+{
+	gpio_cmds_tx(hikey_lcd_backlight_disable_cmds,
+		     ARRAY_SIZE(hikey_lcd_backlight_disable_cmds));
+	return;
+}
+
+static int hikey_panel_on(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisi_panel_info *pinfo = NULL;
+	char __iomem *mipi_dsi0_base = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+	pinfo = &(hisifd->panel_info);
+	BUG_ON(pinfo = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	mipi_dsi0_base = hisifd->mipi_dsi0_base;
+
+	if (pinfo->lcd_init_step = LCD_INIT_POWER_ON) {
+		pinfo->lcd_init_step = LCD_INIT_MIPI_LP_SEND_SEQUENCE;
+	} else if (pinfo->lcd_init_step = LCD_INIT_MIPI_LP_SEND_SEQUENCE) {
+		/*lcd gpio request */
+		gpio_cmds_tx(hikey_lcd_gpio_request_cmds,
+			     ARRAY_SIZE(hikey_lcd_gpio_request_cmds));
+		/*lcd gpio normal */
+		gpio_cmds_tx(hikey_lcd_gpio_normal_cmds,
+			     ARRAY_SIZE(hikey_lcd_gpio_normal_cmds));
+		/*lcd display on sequence */
+		msleep(250);
+		mipi_dsi_cmds_tx(hikey_display_on_cmds,
+				 ARRAY_SIZE(hikey_display_on_cmds),
+				 mipi_dsi0_base);
+
+		pinfo->lcd_init_step = LCD_INIT_MIPI_HS_SEND_SEQUENCE;
+	} else if (pinfo->lcd_init_step = LCD_INIT_MIPI_HS_SEND_SEQUENCE) {
+		;
+	} else {
+		HISI_FB_ERR("failed to init lcd!\n");
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+
+	return 0;
+}
+
+static int hikey_panel_off(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisi_panel_info *pinfo = NULL;
+	char __iomem *mipi_dsi0_base = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+	pinfo = &(hisifd->panel_info);
+	BUG_ON(pinfo = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+	mipi_dsi0_base = hisifd->mipi_dsi0_base;
+	/*lcd enter sleep */
+	mipi_dsi_cmds_tx(hikey_display_off_cmds,
+			 ARRAY_SIZE(hikey_display_off_cmds), mipi_dsi0_base);
+	gpio_cmds_tx(hikey_lcd_gpio_off_cmds,
+		     ARRAY_SIZE(hikey_lcd_gpio_off_cmds));
+	gpio_cmds_tx(hikey_lcd_gpio_free_cmds,
+		     ARRAY_SIZE(hikey_lcd_gpio_free_cmds));
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+
+	return 0;
+}
+
+static int hikey_panel_remove(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+
+	return 0;
+}
+
+static int hikey_panel_set_backlight(struct platform_device *pdev,
+				     uint32_t bl_level)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	int ret = 0;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	if (bl_level = 0) {
+		hikey_set_backlight_off();
+	} else {
+		hikey_set_backlight_on();
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+
+	return ret;
+}
+
+static struct hisi_panel_info g_panel_info = { 0 };
+
+static struct hisi_fb_panel_data g_panel_data = {
+	.panel_info = &g_panel_info,
+	.on = hikey_panel_on,
+	.off = hikey_panel_off,
+	.remove = hikey_panel_remove,
+	.set_backlight = hikey_panel_set_backlight,
+};
+
+static int hikey_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct hisi_panel_info *pinfo = NULL;
+	struct device_node *np = NULL;
+	uint32_t bl_type = 0;
+
+	uint32_t lcd_display_type = 0;
+	uint32_t lcd_ifbc_type = 0;
+
+	HISI_FB_DEBUG("+.\n");
+
+	np = of_find_compatible_node(NULL, NULL, DTS_COMP_MIPI_HIKEY);
+	if (!np) {
+		HISI_FB_ERR("NOT FOUND device node %s!\n", DTS_COMP_MIPI_HIKEY);
+		goto err_return;
+	}
+
+	ret = of_property_read_u32(np, LCD_BL_TYPE_NAME, &bl_type);
+	if (ret) {
+		HISI_FB_ERR("get lcd_bl_type failed!\n");
+		bl_type = BL_SET_BY_BLPWM;
+	}
+
+	ret +	    of_property_read_u32(np, LCD_DISPLAY_TYPE_NAME, &lcd_display_type);
+	if (ret) {
+		HISI_FB_ERR("get lcd_display_type failed!\n");
+		lcd_display_type = PANEL_MIPI_VIDEO;
+	}
+
+	ret = of_property_read_u32(np, LCD_IFBC_TYPE_NAME, &lcd_ifbc_type);
+	if (ret) {
+		HISI_FB_ERR("get ifbc_type failed!\n");
+		lcd_ifbc_type = IFBC_TYPE_NONE;
+	}
+
+	/*GPIO_26_8 GPIO_216 */
+	gpio_lcd_pwr_enable = of_get_named_gpio(np, "gpios", 0);
+	/*GPIO_27_2 GPIO_218 */
+	gpio_lcd_bl_enable = of_get_named_gpio(np, "gpios", 1);
+	/*GPIO_22_6 GPIO_182 */
+	gpio_lcd_pwm = of_get_named_gpio(np, "gpios", 2);
+	/*GPIO_2_4 GPIO_020 */
+	gpio_switch_dsi_hdmi = of_get_named_gpio(np, "gpios", 3);
+
+	if (hisi_fb_device_probe_defer(lcd_display_type, bl_type)) {
+		goto err_probe_defer;
+	}
+
+	pdev->id = 1;
+	/*init lcd panel info */
+	pinfo = g_panel_data.panel_info;
+	memset(pinfo, 0, sizeof(struct hisi_panel_info));
+	pinfo->xres = 1200;
+	pinfo->yres = 1920;
+	pinfo->width = 94;
+	pinfo->height = 151;
+	pinfo->orientation = LCD_PORTRAIT;
+	pinfo->bpp = LCD_RGB888;
+	pinfo->bgr_fmt = LCD_RGB;
+	pinfo->bl_set_type = bl_type;
+
+	pinfo->type = PANEL_MIPI_VIDEO;
+	pinfo->ifbc_type = 0;
+
+	if (pinfo->bl_set_type = BL_SET_BY_BLPWM)
+		pinfo->blpwm_input_ena = 0;
+
+	pinfo->bl_min = 1;
+	pinfo->bl_max = 255;
+	pinfo->bl_default = 102;
+	pinfo->esd_enable = 0;
+
+	/*ldi */
+	pinfo->ldi.h_back_porch = 60;
+	pinfo->ldi.h_front_porch = 200;
+	pinfo->ldi.h_pulse_width = 12;
+	pinfo->ldi.v_back_porch = 8;
+	pinfo->ldi.v_front_porch = 8;
+	pinfo->ldi.v_pulse_width = 2;
+
+	/*
+	   pinfo->ldi.hsync_plr = 0;
+	   pinfo->ldi.vsync_plr = 0;
+	   pinfo->ldi.pixelclk_plr = 1;
+	   pinfo->ldi.data_en_plr = 0;
+	 */
+
+	/*mipi */
+	pinfo->mipi.lane_nums = DSI_4_LANES;
+	pinfo->mipi.color_mode = DSI_24BITS_1;
+	pinfo->mipi.vc = 0;
+	pinfo->mipi.max_tx_esc_clk = 10 * 1000000;
+	pinfo->mipi.burst_mode = DSI_BURST_SYNC_PULSES_1;
+
+	pinfo->mipi.dsi_bit_clk = 480;
+	pinfo->mipi.dsi_bit_clk_upt = pinfo->mipi.dsi_bit_clk;
+
+	pinfo->pxl_clk_rate = 146 * 1000000UL;
+	pinfo->pxl_clk_rate_div = 1;
+	pinfo->fps = 50;
+
+	pinfo->vsync_ctrl_type = 0;
+	pinfo->dirty_region_updt_support = 0;
+	pinfo->dsi_bit_clk_upt_support = 0;
+
+	/*alloc panel device data */
+	ret = platform_device_add_data(pdev, &g_panel_data,
+				       sizeof(struct hisi_fb_panel_data));
+	if (ret) {
+		HISI_FB_ERR("platform_device_add_data failed!\n");
+		goto err_device_put;
+	}
+
+	hisi_fb_add_device(pdev);
+
+	/*
+	   vdd = devm_regulator_get(&(pdev->dev), "vdd");
+	   if (IS_ERR(vdd)) {
+	   ret = PTR_ERR(vdd);
+	   HISI_FB_ERR("vdd regulator get fail\n");
+	   return ret;
+	   }
+
+	   ret = regulator_set_voltage(vdd, 1800000, 1800000);
+	   if (ret) {
+	   HISI_FB_ERR("vdd regulator set voltage fail\n");
+	   return ret;
+	   }
+
+	   ret = regulator_enable(vdd);
+	   if (ret) {
+	   HISI_FB_ERR("vdd regulator enable fail\n");
+	   return ret;
+	   }
+	 */
+
+	HISI_FB_DEBUG("-.\n");
+	return 0;
+
+ err_device_put:
+	platform_device_put(pdev);
+ err_return:
+	return ret;
+ err_probe_defer:
+	return -EPROBE_DEFER;
+}
+
+static const struct of_device_id hisi_panel_match_table[] = {
+	{
+	 .compatible = DTS_COMP_MIPI_HIKEY,
+	 .data = NULL,
+	 },
+	{},
+};
+
+static struct platform_driver this_driver = {
+	.probe = hikey_probe,
+	.remove = NULL,
+	.suspend = NULL,
+	.resume = NULL,
+	.shutdown = NULL,
+	.driver = {
+		   .name = "mipi_hikey",
+		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(hisi_panel_match_table),
+		   },
+};
+
+static int __init hikey_panel_init(void)
+{
+	int ret = 0;
+
+	ret = platform_driver_register(&this_driver);
+	if (ret) {
+		HISI_FB_ERR("platform_driver_register failed, error=%d!\n",
+			    ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+module_init(hikey_panel_init);
-- 
2.12.0-rc0

