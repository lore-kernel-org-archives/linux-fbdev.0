From: Denis Efremov <efremov@linux.com>
Date: Mon, 16 Sep 2019 20:41:48 +0000
Subject: [PATCH v3 16/26] fbmem: use PCI_STD_NUM_BARS
Message-Id: <20190916204158.6889-17-efremov@linux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190916204158.6889-1-efremov@linux.com>
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 64dd732021d8..485e798cd404 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1784,7 +1784,7 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 	int err, idx, bar;
 	bool res_id_found = false;
 
-	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+	for (idx = 0, bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
 		idx++;
@@ -1794,7 +1794,7 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 	if (!ap)
 		return -ENOMEM;
 
-	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+	for (idx = 0, bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
 		ap->ranges[idx].base = pci_resource_start(pdev, bar);
-- 
2.21.0
