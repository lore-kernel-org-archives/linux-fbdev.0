From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 15:54:47 +0000
Subject: [PATCH 3/5] video: mb862xxfb: relocate register space to get contiguous vram
Message-Id: <1305302089-7666-4-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

By default the GDC registers are located in the middle of the 64MiB
area for video RAM and registers. When 32MiB VRAM or more is used,
relocate the register space to the top of the 64MiB space so that
we get the contiguous VRAM for GDC frame buffer layers, drawing
frames, capture and cursor buffers.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xx_reg.h |    6 ++----
 drivers/video/mb862xx/mb862xxfb.c   |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xx_reg.h b/drivers/video/mb862xx/mb862xx_reg.h
index 2ba65e1..737fc01 100644
--- a/drivers/video/mb862xx/mb862xx_reg.h
+++ b/drivers/video/mb862xx/mb862xx_reg.h
@@ -5,11 +5,8 @@
 #ifndef _MB862XX_REG_H
 #define _MB862XX_REG_H
 
-#ifdef MB862XX_MMIO_BOTTOM
-#define MB862XX_MMIO_BASE	0x03fc0000
-#else
 #define MB862XX_MMIO_BASE	0x01fc0000
-#endif
+#define MB862XX_MMIO_HIGH_BASE	0x03fc0000
 #define MB862XX_I2C_BASE	0x0000c000
 #define MB862XX_DISP_BASE	0x00010000
 #define MB862XX_CAP_BASE	0x00018000
@@ -23,6 +20,7 @@
 #define GC_IMASK		0x00000024
 #define GC_SRST			0x0000002c
 #define GC_CCF			0x00000038
+#define GC_RSW			0x0000005c
 #define GC_CID			0x000000f0
 #define GC_REVISION		0x00000084
 
diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index a1b81e7..ffb6a2c 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -742,6 +742,12 @@ static int coralp_init(struct mb862xxfb_par *par)
 
 	par->refclk = GC_DISP_REFCLK_400;
 
+	if (par->mapped_vram >= 0x2000000) {
+		/* relocate gdc registers space */
+		writel(1, par->fb_base + MB862XX_MMIO_BASE + GC_RSW);
+		udelay(1); /* wait at least 20 bus cycles */
+	}
+
 	ver = inreg(host, GC_CID);
 	cn = (ver & GC_CID_CNAME_MSK) >> 8;
 	ver = ver & GC_CID_VERSION_MSK;
@@ -907,7 +913,13 @@ static int __devinit mb862xx_pci_probe(struct pci_dev *pdev,
 	case PCI_DEVICE_ID_FUJITSU_CORALPA:
 		par->fb_base_phys = pci_resource_start(par->pdev, 0);
 		par->mapped_vram = CORALP_MEM_SIZE;
-		par->mmio_base_phys = par->fb_base_phys + MB862XX_MMIO_BASE;
+		if (par->mapped_vram >= 0x2000000) {
+			par->mmio_base_phys = par->fb_base_phys +
+					      MB862XX_MMIO_HIGH_BASE;
+		} else {
+			par->mmio_base_phys = par->fb_base_phys +
+					      MB862XX_MMIO_BASE;
+		}
 		par->mmio_len = MB862XX_MMIO_SIZE;
 		par->type = BT_CORALP;
 		break;
-- 
1.7.1

