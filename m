From: Matthieu Simon <gmatthsim@gmail.com>
Date: Wed, 08 Feb 2017 06:48:43 +0000
Subject: [PATCH] staging: sm750fb: Replace POKE32 and PEEK32 by inline functions
Message-Id: <84ea3b1c79b362a697505891d2f513da6924c2ad.1486534917.git.gmatthsim@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

POKE32 and PEEK32 have been replaced by inlined functions poke32 and
peek32.
Having inline functions instead of macros help to get the correct
type-checking and avoid the possible precedence issues reported by
checkpatch.

Signed-off-by: Matthieu Simon <gmatthsim@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c    |  42 ++++++-------
 drivers/staging/sm750fb/ddk750_chip.h    |  13 +++-
 drivers/staging/sm750fb/ddk750_display.c |  44 ++++++-------
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  38 ++++++------
 drivers/staging/sm750fb/ddk750_mode.c    |  38 ++++++------
 drivers/staging/sm750fb/ddk750_power.c   |  26 ++++----
 drivers/staging/sm750fb/ddk750_power.h   |   4 +-
 drivers/staging/sm750fb/ddk750_swi2c.c   |  34 +++++------
 drivers/staging/sm750fb/sm750_cursor.c   |  12 ++--
 drivers/staging/sm750fb/sm750_hw.c       | 102 +++++++++++++++----------------
 10 files changed, 180 insertions(+), 173 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 9aaf1fdad08d..10cf7295dc6c 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -38,7 +38,7 @@ static unsigned int get_mxclk_freq(void)
 	if (sm750_get_chip_type() = SM750LE)
 		return MHz(130);
 
-	pll_reg = PEEK32(MXCLK_PLL_CTRL);
+	pll_reg = peek32(MXCLK_PLL_CTRL);
 	M = (pll_reg & PLL_CTRL_M_MASK) >> PLL_CTRL_M_SHIFT;
 	N = (pll_reg & PLL_CTRL_N_MASK) >> PLL_CTRL_M_SHIFT;
 	OD = (pll_reg & PLL_CTRL_OD_MASK) >> PLL_CTRL_OD_SHIFT;
@@ -78,7 +78,7 @@ static void set_chip_clock(unsigned int frequency)
 		ulActualMxClk = sm750_calc_pll_value(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
-		POKE32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
+		poke32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
 	}
 }
 
@@ -105,7 +105,7 @@ static void set_memory_clock(unsigned int frequency)
 		divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
 
 		/* Set the corresponding divisor in the register. */
