From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 13:17:44 +0000
Subject: [PATCH] fbdev: sm712fb: Use dev_get_drvdata
Message-Id: <20190724131744.1709-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 7b1b0d8d27a7..207d0add684b 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1694,10 +1694,8 @@ static void smtcfb_pci_remove(struct pci_dev *pdev)
 
 static int __maybe_unused smtcfb_pci_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct smtcfb_info *sfb;
+	struct smtcfb_info *sfb = dev_get_drvdata(device);
 
-	sfb = pci_get_drvdata(pdev);
 
 	/* set the hw in sleep mode use external clock and self memory refresh
 	 * so that we can turn off internal PLLs later on
@@ -1717,10 +1715,8 @@ static int __maybe_unused smtcfb_pci_suspend(struct device *device)
 
 static int __maybe_unused smtcfb_pci_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct smtcfb_info *sfb;
+	struct smtcfb_info *sfb = dev_get_drvdata(device);
 
-	sfb = pci_get_drvdata(pdev);
 
 	/* reinit hardware */
 	sm7xx_init_hw();
-- 
2.20.1
