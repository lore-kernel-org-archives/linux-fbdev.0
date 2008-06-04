From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] atyfb: Use a PCI device ID table
Date: Wed,  4 Jun 2008 12:14:23 +0300
Message-ID: <1212570865-31419-5-git-send-email-syrjala@sci.fi>
References: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
	<1212570865-31419-2-git-send-email-syrjala@sci.fi>
	<1212570865-31419-3-git-send-email-syrjala@sci.fi>
	<1212570865-31419-4-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4l-0008IN-1U for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:35 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4k-0003Vg-AY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:34 -0700
In-Reply-To: <1212570865-31419-4-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ville Syrjala <syrjala@sci.fi>, adaplas@gmail.com

Convert atyfb to use a PCI device ID table.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/aty/atyfb_base.c |   73 ++++++++++++++++++++++++++++++----------
 1 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d6903c7..872760a 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3418,14 +3418,7 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	struct fb_info *info;
 	struct resource *rp;
 	struct atyfb_par *par;
-	int i, rc = -ENOMEM;
-
-	for (i = ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
-		if (pdev->device == aty_chips[i].pci_id)
-			break;
-
-	if (i < 0)
-		return -ENODEV;
+	int rc = -ENOMEM;
 
 	/* Enable device in PCI config */
 	if (pci_enable_device(pdev)) {
@@ -3456,7 +3449,7 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	par = info->par;
 	info->fix = atyfb_fix;
 	info->device = &pdev->dev;
-	par->pci_id = aty_chips[i].pci_id;
+	par->pci_id = pdev->device;
 	par->res_start = res_start;
 	par->res_size = res_size;
 	par->irq = pdev->irq;
@@ -3655,18 +3648,62 @@ static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
 	atyfb_remove(info);
 }
 
-/*
- * This driver uses its own matching table. That will be more difficult
- * to fix, so for now, we just match against any ATI ID and let the
- * probe() function find out what's up. That also mean we don't have
- * a module ID table though.
- */
 static struct pci_device_id atyfb_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0 },
-	{ 0, }
+#ifdef CONFIG_FB_ATY_GX
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GX) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64CX) },
+#endif /* CONFIG_FB_ATY_GX */
+
+#ifdef CONFIG_FB_ATY_CT
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64CT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64ET) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LT) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64VT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GT) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64VU) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GU) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LG) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64VV) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GV) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GW) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GY) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GZ) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GB) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GD) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GQ) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LB) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LD) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LI) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LQ) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GN) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GR) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64GS) },
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LN) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LR) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_CHIP_MACH64LS) },
+#endif /* CONFIG_FB_ATY_CT */
+	{ }
 };
 
+MODULE_DEVICE_TABLE(pci, atyfb_pci_tbl);
+
 static struct pci_driver atyfb_driver = {
 	.name		= "atyfb",
 	.id_table	= atyfb_pci_tbl,
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