-		reg = PEEK32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
+		reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
 		switch (divisor) {
 		default:
 		case 1:
@@ -157,7 +157,7 @@ static void set_master_clock(unsigned int frequency)
 		divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
 
 		/* Set the corresponding divisor in the register. */
-		reg = PEEK32(CURRENT_GATE) & ~CURRENT_GATE_MCLK_MASK;
+		reg = peek32(CURRENT_GATE) & ~CURRENT_GATE_MCLK_MASK;
 		switch (divisor) {
 		default:
 		case 3:
@@ -188,12 +188,12 @@ unsigned int ddk750_get_vm_size(void)
 		return SZ_64M;
 
 	/* for 750,always use power mode0*/
-	reg = PEEK32(MODE0_GATE);
+	reg = peek32(MODE0_GATE);
 	reg |= MODE0_GATE_GPIO;
-	POKE32(MODE0_GATE, reg);
+	poke32(MODE0_GATE, reg);
 
 	/* get frame buffer size from GPIO */
-	reg = PEEK32(MISC_CTRL) & MISC_CTRL_LOCALMEM_SIZE_MASK;
+	reg = peek32(MISC_CTRL) & MISC_CTRL_LOCALMEM_SIZE_MASK;
 	switch (reg) {
 	case MISC_CTRL_LOCALMEM_SIZE_8M:
 		data = SZ_8M;  break; /* 8  Mega byte */
@@ -219,15 +219,15 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	sm750_set_power_mode(pInitParam->powerMode);
 
 	/* Enable display power gate & LOCALMEM power gate*/
-	reg = PEEK32(CURRENT_GATE);
+	reg = peek32(CURRENT_GATE);
 	reg |= (CURRENT_GATE_DISPLAY | CURRENT_GATE_LOCALMEM);
 	sm750_set_current_gate(reg);
 
 	if (sm750_get_chip_type() != SM750LE) {
 		/*	set panel pll and graphic mode via mmio_88 */
-		reg = PEEK32(VGA_CONFIGURATION);
+		reg = peek32(VGA_CONFIGURATION);
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
-		POKE32(VGA_CONFIGURATION, reg);
+		poke32(VGA_CONFIGURATION, reg);
 	} else {
 #if defined(__i386__) || defined(__x86_64__)
 		/* set graphic mode via IO method */
@@ -252,36 +252,36 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	 * The memory should be resetted after changing the MXCLK.
 	 */
 	if (pInitParam->resetMemory = 1) {
-		reg = PEEK32(MISC_CTRL);
+		reg = peek32(MISC_CTRL);
 		reg &= ~MISC_CTRL_LOCALMEM_RESET;
-		POKE32(MISC_CTRL, reg);
+		poke32(MISC_CTRL, reg);
 
 		reg |= MISC_CTRL_LOCALMEM_RESET;
-		POKE32(MISC_CTRL, reg);
+		poke32(MISC_CTRL, reg);
 	}
 
 	if (pInitParam->setAllEngOff = 1) {
 		sm750_enable_2d_engine(0);
 
 		/* Disable Overlay, if a former application left it on */
-		reg = PEEK32(VIDEO_DISPLAY_CTRL);
+		reg = peek32(VIDEO_DISPLAY_CTRL);
 		reg &= ~DISPLAY_CTRL_PLANE;
-		POKE32(VIDEO_DISPLAY_CTRL, reg);
+		poke32(VIDEO_DISPLAY_CTRL, reg);
 
 		/* Disable video alpha, if a former application left it on */
-		reg = PEEK32(VIDEO_ALPHA_DISPLAY_CTRL);
+		reg = peek32(VIDEO_ALPHA_DISPLAY_CTRL);
 		reg &= ~DISPLAY_CTRL_PLANE;
-		POKE32(VIDEO_ALPHA_DISPLAY_CTRL, reg);
+		poke32(VIDEO_ALPHA_DISPLAY_CTRL, reg);
 
 		/* Disable alpha plane, if a former application left it on */
-		reg = PEEK32(ALPHA_DISPLAY_CTRL);
+		reg = peek32(ALPHA_DISPLAY_CTRL);
 		reg &= ~DISPLAY_CTRL_PLANE;
-		POKE32(ALPHA_DISPLAY_CTRL, reg);
+		poke32(ALPHA_DISPLAY_CTRL, reg);
 
 		/* Disable DMA Channel, if a former application left it on */
-		reg = PEEK32(DMA_ABORT_INTERRUPT);
+		reg = peek32(DMA_ABORT_INTERRUPT);
 		reg |= DMA_ABORT_INTERRUPT_ABORT_1;
-		POKE32(DMA_ABORT_INTERRUPT, reg);
+		poke32(DMA_ABORT_INTERRUPT, reg);
 
 		/* Disable DMA Power, if a former application left it on */
 		sm750_enable_dma(0);
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index e63b8b293816..fbeb615aa432 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -9,11 +9,18 @@
 #include <linux/ioport.h>
 #include <linux/uaccess.h>
 
+extern void __iomem *mmio750;
+
 /* software control endianness */
-#define PEEK32(addr) readl(addr + mmio750)
-#define POKE32(addr, data) writel(data, addr + mmio750)
+static inline u32 peek32(u32 addr)
+{
+	return readl(addr + mmio750);
+}
 
-extern void __iomem *mmio750;
+static inline void poke32(u32 data, u32 addr)
+{
+	writel(data, addr + mmio750);
+}
 
 /* This is all the chips recognized by this library */
 typedef enum _logical_chip_type_t {
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index c347803f7e19..e4724a660d07 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -18,7 +18,7 @@ static void setDisplayControl(int ctrl, int disp_state)
 		reserved = CRT_DISPLAY_CTRL_RESERVED_MASK;
 	}
 
-	val = PEEK32(reg);
+	val = peek32(reg);
 	if (disp_state) {
 		/*
 		 * Timing should be enabled first before enabling the
@@ -27,7 +27,7 @@ static void setDisplayControl(int ctrl, int disp_state)
 		 * disabled.
 		 */
 		val |= DISPLAY_CTRL_TIMING;
-		POKE32(reg, val);
+		poke32(reg, val);
 
 		val |= DISPLAY_CTRL_PLANE;
 
@@ -38,8 +38,8 @@ static void setDisplayControl(int ctrl, int disp_state)
 		 */
 		do {
 			cnt++;
-			POKE32(reg, val);
-		} while ((PEEK32(reg) & ~reserved) != (val & ~reserved));
+			poke32(reg, val);
+		} while ((peek32(reg) & ~reserved) != (val & ~reserved));
 		pr_debug("Set Plane enbit:after tried %d times\n", cnt);
 	} else {
 		/*
@@ -52,10 +52,10 @@ static void setDisplayControl(int ctrl, int disp_state)
 		 * before modifying the timing enable bit.
 		 */
 		val &= ~DISPLAY_CTRL_PLANE;
-		POKE32(reg, val);
+		poke32(reg, val);
 
 		val &= ~DISPLAY_CTRL_TIMING;
-		POKE32(reg, val);
+		poke32(reg, val);
 	}
 }
 
@@ -67,19 +67,19 @@ static void primary_wait_vertical_sync(int delay)
 	 * Do not wait when the Primary PLL is off or display control is
 	 * already off. This will prevent the software to wait forever.
 	 */
-	if (!(PEEK32(PANEL_PLL_CTRL) & PLL_CTRL_POWER) ||
-	    !(PEEK32(PANEL_DISPLAY_CTRL) & DISPLAY_CTRL_TIMING))
+	if (!(peek32(PANEL_PLL_CTRL) & PLL_CTRL_POWER) ||
+	    !(peek32(PANEL_DISPLAY_CTRL) & DISPLAY_CTRL_TIMING))
 		return;
 
 	while (delay-- > 0) {
 		/* Wait for end of vsync. */
 		do {
-			status = PEEK32(SYSTEM_CTRL);
+			status = peek32(SYSTEM_CTRL);
 		} while (status & SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
 
 		/* Wait for start of vsync. */
 		do {
-			status = PEEK32(SYSTEM_CTRL);
+			status = peek32(SYSTEM_CTRL);
 		} while (!(status & SYSTEM_CTRL_PANEL_VSYNC_ACTIVE));
 	}
 }
@@ -89,24 +89,24 @@ static void swPanelPowerSequence(int disp, int delay)
 	unsigned int reg;
 
 	/* disp should be 1 to open sequence */
-	reg = PEEK32(PANEL_DISPLAY_CTRL);
+	reg = peek32(PANEL_DISPLAY_CTRL);
 	reg |= (disp ? PANEL_DISPLAY_CTRL_FPEN : 0);
-	POKE32(PANEL_DISPLAY_CTRL, reg);
+	poke32(PANEL_DISPLAY_CTRL, reg);
 	primary_wait_vertical_sync(delay);
 
-	reg = PEEK32(PANEL_DISPLAY_CTRL);
+	reg = peek32(PANEL_DISPLAY_CTRL);
 	reg |= (disp ? PANEL_DISPLAY_CTRL_DATA : 0);
-	POKE32(PANEL_DISPLAY_CTRL, reg);
+	poke32(PANEL_DISPLAY_CTRL, reg);
 	primary_wait_vertical_sync(delay);
 
-	reg = PEEK32(PANEL_DISPLAY_CTRL);
+	reg = peek32(PANEL_DISPLAY_CTRL);
 	reg |= (disp ? PANEL_DISPLAY_CTRL_VBIASEN : 0);
-	POKE32(PANEL_DISPLAY_CTRL, reg);
+	poke32(PANEL_DISPLAY_CTRL, reg);
 	primary_wait_vertical_sync(delay);
 
-	reg = PEEK32(PANEL_DISPLAY_CTRL);
+	reg = peek32(PANEL_DISPLAY_CTRL);
 	reg |= (disp ? PANEL_DISPLAY_CTRL_FPEN : 0);
-	POKE32(PANEL_DISPLAY_CTRL, reg);
+	poke32(PANEL_DISPLAY_CTRL, reg);
 	primary_wait_vertical_sync(delay);
 }
 
@@ -116,22 +116,22 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 
 	if (output & PNL_2_USAGE) {
 		/* set panel path controller select */
-		reg = PEEK32(PANEL_DISPLAY_CTRL);
+		reg = peek32(PANEL_DISPLAY_CTRL);
 		reg &= ~PANEL_DISPLAY_CTRL_SELECT_MASK;
 		reg |= (((output & PNL_2_MASK) >> PNL_2_OFFSET) <<
 			PANEL_DISPLAY_CTRL_SELECT_SHIFT);
-		POKE32(PANEL_DISPLAY_CTRL, reg);
+		poke32(PANEL_DISPLAY_CTRL, reg);
 	}
 
 	if (output & CRT_2_USAGE) {
 		/* set crt path controller select */
-		reg = PEEK32(CRT_DISPLAY_CTRL);
+		reg = peek32(CRT_DISPLAY_CTRL);
 		reg &= ~CRT_DISPLAY_CTRL_SELECT_MASK;
 		reg |= (((output & CRT_2_MASK) >> CRT_2_OFFSET) <<
 			CRT_DISPLAY_CTRL_SELECT_SHIFT);
 		/*se blank off */
 		reg &= ~CRT_DISPLAY_CTRL_BLANK;
-		POKE32(CRT_DISPLAY_CTRL, reg);
+		poke32(CRT_DISPLAY_CTRL, reg);
 	}
 
 	if (output & PRI_TP_USAGE) {
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index 05d4a73aa1d4..68716ef7cb06 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -15,10 +15,10 @@ unsigned char bus_speed_mode
 	unsigned int value;
 
 	/* Enable GPIO 30 & 31 as IIC clock & data */
-	value = PEEK32(GPIO_MUX);
+	value = peek32(GPIO_MUX);
 
 	value |= (GPIO_MUX_30 | GPIO_MUX_31);
-	POKE32(GPIO_MUX, value);
+	poke32(GPIO_MUX, value);
 
 	/*
 	 * Enable Hardware I2C power.
@@ -27,11 +27,11 @@ unsigned char bus_speed_mode
 	sm750_enable_i2c(1);
 
 	/* Enable the I2C Controller and set the bus speed mode */
-	value = PEEK32(I2C_CTRL) & ~(I2C_CTRL_MODE | I2C_CTRL_EN);
+	value = peek32(I2C_CTRL) & ~(I2C_CTRL_MODE | I2C_CTRL_EN);
 	if (bus_speed_mode)
 		value |= I2C_CTRL_MODE;
 	value |= I2C_CTRL_EN;
-	POKE32(I2C_CTRL, value);
+	poke32(I2C_CTRL, value);
 
 	return 0;
 }
@@ -41,17 +41,17 @@ void sm750_hw_i2c_close(void)
 	unsigned int value;
 
 	/* Disable I2C controller */
-	value = PEEK32(I2C_CTRL) & ~I2C_CTRL_EN;
-	POKE32(I2C_CTRL, value);
+	value = peek32(I2C_CTRL) & ~I2C_CTRL_EN;
+	poke32(I2C_CTRL, value);
 
 	/* Disable I2C Power */
 	sm750_enable_i2c(0);
 
 	/* Set GPIO 30 & 31 back as GPIO pins */
-	value = PEEK32(GPIO_MUX);
+	value = peek32(GPIO_MUX);
 	value &= ~GPIO_MUX_30;
 	value &= ~GPIO_MUX_31;
-	POKE32(GPIO_MUX, value);
+	poke32(GPIO_MUX, value);
 }
 
 static long hw_i2c_wait_tx_done(void)
@@ -60,7 +60,7 @@ static long hw_i2c_wait_tx_done(void)
 
 	/* Wait until the transfer is completed. */
 	timeout = HWI2C_WAIT_TIMEOUT;
-	while (!(PEEK32(I2C_STATUS) & I2C_STATUS_TX) && (timeout != 0))
+	while (!(peek32(I2C_STATUS) & I2C_STATUS_TX) && (timeout != 0))
 		timeout--;
 
 	if (timeout = 0)
@@ -91,7 +91,7 @@ static unsigned int hw_i2c_write_data(
 	unsigned int total_bytes = 0;
 
 	/* Set the Device Address */
-	POKE32(I2C_SLAVE_ADDRESS, addr & ~0x01);
+	poke32(I2C_SLAVE_ADDRESS, addr & ~0x01);
 
 	/*
 	 * Write data.
@@ -103,21 +103,21 @@ static unsigned int hw_i2c_write_data(
 		 * Reset I2C by writing 0 to I2C_RESET register to
 		 * clear the previous status.
 		 */
-		POKE32(I2C_RESET, 0);
+		poke32(I2C_RESET, 0);
 
 		/* Set the number of bytes to be written */
 		if (length < MAX_HWI2C_FIFO)
 			count = length - 1;
 		else
 			count = MAX_HWI2C_FIFO - 1;
-		POKE32(I2C_BYTE_COUNT, count);
+		poke32(I2C_BYTE_COUNT, count);
 
 		/* Move the data to the I2C data register */
 		for (i = 0; i <= count; i++)
-			POKE32(I2C_DATA0 + i, *buf++);
+			poke32(I2C_DATA0 + i, *buf++);
 
 		/* Start the I2C */
-		POKE32(I2C_CTRL, PEEK32(I2C_CTRL) | I2C_CTRL_CTRL);
+		poke32(I2C_CTRL, peek32(I2C_CTRL) | I2C_CTRL_CTRL);
 
 		/* Wait until the transfer is completed. */
 		if (hw_i2c_wait_tx_done() != 0)
@@ -158,7 +158,7 @@ static unsigned int hw_i2c_read_data(
 	unsigned int total_bytes = 0;
 
 	/* Set the Device Address */
-	POKE32(I2C_SLAVE_ADDRESS, addr | 0x01);
+	poke32(I2C_SLAVE_ADDRESS, addr | 0x01);
 
 	/*
 	 * Read data and save them to the buffer.
@@ -170,17 +170,17 @@ static unsigned int hw_i2c_read_data(
 		 * Reset I2C by writing 0 to I2C_RESET register to
 		 * clear all the status.
 		 */
-		POKE32(I2C_RESET, 0);
+		poke32(I2C_RESET, 0);
 
 		/* Set the number of bytes to be read */
 		if (length <= MAX_HWI2C_FIFO)
 			count = length - 1;
 		else
 			count = MAX_HWI2C_FIFO - 1;
-		POKE32(I2C_BYTE_COUNT, count);
+		poke32(I2C_BYTE_COUNT, count);
 
 		/* Start the I2C */
-		POKE32(I2C_CTRL, PEEK32(I2C_CTRL) | I2C_CTRL_CTRL);
+		poke32(I2C_CTRL, peek32(I2C_CTRL) | I2C_CTRL_CTRL);
 
 		/* Wait until transaction done. */
 		if (hw_i2c_wait_tx_done() != 0)
@@ -188,7 +188,7 @@ static unsigned int hw_i2c_read_data(
 
 		/* Save the data to the given buffer */
 		for (i = 0; i <= count; i++)
-			*buf++ = PEEK32(I2C_DATA0 + i);
+			*buf++ = peek32(I2C_DATA0 + i);
 
 		/* Subtract length by 16 */
 		length -= (count + 1);
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 4a4b1de97a87..1df7d57dea6d 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -25,9 +25,9 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	 * Note that normal SM750/SM718 only use those two register for
 	 * auto-centering mode.
 	 */
-	POKE32(CRT_AUTO_CENTERING_TL, 0);
+	poke32(CRT_AUTO_CENTERING_TL, 0);
 
-	POKE32(CRT_AUTO_CENTERING_BR,
+	poke32(CRT_AUTO_CENTERING_BR,
 		(((y - 1) << CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT) &
 			CRT_AUTO_CENTERING_BR_BOTTOM_MASK) |
 		((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
@@ -66,7 +66,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	/* Set bit 14 of display controller */
 	dispControl |= DISPLAY_CTRL_CLOCK_PHASE;
 
-	POKE32(CRT_DISPLAY_CTRL, dispControl);
+	poke32(CRT_DISPLAY_CTRL, dispControl);
 
 	return dispControl;
 }
@@ -83,29 +83,29 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 
 	if (pll->clockType = SECONDARY_PLL) {
 		/* programe secondary pixel clock */
-		POKE32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
-		POKE32(CRT_HORIZONTAL_TOTAL,
+		poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
+		poke32(CRT_HORIZONTAL_TOTAL,
 			(((pModeParam->horizontal_total - 1) <<
 				CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
 				CRT_HORIZONTAL_TOTAL_TOTAL_MASK) |
 			((pModeParam->horizontal_display_end - 1) &
 				CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK));
 
-		POKE32(CRT_HORIZONTAL_SYNC,
+		poke32(CRT_HORIZONTAL_SYNC,
 			((pModeParam->horizontal_sync_width <<
 				CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
 				CRT_HORIZONTAL_SYNC_WIDTH_MASK) |
 			((pModeParam->horizontal_sync_start - 1) &
 				CRT_HORIZONTAL_SYNC_START_MASK));
 
-		POKE32(CRT_VERTICAL_TOTAL,
+		poke32(CRT_VERTICAL_TOTAL,
 			(((pModeParam->vertical_total - 1) <<
 				CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
 				CRT_VERTICAL_TOTAL_TOTAL_MASK) |
 			((pModeParam->vertical_display_end - 1) &
 				CRT_VERTICAL_TOTAL_DISPLAY_END_MASK));
 
-		POKE32(CRT_VERTICAL_SYNC,
+		poke32(CRT_VERTICAL_SYNC,
 			((pModeParam->vertical_sync_height <<
 				CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
 				CRT_VERTICAL_SYNC_HEIGHT_MASK) |
@@ -122,41 +122,41 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 		if (sm750_get_chip_type() = SM750LE) {
 			displayControlAdjust_SM750LE(pModeParam, tmp);
 		} else {
-			reg = PEEK32(CRT_DISPLAY_CTRL) &
+			reg = peek32(CRT_DISPLAY_CTRL) &
 				~(DISPLAY_CTRL_VSYNC_PHASE |
 				  DISPLAY_CTRL_HSYNC_PHASE |
 				  DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE);
 
-			 POKE32(CRT_DISPLAY_CTRL, tmp | reg);
+			 poke32(CRT_DISPLAY_CTRL, tmp | reg);
 		}
 
 	} else if (pll->clockType = PRIMARY_PLL) {
 		unsigned int reserved;
 
-		POKE32(PANEL_PLL_CTRL, sm750_format_pll_reg(pll));
+		poke32(PANEL_PLL_CTRL, sm750_format_pll_reg(pll));
 
 		reg = ((pModeParam->horizontal_total - 1) <<
 			PANEL_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
 			PANEL_HORIZONTAL_TOTAL_TOTAL_MASK;
 		reg |= ((pModeParam->horizontal_display_end - 1) &
 			PANEL_HORIZONTAL_TOTAL_DISPLAY_END_MASK);
-		POKE32(PANEL_HORIZONTAL_TOTAL, reg);
+		poke32(PANEL_HORIZONTAL_TOTAL, reg);
 
-		POKE32(PANEL_HORIZONTAL_SYNC,
+		poke32(PANEL_HORIZONTAL_SYNC,
 			((pModeParam->horizontal_sync_width <<
 				PANEL_HORIZONTAL_SYNC_WIDTH_SHIFT) &
 				PANEL_HORIZONTAL_SYNC_WIDTH_MASK) |
 			((pModeParam->horizontal_sync_start - 1) &
 				PANEL_HORIZONTAL_SYNC_START_MASK));
 
-		POKE32(PANEL_VERTICAL_TOTAL,
+		poke32(PANEL_VERTICAL_TOTAL,
 			(((pModeParam->vertical_total - 1) <<
 				PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
 				PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
 			((pModeParam->vertical_display_end - 1) &
 				PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
 
-		POKE32(PANEL_VERTICAL_SYNC,
+		poke32(PANEL_VERTICAL_SYNC,
 			((pModeParam->vertical_sync_height <<
 				PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
 				PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
@@ -174,7 +174,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 		reserved = PANEL_DISPLAY_CTRL_RESERVED_MASK |
 			PANEL_DISPLAY_CTRL_VSYNC;
 
-		reg = (PEEK32(PANEL_DISPLAY_CTRL) & ~reserved) &
+		reg = (peek32(PANEL_DISPLAY_CTRL) & ~reserved) &
 			~(DISPLAY_CTRL_CLOCK_PHASE | DISPLAY_CTRL_VSYNC_PHASE |
 			  DISPLAY_CTRL_HSYNC_PHASE | DISPLAY_CTRL_TIMING |
 			  DISPLAY_CTRL_PLANE);
@@ -187,14 +187,14 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 		 * Note: This problem happens by design. The hardware will wait
 		 *       for the next vertical sync to turn on/off the plane.
 		 */
-		POKE32(PANEL_DISPLAY_CTRL, tmp | reg);
+		poke32(PANEL_DISPLAY_CTRL, tmp | reg);
 
-		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~reserved) !+		while ((peek32(PANEL_DISPLAY_CTRL) & ~reserved) ! 			(tmp | reg)) {
 			cnt++;
 			if (cnt > 1000)
 				break;
-			POKE32(PANEL_DISPLAY_CTRL, tmp | reg);
+			poke32(PANEL_DISPLAY_CTRL, tmp | reg);
 		}
 	} else {
 		ret = -1;
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 6167e30e8e01..02ff6204ee1e 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -7,13 +7,13 @@ void ddk750_set_dpms(DPMS_t state)
 	unsigned int value;
 
 	if (sm750_get_chip_type() = SM750LE) {
-		value = PEEK32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_DPMS_MASK;
+		value = peek32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_DPMS_MASK;
 		value |= (state << CRT_DISPLAY_CTRL_DPMS_SHIFT);
-		POKE32(CRT_DISPLAY_CTRL, value);
+		poke32(CRT_DISPLAY_CTRL, value);
 	} else {
-		value = PEEK32(SYSTEM_CTRL);
+		value = peek32(SYSTEM_CTRL);
 		value = (value & ~SYSTEM_CTRL_DPMS_MASK) | state;
-		POKE32(SYSTEM_CTRL, value);
+		poke32(SYSTEM_CTRL, value);
 	}
 }
 
@@ -21,7 +21,7 @@ static unsigned int get_power_mode(void)
 {
 	if (sm750_get_chip_type() = SM750LE)
 		return 0;
-	return PEEK32(POWER_MODE_CTRL) & POWER_MODE_CTRL_MODE_MASK;
+	return peek32(POWER_MODE_CTRL) & POWER_MODE_CTRL_MODE_MASK;
 }
 
 
@@ -33,7 +33,7 @@ void sm750_set_power_mode(unsigned int mode)
 {
 	unsigned int ctrl = 0;
 
-	ctrl = PEEK32(POWER_MODE_CTRL) & ~POWER_MODE_CTRL_MODE_MASK;
+	ctrl = peek32(POWER_MODE_CTRL) & ~POWER_MODE_CTRL_MODE_MASK;
 
 	if (sm750_get_chip_type() = SM750LE)
 		return;
@@ -69,15 +69,15 @@ void sm750_set_power_mode(unsigned int mode)
 	}
 
 	/* Program new power mode. */
-	POKE32(POWER_MODE_CTRL, ctrl);
+	poke32(POWER_MODE_CTRL, ctrl);
 }
 
 void sm750_set_current_gate(unsigned int gate)
 {
 	if (get_power_mode() = POWER_MODE_CTRL_MODE_MODE1)
-		POKE32(MODE1_GATE, gate);
+		poke32(MODE1_GATE, gate);
 	else
-		POKE32(MODE0_GATE, gate);
+		poke32(MODE0_GATE, gate);
 }
 
 
@@ -89,7 +89,7 @@ void sm750_enable_2d_engine(unsigned int enable)
 {
 	u32 gate;
 
-	gate = PEEK32(CURRENT_GATE);
+	gate = peek32(CURRENT_GATE);
 	if (enable)
 		gate |= (CURRENT_GATE_DE | CURRENT_GATE_CSC);
 	else
@@ -103,7 +103,7 @@ void sm750_enable_dma(unsigned int enable)
 	u32 gate;
 
 	/* Enable DMA Gate */
-	gate = PEEK32(CURRENT_GATE);
+	gate = peek32(CURRENT_GATE);
 	if (enable)
 		gate |= CURRENT_GATE_DMA;
 	else
@@ -120,7 +120,7 @@ void sm750_enable_gpio(unsigned int enable)
 	u32 gate;
 
 	/* Enable GPIO Gate */
-	gate = PEEK32(CURRENT_GATE);
+	gate = peek32(CURRENT_GATE);
 	if (enable)
 		gate |= CURRENT_GATE_GPIO;
 	else
@@ -137,7 +137,7 @@ void sm750_enable_i2c(unsigned int enable)
 	u32 gate;
 
 	/* Enable I2C Gate */
-	gate = PEEK32(CURRENT_GATE);
+	gate = peek32(CURRENT_GATE);
 	if (enable)
 		gate |= CURRENT_GATE_I2C;
 	else
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index eb088b0d805f..4274d74d47c1 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -10,8 +10,8 @@ typedef enum _DPMS_t {
 DPMS_t;
 
 #define setDAC(off) {							\
-	POKE32(MISC_CTRL,						\
-	       (PEEK32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
+	poke32(MISC_CTRL,						\
+	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
 }
 
 void ddk750_set_dpms(DPMS_t);
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index b8a4e44359af..a4ac07cd50cb 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -119,23 +119,23 @@ static void sw_i2c_scl(unsigned char value)
 	unsigned long gpio_data;
 	unsigned long gpio_dir;
 
-	gpio_dir = PEEK32(sw_i2c_clk_gpio_data_dir_reg);
+	gpio_dir = peek32(sw_i2c_clk_gpio_data_dir_reg);
 	if (value) {    /* High */
 		/*
 		 * Set direction as input. This will automatically
 		 * pull the signal up.
 		 */
 		gpio_dir &= ~(1 << sw_i2c_clk_gpio);
-		POKE32(sw_i2c_clk_gpio_data_dir_reg, gpio_dir);
+		poke32(sw_i2c_clk_gpio_data_dir_reg, gpio_dir);
 	} else {        /* Low */
 		/* Set the signal down */
-		gpio_data = PEEK32(sw_i2c_clk_gpio_data_reg);
+		gpio_data = peek32(sw_i2c_clk_gpio_data_reg);
 		gpio_data &= ~(1 << sw_i2c_clk_gpio);
-		POKE32(sw_i2c_clk_gpio_data_reg, gpio_data);
+		poke32(sw_i2c_clk_gpio_data_reg, gpio_data);
 
 		/* Set direction as output */
 		gpio_dir |= (1 << sw_i2c_clk_gpio);
-		POKE32(sw_i2c_clk_gpio_data_dir_reg, gpio_dir);
+		poke32(sw_i2c_clk_gpio_data_dir_reg, gpio_dir);
 	}
 }
 
@@ -156,23 +156,23 @@ static void sw_i2c_sda(unsigned char value)
 	unsigned long gpio_data;
 	unsigned long gpio_dir;
 
-	gpio_dir = PEEK32(sw_i2c_data_gpio_data_dir_reg);
+	gpio_dir = peek32(sw_i2c_data_gpio_data_dir_reg);
 	if (value) {    /* High */
 		/*
 		 * Set direction as input. This will automatically
 		 * pull the signal up.
 		 */
 		gpio_dir &= ~(1 << sw_i2c_data_gpio);
-		POKE32(sw_i2c_data_gpio_data_dir_reg, gpio_dir);
+		poke32(sw_i2c_data_gpio_data_dir_reg, gpio_dir);
 	} else {        /* Low */
 		/* Set the signal down */
-		gpio_data = PEEK32(sw_i2c_data_gpio_data_reg);
+		gpio_data = peek32(sw_i2c_data_gpio_data_reg);
 		gpio_data &= ~(1 << sw_i2c_data_gpio);
-		POKE32(sw_i2c_data_gpio_data_reg, gpio_data);
+		poke32(sw_i2c_data_gpio_data_reg, gpio_data);
 
 		/* Set direction as output */
 		gpio_dir |= (1 << sw_i2c_data_gpio);
-		POKE32(sw_i2c_data_gpio_data_dir_reg, gpio_dir);
+		poke32(sw_i2c_data_gpio_data_dir_reg, gpio_dir);
 	}
 }
 
@@ -189,14 +189,14 @@ static unsigned char sw_i2c_read_sda(void)
 	unsigned long dir_mask = 1 << sw_i2c_data_gpio;
 
 	/* Make sure that the direction is input (High) */
-	gpio_dir = PEEK32(sw_i2c_data_gpio_data_dir_reg);
+	gpio_dir = peek32(sw_i2c_data_gpio_data_dir_reg);
 	if ((gpio_dir & dir_mask) != ~dir_mask) {
 		gpio_dir &= ~(1 << sw_i2c_data_gpio);
-		POKE32(sw_i2c_data_gpio_data_dir_reg, gpio_dir);
+		poke32(sw_i2c_data_gpio_data_dir_reg, gpio_dir);
 	}
 
 	/* Now read the SDA line */
-	gpio_data = PEEK32(sw_i2c_data_gpio_data_reg);
+	gpio_data = peek32(sw_i2c_data_gpio_data_reg);
 	if (gpio_data & (1 << sw_i2c_data_gpio))
 		return 1;
 	else
@@ -422,10 +422,10 @@ long sm750_sw_i2c_init(
 	sw_i2c_data_gpio = data_gpio;
 
 	/* Enable the GPIO pins for the i2c Clock and Data (GPIO MUX) */
-	POKE32(sw_i2c_clk_gpio_mux_reg,
-	       PEEK32(sw_i2c_clk_gpio_mux_reg) & ~(1 << sw_i2c_clk_gpio));
-	POKE32(sw_i2c_data_gpio_mux_reg,
-	       PEEK32(sw_i2c_data_gpio_mux_reg) & ~(1 << sw_i2c_data_gpio));
+	poke32(sw_i2c_clk_gpio_mux_reg,
+	       peek32(sw_i2c_clk_gpio_mux_reg) & ~(1 << sw_i2c_clk_gpio));
+	poke32(sw_i2c_data_gpio_mux_reg,
+	       peek32(sw_i2c_data_gpio_mux_reg) & ~(1 << sw_i2c_data_gpio));
 
 	/* Enable GPIO power */
 	sm750_enable_gpio(1);
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 2a13353fc492..b1651b0d2034 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -20,7 +20,7 @@
 
 
 
-#define POKE32(addr, data) \
+#define poke32(addr, data) \
 writel((data), cursor->mmio + (addr))
 
 /* cursor control for voyager and 718/750*/
@@ -52,11 +52,11 @@ void sm750_hw_cursor_enable(struct lynx_cursor *cursor)
 	u32 reg;
 
 	reg = (cursor->offset & HWC_ADDRESS_ADDRESS_MASK) | HWC_ADDRESS_ENABLE;
-	POKE32(HWC_ADDRESS, reg);
+	poke32(HWC_ADDRESS, reg);
 }
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 {
-	POKE32(HWC_ADDRESS, 0);
+	poke32(HWC_ADDRESS, 0);
 }
 
 void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
@@ -72,7 +72,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 
 	reg = (((y << HWC_LOCATION_Y_SHIFT) & HWC_LOCATION_Y_MASK) |
 		(x & HWC_LOCATION_X_MASK));
-	POKE32(HWC_LOCATION, reg);
+	poke32(HWC_LOCATION, reg);
 }
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg)
@@ -80,8 +80,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
 		HWC_COLOR_12_2_RGB565_MASK;
 
-	POKE32(HWC_COLOR_12, reg | (bg & HWC_COLOR_12_1_RGB565_MASK));
-	POKE32(HWC_COLOR_3, 0xffe0);
+	poke32(HWC_COLOR_12, reg | (bg & HWC_COLOR_12_1_RGB565_MASK));
+	poke32(HWC_COLOR_3, 0xffe0);
 }
 
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index b6af3b53076b..fab3fc9c8330 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -108,30 +108,30 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	ddk750_init_hw((struct initchip_param *)&sm750_dev->initParm);
 	/* for sm718, open pci burst */
 	if (sm750_dev->devid = 0x718) {
-		POKE32(SYSTEM_CTRL,
-		       PEEK32(SYSTEM_CTRL) | SYSTEM_CTRL_PCI_BURST);
+		poke32(SYSTEM_CTRL,
+		       peek32(SYSTEM_CTRL) | SYSTEM_CTRL_PCI_BURST);
 	}
 
 	if (sm750_get_chip_type() != SM750LE) {
 		unsigned int val;
 		/* does user need CRT? */
 		if (sm750_dev->nocrt) {
-			POKE32(MISC_CTRL,
-			       PEEK32(MISC_CTRL) | MISC_CTRL_DAC_POWER_OFF);
+			poke32(MISC_CTRL,
+			       peek32(MISC_CTRL) | MISC_CTRL_DAC_POWER_OFF);
 			/* shut off dpms */
-			val = PEEK32(SYSTEM_CTRL) & ~SYSTEM_CTRL_DPMS_MASK;
+			val = peek32(SYSTEM_CTRL) & ~SYSTEM_CTRL_DPMS_MASK;
 			val |= SYSTEM_CTRL_DPMS_VPHN;
-			POKE32(SYSTEM_CTRL, val);
+			poke32(SYSTEM_CTRL, val);
 		} else {
-			POKE32(MISC_CTRL,
-			       PEEK32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF);
+			poke32(MISC_CTRL,
+			       peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF);
 			/* turn on dpms */
-			val = PEEK32(SYSTEM_CTRL) & ~SYSTEM_CTRL_DPMS_MASK;
+			val = peek32(SYSTEM_CTRL) & ~SYSTEM_CTRL_DPMS_MASK;
 			val |= SYSTEM_CTRL_DPMS_VPHP;
-			POKE32(SYSTEM_CTRL, val);
+			poke32(SYSTEM_CTRL, val);
 		}
 
-		val = PEEK32(PANEL_DISPLAY_CTRL) &
+		val = peek32(PANEL_DISPLAY_CTRL) &
 			~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			  PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
@@ -144,7 +144,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-		POKE32(PANEL_DISPLAY_CTRL, val);
+		poke32(PANEL_DISPLAY_CTRL, val);
 	} else {
 		/*
 		 * for 750LE, no DVI chip initialization
@@ -211,9 +211,9 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0 */
 		u32 reg;
 
-		reg = PEEK32(DISPLAY_CONTROL_750LE);
+		reg = peek32(DISPLAY_CONTROL_750LE);
 		reg |= 0xf;
-		POKE32(DISPLAY_CONTROL_750LE, reg);
+		poke32(DISPLAY_CONTROL_750LE, reg);
 	}
 
 	pr_info("ddk setlogicdispout done\n");
@@ -312,7 +312,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 
 	if (crtc->channel != sm750_secondary) {
 		/* set pitch, offset, width, start address, etc... */
-		POKE32(PANEL_FB_ADDRESS,
+		poke32(PANEL_FB_ADDRESS,
 		       crtc->oScreen & PANEL_FB_ADDRESS_ADDRESS_MASK);
 
 		reg = var->xres * (var->bits_per_pixel >> 3);
@@ -324,32 +324,32 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		reg = (reg << PANEL_FB_WIDTH_WIDTH_SHIFT) &
 		       PANEL_FB_WIDTH_WIDTH_MASK;
 		reg |= (fix->line_length & PANEL_FB_WIDTH_OFFSET_MASK);
-		POKE32(PANEL_FB_WIDTH, reg);
+		poke32(PANEL_FB_WIDTH, reg);
 
 		reg = ((var->xres - 1) << PANEL_WINDOW_WIDTH_WIDTH_SHIFT) &
 		       PANEL_WINDOW_WIDTH_WIDTH_MASK;
 		reg |= (var->xoffset & PANEL_WINDOW_WIDTH_X_MASK);
-		POKE32(PANEL_WINDOW_WIDTH, reg);
+		poke32(PANEL_WINDOW_WIDTH, reg);
 
 		reg = (var->yres_virtual - 1) <<
 		      PANEL_WINDOW_HEIGHT_HEIGHT_SHIFT;
 		reg &= PANEL_WINDOW_HEIGHT_HEIGHT_MASK;
 		reg |= (var->yoffset & PANEL_WINDOW_HEIGHT_Y_MASK);
-		POKE32(PANEL_WINDOW_HEIGHT, reg);
+		poke32(PANEL_WINDOW_HEIGHT, reg);
 
-		POKE32(PANEL_PLANE_TL, 0);
+		poke32(PANEL_PLANE_TL, 0);
 
 		reg = ((var->yres - 1) << PANEL_PLANE_BR_BOTTOM_SHIFT) &
 		       PANEL_PLANE_BR_BOTTOM_MASK;
 		reg |= ((var->xres - 1) & PANEL_PLANE_BR_RIGHT_MASK);
-		POKE32(PANEL_PLANE_BR, reg);
+		poke32(PANEL_PLANE_BR, reg);
 
 		/* set pixel format */
-		reg = PEEK32(PANEL_DISPLAY_CTRL);
-		POKE32(PANEL_DISPLAY_CTRL, reg | (var->bits_per_pixel >> 4));
+		reg = peek32(PANEL_DISPLAY_CTRL);
+		poke32(PANEL_DISPLAY_CTRL, reg | (var->bits_per_pixel >> 4));
 	} else {
 		/* not implemented now */
-		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
+		poke32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
 		/*
 		 * crtc->channel is not equal to par->index on numeric,
@@ -358,13 +358,13 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		reg = ALIGN(reg, crtc->line_pad) << CRT_FB_WIDTH_WIDTH_SHIFT;
 		reg &= CRT_FB_WIDTH_WIDTH_MASK;
 		reg |= (fix->line_length & CRT_FB_WIDTH_OFFSET_MASK);
-		POKE32(CRT_FB_WIDTH, reg);
+		poke32(CRT_FB_WIDTH, reg);
 
 		/* SET PIXEL FORMAT */
-		reg = PEEK32(CRT_DISPLAY_CTRL);
+		reg = peek32(CRT_DISPLAY_CTRL);
 		reg |= ((var->bits_per_pixel >> 4) &
 			CRT_DISPLAY_CTRL_FORMAT_MASK);
-		POKE32(CRT_DISPLAY_CTRL, reg);
+		poke32(CRT_DISPLAY_CTRL, reg);
 	}
 
 exit:
@@ -376,7 +376,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 {
 	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
 
-	POKE32(add[crtc->channel] + index * 4,
+	poke32(add[crtc->channel] + index * 4,
 	       (red << 16) | (green << 8) | blue);
 	return 0;
 }
@@ -413,11 +413,11 @@ int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank)
 	if (output->paths & sm750_crt) {
 		unsigned int val;
 
-		val = PEEK32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_DPMS_MASK;
-		POKE32(CRT_DISPLAY_CTRL, val | dpms);
+		val = peek32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_DPMS_MASK;
+		poke32(CRT_DISPLAY_CTRL, val | dpms);
 
-		val = PEEK32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_BLANK;
-		POKE32(CRT_DISPLAY_CTRL, val | crtdb);
+		val = peek32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_BLANK;
+		poke32(CRT_DISPLAY_CTRL, val | crtdb);
 	}
 	return 0;
 }
@@ -456,20 +456,20 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 	}
 
 	if (output->paths & sm750_crt) {
-		unsigned int val = PEEK32(SYSTEM_CTRL) & ~SYSTEM_CTRL_DPMS_MASK;
+		unsigned int val = peek32(SYSTEM_CTRL) & ~SYSTEM_CTRL_DPMS_MASK;
 
-		POKE32(SYSTEM_CTRL, val | dpms);
+		poke32(SYSTEM_CTRL, val | dpms);
 
-		val = PEEK32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_BLANK;
-		POKE32(CRT_DISPLAY_CTRL, val | crtdb);
+		val = peek32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_BLANK;
+		poke32(CRT_DISPLAY_CTRL, val | crtdb);
 	}
 
 	if (output->paths & sm750_panel) {
-		unsigned int val = PEEK32(PANEL_DISPLAY_CTRL);
+		unsigned int val = peek32(PANEL_DISPLAY_CTRL);
 
 		val &= ~PANEL_DISPLAY_CTRL_DATA;
 		val |= pps;
-		POKE32(PANEL_DISPLAY_CTRL, val);
+		poke32(PANEL_DISPLAY_CTRL, val);
 	}
 
 	return 0;
@@ -482,23 +482,23 @@ void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
 	sm750_enable_2d_engine(1);
 
 	if (sm750_get_chip_type() = SM750LE) {
-		reg = PEEK32(DE_STATE1);
+		reg = peek32(DE_STATE1);
 		reg |= DE_STATE1_DE_ABORT;
-		POKE32(DE_STATE1, reg);
+		poke32(DE_STATE1, reg);
 
-		reg = PEEK32(DE_STATE1);
+		reg = peek32(DE_STATE1);
 		reg &= ~DE_STATE1_DE_ABORT;
-		POKE32(DE_STATE1, reg);
+		poke32(DE_STATE1, reg);
 
 	} else {
 		/* engine reset */
-		reg = PEEK32(SYSTEM_CTRL);
+		reg = peek32(SYSTEM_CTRL);
 		reg |= SYSTEM_CTRL_DE_ABORT;
-		POKE32(SYSTEM_CTRL, reg);
+		poke32(SYSTEM_CTRL, reg);
 
-		reg = PEEK32(SYSTEM_CTRL);
+		reg = peek32(SYSTEM_CTRL);
 		reg &= ~SYSTEM_CTRL_DE_ABORT;
-		POKE32(SYSTEM_CTRL, reg);
+		poke32(SYSTEM_CTRL, reg);
 	}
 
 	/* call 2d init */
@@ -512,7 +512,7 @@ int hw_sm750le_deWait(void)
 		DE_STATE2_DE_MEM_FIFO_EMPTY;
 
 	while (i--) {
-		unsigned int val = PEEK32(DE_STATE2);
+		unsigned int val = peek32(DE_STATE2);
 
 		if ((val & mask) =
 		    (DE_STATE2_DE_FIFO_EMPTY | DE_STATE2_DE_MEM_FIFO_EMPTY))
@@ -530,7 +530,7 @@ int hw_sm750_deWait(void)
 		SYSTEM_CTRL_DE_MEM_FIFO_EMPTY;
 
 	while (i--) {
-		unsigned int val = PEEK32(SYSTEM_CTRL);
+		unsigned int val = peek32(SYSTEM_CTRL);
 
 		if ((val & mask) =
 		    (SYSTEM_CTRL_DE_FIFO_EMPTY | SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
@@ -555,12 +555,12 @@ int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 		((var->xoffset * var->bits_per_pixel) >> 3);
 	total += crtc->oScreen;
 	if (crtc->channel = sm750_primary) {
-		POKE32(PANEL_FB_ADDRESS,
-		       PEEK32(PANEL_FB_ADDRESS) |
+		poke32(PANEL_FB_ADDRESS,
+		       peek32(PANEL_FB_ADDRESS) |
 		       (total & PANEL_FB_ADDRESS_ADDRESS_MASK));
 	} else {
-		POKE32(CRT_FB_ADDRESS,
-		       PEEK32(CRT_FB_ADDRESS) |
+		poke32(CRT_FB_ADDRESS,
+		       peek32(CRT_FB_ADDRESS) |
 		       (total & CRT_FB_ADDRESS_ADDRESS_MASK));
 	}
 	return 0;
-- 
Matthieu

