From: Stefan Hasko <hasko.stevo@gmail.com>
Date: Mon, 24 Dec 2012 21:44:48 +0000
Subject: [PATCH] drivers: video: fix warnings int-to-pointer-cast
Message-Id: <1356385488-6655-1-git-send-email-hasko.stevo@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stefan Hasko <hasko.stevo@gmail.com>

Fixed compile warnings cast to pointer from integer of different size

Signed-off-by: Stefan Hasko <hasko.stevo@gmail.com>
---
 drivers/video/arkfb.c    |    2 +-
 drivers/video/s3fb.c     |    2 +-
 drivers/video/vt8623fb.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 555dd4c..3e4ed96 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1016,7 +1016,7 @@ static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_
 
 	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
 
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	par->state.vgabase = (void __iomem *)(unsigned long) vga_res.start;
 
 	/* FIXME get memsize */
 	regval = vga_rseq(par->state.vgabase, 0x10);
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 1d00736..def0a86 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1183,7 +1183,7 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
 
 	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
 
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	par->state.vgabase = (void __iomem *)(unsigned long) vga_res.start;
 
 	/* Unlock regs */
 	cr38 = vga_rcrt(par->state.vgabase, 0x38);
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 4e74d26..2516808 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -729,7 +729,7 @@ static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_devi
 
 	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
 
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	par->state.vgabase = (void __iomem *)(unsigned long) vga_res.start;
 
 	/* Find how many physical memory there is on card */
 	memsize1 = (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;
-- 
1.7.10.4

