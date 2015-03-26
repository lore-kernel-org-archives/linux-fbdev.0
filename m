From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:27:25 +0000
Subject: [PATCH v2 12/12] staging: sm750: move assignment out of if cond
Message-Id: <1d869c193fc53160e5a2ef06bbb2b7ce9786bd2e.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch moves the assignments from the if conditions to the line before the condition.
The 3 occurrence are return values and the checks for errors.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---

v2: remove double negation in if statments
---
 drivers/staging/sm750fb/sm750.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d363f55..25df813 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -477,7 +477,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	console_lock();
 
-	if ((ret = pci_set_power_state(pdev, PCI_D0)) != 0) {
+	ret = pci_set_power_state(pdev, PCI_D0);
+	if (ret) {
 		pr_err("error:%d occured in pci_set_power_state\n", ret);
 		return ret;
 	}
@@ -485,7 +486,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
 		pci_restore_state(pdev);
-		if ((ret = pci_enable_device(pdev)) != 0) {
+		ret = pci_enable_device(pdev);
+		if (ret) {
 			pr_err("error:%d occured in pci_enable_device\n", ret);
 			return ret;
 		}
@@ -975,7 +977,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
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

