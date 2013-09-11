From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 11 Sep 2013 21:35:05 +0000
Subject: [PATCH 1/2] aty128fb: Use pci_dev pm_cap
Message-Id: <1378935306-16814-1-git-send-email-jdmason@kudzu.us>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the already existing pm_cap variable in struct pci_dev for
determining the power management offset.  This saves the driver from
having to keep track of an extra variable.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/aty/aty128fb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index a4dfe8c..b5edb6f 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -413,7 +413,6 @@ struct aty128fb_par {
 	int blitter_may_be_busy;
 	int fifo_slots;                 /* free slots in FIFO (64 max) */
 
-	int	pm_reg;
 	int crt_on, lcd_on;
 	struct pci_dev *pdev;
 	struct fb_info *next;
@@ -2016,7 +2015,6 @@ static int aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	aty128_init_engine(par);
 
-	par->pm_reg = pdev->pm_cap;
 	par->pdev = pdev;
 	par->asleep = 0;
 	par->lock_blank = 0;
@@ -2397,7 +2395,7 @@ static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 	u32	pmgt;
 	struct pci_dev *pdev = par->pdev;
 
-	if (!par->pm_reg)
+	if (!par->pdev->pm_cap)
 		return;
 		
 	/* Set the chip into the appropriate suspend mode (we use D2,
-- 
1.7.10.4

