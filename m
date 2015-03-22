From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 22 Mar 2015 19:59:43 +0000
Subject: [PATCH 4/5] [resend 2] gxt4500: Use write-combining for framebuffer (PAT and MTRR)
Message-Id: <1427054384-26501-4-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427054384-26501-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1427054384-26501-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Use write-combining for framebuffer to greatly improve performance on x86.
Add both ioremap_wc (for systems with PAT) and MTRR setup for non-PAT systems.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/gxt4500.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 442b07c..f278c82 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -13,6 +13,9 @@
 #include <linux/pci_ids.h>
 #include <linux/delay.h>
 #include <linux/string.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 #define PCI_DEVICE_ID_IBM_GXT4500P	0x21c
 #define PCI_DEVICE_ID_IBM_GXT6500P	0x21b
@@ -142,7 +145,9 @@ static const unsigned char watfmt[] = {
 
 struct gxt4500_par {
 	void __iomem *regs;
-
+#ifdef CONFIG_MTRR
+	int mtrr_reg;
+#endif
 	int pixfmt;		/* pixel format, see DFA_PIX_* values */
 
 	/* PLL parameters */
@@ -158,6 +163,10 @@ struct gxt4500_par {
 /* mode requested by user */
 static char *mode_option;
 
+#ifdef CONFIG_MTRR
+static int mtrr = 1;
+#endif
+
 /* default mode: 1280x1024 @ 60 Hz, 8 bpp */
 static const struct fb_videomode defaultmode = {
 	.refresh = 60,
@@ -663,7 +672,7 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	info->fix.smem_start = fb_phys;
 	info->fix.smem_len = pci_resource_len(pdev, 1);
-	info->screen_base = pci_ioremap_bar(pdev, 1);
+	info->screen_base = ioremap_wc(fb_phys, info->fix.smem_len);
 	if (!info->screen_base) {
 		dev_err(&pdev->dev, "gxt4500: cannot map framebuffer\n");
 		goto err_unmap_regs;
@@ -671,6 +680,14 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, info);
 
+#ifdef CONFIG_MTRR
+	if (mtrr) {
+		par->mtrr_reg = -1;
+		par->mtrr_reg = mtrr_add(info->fix.smem_start,
+				info->fix.smem_len, MTRR_TYPE_WRCOMB, 1);
+	}
+#endif
+
 #ifdef __BIG_ENDIAN
 	/* Set byte-swapping for DFA aperture for all pixel sizes */
 	pci_write_config_dword(pdev, CFG_ENDIAN0, 0x333300);
@@ -735,6 +752,12 @@ static void gxt4500_remove(struct pci_dev *pdev)
 		return;
 	par = info->par;
 	unregister_framebuffer(info);
+#ifdef CONFIG_MTRR
+	if (par->mtrr_reg >= 0) {
+		mtrr_del(par->mtrr_reg, 0, 0);
+		par->mtrr_reg = -1;
+	}
+#endif
 	fb_dealloc_cmap(&info->cmap);
 	iounmap(par->regs);
 	iounmap(info->screen_base);
@@ -789,3 +812,8 @@ MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6500P and GXT4000P/6000P");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\"");
+
+#ifdef CONFIG_MTRR
+module_param(mtrr, int, 0444);
+MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, default=1)");
+#endif
-- 
Ondrej Zary

