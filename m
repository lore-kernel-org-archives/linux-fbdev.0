From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Wed, 19 Aug 2020 18:59:43 +0000
Subject: [PATCH v3 04/12] fbdev: aty: use generic power management
Message-Id: <20200819185654.151170-5-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <bjorn@helgaas.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Drivers should do only device-specific jobs. But in general, drivers using
legacy PCI PM framework for .suspend()/.resume() have to manage many PCI
PM-related tasks themselves which can be done by PCI Core itself. This
brings extra load on the driver and it directly calls PCI helper functions
to handle them.

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. Also, remove
unnecessary calls to the PCI Helper functions along with the legacy
.suspend & .resume bindings.

Now,
- atyfb_pci_suspend() had a "pm_message_t" type parameter as per legacy
  PCI PM framework, that got deprecated in generic.
- Rename the callback as atyfb_pci_suspend_late() and preserve the
  parameter.
- Define 3 new callbacks as:
        * atyfb_pci_suspend()
        * atyfb_pci_freeze()
        * atyfb_pci_hibernate()
  which in turn call atyfb_pci_suspend_late() by passing appropriate
  value for "pm_message_t" type parameter.
- Bind the callbacks in "struct dev_pm_ops" type variable
  "atyfb_pci_pm_ops".

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 50 ++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index b0ac895e5ac9..a24d5bf6ade1 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -132,8 +132,8 @@
 #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
 #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
-defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
+#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
+defined(CONFIG_FB_ATY_BACKLIGHT)
 static const u32 lt_lcd_regs[] = {
 	CNFG_PANEL_LG,
 	LCD_GEN_CNTL_LG,
@@ -175,7 +175,7 @@ u32 aty_ld_lcd(int index, const struct atyfb_par *par)
 		return aty_ld_le32(LCD_DATA, par);
 	}
 }
-#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
+#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 /*
@@ -1994,7 +1994,7 @@ static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 
 
-#if defined(CONFIG_PM) && defined(CONFIG_PCI)
+#if defined(CONFIG_PCI)
 
 #ifdef CONFIG_PPC_PMAC
 /* Power management routines. Those are used for PowerBook sleep.
@@ -2055,8 +2055,9 @@ static int aty_power_mgmt(int sleep, struct atyfb_par *par)
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int atyfb_pci_suspend_late(struct device *dev, pm_message_t state)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
@@ -2082,7 +2083,6 @@ static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	 * first save the config space content so the core can
 	 * restore it properly on resume.
 	 */
-	pci_save_state(pdev);
 
 #ifdef CONFIG_PPC_PMAC
 	/* Set chip to "suspend" mode */
@@ -2094,8 +2094,6 @@ static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 		console_unlock();
 		return -EIO;
 	}
-#else
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 #endif
 
 	console_unlock();
@@ -2105,6 +2103,21 @@ static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
+static int __maybe_unused atyfb_pci_suspend(struct device *dev)
+{
+	return atyfb_pci_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused atyfb_pci_hibernate(struct device *dev)
+{
+	return atyfb_pci_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int __maybe_unused atyfb_pci_freeze(struct device *dev)
+{
+	return atyfb_pci_suspend_late(dev, PMSG_FREEZE);
+}
+
 static void aty_resume_chip(struct fb_info *info)
 {
 	struct atyfb_par *par = info->par;
@@ -2119,8 +2132,9 @@ static void aty_resume_chip(struct fb_info *info)
 			aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
 }
 
-static int atyfb_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused atyfb_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
@@ -2162,7 +2176,18 @@ static int atyfb_pci_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#endif /*  defined(CONFIG_PM) && defined(CONFIG_PCI) */
+static const struct dev_pm_ops atyfb_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= atyfb_pci_suspend,
+	.resume		= atyfb_pci_resume,
+	.freeze		= atyfb_pci_freeze,
+	.thaw		= atyfb_pci_resume,
+	.poweroff	= atyfb_pci_hibernate,
+	.restore	= atyfb_pci_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
+
+#endif /*  defined(CONFIG_PCI) */
 
 /* Backlight */
 #ifdef CONFIG_FB_ATY_BACKLIGHT
@@ -3801,10 +3826,7 @@ static struct pci_driver atyfb_driver = {
 	.id_table	= atyfb_pci_tbl,
 	.probe		= atyfb_pci_probe,
 	.remove		= atyfb_pci_remove,
-#ifdef CONFIG_PM
-	.suspend	= atyfb_pci_suspend,
-	.resume		= atyfb_pci_resume,
-#endif /* CONFIG_PM */
+	.driver.pm	= &atyfb_pci_pm_ops,
 };
 
 #endif /* CONFIG_PCI */
-- 
2.28.0
