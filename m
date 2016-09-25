From: Moshe Green <mgmoshes@gmail.com>
Date: Sun, 25 Sep 2016 19:58:35 +0000
Subject: [PATCH] staging: sm750fb: rename getChipType to sm750_get_chip_type
Message-Id: <17c430c018479bec0e4c631144cbe5a3be48b133.1474833463.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9a9ab953f0c55df0ffe75a7a3c35ba6dc9e2f742.1474568117.git.mgmoshes@gmail.com>
In-Reply-To: <9a9ab953f0c55df0ffe75a7a3c35ba6dc9e2f742.1474568117.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Rename CamelCased function getChipType to sm750_get_chip_type
(prefex with sm750 in order to make the context of
the function clear).

This issue was found by checkpatch.pl

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  | 16 ++++++++--------
 drivers/staging/sm750fb/ddk750_chip.h  |  2 +-
 drivers/staging/sm750fb/ddk750_mode.c  |  4 ++--
 drivers/staging/sm750fb/ddk750_power.c |  6 +++---
 drivers/staging/sm750fb/ddk750_swi2c.c |  2 +-
 drivers/staging/sm750fb/sm750_hw.c     |  8 ++++----
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index a887f32..3a0afe1 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -10,7 +10,7 @@
 #define roundedDiv(num, denom)	((2 * (num) + (denom)) / (2 * (denom)))
 #define MHz(x) ((x) * 1000000)
 
-logical_chip_type_t getChipType(void)
+logical_chip_type_t sm750_get_chip_type(void)
 {
 	unsigned short physicalID;
 	char physicalRev;
@@ -37,7 +37,7 @@ static unsigned int get_mxclk_freq(void)
 	unsigned int pll_reg;
 	unsigned int M, N, OD, POD;
 
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return MHz(130);
 
 	pll_reg = PEEK32(MXCLK_PLL_CTRL);
@@ -60,7 +60,7 @@ static void setChipClock(unsigned int frequency)
 	unsigned int ulActualMxClk;
 
 	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return;
 
 	if (frequency) {
@@ -90,7 +90,7 @@ static void setMemoryClock(unsigned int frequency)
 	/* Cheok_0509: For SM750LE, the memory clock is fixed.
 	 * Nothing to set.
 	 */
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return;
 
 	if (frequency) {
@@ -141,7 +141,7 @@ static void setMasterClock(unsigned int frequency)
 	/* Cheok_0509: For SM750LE, the memory clock is fixed.
 	 * Nothing to set.
 	 */
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return;
 
 	if (frequency) {
@@ -182,7 +182,7 @@ unsigned int ddk750_getVMSize(void)
 	unsigned int data;
 
 	/* sm750le only use 64 mb memory*/
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return SZ_64M;
 
 	/* for 750,always use power mode0*/
@@ -221,7 +221,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 	reg |= (CURRENT_GATE_DISPLAY | CURRENT_GATE_LOCALMEM);
 	setCurrentGate(reg);
 
-	if (getChipType() != SM750LE) {
+	if (sm750_get_chip_type() != SM750LE) {
 		/*	set panel pll and graphic mode via mmio_88 */
 		reg = PEEK32(VGA_CONFIGURATION);
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
@@ -320,7 +320,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	const int max_OD = 3;
 	int max_d = 6;
 
-	if (getChipType() = SM750LE) {
+	if (sm750_get_chip_type() = SM750LE) {
 		/* SM750LE don't have
 		 * programmable PLL and M/N values to work on.
 		 * Just return the requested clock.
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 0891384..14357fd 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -69,7 +69,7 @@ typedef struct _initchip_param_t {
 }
 initchip_param_t;
 
-logical_chip_type_t getChipType(void);
+logical_chip_type_t sm750_get_chip_type(void);
 unsigned int calcPllValue(unsigned int request, pll_value_t *pll);
 unsigned int formatPllReg(pll_value_t *pPLL);
 void ddk750_set_mmio(void __iomem *, unsigned short, char);
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index e29d4bd..b767c7d 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -117,7 +117,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		if (pModeParam->horizontal_sync_polarity)
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
 
-		if (getChipType() = SM750LE) {
+		if (sm750_get_chip_type() = SM750LE) {
 			displayControlAdjust_SM750LE(pModeParam, tmp);
 		} else {
 			reg = PEEK32(CRT_DISPLAY_CTRL) &
@@ -209,7 +209,7 @@ int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 	pll.clockType = clock;
 
 	uiActualPixelClk = calcPllValue(parm->pixel_clock, &pll);
-	if (getChipType() = SM750LE) {
+	if (sm750_get_chip_type() = SM750LE) {
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index b3c3791..7cc6169 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -6,7 +6,7 @@ void ddk750_setDPMS(DPMS_t state)
 {
 	unsigned int value;
 
-	if (getChipType() = SM750LE) {
+	if (sm750_get_chip_type() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL) & ~CRT_DISPLAY_CTRL_DPMS_MASK;
 		value |= (state << CRT_DISPLAY_CTRL_DPMS_SHIFT);
 		POKE32(CRT_DISPLAY_CTRL, value);
@@ -19,7 +19,7 @@ void ddk750_setDPMS(DPMS_t state)
 
 static unsigned int getPowerMode(void)
 {
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return 0;
 	return PEEK32(POWER_MODE_CTRL) & POWER_MODE_CTRL_MODE_MASK;
 }
@@ -35,7 +35,7 @@ void setPowerMode(unsigned int powerMode)
 
 	control_value = PEEK32(POWER_MODE_CTRL) & ~POWER_MODE_CTRL_MODE_MASK;
 
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return;
 
 	switch (powerMode) {
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 8d644a7..6c1ffa1 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -403,7 +403,7 @@ long sm750_sw_i2c_init(
 	if ((clk_gpio > 31) || (data_gpio > 31))
 		return -1;
 
-	if (getChipType() = SM750LE)
+	if (sm750_get_chip_type() = SM750LE)
 		return sm750le_i2c_init(clk_gpio, data_gpio);
 
 	/* Initialize the GPIO pin for the i2c Clock Register */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index bff7db5..7dd208c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -91,7 +91,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	parm = &sm750_dev->initParm;
 	if (parm->chip_clk = 0)
-		parm->chip_clk = (getChipType() = SM750LE) ?
+		parm->chip_clk = (sm750_get_chip_type() = SM750LE) ?
 						DEFAULT_SM750LE_CHIP_CLOCK :
 						DEFAULT_SM750_CHIP_CLOCK;
 
@@ -107,7 +107,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		       PEEK32(SYSTEM_CTRL) | SYSTEM_CTRL_PCI_BURST);
 	}
 
-	if (getChipType() != SM750LE) {
+	if (sm750_get_chip_type() != SM750LE) {
 		unsigned int val;
 		/* does user need CRT? */
 		if (sm750_dev->nocrt) {
@@ -183,7 +183,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 	dispSet = 0;
 	channel = *output->channel;
 
-	if (getChipType() != SM750LE) {
+	if (sm750_get_chip_type() != SM750LE) {
 		if (channel = sm750_primary) {
 			pr_info("primary channel\n");
 			if (output->paths & sm750_panel)
@@ -471,7 +471,7 @@ void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
 
 	enable2DEngine(1);
 
-	if (getChipType() = SM750LE) {
+	if (sm750_get_chip_type() = SM750LE) {
 		reg = PEEK32(DE_STATE1);
 		reg |= DE_STATE1_DE_ABORT;
 		POKE32(DE_STATE1, reg);
-- 
2.7.4

