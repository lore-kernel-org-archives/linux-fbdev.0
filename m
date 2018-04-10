From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue, 10 Apr 2018 01:47:20 +0000
Subject: [PATCH] video: fbdev: aty: radeon_pm: Replace mdelay with msleep in radeonfb_pci_suspend
Message-Id: <1523324840-28830-1-git-send-email-baijiaju1990@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

radeonfb_pci_suspend() is never called in atomic context.

radeonfb_pci_suspend() is only set as ".suspend" in struct pci_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, radeonfb_pci_suspend()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() 
and usleep_range() to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/video/fbdev/aty/radeon_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index 1417542..a8de909 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -2674,17 +2674,17 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 		 * it, we'll restore the dynamic clocks state on wakeup
 		 */
 		radeon_pm_disable_dynamic_mode(rinfo);
-		mdelay(50);
+		msleep(50);
 		radeon_pm_save_regs(rinfo, 1);
 
 		if (rinfo->is_mobility && !(rinfo->pm_mode & radeon_pm_d2)) {
 			/* Switch off LVDS interface */
-			mdelay(1);
+			usleep_range(1000, 2000);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_BL_MOD_EN));
-			mdelay(1);
+			usleep_range(1000, 2000);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_EN | LVDS_ON));
 			OUTREG(LVDS_PLL_CNTL, (INREG(LVDS_PLL_CNTL) & ~30000) | 0x20000);
-			mdelay(20);
+			msleep(20);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_DIGON));
 		}
 		pci_disable_device(pdev);
-- 
1.9.1

