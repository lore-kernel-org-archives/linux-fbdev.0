From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 18 Jun 2013 08:24:51 +0000
Subject: [PATCH 9/9] radeon: use pdev->pm_cap instead of pci_find_capability(..,PCI_CAP_ID_PM)
Message-Id: <1371543891-11460-1-git-send-email-wangyijing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com, Yijing Wang <wangyijing@huawei.com>, linux-fbdev@vger.kernel.org

Pci core has been saved pm cap register offset by pdev->pm_cap in pci_pm_init()
in init path. So we can use pdev->pm_cap instead of using
pci_find_capability(pdev, PCI_CAP_ID_PM) for better performance and simplified code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/video/aty/radeon_pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index 92bda58..f7091ec 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -2805,7 +2805,7 @@ static void radeonfb_early_resume(void *data)
 void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlist, int force_sleep)
 {
 	/* Find PM registers in config space if any*/
-	rinfo->pm_reg = pci_find_capability(rinfo->pdev, PCI_CAP_ID_PM);
+	rinfo->pm_reg = rinfo->pdev->pm_cap;
 
 	/* Enable/Disable dynamic clocks: TODO add sysfs access */
 	if (rinfo->family = CHIP_FAMILY_RS480)
-- 
1.7.1


