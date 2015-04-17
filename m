From: Julian Gindi <juliangindi@gmail.com>
Date: Fri, 17 Apr 2015 20:44:16 +0000
Subject: [PATCH] staging: sm750fb: Cleaning up a few return statements
Message-Id: <20150417204416.GA18202@rosebud>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Julian Gindi <juliangindi@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 4 +---
 drivers/staging/sm750fb/sm750.c       | 6 +-----
 drivers/staging/sm750fb/sm750_hw.c    | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 7b28328..ac88623 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -499,7 +499,6 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 {
 	unsigned int M, N, OD, POD = 0, diff, pllClk, odPower, podPower;
 	unsigned int bestDiff = 0xffffffff; /* biggest 32 bit unsigned number */
-	unsigned int ret;
     /* Init PLL structure to know states */
 	pPLL->M = 0;
 	pPLL->N = 0;
@@ -589,8 +588,7 @@ pll_value_t *pPLL           /* Structure to hold the value to be set in PLL */
 	//DDKDEBUGPRINT((DISPLAY_LEVEL, "calcPllValue: Input CLK = %dHz, M=%d, N=%d, OD=%d, POD=%d\n", pPLL->inputFreq, pPLL->M, pPLL->N, pPLL->OD, pPLL->POD));
 
     /* Return actual frequency that the PLL can set */
-	ret = calcPLL(pPLL);
-	return ret;
+	return calcPLL(pPLL);
 }
 
 
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3c7ea95..e05bb64 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -303,8 +303,6 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 {
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
-	int ret;
-
 
 	if (!info)
 		return -EINVAL;
@@ -312,9 +310,7 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
-	ret = crtc->proc_panDisplay(crtc, var, info);
-
-	return ret;
+	return crtc->proc_panDisplay(crtc, var, info);
 }
 
 static int lynxfb_ops_set_par(struct fb_info *info)
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 9f0d06d..8f2432d 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -203,10 +203,7 @@ int hw_sm750_inithw(struct lynx_share* share, struct pci_dev * pdev)
 
 resource_size_t hw_sm750_getVMSize(struct lynx_share * share)
 {
-	resource_size_t ret;
-	
-	ret = ddk750_getVMSize();
-	return ret;
+	return ddk750_getVMSize();
 }
 
 
-- 
1.9.1

