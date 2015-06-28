From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:55 +0000
Subject: [PATCH 02/11] staging: sm750fb: remove trailing whitespaces
Message-Id: <1435535044-22042-3-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Remove trailing whitespaces according to checkpatch.pl error message:
"ERROR: trailing whitespace"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 3b3089c..1dd20be 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -28,7 +28,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 {
 	int ret;
 	struct sm750_share *spec_share;
-	
+
 
 	spec_share = container_of(share, struct sm750_share, share);
 	ret = 0;
@@ -60,7 +60,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 		pr_info("mmio virtual addr = %p\n", share->pvReg);
 	}
 
-	
+
 	share->accel.dprBase = share->pvReg + DE_BASE_ADDR_TYPE1;
 	share->accel.dpPortBase = share->pvReg + DE_PORT_ADDR_TYPE1;
 
@@ -104,7 +104,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 {
 	struct sm750_share *spec_share;
 	struct init_status *parm;
-	
+
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
 	if(parm->chip_clk = 0)
@@ -202,7 +202,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 {
 	resource_size_t ret;
-	
+
 	ret = ddk750_getVMSize();
 	return ret;
 }
@@ -211,7 +211,7 @@ resource_size_t hw_sm750_getVMSize(struct lynx_share *share)
 
 int hw_sm750_output_checkMode(struct lynxfb_output* output, struct fb_var_screeninfo* var)
 {
-	
+
 	return 0;
 }
 
@@ -222,7 +222,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	int ret;
 	disp_output_t dispSet;
 	int channel;
-	
+
 	ret = 0;
 	dispSet = 0;
 	channel = *output->channel;
@@ -259,14 +259,14 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 
 void hw_sm750_output_clear(struct lynxfb_output* output)
 {
-	
+
 	return;
 }
 
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo* var)
 {
 	struct lynx_share *share;
-	
+
 
 	share = container_of(crtc, struct lynxfb_par, crtc)->share;
 
@@ -303,7 +303,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	struct lynx_share *share;
 	struct lynxfb_par *par;
 
-	
+
 	ret = 0;
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	share = par->share;
@@ -414,7 +414,7 @@ exit:
 
 void hw_sm750_crtc_clear(struct lynxfb_crtc* crtc)
 {
-	
+
 	return;
 }
 
@@ -428,7 +428,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 
 int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
 	int dpms, crtdb;
-	
+
 	switch(blank)
 	{
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
@@ -483,7 +483,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
 int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 {
 	unsigned int dpms, pps, crtdb;
-	
+
 	dpms = pps = crtdb = 0;
 
 	switch (blank)
@@ -636,4 +636,3 @@ int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
 	}
 	return 0;
 }
-
-- 
2.1.0

