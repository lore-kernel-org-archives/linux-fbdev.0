From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu, 19 Apr 2012 16:55:53 +0000
Subject: [PATCH] drivers/video/intelfb/intelfbdrv.c: add missing agp_backend_release
Message-Id: <1334854553-30067-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maik Broemme <mbroemme@plusserver.de>
Cc: kernel-janitors@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Release bridge, as done on all other paths out of the function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/intelfb/intelfbdrv.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 02fd226..bdcbfba 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -680,6 +680,7 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
 		 + dinfo->fb.size);
 	if (!dinfo->aperture.virtual) {
 		ERR_MSG("Cannot remap FB region.\n");
+		agp_backend_release(bridge);
 		cleanup(dinfo);
 		return -ENODEV;
 	}
@@ -689,6 +690,7 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
 					      INTEL_REG_SIZE);
 	if (!dinfo->mmio_base) {
 		ERR_MSG("Cannot remap MMIO region.\n");
+		agp_backend_release(bridge);
 		cleanup(dinfo);
 		return -ENODEV;
 	}

