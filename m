From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Mar 2019 11:07:41 +0000
Subject: [RfC PATCH] fbdev: list all memory bars as conflicting apertures
Message-Id: <20190313110741.6541-1-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Simply add all pci memory bars to struct apertures_struct in
remove_conflicting_pci_framebuffers().  That allows to drop
the res_id parameter.

TODO: actually remove the res_id parameter.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cb43a2258c51..e8223c231de2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1879,14 +1879,28 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 {
 	struct apertures_struct *ap;
 	bool primary = false;
-	int err;
+	int err, idx, cnt, bar;
 
-	ap = alloc_apertures(1);
+	for (cnt = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		cnt++;
+	}
+
+	ap = alloc_apertures(cnt);
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
+	}
 #ifdef CONFIG_X86
 	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
 					IORESOURCE_ROM_SHADOW;
-- 
2.18.1
