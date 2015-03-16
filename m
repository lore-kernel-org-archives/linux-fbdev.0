From: Ragavendra Nagraj <ragavendra.bn@gmail.com>
Date: Mon, 16 Mar 2015 00:21:09 +0000
Subject: [PATCH] staging:sm750fb:Fixed no space and indent warnings
Message-Id: <20150316002109.GA6640@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch fixes the no spaces and indent warnings identified by the
checkpath.pl script for the entire ddk750_chip.c file by using appropriate tab
spaces and indents accordingly.

Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c |  454 ++++++++++++++++-----------------
 1 file changed, 227 insertions(+), 227 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index b71169e..5c9a118 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -20,22 +20,22 @@ logical_chip_type_t getChipType()
 	physicalID = devId750;//either 0x718 or 0x750
 	physicalRev = revId750;
 
-    if (physicalID = 0x718)
-    {
-        chip = SM718;
-    }
-    else if (physicalID = 0x750)
-    {
-        chip = SM750;
+	if (physicalID = 0x718)
+	{
+		chip = SM718;
+	}
+	else if (physicalID = 0x750)
+	{
+		chip = SM750;
 		/* SM750 and SM750LE are different in their revision ID only. */
 		if (physicalRev = SM750LE_REVISION_ID){
 			chip = SM750LE;
 		}
-    }
-    else
-    {
-        chip = SM_UNKNOWN;
-    }
+	}
+	else
+	{
+		chip = SM_UNKNOWN;
+	}
 
 	return chip;
 }
@@ -43,63 +43,63 @@ logical_chip_type_t getChipType()
 
 inline unsigned int twoToPowerOfx(unsigned long x)
 {
-    unsigned long i;
-    unsigned long result = 1;
+	unsigned long i;
+	unsigned long result = 1;
 
-    for (i=1; i<=x; i++)
-        result *= 2;
-    return result;
+	for (i=1; i<=x; i++)
+		result *= 2;
+	return result;
 }
 
 inline unsigned int calcPLL(pll_value_t *pPLL)
 {
-    return (pPLL->inputFreq * pPLL->M / pPLL->N / twoToPowerOfx(pPLL->OD) / twoToPowerOfx(pPLL->POD));
+	return (pPLL->inputFreq * pPLL->M / pPLL->N / twoToPowerOfx(pPLL->OD) / twoToPowerOfx(pPLL->POD));
 }
 
 unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL)
 {
-    unsigned int ulPllReg = 0;
-
-    pPLL->inputFreq = DEFAULT_INPUT_CLOCK;
-    pPLL->clockType = clockType;
-
-    switch (clockType)
-    {
-        case MXCLK_PLL:
-            ulPllReg = PEEK32(MXCLK_PLL_CTRL);
-            break;
-        case PRIMARY_PLL:
-            ulPllReg = PEEK32(PANEL_PLL_CTRL);
-            break;
-        case SECONDARY_PLL:
-            ulPllReg = PEEK32(CRT_PLL_CTRL);
-            break;
-        case VGA0_PLL:
-            ulPllReg = PEEK32(VGA_PLL0_CTRL);
-            break;
-        case VGA1_PLL:
-            ulPllReg = PEEK32(VGA_PLL1_CTRL);
-            break;
-    }
-
-    pPLL->M = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, M);
-    pPLL->N = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, N);
-    pPLL->OD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, OD);
-    pPLL->POD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, POD);
-
-    return calcPLL(pPLL);
+	unsigned int ulPllReg = 0;
+
+	pPLL->inputFreq = DEFAULT_INPUT_CLOCK;
+	pPLL->clockType = clockType;
+
+	switch (clockType)
+	{
+	case MXCLK_PLL:
+		ulPllReg = PEEK32(MXCLK_PLL_CTRL);
+		break;
+	case PRIMARY_PLL:
+		ulPllReg = PEEK32(PANEL_PLL_CTRL);
+		break;
+	case SECONDARY_PLL:
+		ulPllReg = PEEK32(CRT_PLL_CTRL);
+		break;
+	case VGA0_PLL:
+		ulPllReg = PEEK32(VGA_PLL0_CTRL);
+		break;
+	case VGA1_PLL:
+		ulPllReg = PEEK32(VGA_PLL1_CTRL);
+		break;
+	}
+
+	pPLL->M = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, M);
+	pPLL->N = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, N);
+	pPLL->OD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, OD);
+	pPLL->POD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, POD);
+
+	return calcPLL(pPLL);
 }
 
 
 unsigned int getChipClock()
 {
-    pll_value_t pll;
+	pll_value_t pll;
 #if 1
 	if(getChipType() = SM750LE)
 		return MHz(130);
 #endif
 
-    return getPllValue(MXCLK_PLL, &pll);
+	return getPllValue(MXCLK_PLL, &pll);
 }
 
 
