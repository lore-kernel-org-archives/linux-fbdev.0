From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Fri, 20 Mar 2015 18:53:05 +0000
Subject: [PATCH] sm750fb: Fix indentation, spacing and switch-case
Message-Id: <20150320184105.GA19710@amitoj-Inspiron-3542>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix the spacing problems with correct indentation and correct use of
braces and spacing in switch-case statements.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 63 +++++++++++++++++------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 1e6b474..de56302 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -46,53 +46,52 @@ inline unsigned int twoToPowerOfx(unsigned long x)
 
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
+	unsigned int ulPllReg = 0;
+
+	pPLL->inputFreq = DEFAULT_INPUT_CLOCK;
+	pPLL->clockType = clockType;
+
+	switch (clockType) {
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
 
-    pPLL->M = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, M);
-    pPLL->N = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, N);
-    pPLL->OD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, OD);
-    pPLL->POD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, POD);
+	pPLL->M = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, M);
+	pPLL->N = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, N);
+	pPLL->OD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, OD);
+	pPLL->POD = FIELD_GET(ulPllReg, PANEL_PLL_CTRL, POD);
 
-    return calcPLL(pPLL);
+	return calcPLL(pPLL);
 }
 
 
 unsigned int getChipClock(void)
 {
-    pll_value_t pll;
+	pll_value_t pll;
 #if 1
-	if(getChipType() = SM750LE)
+	if (getChipType() = SM750LE)
 		return MHz(130);
 #endif
 
-    return getPllValue(MXCLK_PLL, &pll);
+	return getPllValue(MXCLK_PLL, &pll);
 }
 
 
-- 
1.9.1

