From: Richa Jha <richaj@cdac.in>
Date: Mon, 22 May 2017 12:23:31 +0000
Subject: [PATCH] Fixed cameCase check in file  drivers/staging/sm750fb/ddk750_chip.c
Message-Id: <1495455091-25431-1-git-send-email-richaj@cdac.in>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495449937-24573-1-git-send-email-richaj@cdac.in>
In-Reply-To: <1495449937-24573-1-git-send-email-richaj@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Richa Jha <richaj@cdac.in>

Changes :

ulActualMxClk ---> ul_actual_max_clk
pInitParam    ---> p_init_param

Signed-off-by: Richa Jha <richaj@cdac.in>
---
 drivers/staging/sm750fb/ddk750_chip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 7b1180a..00bca17 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
 static void set_chip_clock(unsigned int frequency)
 {
 	struct pll_value pll;
-	unsigned int ulActualMxClk;
+	unsigned int ul_actual_max_clk;
 
 	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
 	if (sm750_get_chip_type() = SM750LE)
@@ -75,7 +75,7 @@ static void set_chip_clock(unsigned int frequency)
 		 * Return value of sm750_calc_pll_value gives the actual
 		 * possible clock.
 		 */
-		ulActualMxClk = sm750_calc_pll_value(frequency, &pll);
+		ul_actual_max_clk = sm750_calc_pll_value(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
 		poke32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
@@ -210,11 +210,11 @@ unsigned int ddk750_get_vm_size(void)
 	return data;
 }
 
-int ddk750_init_hw(struct initchip_param *pInitParam)
+int ddk750_init_hw(struct initchip_param *p_init_param)
 {
 	unsigned int reg;
 
-	if (pInitParam->powerMode != 0)
+	if (p_init_param->powerMode != 0)
 		p_init_param->powerMode = 0;
 	sm750_set_power_mode(p_init_param->powerMode);
 
@@ -237,13 +237,13 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	}
 
 	/* Set the Main Chip Clock */
-	set_chip_clock(MHz((unsigned int)pInitParam->chipClock));
+	set_chip_clock(MHz((unsigned int)p_init_param->chipClock));
 
 	/* Set up memory clock. */
-	set_memory_clock(MHz(pInitParam->memClock));
+	set_memory_clock(MHz(p_init_param->memClock));
 
 	/* Set up master clock */
-	set_master_clock(MHz(pInitParam->masterClock));
+	set_master_clock(MHz(p_init_param->masterClock));
 
 	/*
 	 * Reset the memory controller.
@@ -251,7 +251,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	 * the system might hang when sw accesses the memory.
 	 * The memory should be resetted after changing the MXCLK.
 	 */
-	if (pInitParam->resetMemory = 1) {
+	if (p_init_param->resetMemory = 1) {
 		reg = peek32(MISC_CTRL);
 		reg &= ~MISC_CTRL_LOCALMEM_RESET;
 		poke32(MISC_CTRL, reg);
@@ -260,7 +260,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 		poke32(MISC_CTRL, reg);
 	}
 
-	if (pInitParam->setAllEngOff = 1) {
+	if (p_init_param->setAllEngOff = 1) {
 		sm750_enable_2d_engine(0);
 
 		/* Disable Overlay, if a former application left it on */
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