@@ -110,75 +110,75 @@ unsigned int getChipClock()
  */
 void setChipClock(unsigned int frequency)
 {
-    pll_value_t pll;
-    unsigned int ulActualMxClk;
+	pll_value_t pll;
+	unsigned int ulActualMxClk;
 #if 1
 		/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
 		if (getChipType() = SM750LE)
 			return;
 #endif
 
-    if (frequency != 0)
-    {
-        /*
-         * Set up PLL, a structure to hold the value to be set in clocks.
-         */
-        pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
-        pll.clockType = MXCLK_PLL;
-
-        /*
-         * Call calcPllValue() to fill up the other fields for PLL structure.
-         * Sometime, the chip cannot set up the exact clock required by User.
-         * Return value from calcPllValue() gives the actual possible clock.
-         */
-        ulActualMxClk = calcPllValue(frequency, &pll);
-
-        /* Master Clock Control: MXCLK_PLL */
-        POKE32(MXCLK_PLL_CTRL, formatPllReg(&pll));
-    }
+	if (frequency != 0)
+		{
+		/*
+		* Set up PLL, a structure to hold the value to be set in clocks.
+		*/
+		pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
+		pll.clockType = MXCLK_PLL;
+
+		/*
+		* Call calcPllValue() to fill up the other fields for PLL structure.
+		* Sometime, the chip cannot set up the exact clock required by User.
+		* Return value from calcPllValue() gives the actual possible clock.
+		*/
+		ulActualMxClk = calcPllValue(frequency, &pll);
+
+		/* Master Clock Control: MXCLK_PLL */
+		POKE32(MXCLK_PLL_CTRL, formatPllReg(&pll));
+	}
 }
 
 
 
 void setMemoryClock(unsigned int frequency)
 {
-    unsigned int ulReg, divisor;
+	unsigned int ulReg, divisor;
  #if 1
 	/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
 	if (getChipType() = SM750LE)
 		return;
 #endif
-    if (frequency != 0)
-    {
-        /* Set the frequency to the maximum frequency that the DDR Memory can take
-           which is 336MHz. */
-        if (frequency > MHz(336))
-            frequency = MHz(336);
-
-        /* Calculate the divisor */
-        divisor = (unsigned int) roundedDiv(getChipClock(), frequency);
-
-        /* Set the corresponding divisor in the register. */
-        ulReg = PEEK32(CURRENT_GATE);
-        switch(divisor)
-        {
-            default:
-            case 1:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_1);
-                break;
-            case 2:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_2);
-                break;
-            case 3:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_3);
-                break;
-            case 4:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_4);
-                break;
-        }
-
-        setCurrentGate(ulReg);
-    }
+	if (frequency != 0)
+		{
+		/* Set the frequency to the maximum frequency that the DDR Memory can take
+		which is 336MHz. */
+		if (frequency > MHz(336))
+			frequency = MHz(336);
+
+		/* Calculate the divisor */
+		divisor = (unsigned int) roundedDiv(getChipClock(), frequency);
+
+		/* Set the corresponding divisor in the register. */
+		ulReg = PEEK32(CURRENT_GATE);
+		switch(divisor)
+		{
+			default:
+			case 1:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_1);
+				break;
+			case 2:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_2);
+				break;
+			case 3:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_3);
+				break;
+			case 4:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, M2XCLK, DIV_4);
+				break;
+		}
+
+		setCurrentGate(ulReg);
+		}
 }
 
 
