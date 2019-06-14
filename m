From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Jun 2019 14:48:23 +0000
Subject: [PATCH 2/3] video: fbdev: intelfb: return -ENOMEM on framebuffer_alloc() failure
Message-Id: <a659cb04-b16c-a3a0-30f4-b2f90b0d7196@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614144823eucas1p1f6d5ed1905350e9933f4d7fec0a3419f@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maik Broemme <mbroemme@libmpq.org>

Fix error code from -ENODEV to -ENOMEM.

Cc: Maik Broemme <mbroemme@libmpq.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/intelfb/intelfbdrv.c
=================================--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -493,7 +493,7 @@ static int intelfb_pci_register(struct p
 	info = framebuffer_alloc(sizeof(struct intelfb_info), &pdev->dev);
 	if (!info) {
 		ERR_MSG("Could not allocate memory for intelfb_info.\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 	if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
 		ERR_MSG("Could not allocate cmap for intelfb_info.\n");
