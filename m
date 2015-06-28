From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:44:02 +0000
Subject: [PATCH 09/11] staging: sm750fb: remove assignment from if condition
Message-Id: <1435535044-22042-10-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Remove assignment from if condition according to checkpatch.pl message:
"ERROR: do not use assignment in if condition"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 3093c25..987da9e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -43,8 +43,8 @@ int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 	 * in lynxfb_remove, or memory will not be mapped again
 	 * successfully
 	 * */
-
-	if ((ret = pci_request_region(pdev, 1, "sm750fb"))) {
+	ret = pci_request_region(pdev, 1, "sm750fb");
+	if (ret) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
@@ -77,7 +77,8 @@ int hw_sm750_map(struct lynx_share *share, struct pci_dev *pdev)
 
 	/* reserve the vidmem space of smi adaptor */
 #if 0
-	if ((ret = pci_request_region(pdev, 0, _moduleName_))) {
+	ret = pci_request_region(pdev, 0, _moduleName_);
+	if (ret) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
-- 
2.1.0