@@ -192,43 +192,43 @@ void setMemoryClock(unsigned int frequency)
  */
 void setMasterClock(unsigned int frequency)
 {
-    unsigned int ulReg, divisor;
+	unsigned int ulReg, divisor;
   #if 1
 	/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
 	if (getChipType() = SM750LE)
 		return;
 #endif
-    if (frequency != 0)
-    {
-        /* Set the frequency to the maximum frequency that the SM750 engine can
-           run, which is about 190 MHz. */
-        if (frequency > MHz(190))
-            frequency = MHz(190);
-
-        /* Calculate the divisor */
-        divisor = (unsigned int) roundedDiv(getChipClock(), frequency);
-
-        /* Set the corresponding divisor in the register. */
-        ulReg = PEEK32(CURRENT_GATE);
-        switch(divisor)
-        {
-            default:
-            case 3:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_3);
-                break;
-            case 4:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_4);
-                break;
-            case 6:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_6);
-                break;
-            case 8:
-                ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_8);
-                break;
-        }
-
-        setCurrentGate(ulReg);
-    }
+	if (frequency != 0)
+		{
+		/* Set the frequency to the maximum frequency that the SM750 engine can
+		run, which is about 190 MHz. */
+		if (frequency > MHz(190))
+			frequency = MHz(190);
+
+		/* Calculate the divisor */
+		divisor = (unsigned int) roundedDiv(getChipClock(), frequency);
+
+		/* Set the corresponding divisor in the register. */
+		ulReg = PEEK32(CURRENT_GATE);
+		switch(divisor)
+		{
+			default:
+			case 3:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_3);
+				break;
+			case 4:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_4);
+				break;
+			case 6:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_6);
+				break;
+			case 8:
+				ulReg = FIELD_SET(ulReg, CURRENT_GATE, MCLK, DIV_8);
+				break;
+		}
+
+		setCurrentGate(ulReg);
+		}
 }
 
 
@@ -249,11 +249,11 @@ unsigned int ddk750_getVMSize()
 	/* get frame buffer size from GPIO */
 	reg = FIELD_GET(PEEK32(MISC_CTRL),MISC_CTRL,LOCALMEM_SIZE);
 	switch(reg){
-        case MISC_CTRL_LOCALMEM_SIZE_8M:  data = MB(8);  break; /* 8  Mega byte */
-        case MISC_CTRL_LOCALMEM_SIZE_16M: data = MB(16); break; /* 16 Mega byte */
-        case MISC_CTRL_LOCALMEM_SIZE_32M: data = MB(32); break; /* 32 Mega byte */
-        case MISC_CTRL_LOCALMEM_SIZE_64M: data = MB(64); break; /* 64 Mega byte */
-		default: data = 0;break;
+	case MISC_CTRL_LOCALMEM_SIZE_8M:  data = MB(8);  break; /* 8  Mega byte */
+	case MISC_CTRL_LOCALMEM_SIZE_16M: data = MB(16); break; /* 16 Mega byte */
+	case MISC_CTRL_LOCALMEM_SIZE_32M: data = MB(32); break; /* 32 Mega byte */
+	case MISC_CTRL_LOCALMEM_SIZE_64M: data = MB(64); break; /* 64 Mega byte */
+	default: data = 0;break;
 	}
 	return data;
 
@@ -391,10 +391,10 @@ int ddk750_initHw(initchip_param_t * pInitParam)
 
 unsigned int absDiff(unsigned int a, unsigned int b)
 {
-    if ( a > b )
-        return(a - b);
-    else
-        return(b - a);
+	if ( a > b )
+		return(a - b);
+	else
+	return(b - a);
 }
 
 #endif
@@ -435,7 +435,7 @@ unsigned int calcPllValue(unsigned int request_orig,pll_value_t *pll)
 							{3,0,3,8},
 							};
 
-	/* 	as sm750 register definition, N located in 2,15 and M located in 1,255	*/
+	/* as sm750 register definition, N located in 2,15 and M located in 1,255	*/
 	int N,M,X,d;
 	int xcnt;
 	int miniDiff;
@@ -446,11 +446,11 @@ unsigned int calcPllValue(unsigned int request_orig,pll_value_t *pll)
 
 #if 1
 	if (getChipType() = SM750LE)
-    {
-        /* SM750LE don't have prgrammable PLL and M/N values to work on.
-           Just return the requested clock. */
-        return request_orig;
-    }
+	{
+		/* SM750LE don't have prgrammable PLL and M/N values to work on.
+		Just return the requested clock. */
+		return request_orig;
+	}
 #endif
 
 	ret = 0;
