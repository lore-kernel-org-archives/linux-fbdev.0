From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 03 Feb 2015 14:54:27 +0000
Subject: [PATCH 1/2] staging: sm7xxfb: fix CamelCase
Message-Id: <1422975214-15250-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422975214-15250-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1422975214-15250-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

since mixed case names are not encouraged in coding, so those has
been changed to their corresponding lowercase version.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xx.h   | 14 +++++++-------
 drivers/staging/sm7xxfb/sm7xxfb.c | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index 8599861..fe63cd7 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -29,14 +29,14 @@
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
 
-extern void __iomem *smtc_RegBaseAddress;
-#define smtc_mmiowb(dat, reg)	writeb(dat, smtc_RegBaseAddress + reg)
-#define smtc_mmioww(dat, reg)	writew(dat, smtc_RegBaseAddress + reg)
-#define smtc_mmiowl(dat, reg)	writel(dat, smtc_RegBaseAddress + reg)
+extern void __iomem *smtc_regbaseaddress;
+#define smtc_mmiowb(dat, reg)	writeb(dat, smtc_regbaseaddress + reg)
+#define smtc_mmioww(dat, reg)	writew(dat, smtc_regbaseaddress + reg)
+#define smtc_mmiowl(dat, reg)	writel(dat, smtc_regbaseaddress + reg)
 
-#define smtc_mmiorb(reg)	readb(smtc_RegBaseAddress + reg)
-#define smtc_mmiorw(reg)	readw(smtc_RegBaseAddress + reg)
-#define smtc_mmiorl(reg)	readl(smtc_RegBaseAddress + reg)
+#define smtc_mmiorb(reg)	readb(smtc_regbaseaddress + reg)
+#define smtc_mmiorw(reg)	readw(smtc_regbaseaddress + reg)
+#define smtc_mmiorl(reg)	readl(smtc_regbaseaddress + reg)
 
 #define SIZE_SR00_SR04      (0x04 - 0x00 + 1)
 #define SIZE_SR10_SR24      (0x24 - 0x10 + 1)
diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 2ae9fd0..3150f0b 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -56,7 +56,7 @@ struct smtcfb_info {
 	u32 colreg[17];
 };
 
-void __iomem *smtc_RegBaseAddress;	/* Memory Map IO starting address */
+void __iomem *smtc_regbaseaddress;	/* Memory Map IO starting address */
 
 static struct fb_var_screeninfo smtcfb_var = {
 	.xres           = 1024,
@@ -711,8 +711,8 @@ static void smtc_free_fb_info(struct smtcfb_info *sfb)
 
 static void smtc_unmap_mmio(struct smtcfb_info *sfb)
 {
-	if (sfb && smtc_RegBaseAddress)
-		smtc_RegBaseAddress = NULL;
+	if (sfb && smtc_regbaseaddress)
+		smtc_regbaseaddress = NULL;
 }
 
 /*
@@ -823,7 +823,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 #else
 		sfb->lfb = ioremap(mmio_base, 0x00800000);
 #endif
-		sfb->mmio = (smtc_RegBaseAddress +		sfb->mmio = (smtc_regbaseaddress  		    sfb->lfb + 0x00700000);
 		sfb->dp_regs = sfb->lfb + 0x00408000;
 		sfb->vp_regs = sfb->lfb + 0x0040c000;
@@ -833,7 +833,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 			dev_info(&pdev->dev, "sfb->lfb=%p", sfb->lfb);
 		}
 #endif
-		if (!smtc_RegBaseAddress) {
+		if (!smtc_regbaseaddress) {
 			dev_err(&pdev->dev,
 				"%s: unable to map memory mapped IO!",
 				sfb->fb.fix.id);
@@ -859,7 +859,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		smem_size = SM722_VIDEOMEMORYSIZE;
 		sfb->dp_regs = ioremap(mmio_base, 0x00a00000);
 		sfb->lfb = sfb->dp_regs + 0x00200000;
-		sfb->mmio = (smtc_RegBaseAddress +		sfb->mmio = (smtc_regbaseaddress  		    sfb->dp_regs + 0x000c0000);
 		sfb->vp_regs = sfb->dp_regs + 0x800;
 
-- 
1.8.1.2

