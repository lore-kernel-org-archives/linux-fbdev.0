From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:15:16 +0000
Subject: [PATCH 13/13] staging: sm750: move assignment out of if cond
Message-Id: <20150322231516.GA17336@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch moves the assignments from the if conditions to the line before the condition.
The 3 occurrence are return values and the checks for errors.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c250882..a4a7fed 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -474,7 +474,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	console_lock();
 
-	if ((ret = pci_set_power_state(pdev, PCI_D0)) != 0) {
+	ret = pci_set_power_state(pdev, PCI_D0);
+	if (ret != 0) {
 		pr_err("error:%d occured in pci_set_power_state\n", ret);
 		return ret;
 	}
@@ -482,7 +483,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
 		pci_restore_state(pdev);
-		if ((ret = pci_enable_device(pdev)) != 0) {
+		ret = pci_enable_device(pdev);
+		if (ret != 0) {
 			pr_err("error:%d occured in pci_enable_device\n", ret);
 			return ret;
 		}
@@ -971,7 +973,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 			info->cmap.red, info->cmap.green, info->cmap.blue,
 			info->cmap.transp);
 
-	if ((ret = fb_alloc_cmap(&info->cmap, 256, 0)) < 0) {
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret < 0) {
 		pr_err("Could not allcate memory for cmap.\n");
 		goto exit;
 	}
-- 
2.3.3

