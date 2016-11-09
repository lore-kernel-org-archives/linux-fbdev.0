From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 09 Nov 2016 09:26:27 +0000
Subject: [PATCH] staging: sm750fb: prefix global identifiers
Message-Id: <20161109092749.1454700-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Mike Rapoport <mike.rapoport@gmail.com>, Elise Lennion <elise.lennion@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Renaming some symbols inside this driver caused a conflict with
an existing function, which in turn results in a link error:

drivers/staging/sm750fb/sm750fb.o: In function `enable_dma':
ddk750_hwi2c.c:(.text.enable_dma+0x0): multiple definition of `enable_dma'

This adds a sm750_ prefix to each global symbol in the sm750fb
driver that does not already have one. I manually looked for the
symbols and then converted the driver using

for i in calc_pll_value format_pll_reg set_power_mode set_current_gate    \
	enable_2d_engine enable_dma enable_gpio enable_i2c hw_set2dformat \
	hw_de_init hw_fillrect hw_copyarea hw_imageblit hw_cursor_enable  \
	hw_cursor_disable hw_cursor_setSize hw_cursor_setPos		  \
	hw_cursor_setColor hw_cursor_setData hw_cursor_setData2 ;
do
		sed -i "s:\<$i\>:sm750_$i:" drivers/staging/sm750fb/*.[ch]
done

Fixes: 03140dabf584 ("staging: sm750fb: Replace functions CamelCase naming with underscores.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/sm750fb/ddk750_chip.c  | 24 ++++++++++++------------
 drivers/staging/sm750fb/ddk750_chip.h  |  4 ++--
 drivers/staging/sm750fb/ddk750_hwi2c.c |  4 ++--
 drivers/staging/sm750fb/ddk750_mode.c  |  6 +++---
 drivers/staging/sm750fb/ddk750_power.c | 20 ++++++++++----------
 drivers/staging/sm750fb/ddk750_power.h | 12 ++++++------
 drivers/staging/sm750fb/ddk750_swi2c.c |  2 +-
 drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750_accel.c  | 10 +++++-----
 drivers/staging/sm750fb/sm750_accel.h  | 10 +++++-----
 drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.h | 14 +++++++-------
 drivers/staging/sm750fb/sm750_hw.c     |  4 ++--
 13 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 14b5112dfb03..94f59f446322 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -68,16 +68,16 @@ static void set_chip_clock(unsigned int frequency)
 		pll.clockType = MXCLK_PLL;
 
 		/*
-		 * Call calc_pll_value() to fill the other fields of the PLL
+		 * Call sm750_calc_pll_value() to fill the other fields of the PLL
 		 * structure. Sometimes, the chip cannot set up the exact
 		 * clock required by the User.
-		 * Return value of calc_pll_value gives the actual possible
+		 * Return value of sm750_calc_pll_value gives the actual possible
 		 * clock.
 		 */
-		ulActualMxClk = calc_pll_value(frequency, &pll);
+		ulActualMxClk = sm750_calc_pll_value(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
-		POKE32(MXCLK_PLL_CTRL, format_pll_reg(&pll));
+		POKE32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
 	}
 }
 
@@ -121,7 +121,7 @@ static void set_memory_clock(unsigned int frequency)
 			break;
 		}
 
-		set_current_gate(reg);
+		sm750_set_current_gate(reg);
 	}
 }
 
@@ -173,7 +173,7 @@ static void set_master_clock(unsigned int frequency)
 			break;
 		}
 
-		set_current_gate(reg);
+		sm750_set_current_gate(reg);
 		}
 }
 
@@ -215,12 +215,12 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 
 	if (pInitParam->powerMode != 0)
 		pInitParam->powerMode = 0;
-	set_power_mode(pInitParam->powerMode);
+	sm750_set_power_mode(pInitParam->powerMode);
 
 	/* Enable display power gate & LOCALMEM power gate*/
 	reg = PEEK32(CURRENT_GATE);
 	reg |= (CURRENT_GATE_DISPLAY | CURRENT_GATE_LOCALMEM);