@@ -487,7 +487,7 @@ unsigned int calcPllValue(unsigned int request_orig,pll_value_t *pll)
 			{
 				unsigned int diff;
 				tmpClock = pll->inputFreq *M / N / X;
-                diff = absDiff(tmpClock,request_orig);
+				diff = absDiff(tmpClock,request_orig);
 				if(diff < miniDiff)
 				{
 					pll->M = M;
@@ -510,104 +510,104 @@ unsigned int ulRequestClk, /* Required pixel clock in Hz unit */
 pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 )
 {
-    unsigned int M, N, OD, POD = 0, diff, pllClk, odPower, podPower;
-    unsigned int bestDiff = 0xffffffff; /* biggest 32 bit unsigned number */
+	unsigned int M, N, OD, POD = 0, diff, pllClk, odPower, podPower;
+	unsigned int bestDiff = 0xffffffff; /* biggest 32 bit unsigned number */
 	unsigned int ret;
     /* Init PLL structure to know states */
-    pPLL->M = 0;
-    pPLL->N = 0;
-    pPLL->OD = 0;
-    pPLL->POD = 0;
+	pPLL->M = 0;
+	pPLL->N = 0;
+	pPLL->OD = 0;
+	pPLL->POD = 0;
 
     /* Sanity check: None at the moment */
 
     /* Convert everything in Khz range in order to avoid calculation overflow */
-    pPLL->inputFreq /= 1000;
-    ulRequestClk /= 1000;
+	pPLL->inputFreq /= 1000;
+	ulRequestClk /= 1000;
 
 #ifndef VALIDATION_CHIP
     /* The maximum of post divider is 8. */
-    for (POD=0; POD<=3; POD++)
+	for (POD=0; POD<=3; POD++)
 #endif
-    {
+		{
 
 #ifndef VALIDATION_CHIP
-        /* MXCLK_PLL does not have post divider. */
-        if ((POD > 0) && (pPLL->clockType = MXCLK_PLL))
-            break;
+	/* MXCLK_PLL does not have post divider. */
+	if ((POD > 0) && (pPLL->clockType = MXCLK_PLL))
+		break;
 #endif
 
-        /* Work out 2 to the power of POD */
-        podPower = twoToPowerOfx(POD);
+	/* Work out 2 to the power of POD */
+	podPower = twoToPowerOfx(POD);
 
-        /* OD has only 2 bits [15:14] and its value must between 0 to 3 */
-        for (OD=0; OD<=3; OD++)
-        {
-            /* Work out 2 to the power of OD */
-            odPower = twoToPowerOfx(OD);
+	/* OD has only 2 bits [15:14] and its value must between 0 to 3 */
+	for (OD=0; OD<=3; OD++)
+		{
+		/* Work out 2 to the power of OD */
+		odPower = twoToPowerOfx(OD);
 
 #ifdef VALIDATION_CHIP
-            if (odPower > 4)
-                podPower = 4;
-            else
-                podPower = odPower;
+	if (odPower > 4)
+		podPower = 4;
+	else
+		podPower = odPower;
 #endif
 
-            /* N has 4 bits [11:8] and its value must between 2 and 15.
-               The N = 1 will behave differently --> Result is not correct. */
-            for (N=2; N<; N++)
-            {
-                /* The formula for PLL is ulRequestClk = inputFreq * M / N / (2^OD)
-                   In the following steps, we try to work out a best M value given the others are known.
-                   To avoid decimal calculation, we use 1000 as multiplier for up to 3 decimal places of accuracy.
-                */
-                M = ulRequestClk * N * odPower * 1000 / pPLL->inputFreq;
-                M = roundedDiv(M, 1000);
-
-                /* M field has only 8 bits, reject value bigger than 8 bits */
-                if (M < 256)
-                {
-                    /* Calculate the actual clock for a given M & N */
-                    pllClk = pPLL->inputFreq * M / N / odPower / podPower;
-
-                    /* How much are we different from the requirement */
-                    diff = absDiff(pllClk, ulRequestClk);
-
-                    if (diff < bestDiff)
-                    {
-                        bestDiff = diff;
-
-                        /* Store M and N values */
-                        pPLL->M  = M;
-                        pPLL->N  = N;
-                        pPLL->OD = OD;
+		/* N has 4 bits [11:8] and its value must between 2 and 15.
+		The N = 1 will behave differently --> Result is not correct. */
+	for (N=2; N<; N++)
+		{
+		/* The formula for PLL is ulRequestClk = inputFreq * M / N / (2^OD)
+		In the following steps, we try to work out a best M value given the others are known.
+		To avoid decimal calculation, we use 1000 as multiplier for up to 3 decimal places of accuracy.
+		*/
+		M = ulRequestClk * N * odPower * 1000 / pPLL->inputFreq;
+		M = roundedDiv(M, 1000);
+
+		/* M field has only 8 bits, reject value bigger than 8 bits */
+		if (M < 256)
+		{
+			/* Calculate the actual clock for a given M & N */
+			pllClk = pPLL->inputFreq * M / N / odPower / podPower;
+
+			/* How much are we different from the requirement */
+			diff = absDiff(pllClk, ulRequestClk);
+
+			if (diff < bestDiff)
+			{
+				bestDiff = diff;
+
+				/* Store M and N values */
+				pPLL->M  = M;
+				pPLL->N  = N;
+				pPLL->OD = OD;
 
 #ifdef VALIDATION_CHIP
-                        if (OD > 2)
-                            POD = 2;
-                        else
-                            POD = OD;
+			if (OD > 2)
+				POD = 2;
+			else
+				POD = OD;
 #endif
 
-                        pPLL->POD = POD;
-                    }
-                }
-            }
-        }
-    }
+			pPLL->POD = POD;
+			}
+		}
+		}
+	}
+	}
 
     /* Restore input frequency from Khz to hz unit */
 //    pPLL->inputFreq *= 1000;
-    ulRequestClk *= 1000;
-    pPLL->inputFreq = DEFAULT_INPUT_CLOCK; /* Default reference clock */
+	ulRequestClk *= 1000;
+	pPLL->inputFreq = DEFAULT_INPUT_CLOCK; /* Default reference clock */
 
     /* Output debug information */
-    //DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Requested Frequency = %d\n", ulRequestClk));
-    //DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));
+	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Requested Frequency = %d\n", ulRequestClk));
+	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));
 
     /* Return actual frequency that the PLL can set */
 	ret = calcPLL(pPLL);
