From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>
Subject: [PATCH 3/3] cr_pll: Add suspend/resume support.
Date: Thu, 16 Aug 2007 17:19:58 +0200
Message-ID: <18728.1586732299$1187279602@news.gmane.org>
References: <11872775981058-git-send-email-> <11872775984188-git-send-email->
	<11872775982982-git-send-email->
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1157803628=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILhem-0008Rb-Pu for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 08:53:09 -0700
Received: from darkcity.gna.ch ([195.226.6.51] helo=mail.gna.ch)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILhej-0003F3-Ly
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 08:53:08 -0700
In-Reply-To: <11872775982982-git-send-email->
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
To: Antonino Daplas <adaplas@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>, Alan Hourihane <alanh@tungstengraphics.com>

--===============1157803628==

From: Michel D������nzer <michel@tungstengraphics.com>

Mostly save and restore all (extended) PCI config space and device registers,
with one exception.

Signed-off-by: Michel D������nzer <michel@tungstengraphics.com>
---
 drivers/video/vermilion/cr_pll.c |  228 +++++++++++++++++++++++++++++++++++--
 1 files changed, 215 insertions(+), 13 deletions(-)

diff --git a/drivers/video/vermilion/cr_pll.c b/drivers/video/vermilion/cr_pll.c
index ebc6e6e..ab652ec 100644
--- a/drivers/video/vermilion/cr_pll.c
+++ b/drivers/video/vermilion/cr_pll.c
@@ -25,6 +25,7 @@
  * Authors:
  *   Thomas Hellstrom <thomas-at-tungstengraphics-dot-com>
  *   Alan Hourihane <alanh-at-tungstengraphics-dot-com>
+ *   Michel D������nzer <michel-at-tungstengraphics-dot-com>
  */
 
 #include <linux/module.h>
@@ -34,12 +35,20 @@
 #include <linux/fb.h>
 #include "vermilion.h"
 
+#define MODULE_NAME "crvml"
+
 /* The PLL Clock register sits on Host bridge */
 #define CRVML_DEVICE_MCH   0x5001
+#define CRVML_REG_EPBAR    0x40
 #define CRVML_REG_MCHBAR   0x44
-#define CRVML_REG_MCHEN    0x54
+#define CRVML_REG_DMIBAR   0x4C
+#define CRVML_REG_DEVEN    0x54
+#define CRVML_EPEN_BIT     (1 << 27)
 #define CRVML_MCHEN_BIT    (1 << 28)
-#define CRVML_MCHMAP_SIZE  4096
+#define CRVML_DMIEN_BIT    (1 << 29)
+#define CRVML_EPMAP_SIZE   4096
+#define CRVML_MCHMAP_SIZE  16384
+#define CRVML_DMIMAP_SIZE  4096
 #define CRVML_REG_CLOCK    0xc3c
 #define CRVML_CLOCK_SHIFT  8
 #define CRVML_CLOCK_MASK   0x00000f00
@@ -49,6 +58,25 @@ static u32 mch_bar;
 static void __iomem *mch_regs_base;
 static u32 saved_clock;
 
