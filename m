From: Ragavendra Nagraj <ragavendra.bn@gmail.com>
Date: Tue, 24 Mar 2015 04:51:54 +0000
Subject: [PATCH] staging: sm750fb: Fixed C99 comments warnings
Message-Id: <20150324045154.GA12298@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch fixes the C99-style "// ..." comments warnings identified by the
checkpath.pl script for the entire ddk750_chip.c file by using the
appropriate C89 "/* ... */" style comments accordingly.

Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 02f9326..1fb00a4 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -17,7 +17,7 @@ logical_chip_type_t getChipType(void)
 	char physicalRev;
 	logical_chip_type_t chip;
 
-	physicalID = devId750;//either 0x718 or 0x750
+	physicalID = devId750;/*either 0x718 or 0x750*/
 	physicalRev = revId750;
 
 	if (physicalID = 0x718)
@@ -264,7 +264,7 @@ int ddk750_initHw(initchip_param_t * pInitParam)
 
 	unsigned int ulReg;
 #if 0
-	//move the code to map regiter function.
+	/*move the code to map regiter function.*/
 	if(getChipType() = SM718){
 		/* turn on big endian bit*/
 		ulReg = PEEK32(0x74);
@@ -501,7 +501,7 @@ unsigned int calcPllValue(unsigned int request_orig,pll_value_t *pll)
 		}
 	}
 
-	//printk("Finally:  pll->n[%lu],m[%lu],od[%lu],pod[%lu]\n",pll->N,pll->M,pll->OD,pll->POD);
+	/*printk("Finally:  pll->n[%lu],m[%lu],od[%lu],pod[%lu]\n",pll->N,pll->M,pll->OD,pll->POD);*/
 	return ret;
 }
 
@@ -597,13 +597,13 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 	}
 
     /* Restore input frequency from Khz to hz unit */
-//    pPLL->inputFreq *= 1000;
+/*    pPLL->inputFreq *= 1000;*/
 	ulRequestClk *= 1000;
 	pPLL->inputFreq = DEFAULT_INPUT_CLOCK; /* Default reference clock */
 
     /* Output debug information */
-	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Requested Frequency = %d\n", ulRequestClk));
-	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));
+	/*DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Requested Frequency = %d\n", ulRequestClk));*/
+	/*DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));*/
 
     /* Return actual frequency that the PLL can set */
 	ret = calcPLL(pPLL);
-- 
1.7.10.4