-    return ret;
+	return ret;
 }
 
 
@@ -616,24 +616,24 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 
 unsigned int formatPllReg(pll_value_t *pPLL)
 {
-    unsigned int ulPllReg = 0;
+	unsigned int ulPllReg = 0;
 
     /* Note that all PLL's have the same format. Here, we just use Panel PLL parameter
        to work out the bit fields in the register.
        On returning a 32 bit number, the value can be applied to any PLL in the calling function.
     */
-    ulPllReg -        FIELD_SET(  0, PANEL_PLL_CTRL, BYPASS, OFF)
-      | FIELD_SET(  0, PANEL_PLL_CTRL, POWER,  ON)
-      | FIELD_SET(  0, PANEL_PLL_CTRL, INPUT,  OSC)
+	ulPllReg +	FIELD_SET(  0, PANEL_PLL_CTRL, BYPASS, OFF)
+	| FIELD_SET(  0, PANEL_PLL_CTRL, POWER,  ON)
+	| FIELD_SET(  0, PANEL_PLL_CTRL, INPUT,  OSC)
 #ifndef VALIDATION_CHIP
-      | FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    pPLL->POD)
+	| FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    pPLL->POD)
 #endif
-      | FIELD_VALUE(0, PANEL_PLL_CTRL, OD,     pPLL->OD)
-      | FIELD_VALUE(0, PANEL_PLL_CTRL, N,      pPLL->N)
-      | FIELD_VALUE(0, PANEL_PLL_CTRL, M,      pPLL->M);
+	| FIELD_VALUE(0, PANEL_PLL_CTRL, OD,     pPLL->OD)
+	| FIELD_VALUE(0, PANEL_PLL_CTRL, N,      pPLL->N)
+	| FIELD_VALUE(0, PANEL_PLL_CTRL, M,      pPLL->M);
 
-    return(ulPllReg);
+	return(ulPllReg);
 }
 
 
-- 
1.7.10.4

