From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:51 +0000
Subject: [PATCH 1/9] staging: sm750fb: fix length of lines
Message-Id: <1494453359-3722-2-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch breaks lines that are longer than 80 characters and joins
together those, that are too short and can be placed at one.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_chip.c   |  7 +++--
 drivers/staging/sm750fb/ddk750_dvi.c    | 35 +++++++++++++----------
 drivers/staging/sm750fb/ddk750_dvi.h    | 43 ++++++++++++++---------------
 drivers/staging/sm750fb/ddk750_hwi2c.c  | 33 ++++++++--------------
 drivers/staging/sm750fb/ddk750_sii164.c | 49 ++++++++++++++-------------------
 drivers/staging/sm750fb/ddk750_sii164.h | 22 +++++++--------
 drivers/staging/sm750fb/ddk750_swi2c.c  | 21 ++++----------
 drivers/staging/sm750fb/ddk750_swi2c.h  | 18 ++++--------
 drivers/staging/sm750fb/sm750.c         | 26 ++++++++---------
 drivers/staging/sm750fb/sm750_accel.c   | 15 +++++-----
 drivers/staging/sm750fb/sm750_cursor.c  | 17 +++++-------
 11 files changed, 125 insertions(+), 161 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 5e4bfb6..944dd25 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -175,7 +175,7 @@ static void set_master_clock(unsigned int frequency)
 		}
 
 		sm750_set_current_gate(reg);
-		}
+	}
 }
 
 unsigned int ddk750_get_vm_size(void)
@@ -224,7 +224,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	sm750_set_current_gate(reg);
 
 	if (sm750_get_chip_type() != SM750LE) {
-		/*	set panel pll and graphic mode via mmio_88 */
+		/* set panel pll and graphic mode via mmio_88 */
 		reg = peek32(VGA_CONFIGURATION);
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
 		poke32(VGA_CONFIGURATION, reg);
@@ -309,7 +309,8 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
  * M = {1,...,255}
  * N = {2,...,15}
  */
-unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *pll)
+unsigned int sm750_calc_pll_value(unsigned int request_orig,
+				  struct pll_value *pll)
 {
 	/*
 	 * as sm750 register definition,
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 171ae06..87a199d 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -29,26 +29,31 @@
 #endif
 };
 
-int dviInit(
-	unsigned char edgeSelect,
-	unsigned char busSelect,
-	unsigned char dualEdgeClkSelect,
-	unsigned char hsyncEnable,
-	unsigned char vsyncEnable,
-	unsigned char deskewEnable,
-	unsigned char deskewSetting,
-	unsigned char continuousSyncEnable,
-	unsigned char pllFilterEnable,
-	unsigned char pllFilterValue
-			)
+int dviInit(unsigned char edgeSelect,
+	    unsigned char busSelect,
+	    unsigned char dualEdgeClkSelect,
+	    unsigned char hsyncEnable,
+	    unsigned char vsyncEnable,
+	    unsigned char deskewEnable,
+	    unsigned char deskewSetting,
+	    unsigned char continuousSyncEnable,
+	    unsigned char pllFilterEnable,
+	    unsigned char pllFilterValue)
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 
 	pCurrentDviCtrl = g_dcftSupportedDviController;
 	if (pCurrentDviCtrl->pfnInit) {
-		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
-						vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
-						pllFilterEnable, pllFilterValue);
+		return pCurrentDviCtrl->pfnInit(edgeSelect,
+						busSelect,
+						dualEdgeClkSelect,
+						hsyncEnable,
+						vsyncEnable,
+						deskewEnable,
+						deskewSetting,
+						continuousSyncEnable,
+						pllFilterEnable,
+						pllFilterValue);
 	}
 	return -1; /* error */
 }
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 677939c..4a83945 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -3,17 +3,16 @@
 
 /* dvi chip stuffs structros */
 
-typedef long (*PFN_DVICTRL_INIT)(
-	unsigned char edgeSelect,
-	unsigned char busSelect,
-	unsigned char dualEdgeClkSelect,
-	unsigned char hsyncEnable,
-	unsigned char vsyncEnable,
-	unsigned char deskewEnable,
-	unsigned char deskewSetting,
-	unsigned char continuousSyncEnable,
-	unsigned char pllFilterEnable,
-	unsigned char pllFilterValue);
+typedef long (*PFN_DVICTRL_INIT)(unsigned char edgeSelect,
+				 unsigned char busSelect,
+				 unsigned char dualEdgeClkSelect,
+				 unsigned char hsyncEnable,
+				 unsigned char vsyncEnable,
+				 unsigned char deskewEnable,
+				 unsigned char deskewSetting,
+				 unsigned char continuousSyncEnable,
+				 unsigned char pllFilterEnable,
+				 unsigned char pllFilterValue);
 
 typedef void (*PFN_DVICTRL_RESETCHIP)(void);
 typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
