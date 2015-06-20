From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Sat, 20 Jun 2015 05:37:18 +0000
Subject: [PATCH] Staging: sm750fb: Fix C99 Comments
Message-Id: <20150620052517.GA17104@amitoj-Inspiron-3542>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434092837-10290-1-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1434092837-10290-1-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Used C89 instead of C99 Comments and removed C99 comments performing
prints only.
Problem found using checkpatch.pl

ERROR: do not use C99 // comments

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 3cb860c..1683b3d 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -17,7 +17,7 @@ logical_chip_type_t getChipType(void)
 	char physicalRev;
 	logical_chip_type_t chip;
 
-	physicalID = devId750;//either 0x718 or 0x750
+	physicalID = devId750; /* either 0x718 or 0x750 */
 	physicalRev = revId750;
 
 	if (physicalID = 0x718)
@@ -257,7 +257,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 
 	unsigned int ulReg;
 #if 0
-	//move the code to map regiter function.
+	/* move the code to map regiter function. */
 	if (getChipType() = SM718) {
 		/* turn on big endian bit*/
 		ulReg = PEEK32(0x74);
@@ -488,7 +488,6 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 		}
 	}
 
-	//printk("Finally:  pll->n[%lu],m[%lu],od[%lu],pod[%lu]\n",pll->N,pll->M,pll->OD,pll->POD);
 	return ret;
 }
 
@@ -580,14 +579,9 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 	}
 
     /* Restore input frequency from Khz to hz unit */
-//    pPLL->inputFreq *= 1000;
 	ulRequestClk *= 1000;
 	pPLL->inputFreq = DEFAULT_INPUT_CLOCK; /* Default reference clock */
 
-    /* Output debug information */
-	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Requested Frequency = %d\n", ulRequestClk));
-	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));
-
     /* Return actual frequency that the PLL can set */
 	ret = calcPLL(pPLL);
 	return ret;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
