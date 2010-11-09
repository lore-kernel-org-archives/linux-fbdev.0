From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 09 Nov 2010 22:25:04 +0000
Subject: [PATCH] sisfb: limit POST memory test according to PCI resource length
Message-Id: <1289341504-1038-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: aaro.koskinen@iki.fi, Thomas Winischhofer <thomas@winischhofer.net>

If the POST memory test fails, the driver may access illegal memory
areas. Instead of hard coding the maximum size, set it according to the
PCI resource length. DRAM sizing will later adjust video_size to the
correct value.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/sis_main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index b52f8e4..8a528aa 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -4514,7 +4514,7 @@ sisfb_post_sis300(struct pci_dev *pdev)
 	} else {
 #endif
 		/* Need to map max FB size for finding out about RAM size */
-		mapsize = 64 << 20;
+		mapsize = ivideo->video_size;
 		sisfb_post_map_vram(ivideo, &mapsize, 4);
 
 		if(ivideo->video_vbase) {
@@ -4680,7 +4680,7 @@ sisfb_post_xgi_ramsize(struct sis_video_info *ivideo)
 	orSISIDXREG(SISSR, 0x20, (0x80 | 0x04));
 
 	/* Need to map max FB size for finding out about RAM size */
-	mapsize = 256 << 20;
+	mapsize = ivideo->video_size;
 	sisfb_post_map_vram(ivideo, &mapsize, 32);
 
 	if(!ivideo->video_vbase) {
@@ -5936,6 +5936,7 @@ sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	ivideo->video_base = pci_resource_start(pdev, 0);
+	ivideo->video_size = pci_resource_len(pdev, 0);
 	ivideo->mmio_base  = pci_resource_start(pdev, 1);
 	ivideo->mmio_size  = pci_resource_len(pdev, 1);
 	ivideo->SiS_Pr.RelIO = pci_resource_start(pdev, 2) + 0x30;
-- 
1.5.6.5

