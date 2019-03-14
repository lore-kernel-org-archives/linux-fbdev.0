From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Mar 2019 11:45:00 +0000
Subject: [PATCH] fbdev: list all pci memory bars as conflicting apertures
Message-Id: <20190314114500.8336-1-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Simply add all pci memory bars to struct apertures_struct in
remove_conflicting_pci_framebuffers(), without depending on the
res_id parameter.

The plan is to drop the res_id parameter later on.  For now keep the
parameter, use it for sanity-checking and warn on inconsistencies.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/core/fbmem.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cb43a2258c51..e4e5c129a0f5 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1879,14 +1879,35 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 {
 	struct apertures_struct *ap;
 	bool primary = false;
-	int err;
+	int err, idx, bar;
+	bool res_id_found = false;
 
-	ap = alloc_apertures(1);
+	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		idx++;
+	}
+
+	ap = alloc_apertures(idx);
 	if (!ap)
 		return -ENOMEM;
 
-	ap->ranges[0].base = pci_resource_start(pdev, res_id);
-	ap->ranges[0].size = pci_resource_len(pdev, res_id);
+	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		ap->ranges[idx].base = pci_resource_start(pdev, bar);
+		ap->ranges[idx].size = pci_resource_len(pdev, bar);
+		pci_info(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
+			 (unsigned long)pci_resource_start(pdev, bar),
+			 (unsigned long)pci_resource_end(pdev, bar));
+		idx++;
+		if (res_id = bar)
+			res_id_found = true;
+	}
+	if (!res_id_found)
+		pci_warn(pdev, "%s: passed res_id (%d) is not a memory bar\n",
+			 __func__, res_id);
+
 #ifdef CONFIG_X86
 	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
 					IORESOURCE_ROM_SHADOW;
-- 
2.18.1
