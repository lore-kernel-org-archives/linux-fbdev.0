From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:16 +0000
Subject: [PATCH 08/15] fbdev: sh_mobile_hdmi: add initial support for modes,
Message-Id: <Pine.LNX.4.64.1009030914050.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

To support standard video modes, other than 720p, the HDMI PHY configuration
has to be adjusted and the VIC has to be sent to the display.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   82 ++++++++++++++++++++++++++++++----------
 1 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 5583cd6..fd91204 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -381,21 +381,61 @@ static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
 }
 
 /**
- * sh_hdmi_phy_config()
+ * sh_hdmi_phy_config() - configure the HDMI PHY for the used video mode
  */
 static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
 {
-	/* 720p, 8bit, 74.25MHz. Might need to be adjusted for other formats */
-	hdmi_write(hdmi, 0x19, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
-	hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_2);
-	hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_3);
-	/* PLLA_CONFIG[7:0]: VCO gain, VCO offset, LPF resistance[0] */
-	hdmi_write(hdmi, 0x44, HDMI_SLIPHDMIT_PARAM_SETTINGS_5);
-	hdmi_write(hdmi, 0x32, HDMI_SLIPHDMIT_PARAM_SETTINGS_6);
-	hdmi_write(hdmi, 0x4A, HDMI_SLIPHDMIT_PARAM_SETTINGS_7);
-	hdmi_write(hdmi, 0x0E, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
-	hdmi_write(hdmi, 0x25, HDMI_SLIPHDMIT_PARAM_SETTINGS_9);
-	hdmi_write(hdmi, 0x04, HDMI_SLIPHDMIT_PARAM_SETTINGS_10);
+	if (hdmi->var.yres > 480) {
+		/* 720p, 8bit, 74.25MHz. Might need to be adjusted for other formats */
+		/*
+		 * [1:0]	Speed_A
+		 * [3:2]	Speed_B
+		 * [4]		PLLA_Bypass
+		 * [6]		DRV_TEST_EN
+		 * [7]		DRV_TEST_IN
+		 */
+		hdmi_write(hdmi, 0x19, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
+		/* PLLB_CONFIG[17], PLLA_CONFIG[17] - not in PHY datasheet */
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_2);
+		/*
+		 * [2:0]	BGR_I_OFFSET
+		 * [6:4]	BGR_V_OFFSET
+		 */
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_3);
+		/* PLLA_CONFIG[7:0]: VCO gain, VCO offset, LPF resistance[0] */
+		hdmi_write(hdmi, 0x44, HDMI_SLIPHDMIT_PARAM_SETTINGS_5);
+		/*
+		 * PLLA_CONFIG[15:8]: regulator voltage[0], CP current,
+		 * LPF capacitance, LPF resistance[1]
+		 */
+		hdmi_write(hdmi, 0x32, HDMI_SLIPHDMIT_PARAM_SETTINGS_6);
+		/* PLLB_CONFIG[7:0]: LPF resistance[0], VCO offset, VCO gain */
+		hdmi_write(hdmi, 0x4A, HDMI_SLIPHDMIT_PARAM_SETTINGS_7);
+		/*
+		 * PLLB_CONFIG[15:8]: regulator voltage[0], CP current,
+		 * LPF capacitance, LPF resistance[1]
+		 */
+		hdmi_write(hdmi, 0x0E, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
+		/* DRV_CONFIG, PE_CONFIG */
+		hdmi_write(hdmi, 0x25, HDMI_SLIPHDMIT_PARAM_SETTINGS_9);
+		/*
+		 * [2:0]	AMON_SEL (4 = LPF voltage)
+		 * [4]		PLLA_CONFIG[16]
+		 * [5]		PLLB_CONFIG[16]
+		 */
+		hdmi_write(hdmi, 0x04, HDMI_SLIPHDMIT_PARAM_SETTINGS_10);
+	} else {
+		/* for 480p8bit 27MHz */
+		hdmi_write(hdmi, 0x19, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_2);
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_3);
+		hdmi_write(hdmi, 0x44, HDMI_SLIPHDMIT_PARAM_SETTINGS_5);
+		hdmi_write(hdmi, 0x32, HDMI_SLIPHDMIT_PARAM_SETTINGS_6);
+		hdmi_write(hdmi, 0x48, HDMI_SLIPHDMIT_PARAM_SETTINGS_7);
+		hdmi_write(hdmi, 0x0F, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
+		hdmi_write(hdmi, 0x20, HDMI_SLIPHDMIT_PARAM_SETTINGS_9);
+		hdmi_write(hdmi, 0x04, HDMI_SLIPHDMIT_PARAM_SETTINGS_10);
+	}
 }
 
 /**
@@ -403,6 +443,8 @@ static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
  */
 static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
 {
+	u8 vic;
+
 	/* AVI InfoFrame */
 	hdmi_write(hdmi, 0x06, HDMI_CTRL_PKT_BUF_INDEX);
 
@@ -443,9 +485,15 @@ static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
 
 	/*
 	 * VIC = 1280 x 720p: ignored if external config is used
-	 * Send 2 for 720 x 480p, 16 for 1080p
+	 * Send 2 for 720 x 480p, 16 for 1080p, ignored in external mode
 	 */
-	hdmi_write(hdmi, 4, HDMI_CTRL_PKT_BUF_ACCESS_PB4);
+	if (hdmi->var.yres = 1080 && hdmi->var.xres = 1920)
+		vic = 16;
+	else if (hdmi->var.yres = 480 && hdmi->var.xres = 720)
+		vic = 2;
+	else
+		vic = 4;
+	hdmi_write(hdmi, vic, HDMI_CTRL_PKT_BUF_ACCESS_PB4);
 
 	/* PR = No Repetition */
 	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB5);
@@ -772,12 +820,6 @@ static void hdmi_display_on(void *arg, struct fb_info *info)
 	struct sh_hdmi *hdmi = arg;
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 
-	if (info->var.xres != 1280 || info->var.yres != 720) {
-		dev_warn(info->device, "Unsupported framebuffer geometry %ux%u\n",
-			 info->var.xres, info->var.yres);
-		return;
-	}
-
 	pr_debug("%s(%p): state %x\n", __func__, pdata->lcd_dev, info->state);
 	/*
 	 * FIXME: not a good place to store fb_info. And we cannot nullify it
-- 
1.7.1

