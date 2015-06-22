From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Mon, 22 Jun 2015 07:26:25 +0000
Subject: [PATCH] staging: sm750fb: remove unused variables
Message-Id: <20150622072017.GA32220@IND12F0122>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>

This patch removes unused variables as reported by cppcheck

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
 drivers/staging/sm750fb/ddk750_chip.c   | 3 +--
 drivers/staging/sm750fb/ddk750_mode.c   | 3 +--
 drivers/staging/sm750fb/ddk750_sii164.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f4975d2..e8ac6e6 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -103,7 +103,6 @@ unsigned int getChipClock(void)
 void setChipClock(unsigned int frequency)
 {
 	pll_value_t pll;
-	unsigned int ulActualMxClk;
 #if 1
 	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
 	if (getChipType() = SM750LE)
@@ -122,7 +121,7 @@ void setChipClock(unsigned int frequency)
 		* Sometime, the chip cannot set up the exact clock required by User.
 		* Return value from calcPllValue() gives the actual possible clock.
 		*/
-		ulActualMxClk = calcPllValue(frequency, &pll);
+		calcPllValue(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
 		POKE32(MXCLK_PLL_CTRL, formatPllReg(&pll));
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 74313ff..e67e1e9 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -188,11 +188,10 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 {
 	pll_value_t pll;
-	unsigned int uiActualPixelClk;
 	pll.inputFreq = DEFAULT_INPUT_CLOCK;
 	pll.clockType = clock;
 
-	uiActualPixelClk = calcPllValue(parm->pixel_clock, &pll);
+	calcPllValue(parm->pixel_clock, &pll);
 	if(getChipType() = SM750LE){
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index b6395b8..2ac3470 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -345,8 +345,7 @@ void sii164EnableHotPlugDetection(
     unsigned char enableHotPlug
 )
 {
-    unsigned char detectReg;
-    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+    i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
 
     /* Depending on each DVI controller, need to enable the hot plug based on each
        individual chip design. */
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
