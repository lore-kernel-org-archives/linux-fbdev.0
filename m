From: Richa Jha <richaj@cdac.in>
Date: Thu, 25 May 2017 07:50:56 +0000
Subject: [PATCH] staging : sm750fb : Replace CamelCase variable names and hungarian prefx
Message-Id: <1495697936-19959-1-git-send-email-richaj@cdac.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Richa Jha <richaj@cdac.in>


Replace CamelCase variable names with underscores and remove 
 hungarian prefixes to comply with the standard kernel coding style

Signed-off-by: Richa Jha <richaj@cdac.in>
---
 drivers/staging/sm750fb/ddk750_chip.c | 59 ++++++++++++++++++-----------------
 drivers/staging/sm750fb/ddk750_chip.h | 18 +++++------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 5e4bfb6..f2c89fc 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -14,14 +14,14 @@ logical_chip_type_t sm750_get_chip_type(void)
 	return chip;
 }
 
-void sm750_set_chip_type(unsigned short devId, u8 revId)
+void sm750_set_chip_type(unsigned short dev_id, u8 rev_id)
 {
-	if (devId = 0x718) {
+	if (dev_id = 0x718) {
 		chip = SM718;
-	} else if (devId = 0x750) {
+	} else if (dev_id = 0x750) {
 		chip = SM750;
 		/* SM750 and SM750LE are different in their revision ID only. */
-		if (revId = SM750LE_REVISION_ID) {
+		if (rev_id = SM750LE_REVISION_ID) {
 			chip = SM750LE;
 			pr_info("found sm750le\n");
 		}
@@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
 static void set_chip_clock(unsigned int frequency)
 {
 	struct pll_value pll;
-	unsigned int ulActualMxClk;
+	unsigned int actual_max_clk;
 
 	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
 	if (sm750_get_chip_type() = SM750LE)
@@ -65,8 +65,8 @@ static void set_chip_clock(unsigned int frequency)
 		/*
 		 * Set up PLL structure to hold the value to be set in clocks.
 		 */
-		pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
-		pll.clockType = MXCLK_PLL;
+		pll.input_freq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
+		pll.clock_type = MXCLK_PLL;
 
 		/*
 		 * Call sm750_calc_pll_value() to fill the other fields
@@ -75,7 +75,7 @@ static void set_chip_clock(unsigned int frequency)
 		 * Return value of sm750_calc_pll_value gives the actual
 		 * possible clock.
 		 */
-		ulActualMxClk = sm750_calc_pll_value(frequency, &pll);
+		actual_max_clk = sm750_calc_pll_value(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
 		poke32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
@@ -210,13 +210,13 @@ unsigned int ddk750_get_vm_size(void)
 	return data;
 }
 
-int ddk750_init_hw(struct initchip_param *pInitParam)
+int ddk750_init_hw(struct initchip_param *init_param)
 {
 	unsigned int reg;
 
-	if (pInitParam->powerMode != 0)
-		pInitParam->powerMode = 0;
-	sm750_set_power_mode(pInitParam->powerMode);
+	if (init_param->power_mode != 0)
+		init_param->power_mode = 0;
+	sm750_set_power_mode(init_param->power_mode);
 
 	/* Enable display power gate & LOCALMEM power gate*/
 	reg = peek32(CURRENT_GATE);
@@ -237,13 +237,13 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	}
 
 	/* Set the Main Chip Clock */
-	set_chip_clock(MHz((unsigned int)pInitParam->chipClock));
+	set_chip_clock(MHz((unsigned int)init_param->chip_clock));
 
 	/* Set up memory clock. */
-	set_memory_clock(MHz(pInitParam->memClock));
+	set_memory_clock(MHz(init_param->mem_clock));
 
 	/* Set up master clock */
-	set_master_clock(MHz(pInitParam->masterClock));
+	set_master_clock(MHz(init_param->master_clock));
 
 	/*
 	 * Reset the memory controller.
@@ -251,7 +251,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	 * the system might hang when sw accesses the memory.
 	 * The memory should be resetted after changing the MXCLK.
 	 */
-	if (pInitParam->resetMemory = 1) {
+	if (init_param->reset_memory = 1) {
 		reg = peek32(MISC_CTRL);
 		reg &= ~MISC_CTRL_LOCALMEM_RESET;
 		poke32(MISC_CTRL, reg);
@@ -260,7 +260,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 		poke32(MISC_CTRL, reg);
 	}
 
-	if (pInitParam->setAllEngOff = 1) {
+	if (init_param->set_all_eng_off = 1) {
 		sm750_enable_2d_engine(0);
 
 		/* Disable Overlay, if a former application left it on */
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
@@ -319,7 +320,7 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *p
 	int mini_diff;
 	unsigned int RN, quo, rem, fl_quo;
 	unsigned int input, request;
-	unsigned int tmpClock, ret;
+	unsigned int tmp_clock, ret;
 	const int max_OD = 3;
 	int max_d = 6;
 
@@ -335,13 +336,13 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *p
 	ret = 0;
 	mini_diff = ~0;
 	request = request_orig / 1000;
-	input = pll->inputFreq / 1000;
+	input = pll->input_freq / 1000;
 
 	/*
 	 * for MXCLK register,
 	 * no POD provided, so need be treated differently
 	 */
-	if (pll->clockType = MXCLK_PLL)
+	if (pll->clock_type = MXCLK_PLL)
 		max_d = 3;
 
 	for (N = 15; N > 1; N--) {
@@ -363,8 +364,8 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *p
 			if (M < 256 && M > 0) {
 				unsigned int diff;
 
-				tmpClock = pll->inputFreq * M / N / X;
-				diff = abs(tmpClock - request_orig);
+				tmp_clock = pll->input_freq * M / N / X;
+				diff = abs(tmp_clock - request_orig);
 				if (diff < mini_diff) {
 					pll->M = M;
 					pll->N = N;
@@ -373,7 +374,7 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *p
 						pll->POD = d - max_OD;
 					pll->OD = d - pll->POD;
 					mini_diff = diff;
-					ret = tmpClock;
+					ret = tmp_clock;
 				}
 			}
 		}
@@ -381,14 +382,14 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig, struct pll_value *p
 	return ret;
 }
 
-unsigned int sm750_format_pll_reg(struct pll_value *pPLL)
+unsigned int sm750_format_pll_reg(struct pll_value *pll)
 {
 #ifndef VALIDATION_CHIP
-	unsigned int POD = pPLL->POD;
+	unsigned int POD = pll->POD;
 #endif
-	unsigned int OD = pPLL->OD;
-	unsigned int M = pPLL->M;
-	unsigned int N = pPLL->N;
+	unsigned int OD = pll->OD;
+	unsigned int M = pll->M;
+	unsigned int N = pll->N;
 	unsigned int reg = 0;
 
 	/*
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 2c7a9b9..069a244 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -41,10 +41,10 @@ typedef enum _clock_type_t {
 clock_type_t;
 
 struct pll_value {
-	clock_type_t clockType;
-	unsigned long inputFreq; /* Input clock frequency to the PLL */
+	clock_type_t clock_type;
+	unsigned long input_freq; /* Input clock frequency to the PLL */
 
-	/* Use this when clockType = PANEL_PLL */
+	/* Use this when clock_type = PANEL_PLL */
 	unsigned long M;
 	unsigned long N;
 	unsigned long OD;
@@ -54,41 +54,41 @@ struct pll_value {
 /* input struct to initChipParam() function */
 struct initchip_param {
 	/* Use power mode 0 or 1 */
-	unsigned short powerMode;
+	unsigned short power_mode;
 
 	/*
 	 * Speed of main chip clock in MHz unit
 	 * 0 = keep the current clock setting
 	 * Others = the new main chip clock
 	 */
-	unsigned short chipClock;
+	unsigned short chip_clock;
 
 	/*
 	 * Speed of memory clock in MHz unit
 	 * 0 = keep the current clock setting
 	 * Others = the new memory clock
 	 */
-	unsigned short memClock;
+	unsigned short mem_clock;
 
 	/*
 	 * Speed of master clock in MHz unit
 	 * 0 = keep the current clock setting
 	 * Others = the new master clock
 	 */
-	unsigned short masterClock;
+	unsigned short master_clock;
 
 	/*
 	 * 0 = leave all engine state untouched.
 	 * 1 = make sure they are off: 2D, Overlay,
 	 * video alpha, alpha, hardware cursors
 	 */
-	unsigned short setAllEngOff;
+	unsigned short set_all_eng_off;
 
 	/*
 	 * 0 = Do not reset the memory controller
 	 * 1 = Reset the memory controller
 	 */
-	unsigned char resetMemory;
+	unsigned char reset_memory;
 
 	/* More initialization parameter can be added if needed */
 };
-- 
2.1.4


-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------