+#ifdef CONFIG_PM
+
+#define NUM_MCH_EXTRA_CONFIG_SPACE 48
+static int mch_saved_config_space[NUM_MCH_EXTRA_CONFIG_SPACE];
+
+static u32 dmi_bar;
+static void __iomem *dmi_regs_base;
+static u32 ep_bar;
+static void __iomem *ep_regs_base;
+
+#define REGSAVE_SIZE (CRVML_EPMAP_SIZE + CRVML_DMIMAP_SIZE + CRVML_MCHMAP_SIZE)
+static u32 *regsave;
+
+static struct pci_dev *pci2pci_dev;
+#define NUM_PCI2PCI_EXTRA_CONFIG_SPACE 6
+static int pci2pci_saved_config_space[NUM_PCI2PCI_EXTRA_CONFIG_SPACE];
+
+#endif /* CONFIG_PM */
+
 static const unsigned crvml_clocks[] = {
 	6750,
 	13500,
@@ -78,6 +106,123 @@ static const u32 crvml_clock_bits[] = {
 
 static const unsigned crvml_num_clocks = ARRAY_SIZE(crvml_clocks);
 
+#ifdef CONFIG_PM
+
+static void crvml_save_device(struct pci_dev *pdev, int num_extra_cfg,
+			      int *saved_extra_cfg, pm_message_t state)
+{
+	int i;
+
+	for (i = 0; i < num_extra_cfg; i++)
+		pci_read_config_dword(pdev, (i + 16) * 4, &saved_extra_cfg[i]);
+
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+}
+
+static int crvml_suspend(const struct vml_sys *sys, pm_message_t state)
+{
+	int reg;
+	int saveidx = 0;
+
+	printk(KERN_DEBUG MODULE_NAME ": suspending to state: %d\n",
+	       state.event);
+
+	/* Save registers and config space */
+
+	regsave = kmalloc(REGSAVE_SIZE, GFP_ATOMIC);
+
+	if (!regsave) {
+		printk(KERN_ERR MODULE_NAME
+		       ": Could not allocate %d bytes for saving registers\n",
+		       REGSAVE_SIZE);
+		return -ENOMEM;
+	}
+
+	for (reg = 0; reg < CRVML_EPMAP_SIZE; reg += 4)
+		regsave[saveidx++] = ioread32(ep_regs_base + reg);
+
+	for (reg = 0; reg < CRVML_DMIMAP_SIZE; reg += 4)
+		regsave[saveidx++] = ioread32(dmi_regs_base + reg);
+
+	for (reg = 0; reg < CRVML_MCHMAP_SIZE; reg += 4)
+		if (reg != 0xc48)
+			regsave[saveidx++] = ioread32(mch_regs_base + reg);
+
+	crvml_save_device(mch_dev, NUM_MCH_EXTRA_CONFIG_SPACE,
+			  mch_saved_config_space, state);
+
+	crvml_save_device(pci2pci_dev, NUM_PCI2PCI_EXTRA_CONFIG_SPACE,
+			  pci2pci_saved_config_space, state);
+
+	return 0;
+}
+
+static int crvml_restore_device(struct pci_dev *pdev, int num_extra_cfg,
+				int *saved_extra_cfg)
+{
+	int i;
+	int val;
+
+	pci_restore_state(pdev);
+	pci_set_power_state(pdev, PCI_D0);
+	for (i = 0; i < num_extra_cfg; i++) {
+		pci_read_config_dword(pdev, (i + 16) * 4, &val);
+		if (val != saved_extra_cfg[i]) {
+			printk(KERN_DEBUG MODULE_NAME ": Writing back config "
+			       "space on device %s at offset %x (was %x, "
+			       "writing %x)\n", pci_name(pdev), (i + 16), val,
+			       saved_extra_cfg[i]);
+			pci_write_config_dword(pdev, (i + 16) * 4,
+					       saved_extra_cfg[i]);
+		}
+	}
+
+	return pci_enable_device(pdev);
+}
+
+static int crvml_resume(const struct vml_sys *sys)
+{
+	int reg;
+	int ret;
+	int restoreidx = 0;
+
+	/* Restore config space and registers */
+
+	ret = crvml_restore_device(pci2pci_dev, NUM_PCI2PCI_EXTRA_CONFIG_SPACE,
+				   pci2pci_saved_config_space);
+
+	if (ret)
+		return ret;
+
+	ret = crvml_restore_device(mch_dev, NUM_MCH_EXTRA_CONFIG_SPACE,
+				   mch_saved_config_space);
+
+	if (ret)
+		return ret;
+
+	for (reg = 0; reg < CRVML_EPMAP_SIZE; reg += 4)
+		iowrite32(regsave[restoreidx++], ep_regs_base + reg);
+
+	for (reg = 0; reg < CRVML_DMIMAP_SIZE; reg += 4)
+		iowrite32(regsave[restoreidx++], dmi_regs_base + reg);
+
+	for (reg = 0; reg < CRVML_MCHMAP_SIZE; reg += 4)
+		if (reg != 0xc48)
+			iowrite32(regsave[restoreidx++], mch_regs_base + reg);
+
+	/* Flush posted writes */
+	ioread32(mch_regs_base);
+
+	kfree(regsave);
+
+	printk(KERN_DEBUG MODULE_NAME ": resumed\n");
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static int crvml_sys_restore(struct vml_sys *sys)
 {
 	void __iomem *clock_reg = mch_regs_base + CRVML_REG_CLOCK;
@@ -147,6 +292,10 @@ static struct vml_sys cr_pll_ops = {
 	.restore = crvml_sys_restore,
 	.set_clock = crvml_set_clock,
 	.nearest_clock = crvml_nearest_clock,
+#ifdef CONFIG_PM
+	.suspend = crvml_suspend,
+	.resume = crvml_resume,
+#endif
 };
 
 static int __init cr_pll_init(void)
@@ -162,12 +311,12 @@ static int __init cr_pll_init(void)
 		return -ENODEV;
 	}
 
-	pci_read_config_dword(mch_dev, CRVML_REG_MCHEN, &dev_en);
+	pci_read_config_dword(mch_dev, CRVML_REG_DEVEN, &dev_en);
 	if (!(dev_en & CRVML_MCHEN_BIT)) {
 		printk(KERN_ERR
-		       "Carillo Ranch MCH device was not enabled.\n");
-		pci_dev_put(mch_dev);
-		return -ENODEV;
+		       "Carillo Ranch MCH BAR was not enabled.\n");
+		err = -ENODEV;
+		goto err_0;
 	}
 
 	pci_read_config_dword(mch_dev, CRVML_REG_MCHBAR,
@@ -176,26 +325,79 @@ static int __init cr_pll_init(void)
 	    ioremap_nocache(mch_bar, CRVML_MCHMAP_SIZE);
 	if (!mch_regs_base) {
 		printk(KERN_ERR
-		       "Carillo Ranch MCH device was not enabled.\n");
-		pci_dev_put(mch_dev);
-		return -ENODEV;
+		       "Failed to map Carillo Ranch MCH BAR.\n");
+		err = -ENODEV;
+		goto err_0;
 	}
 
+#ifdef CONFIG_PM
+	if (!(dev_en & CRVML_DMIEN_BIT ) || !(dev_en & CRVML_EPEN_BIT)) {
+		printk(KERN_ERR
+		       "Carillo Ranch DMI or EP BAR was not enabled.\n");
+		err = -ENODEV;
+		goto err_1;
+	}
+
+	pci_read_config_dword(mch_dev, CRVML_REG_DMIBAR, &dmi_bar);
+	dmi_regs_base = ioremap_nocache(dmi_bar, CRVML_DMIMAP_SIZE);
+	if (!dmi_regs_base) {
+		printk(KERN_ERR
+		       "Failed to map Carillo Ranch DMI BAR.\n");
+		err = -ENODEV;
+		goto err_1;
+	}
+
+	pci_read_config_dword(mch_dev, CRVML_REG_EPBAR, &ep_bar);
+	ep_regs_base = ioremap_nocache(ep_bar, CRVML_EPMAP_SIZE);
+	if (!ep_regs_base) {
+		printk(KERN_ERR
+		       "Failed to map Carillo Ranch EP BAR.\n");
+		err = -ENODEV;
+		goto err_2;
+	}
+
+	pci2pci_dev = pci_get_device(PCI_VENDOR_ID_INTEL,
+				     PCI_DEVICE_ID_INTEL_82801BA_11, NULL);
+	if (!pci2pci_dev) {
+		printk(KERN_ERR
+		       "Could not find Carillo Ranch PCI bridge.\n");
+		err = -ENODEV;
+		goto err_3;
+	}
+#endif /* CONFIG_PM */
+
 	err = vmlfb_register_subsys(&cr_pll_ops);
 	if (err) {
 		printk(KERN_ERR
 		       "Carillo Ranch failed to initialize vml_sys.\n");
-		pci_dev_put(mch_dev);
-		return err;
-	}
+	} else
+		return 0;
 
-	return 0;
+#ifdef CONFIG_PM
+	pci_dev_put(pci2pci_dev);
+err_3:
+	iounmap(ep_regs_base);
+err_2:
+	iounmap(dmi_regs_base);
+err_1:
+#endif
+	iounmap(mch_regs_base);
+err_0:
+	pci_dev_put(mch_dev);
+
+	return err;
 }
 
 static void __exit cr_pll_exit(void)
 {
 	vmlfb_unregister_subsys(&cr_pll_ops);
 
+#ifdef CONFIG_PM
+	pci_dev_put(pci2pci_dev);
+
+	iounmap(ep_regs_base);
+	iounmap(dmi_regs_base);
+#endif
 	iounmap(mch_regs_base);
 	pci_dev_put(mch_dev);
 }
-- 
1.5.2.4



--===============1157803628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1157803628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1157803628==--
