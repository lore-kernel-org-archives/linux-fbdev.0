From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 11 Sep 2013 21:35:06 +0000
Subject: [PATCH 2/2] radeonfb: Use pci_dev pm_cap
Message-Id: <1378935306-16814-2-git-send-email-jdmason@kudzu.us>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the already existing pm_cap variable in struct pci_dev for
determining the power management offset.  This saves the driver from
having to keep track of an extra variable.  Also, use the pci_power_t
value instead of always using the raw value for PCI_D2.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/aty/radeon_pm.c |   15 ++++++---------
 drivers/video/aty/radeonfb.h  |    1 -
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index f7091ec..f266224 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -2515,13 +2515,13 @@ static void radeonfb_whack_power_state(struct radeonfb_info *rinfo, pci_power_t
 
 	for (;;) {
 		pci_read_config_word(rinfo->pdev,
-				     rinfo->pm_reg+PCI_PM_CTRL,
+				     rinfo->pdev->pm_cap + PCI_PM_CTRL,
 				     &pwr_cmd);
-		if (pwr_cmd & 2)
+		if (pwr_cmd & state)
 			break;
-		pwr_cmd = (pwr_cmd & ~PCI_PM_CTRL_STATE_MASK) | 2;
+		pwr_cmd = (pwr_cmd & ~PCI_PM_CTRL_STATE_MASK) | state;
 		pci_write_config_word(rinfo->pdev,
-				      rinfo->pm_reg+PCI_PM_CTRL,
+				      rinfo->pdev->pm_cap + PCI_PM_CTRL,
 				      pwr_cmd);
 		msleep(500);
 	}
@@ -2532,7 +2532,7 @@ static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u32 tmp;
 
-	if (!rinfo->pm_reg)
+	if (!rinfo->pdev->pm_cap)
 		return;
 
 	/* Set the chip into appropriate suspend mode (we use D2,
@@ -2804,9 +2804,6 @@ static void radeonfb_early_resume(void *data)
 
 void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlist, int force_sleep)
 {
-	/* Find PM registers in config space if any*/
-	rinfo->pm_reg = rinfo->pdev->pm_cap;
-
 	/* Enable/Disable dynamic clocks: TODO add sysfs access */
 	if (rinfo->family = CHIP_FAMILY_RS480)
 		rinfo->dynclk = -1;
@@ -2830,7 +2827,7 @@ void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlis
 	 * reason. --BenH
 	 */
 	if (machine_is(powermac) && rinfo->of_node) {
-		if (rinfo->is_mobility && rinfo->pm_reg &&
+		if (rinfo->is_mobility && rinfo->pdev->pm_cap &&
 		    rinfo->family <= CHIP_FAMILY_RV250)
 			rinfo->pm_mode |= radeon_pm_d2;
 
diff --git a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
index 7351e66..cb84604 100644
--- a/drivers/video/aty/radeonfb.h
+++ b/drivers/video/aty/radeonfb.h
@@ -342,7 +342,6 @@ struct radeonfb_info {
 
 	int			mtrr_hdl;
 
-	int			pm_reg;
 	u32			save_regs[100];
 	int			asleep;
 	int			lock_blank;
-- 
1.7.10.4