-	set_current_gate(reg);
+	sm750_set_current_gate(reg);
 
 	if (sm750_get_chip_type() != SM750LE) {
 		/*	set panel pll and graphic mode via mmio_88 */
@@ -261,7 +261,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	}
 
 	if (pInitParam->setAllEngOff = 1) {
-		enable_2d_engine(0);
+		sm750_enable_2d_engine(0);
 
 		/* Disable Overlay, if a former application left it on */
 		reg = PEEK32(VIDEO_DISPLAY_CTRL);
@@ -284,7 +284,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 		POKE32(DMA_ABORT_INTERRUPT, reg);
 
 		/* Disable DMA Power, if a former application left it on */
-		enable_dma(0);
+		sm750_enable_dma(0);
 	}
 
 	/* We can add more initialization as needed. */
@@ -309,7 +309,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
  * M = {1,...,255}
  * N = {2,...,15}
  */
-unsigned int calc_pll_value(unsigned int request_orig, struct pll_value *pll)
+unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *pll)
 {
 	/*
 	 * as sm750 register definition,
@@ -381,7 +381,7 @@ unsigned int calc_pll_value(unsigned int request_orig, struct pll_value *pll)
 	return ret;
 }
 
-unsigned int format_pll_reg(struct pll_value *pPLL)
+unsigned int sm750_format_pll_reg(struct pll_value *pPLL)
 {
 #ifndef VALIDATION_CHIP
 	unsigned int POD = pPLL->POD;
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 5eee29dfc4b3..e97e8592d973 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -88,8 +88,8 @@ struct initchip_param {
 
 logical_chip_type_t sm750_get_chip_type(void);
 void sm750_set_chip_type(unsigned short devId, char revId);
-unsigned int calc_pll_value(unsigned int request, struct  pll_value *pll);
-unsigned int format_pll_reg(struct pll_value *pPLL);
+unsigned int sm750_calc_pll_value(unsigned int request, struct  pll_value *pll);
+unsigned int sm750_format_pll_reg(struct pll_value *pPLL);
 unsigned int ddk750_get_vm_size(void);
 int ddk750_init_hw(struct initchip_param *);
 
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index 10439e061ae8..05d4a73aa1d4 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -24,7 +24,7 @@ unsigned char bus_speed_mode
 	 * Enable Hardware I2C power.
 	 * TODO: Check if we need to enable GPIO power?
 	 */
-	enable_i2c(1);
+	sm750_enable_i2c(1);
 
 	/* Enable the I2C Controller and set the bus speed mode */
 	value = PEEK32(I2C_CTRL) & ~(I2C_CTRL_MODE | I2C_CTRL_EN);
@@ -45,7 +45,7 @@ void sm750_hw_i2c_close(void)
 	POKE32(I2C_CTRL, value);
 
 	/* Disable I2C Power */
-	enable_i2c(0);
+	sm750_enable_i2c(0);
 
 	/* Set GPIO 30 & 31 back as GPIO pins */
 	value = PEEK32(GPIO_MUX);
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 47d224e542c3..4a4b1de97a87 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -83,7 +83,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 
 	if (pll->clockType = SECONDARY_PLL) {
 		/* programe secondary pixel clock */
-		POKE32(CRT_PLL_CTRL, format_pll_reg(pll));
+		POKE32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
 		POKE32(CRT_HORIZONTAL_TOTAL,
 			(((pModeParam->horizontal_total - 1) <<
 				CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
@@ -133,7 +133,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 	} else if (pll->clockType = PRIMARY_PLL) {
 		unsigned int reserved;
 
-		POKE32(PANEL_PLL_CTRL, format_pll_reg(pll));
+		POKE32(PANEL_PLL_CTRL, sm750_format_pll_reg(pll));
 
 		reg = ((pModeParam->horizontal_total - 1) <<
 			PANEL_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
@@ -210,7 +210,7 @@ int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 	pll.inputFreq = DEFAULT_INPUT_CLOCK;
 	pll.clockType = clock;
 
-	uiActualPixelClk = calc_pll_value(parm->pixel_clock, &pll);
+	uiActualPixelClk = sm750_calc_pll_value(parm->pixel_clock, &pll);
 	if (sm750_get_chip_type() = SM750LE) {
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 6f4374057405..6167e30e8e01 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -29,7 +29,7 @@ static unsigned int get_power_mode(void)
  * SM50x can operate in one of three modes: 0, 1 or Sleep.
  * On hardware reset, power mode 0 is default.
  */
-void set_power_mode(unsigned int mode)
+void sm750_set_power_mode(unsigned int mode)
 {
 	unsigned int ctrl = 0;
 
@@ -72,7 +72,7 @@ void set_power_mode(unsigned int mode)
 	POKE32(POWER_MODE_CTRL, ctrl);
 }
 
-void set_current_gate(unsigned int gate)
+void sm750_set_current_gate(unsigned int gate)
 {
 	if (get_power_mode() = POWER_MODE_CTRL_MODE_MODE1)
 		POKE32(MODE1_GATE, gate);
@@ -85,7 +85,7 @@ void set_current_gate(unsigned int gate)
 /*
  * This function enable/disable the 2D engine.
  */
-void enable_2d_engine(unsigned int enable)
+void sm750_enable_2d_engine(unsigned int enable)
 {
 	u32 gate;
 
@@ -95,10 +95,10 @@ void enable_2d_engine(unsigned int enable)
 	else
 		gate &= ~(CURRENT_GATE_DE | CURRENT_GATE_CSC);
 
-	set_current_gate(gate);
+	sm750_set_current_gate(gate);
 }
 
-void enable_dma(unsigned int enable)
+void sm750_enable_dma(unsigned int enable)
 {
 	u32 gate;
 
@@ -109,13 +109,13 @@ void enable_dma(unsigned int enable)
 	else
 		gate &= ~CURRENT_GATE_DMA;
 
-	set_current_gate(gate);
+	sm750_set_current_gate(gate);
 }
 
 /*
  * This function enable/disable the GPIO Engine
  */
-void enable_gpio(unsigned int enable)
+void sm750_enable_gpio(unsigned int enable)
 {
 	u32 gate;
 
@@ -126,13 +126,13 @@ void enable_gpio(unsigned int enable)
 	else
 		gate &= ~CURRENT_GATE_GPIO;
 
-	set_current_gate(gate);
+	sm750_set_current_gate(gate);
 }
 
 /*
  * This function enable/disable the I2C Engine
  */
-void enable_i2c(unsigned int enable)
+void sm750_enable_i2c(unsigned int enable)
 {
 	u32 gate;
 
@@ -143,7 +143,7 @@ void enable_i2c(unsigned int enable)
 	else
 		gate &= ~CURRENT_GATE_I2C;
 
-	set_current_gate(gate);
+	sm750_set_current_gate(gate);
 }
 
 
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index ea56026d41b2..eb088b0d805f 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -15,28 +15,28 @@ DPMS_t;
 }
 
 void ddk750_set_dpms(DPMS_t);
-void set_power_mode(unsigned int powerMode);
-void set_current_gate(unsigned int gate);
+void sm750_set_power_mode(unsigned int powerMode);
+void sm750_set_current_gate(unsigned int gate);
 
 /*
  * This function enable/disable the 2D engine.
  */
-void enable_2d_engine(unsigned int enable);
+void sm750_enable_2d_engine(unsigned int enable);
 
 /*
  * This function enable/disable the DMA Engine
  */
-void enable_dma(unsigned int enable);
+void sm750_enable_dma(unsigned int enable);
 
 /*
  * This function enable/disable the GPIO Engine
  */
-void enable_gpio(unsigned int enable);
+void sm750_enable_gpio(unsigned int enable);
 
 /*
  * This function enable/disable the I2C Engine
  */
-void enable_i2c(unsigned int enable);
+void sm750_enable_i2c(unsigned int enable);
 
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index e2e3ca64d483..b8a4e44359af 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -428,7 +428,7 @@ long sm750_sw_i2c_init(
 	       PEEK32(sw_i2c_data_gpio_mux_reg) & ~(1 << sw_i2c_data_gpio));
 
 	/* Enable GPIO power */
-	enable_gpio(1);
+	sm750_enable_gpio(1);
 
 	/* Clear the i2c lines. */
 	for (i = 0; i < 9; i++)
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 5c153d68212a..2d22c51cb33b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -118,14 +118,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		return -ENXIO;
 	}
 
-	hw_cursor_disable(cursor);
+	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		hw_cursor_setSize(cursor,
+		sm750_hw_cursor_setSize(cursor,
 				  fbcursor->image.width,
 				  fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
-		hw_cursor_setPos(cursor,
+		sm750_hw_cursor_setPos(cursor,
 				 fbcursor->image.dx - info->var.xoffset,
 				 fbcursor->image.dy - info->var.yoffset);
 
@@ -141,18 +141,18 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		      ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
 		      ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		hw_cursor_setColor(cursor, fg, bg);
+		sm750_hw_cursor_setColor(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
-		hw_cursor_setData(cursor,
+		sm750_hw_cursor_setData(cursor,
 				  fbcursor->rop,
 				  fbcursor->image.data,
 				  fbcursor->mask);
 	}
 
 	if (fbcursor->enable)
-		hw_cursor_enable(cursor);
+		sm750_hw_cursor_enable(cursor);
 
 	return 0;
 }
@@ -788,7 +788,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor) {
 		lynxfb_ops.fb_cursor = NULL;
-		hw_cursor_disable(&crtc->cursor);
+		sm750_hw_cursor_disable(&crtc->cursor);
 	}
 
 	/* set info->fbops, must be set before fb_find_mode */
@@ -1083,10 +1083,10 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		 * if some chip need specific function,
 		 * please hook it in smXXX_set_drv routine
 		 */
-		sm750_dev->accel.de_init = hw_de_init;
-		sm750_dev->accel.de_fillrect = hw_fillrect;
-		sm750_dev->accel.de_copyarea = hw_copyarea;
-		sm750_dev->accel.de_imageblit = hw_imageblit;
+		sm750_dev->accel.de_init = sm750_hw_de_init;
+		sm750_dev->accel.de_fillrect = sm750_hw_fillrect;
+		sm750_dev->accel.de_copyarea = sm750_hw_copyarea;
+		sm750_dev->accel.de_imageblit = sm750_hw_imageblit;
 	}
 
 	/* call chip specific setup routine  */
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 2e9c94142274..6fd18d24f5b2 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -32,7 +32,7 @@ static inline void write_dpPort(struct lynx_accel *accel, u32 data)
 	writel(data, accel->dpPortBase);
 }
 
-void hw_de_init(struct lynx_accel *accel)
+void sm750_hw_de_init(struct lynx_accel *accel)
 {
 	/* setup 2d engine registers */
 	u32 reg, clr;
@@ -71,7 +71,7 @@ void hw_de_init(struct lynx_accel *accel)
  * every time you use 2d function
  */
 
-void hw_set2dformat(struct lynx_accel *accel, int fmt)
+void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
 
@@ -83,7 +83,7 @@ void hw_set2dformat(struct lynx_accel *accel, int fmt)
 	write_dpr(accel, DE_STRETCH_FORMAT, reg);
 }
 
-int hw_fillrect(struct lynx_accel *accel,
+int sm750_hw_fillrect(struct lynx_accel *accel,
 				u32 base, u32 pitch, u32 Bpp,
 				u32 x, u32 y, u32 width, u32 height,
 				u32 color, u32 rop)
@@ -128,7 +128,7 @@ int hw_fillrect(struct lynx_accel *accel,
 	return 0;
 }
 
-int hw_copyarea(
+int sm750_hw_copyarea(
 struct lynx_accel *accel,
 unsigned int sBase,  /* Address of source: offset in frame buffer */
 unsigned int sPitch, /* Pitch value of source surface in BYTE */
@@ -293,7 +293,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 	return de_ctrl;
 }
 
-int hw_imageblit(struct lynx_accel *accel,
+int sm750_hw_imageblit(struct lynx_accel *accel,
 		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
 		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d59d005e0add..4b0ff8feb9a0 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -184,16 +184,16 @@
 #define BOTTOM_TO_TOP 1
 #define RIGHT_TO_LEFT 1
 
-void hw_set2dformat(struct lynx_accel *accel, int fmt);
+void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 
-void hw_de_init(struct lynx_accel *accel);
+void sm750_hw_de_init(struct lynx_accel *accel);
 
-int hw_fillrect(struct lynx_accel *accel,
+int sm750_hw_fillrect(struct lynx_accel *accel,
 				u32 base, u32 pitch, u32 Bpp,
 				u32 x, u32 y, u32 width, u32 height,
 				u32 color, u32 rop);
 
-int hw_copyarea(
+int sm750_hw_copyarea(
 struct lynx_accel *accel,
 unsigned int sBase,  /* Address of source: offset in frame buffer */
 unsigned int sPitch, /* Pitch value of source surface in BYTE */
@@ -208,7 +208,7 @@ unsigned int width,
 unsigned int height, /* width and height of rectangle in pixel value */
 unsigned int rop2);
 
-int hw_imageblit(struct lynx_accel *accel,
+int sm750_hw_imageblit(struct lynx_accel *accel,
 		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
 		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index d622d65b6cee..2a13353fc492 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -47,25 +47,25 @@ writel((data), cursor->mmio + (addr))
 
 
 /* hw_cursor_xxx works for voyager,718 and 750 */
-void hw_cursor_enable(struct lynx_cursor *cursor)
+void sm750_hw_cursor_enable(struct lynx_cursor *cursor)
 {
 	u32 reg;
 
 	reg = (cursor->offset & HWC_ADDRESS_ADDRESS_MASK) | HWC_ADDRESS_ENABLE;
 	POKE32(HWC_ADDRESS, reg);
 }
-void hw_cursor_disable(struct lynx_cursor *cursor)
+void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 {
 	POKE32(HWC_ADDRESS, 0);
 }
 
-void hw_cursor_setSize(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
 						int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
 }
-void hw_cursor_setPos(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y)
 {
 	u32 reg;
@@ -74,7 +74,7 @@ void hw_cursor_setPos(struct lynx_cursor *cursor,
 		(x & HWC_LOCATION_X_MASK));
 	POKE32(HWC_LOCATION, reg);
 }
-void hw_cursor_setColor(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg)
 {
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
@@ -84,7 +84,7 @@ void hw_cursor_setColor(struct lynx_cursor *cursor,
 	POKE32(HWC_COLOR_3, 0xffe0);
 }
 
-void hw_cursor_setData(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
 			u16 rop, const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
@@ -138,7 +138,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 }
 
 
-void hw_cursor_setData2(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
 			u16 rop, const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 6c4fc9b73489..c7b86ae235b4 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -2,16 +2,16 @@
 #define LYNX_CURSOR_H__
 
 /* hw_cursor_xxx works for voyager,718 and 750 */
-void hw_cursor_enable(struct lynx_cursor *cursor);
-void hw_cursor_disable(struct lynx_cursor *cursor);
-void hw_cursor_setSize(struct lynx_cursor *cursor,
+void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
+void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
+void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
 						int w, int h);
-void hw_cursor_setPos(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y);
-void hw_cursor_setColor(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg);
-void hw_cursor_setData(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
 			u16 rop, const u8 *data, const u8 *mask);
-void hw_cursor_setData2(struct lynx_cursor *cursor,
+void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
 			u16 rop, const u8 *data, const u8 *mask);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 23b6b1cda529..b6af3b53076b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -275,7 +275,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 			fmt = 2;
 			break;
 		}
-		hw_set2dformat(&sm750_dev->accel, fmt);
+		sm750_hw_set2dformat(&sm750_dev->accel, fmt);
 	}
 
 	/* set timing */
@@ -479,7 +479,7 @@ void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
 {
 	u32 reg;
 
-	enable_2d_engine(1);
+	sm750_enable_2d_engine(1);
 
 	if (sm750_get_chip_type() = SM750LE) {
 		reg = PEEK32(DE_STATE1);
-- 
2.9.0

