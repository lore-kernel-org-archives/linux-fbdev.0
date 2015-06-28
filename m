From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:59 +0000
Subject: [PATCH 06/11] staging: sm750fb: put open brace on the previous line
Message-Id: <1435535044-22042-7-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Fix open braces according to checkpatch.pl message:
"ERROR: that open brace { should be on the previous line"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 4f4ec93..4dded62 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -44,8 +44,7 @@ int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 	 * successfully
 	 * */
 
-	if ((ret = pci_request_region(pdev, 1, "sm750fb")))
-	{
+	if ((ret = pci_request_region(pdev, 1, "sm750fb"))) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
@@ -78,8 +77,7 @@ int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 
 	/* reserve the vidmem space of smi adaptor */
 #if 0
-	if ((ret = pci_request_region(pdev, 0, _moduleName_)))
-	{
+	if ((ret = pci_request_region(pdev, 0, _moduleName_))) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
@@ -130,8 +128,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	ddk750_initDVIDisp();
 #endif
 
-	if (getChipType() != SM750LE)
-	{
+	if (getChipType() != SM750LE) {
 		/* does user need CRT ?*/
 		if (spec_share->state.nocrt) {
 			POKE32(MISC_CTRL,
@@ -177,8 +174,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	/* Customer may NOT use CH7301 DVI chip, which has to be
 	   initialized differently.
 	*/
-	if (swI2CReadReg(0xec, 0x4a) = 0x95)
-	{
+	if (swI2CReadReg(0xec, 0x4a) = 0x95) {
 		/* The following register values for CH7301 are from
 		   Chrontel app note and our experiment.
 		*/
@@ -429,8 +425,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank) {
 	int dpms, crtdb;
 
-	switch (blank)
-	{
+	switch (blank) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_UNBLANK:
 #else
@@ -486,8 +481,7 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 
 	dpms = pps = crtdb = 0;
 
-	switch (blank)
-	{
+	switch (blank) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_UNBLANK:
 #else
@@ -585,8 +579,7 @@ int hw_sm750le_deWait(void)
 		unsigned int dwVal = PEEK32(DE_STATE2);
 		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
-			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY))
-		{
+			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY)) {
 			return 0;
 		}
 	}
@@ -602,8 +595,7 @@ int hw_sm750_deWait(void)
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
 		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
-			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
-		{
+			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY)) {
 			return 0;
 		}
 	}
-- 
2.1.0

