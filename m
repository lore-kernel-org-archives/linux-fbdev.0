From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 18 Jun 2013 08:15:07 +0000
Subject: [PATCH 3/9] aty128fb: use pdev->pm_cap instead of pci_find_capability(..,PCI_CAP_ID_PM)
Message-Id: <1371543307-14360-1-git-send-email-wangyijing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com, Yijing Wang <wangyijing@huawei.com>, linux-fbdev@vger.kernel.org

Pci core has been saved pm cap register offset by pdev->pm_cap in pci_pm_init()
in init path. So we can use pdev->pm_cap instead of using
pci_find_capability(pdev, PCI_CAP_ID_PM) for better performance and simplified code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/aty/aty128fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 8c55011..a4dfe8c 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -2016,7 +2016,7 @@ static int aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	aty128_init_engine(par);
 
-	par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	par->pm_reg = pdev->pm_cap;
 	par->pdev = pdev;
 	par->asleep = 0;
 	par->lock_blank = 0;
-- 
1.7.1


