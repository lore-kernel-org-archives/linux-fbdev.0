From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue, 10 Apr 2018 01:40:35 +0000
Subject: [PATCH] video: fbdev: aty: aty128fb: Replace mdelay with msleep in aty128_set_suspend
Message-Id: <1523324435-28719-1-git-send-email-baijiaju1990@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulus@samba.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

aty128_set_suspend() is never called in atomic context.

The call chains ending up at aty128_set_suspend() are:
[1] aty128_set_suspend() <- aty128_pci_suspend()
[2] aty128_set_suspend() <- aty128_do_resume() <- aty128_pci_resume()
[3] aty128_set_suspend() <- aty128_do_resume() <- aty128_early_resume()

aty128_pci_suspend() is set as ".suspend" in struct pci_driver.
aty128_pci_resume() is set as ".resume" in struct pci_driver.
aty128_early_resume() is never called.
These functions are not called in atomic context.

Despite never getting called from atomic context, aty128_set_suspend()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index db18474..15dfdff 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -2442,7 +2442,7 @@ static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 		(void)aty_ld_pll(POWER_MANAGEMENT);
 		aty_st_le32(BUS_CNTL1, 0x00000010);
 		aty_st_le32(MEM_POWER_MISC, 0x0c830000);
-		mdelay(100);
+		msleep(100);
 
 		/* Switch PCI power management to D2 */
 		pci_set_power_state(pdev, PCI_D2);
-- 
1.9.1

