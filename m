From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>
Subject: [PATCH 1/3] cr_bllcd: Add suspend/resume
	support.
Date: Thu, 16 Aug 2007 17:19:56 +0200
Message-ID: <6421.99275685034$1187279597@news.gmane.org>
References: <11872775981058-git-send-email->
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1506069667=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILhel-0008Q0-9B for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 08:53:07 -0700
Received: from darkcity.gna.ch ([195.226.6.51] helo=mail.gna.ch)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILhej-0003F5-FS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 08:53:07 -0700
In-Reply-To: <11872775981058-git-send-email->
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Alan Hourihane <alanh@tungstengraphics.com>

--===============1506069667==

Mostly save and restore all (extended) PCI config space and device registers,
with one exception.

Also remove some unused definitions and fix a PTR_ERR() typo.

Signed-off-by: Michel D������nzer <michel@tungstengraphics.com>
---
 drivers/video/backlight/cr_bllcd.c |  148 +++++++++++++++++++++++++++++++++---
 1 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index b7904da..7048c29 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -25,6 +25,7 @@
  * Authors:
  *   Thomas Hellstrom <thomas-at-tungstengraphics-dot-com>
  *   Alan Hourihane <alanh-at-tungstengraphics-dot-com>
+ *   Michel D������nzer <michel-at-tungstengraphics-dot-com>
  */
 
 #include <linux/module.h>
@@ -38,6 +39,8 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
+#define MODULE_NAME "cr_bllcd"
+
 /* The LVDS- and panel power controls sits on the
  * GPIO port of the ISA bridge.
  */
@@ -51,19 +54,25 @@
 #define CRVML_PANEL_ON      0x00000002
 #define CRVML_BACKLIGHT_OFF 0x00000004
 
-/* The PLL Clock register sits on Host bridge */
-#define CRVML_DEVICE_MCH   0x5001
-#define CRVML_REG_MCHBAR   0x44
-#define CRVML_REG_MCHEN    0x54
-#define CRVML_MCHEN_BIT    (1 << 28)
-#define CRVML_MCHMAP_SIZE  4096
-#define CRVML_REG_CLOCK    0xc3c
-#define CRVML_CLOCK_SHIFT  8
-#define CRVML_CLOCK_MASK   0x00000f00
-
 static struct pci_dev *lpc_dev;
 static u32 gpio_bar;
 
