From: Joe Perches <joe@perches.com>
Date: Fri, 20 Sep 2013 03:10:11 +0000
Subject: [PATCH 2/2] framebuffer: Fix int cast to pointer warnings
Message-Id: <1379646611.2021.7.camel@joe-AO722>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
In-Reply-To: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Casts of int to pointer need additional casts to (unsigned long)
when compiled for x86-64 to silence the compiler.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/arkfb.c    | 2 +-
 drivers/video/vt8623fb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index b13f3f2..26fd4e4 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1016,7 +1016,7 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
 
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	par->state.vgabase = (void __iomem *)(unsigned long)vga_res.start;
 
 	/* FIXME get memsize */
 	regval = vga_rseq(par->state.vgabase, 0x10);
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 7e97c53..281d41b 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -731,7 +731,7 @@ static int vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
 
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	par->state.vgabase = (void __iomem *)(unsigned long)vga_res.start;
 
 	/* Find how many physical memory there is on card */
 	memsize1 = (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;