@@ -42,18 +41,16 @@ typedef long (*PFN_DVICTRL_INIT)(
 #define DVI_CTRL_SII164
 
 /* dvi functions prototype */
-int dviInit(
-	unsigned char edgeSelect,
-	unsigned char busSelect,
-	unsigned char dualEdgeClkSelect,
-	unsigned char hsyncEnable,
-	unsigned char vsyncEnable,
-	unsigned char deskewEnable,
-	unsigned char deskewSetting,
-	unsigned char continuousSyncEnable,
-	unsigned char pllFilterEnable,
-	unsigned char pllFilterValue
-);
+int dviInit(unsigned char edgeSelect,
+	    unsigned char busSelect,
+	    unsigned char dualEdgeClkSelect,
+	    unsigned char hsyncEnable,
+	    unsigned char vsyncEnable,
+	    unsigned char deskewEnable,
+	    unsigned char deskewSetting,
+	    unsigned char continuousSyncEnable,
+	    unsigned char pllFilterEnable,
+	    unsigned char pllFilterValue);
 
 #endif
 
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index fe814e4..ec556a9 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -8,9 +8,7 @@
 #define MAX_HWI2C_FIFO                  16
 #define HWI2C_WAIT_TIMEOUT              0xF0000
 
-int sm750_hw_i2c_init(
-unsigned char bus_speed_mode
-)
+int sm750_hw_i2c_init(unsigned char bus_speed_mode)
 {
 	unsigned int value;
 
@@ -81,11 +79,9 @@ static long hw_i2c_wait_tx_done(void)
  *  Return Value:
  *      Total number of bytes those are actually written.
  */
-static unsigned int hw_i2c_write_data(
-	unsigned char addr,
-	unsigned int length,
-	unsigned char *buf
-)
+static unsigned int hw_i2c_write_data(unsigned char addr,
+				      unsigned int length,
+				      unsigned char *buf)
 {
 	unsigned char count, i;
 	unsigned int total_bytes = 0;
@@ -148,11 +144,9 @@ static unsigned int hw_i2c_write_data(
  *  Return Value:
  *      Total number of actual bytes read from the slave device
  */
-static unsigned int hw_i2c_read_data(
-	unsigned char addr,
-	unsigned int length,
-	unsigned char *buf
-)
+static unsigned int hw_i2c_read_data(unsigned char addr,
+				     unsigned int length,
+				     unsigned char *buf)
 {
 	unsigned char count, i;
 	unsigned int total_bytes = 0;
@@ -212,10 +206,7 @@ static unsigned int hw_i2c_read_data(
  *  Return Value:
  *      Register value
  */
-unsigned char sm750_hw_i2c_read_reg(
-	unsigned char addr,
-	unsigned char reg
-)
+unsigned char sm750_hw_i2c_read_reg(unsigned char addr, unsigned char reg)
 {
 	unsigned char value = 0xFF;
 
@@ -238,11 +229,9 @@ unsigned char sm750_hw_i2c_read_reg(
  *          0   - Success
  *         -1   - Fail
  */
-int sm750_hw_i2c_write_reg(
-	unsigned char addr,
-	unsigned char reg,
-	unsigned char data
-)
+int sm750_hw_i2c_write_reg(unsigned char addr,
+			   unsigned char reg,
+			   unsigned char data)
 {
 	unsigned char value[2];
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 259006a..0431833 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -112,18 +112,16 @@ unsigned short sii164GetDeviceID(void)
  *      0   - Success
  *     -1   - Fail.
  */
-long sii164InitChip(
-	unsigned char edgeSelect,
-	unsigned char busSelect,
-	unsigned char dualEdgeClkSelect,
-	unsigned char hsyncEnable,
-	unsigned char vsyncEnable,
-	unsigned char deskewEnable,
-	unsigned char deskewSetting,
-	unsigned char continuousSyncEnable,
-	unsigned char pllFilterEnable,
-	unsigned char pllFilterValue
-)
+long sii164InitChip(unsigned char edgeSelect,
+		    unsigned char busSelect,
+		    unsigned char dualEdgeClkSelect,
+		    unsigned char hsyncEnable,
+		    unsigned char vsyncEnable,
+		    unsigned char deskewEnable,
+		    unsigned char deskewSetting,
+		    unsigned char continuousSyncEnable,
+		    unsigned char pllFilterEnable,
+		    unsigned char pllFilterValue)
 {
 	unsigned char config;
 
@@ -259,7 +257,6 @@ void sii164ResetChip(void)
 	sii164SetPower(1);
 }
 
-
 /*
  * sii164GetChipString
  *      This function returns a char string name of the current DVI Controller chip.
@@ -270,7 +267,6 @@ char *sii164GetChipString(void)
 	return gDviCtrlChipName;
 }
 
-
 /*
  *  sii164SetPower
  *      This function sets the power configuration of the DVI Controller Chip.
@@ -278,9 +274,7 @@ char *sii164GetChipString(void)
  *  Input:
  *      powerUp - Flag to set the power down or up
  */
-void sii164SetPower(
-	unsigned char powerUp
-)
+void sii164SetPower(unsigned char powerUp)
 {
 	unsigned char config;
 
@@ -298,18 +292,16 @@ void sii164SetPower(
 	}
 }
 
-
 /*
  *  sii164SelectHotPlugDetectionMode
  *      This function selects the mode of the hot plug detection.
  */
-static void sii164SelectHotPlugDetectionMode(
-	sii164_hot_plug_mode_t hotPlugMode
-)
+static void sii164SelectHotPlugDetectionMode(sii164_hot_plug_mode_t hotPlugMode)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
+	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
 	switch (hotPlugMode) {
 	case SII164_HOTPLUG_DISABLE:
 		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
@@ -336,9 +328,7 @@ static void sii164SelectHotPlugDetectionMode(
  *
  *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(
-	unsigned char enableHotPlug
-)
+void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
 {
 	unsigned char detectReg;
 
@@ -365,7 +355,8 @@ unsigned char sii164IsConnected(void)
 {
 	unsigned char hotPlugValue;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & SII164_DETECT_HOT_PLUG_STATUS_MASK;
+	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
 	if (hotPlugValue = SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
@@ -384,7 +375,8 @@ unsigned char sii164CheckInterrupt(void)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & SII164_DETECT_MONITOR_STATE_MASK;
+	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		    SII164_DETECT_MONITOR_STATE_MASK;
 	if (detectReg = SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
@@ -401,7 +393,8 @@ void sii164ClearInterrupt(void)
 
 	/* Clear the MDI interrupt */
 	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
+		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 664ad08..6968cf5 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -13,18 +13,16 @@
 
 
 /* Silicon Image SiI164 chip prototype */
-long sii164InitChip(
-	unsigned char edgeSelect,
-	unsigned char busSelect,
-	unsigned char dualEdgeClkSelect,
-	unsigned char hsyncEnable,
-	unsigned char vsyncEnable,
-	unsigned char deskewEnable,
-	unsigned char deskewSetting,
-	unsigned char continuousSyncEnable,
-	unsigned char pllFilterEnable,
-	unsigned char pllFilterValue
-);
+long sii164InitChip(unsigned char edgeSelect,
+		    unsigned char busSelect,
+		    unsigned char dualEdgeClkSelect,
+		    unsigned char hsyncEnable,
+		    unsigned char vsyncEnable,
+		    unsigned char deskewEnable,
+		    unsigned char deskewSetting,
+		    unsigned char continuousSyncEnable,
+		    unsigned char pllFilterEnable,
+		    unsigned char pllFilterValue);
 
 unsigned short sii164GetVendorID(void);
 unsigned short sii164GetDeviceID(void);
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index a4ac07c..19c5ffc 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -349,8 +349,7 @@ static unsigned char sw_i2c_read_byte(unsigned char ack)
  *      -1   - Fail to initialize the i2c
  *       0   - Success
  */
-static long sm750le_i2c_init(unsigned char clk_gpio,
-			     unsigned char data_gpio)
+static long sm750le_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 {
 	int i;
 
@@ -388,10 +387,7 @@ static long sm750le_i2c_init(unsigned char clk_gpio,
  *      -1   - Fail to initialize the i2c
  *       0   - Success
  */
-long sm750_sw_i2c_init(
-	unsigned char clk_gpio,
-	unsigned char data_gpio
-)
+long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 {
 	int i;
 
@@ -448,10 +444,7 @@ long sm750_sw_i2c_init(
  *  Return Value:
  *      Register value
  */
-unsigned char sm750_sw_i2c_read_reg(
-	unsigned char addr,
-	unsigned char reg
-)
+unsigned char sm750_sw_i2c_read_reg(unsigned char addr, unsigned char reg)
 {
 	unsigned char data;
 
@@ -488,11 +481,9 @@ unsigned char sm750_sw_i2c_read_reg(
  *          0   - Success
  *         -1   - Fail
  */
-long sm750_sw_i2c_write_reg(
-	unsigned char addr,
-	unsigned char reg,
-	unsigned char data
-)
+long sm750_sw_i2c_write_reg(unsigned char addr,
+			    unsigned char reg,
+			    unsigned char data)
 {
 	long ret = 0;
 
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.h b/drivers/staging/sm750fb/ddk750_swi2c.h
index 5a9466e..3b8a96d 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.h
+++ b/drivers/staging/sm750fb/ddk750_swi2c.h
@@ -28,10 +28,7 @@
  *      -1   - Fail to initialize the i2c
  *       0   - Success
  */
-long sm750_sw_i2c_init(
-	unsigned char clk_gpio,
-	unsigned char data_gpio
-);
+long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio);
 
 /*
  *  This function reads the slave device's register
@@ -44,10 +41,7 @@ long sm750_sw_i2c_init(
  *  Return Value:
  *      Register value
  */
-unsigned char sm750_sw_i2c_read_reg(
-	unsigned char addr,
-	unsigned char reg
-);
+unsigned char sm750_sw_i2c_read_reg(unsigned char addr, unsigned char reg);
 
 /*
  *  This function writes a value to the slave device's register
@@ -62,10 +56,8 @@ unsigned char sm750_sw_i2c_read_reg(
  *          0   - Success
  *         -1   - Fail
  */
-long sm750_sw_i2c_write_reg(
-	unsigned char addr,
-	unsigned char reg,
-	unsigned char data
-);
+long sm750_sw_i2c_write_reg(unsigned char addr,
+			    unsigned char reg,
+			    unsigned char data);
 
 #endif  /* _SWI2C_H_ */
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 386d4ad..a7f722a 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -112,42 +112,42 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	cursor = &crtc->cursor;
 
 	if (fbcursor->image.width > cursor->maxW ||
-	   fbcursor->image.height > cursor->maxH ||
-	   fbcursor->image.depth > 1) {
+	    fbcursor->image.height > cursor->maxH ||
+	    fbcursor->image.depth > 1) {
 		return -ENXIO;
 	}
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_setSize(cursor,
-				  fbcursor->image.width,
-				  fbcursor->image.height);
+					fbcursor->image.width,
+					fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_setPos(cursor,
-				 fbcursor->image.dx - info->var.xoffset,
-				 fbcursor->image.dy - info->var.yoffset);
+				       fbcursor->image.dx - info->var.xoffset,
+				       fbcursor->image.dy - info->var.yoffset);
 
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
 		u16 fg, bg;
 
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
-		      ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
-		      ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
+		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
+		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
 
 		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800)) |
-		      ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
-		      ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
+		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
+		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
 		sm750_hw_cursor_setColor(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
 		sm750_hw_cursor_setData(cursor,
-				  fbcursor->rop,
-				  fbcursor->image.data,
-				  fbcursor->mask);
+					fbcursor->rop,
+					fbcursor->image.data,
+					fbcursor->mask);
 	}
 
 	if (fbcursor->enable)
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 6be86e4..4b720cf 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -42,10 +42,11 @@ void sm750_hw_de_init(struct lynx_accel *accel)
 	/* dpr1c */
 	reg =  0x3;
 
-	clr = DE_STRETCH_FORMAT_PATTERN_XY | DE_STRETCH_FORMAT_PATTERN_Y_MASK |
-		DE_STRETCH_FORMAT_PATTERN_X_MASK |
-		DE_STRETCH_FORMAT_ADDRESSING_MASK |
-		DE_STRETCH_FORMAT_SOURCE_HEIGHT_MASK;
+	clr = DE_STRETCH_FORMAT_PATTERN_XY |
+	      DE_STRETCH_FORMAT_PATTERN_Y_MASK |
+	      DE_STRETCH_FORMAT_PATTERN_X_MASK |
+	      DE_STRETCH_FORMAT_ADDRESSING_MASK |
+	      DE_STRETCH_FORMAT_SOURCE_HEIGHT_MASK;
 
 	/* DE_STRETCH bpp format need be initialized in setMode routine */
 	write_dpr(accel, DE_STRETCH_FORMAT,
@@ -84,9 +85,9 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 }
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-				u32 base, u32 pitch, u32 Bpp,
-				u32 x, u32 y, u32 width, u32 height,
-				u32 color, u32 rop)
+		      u32 base, u32 pitch, u32 Bpp,
+		      u32 x, u32 y, u32 width, u32 height,
+		      u32 color, u32 rop)
 {
 	u32 deCtrl;
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index b64dc8a..aa47a16 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -60,15 +60,13 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 	poke32(HWC_ADDRESS, 0);
 }
 
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
-						int w, int h)
+void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
 }
 
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
-						int x, int y)
+void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
 {
 	u32 reg;
 
@@ -77,8 +75,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 	poke32(HWC_LOCATION, reg);
 }
 
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
-						u32 fg, u32 bg)
+void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
 {
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
 		HWC_COLOR_12_2_RGB565_MASK;
@@ -87,8 +84,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 	poke32(HWC_COLOR_3, 0xffe0);
 }
 
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
+			     const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask, opr;
@@ -138,8 +135,8 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
 }
 
 
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask;
-- 
1.8.3.1