+#ifdef CONFIG_PM
+
+#define NUM_LPC_EXTRA_CONFIG_SPACE 45
+static int lpc_saved_config_space[NUM_LPC_EXTRA_CONFIG_SPACE];
+
+#define CRVML_REG_RCBABAR   0xF0
+#define CRVML_RCBAEN_BIT    (1 << 0)
+#define CRVML_RCBAMAP_SIZE  16384
+static u32 rcba_bar;
+static void __iomem *rcba_regs_base;
+
+#define REGSAVE_SIZE (CRVML_RCBAMAP_SIZE + 4)
+static u32 *regsave;
+
+#endif /* CONFIG_PM */
+
 struct cr_panel {
 	struct backlight_device *cr_backlight_device;
 	struct lcd_device *cr_lcd_device;
@@ -169,6 +178,94 @@ static struct lcd_ops cr_lcd_ops = {
 	.set_power = cr_lcd_set_power,
 };
 
+#ifdef CONFIG_PM
+
+static int cr_backlight_suspend(struct platform_device *pdev,
+				pm_message_t state)
+{
+	int i;
+	int reg;
+	int saveidx = 0;
+
+	printk(KERN_DEBUG MODULE_NAME ": suspending to state: %d\n",
+	       state.event);
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
+	/* Save registers and config space */
+
+	regsave[saveidx++] = inl(gpio_bar + CRVML_PANEL_PORT);
+
+	for (reg = 0; reg < CRVML_RCBAMAP_SIZE; reg += 4)
+		regsave[saveidx++] = ioread32(rcba_regs_base + reg);
+
+	pci_save_state(lpc_dev);
+	for (i = 0; i < NUM_LPC_EXTRA_CONFIG_SPACE; i++)
+		pci_read_config_dword(lpc_dev, (i + 16) * 4,
+				      &lpc_saved_config_space[i]);
+	pci_disable_device(lpc_dev);
+	pci_set_power_state(lpc_dev, pci_choose_state(lpc_dev, state));
+
+	pdev->dev.power.power_state = state;
+
+	return 0;
+}
+
+static int cr_backlight_resume(struct platform_device *pdev)
+{
+	int i;
+	int reg;
+	int val;
+	int restoreidx = 0;
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
+		return 0;
+
+	pci_set_power_state(lpc_dev, PCI_D0);
+	pci_restore_state(lpc_dev);
+	for (i = 0; i < NUM_LPC_EXTRA_CONFIG_SPACE; i++) {
+		if (i == 0x70 / 4)
+			continue;
+
+		pci_read_config_dword(lpc_dev, (i + 16) * 4, &val);
+		if (val != lpc_saved_config_space[i]) {
+			printk(KERN_DEBUG MODULE_NAME ": Writing back config "
+			       "space on device %s at offset %x (was %x, "
+			       "writing %x)\n", pci_name(lpc_dev), (i + 16),
+			       val, lpc_saved_config_space[i]);
+			pci_write_config_dword(lpc_dev, (i + 16) * 4,
+					       lpc_saved_config_space[i]);
+		}
+	}
+	if (pci_enable_device(lpc_dev))
+		return -1;
+
+	outl(regsave[restoreidx++], gpio_bar + CRVML_PANEL_PORT);
+
+	for (reg = 0; reg < CRVML_RCBAMAP_SIZE; reg += 4)
+		iowrite32(regsave[restoreidx++], rcba_regs_base + reg);
+
+	/* Flush posted writes */
+	ioread32(rcba_regs_base);
+
+	kfree(regsave);
+
+	pdev->dev.power.power_state = PMSG_ON;
+
+	printk(KERN_DEBUG MODULE_NAME ": resumed\n");
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static int cr_backlight_probe(struct platform_device *pdev)
 {
 	struct cr_panel *crp;
@@ -207,7 +304,7 @@ static int cr_backlight_probe(struct platform_device *pdev)
 
 	if (IS_ERR(crp->cr_lcd_device)) {
 		pci_dev_put(lpc_dev);
-		return PTR_ERR(crp->cr_backlight_device);
+		return PTR_ERR(crp->cr_lcd_device);
 	}
 
 	pci_read_config_dword(lpc_dev, CRVML_REG_GPIOBAR,
@@ -223,6 +320,26 @@ static int cr_backlight_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, crp);
 
+#ifdef CONFIG_PM
+	pci_read_config_dword(lpc_dev, CRVML_REG_RCBABAR, &rcba_bar);
+
+	if (!(rcba_bar & CRVML_RCBAEN_BIT)) {
+		printk(KERN_ERR MODULE_NAME
+		       ": Carillo Ranch LPC device RCBA BAR was not enabled\n");
+		pci_dev_put(lpc_dev);
+		return -ENODEV;
+	}
+
+	rcba_regs_base =
+	    ioremap_nocache(rcba_bar, CRVML_RCBAMAP_SIZE);
+	if (!rcba_regs_base) {
+		printk(KERN_ERR MODULE_NAME
+		       ": Could not map Carillo Ranch RCBA BAR\n");
+		pci_dev_put(lpc_dev);
+		return -ENODEV;
+	}
+#endif /* CONFIG_PM */
+
 	return 0;
 }
 
@@ -236,6 +353,11 @@ static int cr_backlight_remove(struct platform_device *pdev)
 	cr_lcd_set_power(crp->cr_lcd_device, FB_BLANK_POWERDOWN);
 	backlight_device_unregister(crp->cr_backlight_device);
 	lcd_device_unregister(crp->cr_lcd_device);
+	platform_set_drvdata(pdev, NULL);
+#ifdef CONFIG_PM
+	iounmap(rcba_regs_base);
+#endif
+	kfree(crp);
 	pci_dev_put(lpc_dev);
 
 	return 0;
@@ -247,6 +369,10 @@ static struct platform_driver cr_backlight_driver = {
 	.driver = {
 		   .name = "cr_backlight",
 		   },
+#ifdef CONFIG_PM
+	.suspend = cr_backlight_suspend,
+	.resume = cr_backlight_resume,
+#endif
 };
 
 static struct platform_device *crp;
-- 
1.5.2.4



--===============1506069667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1506069667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1506069667==--
