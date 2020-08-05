From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Wed, 05 Aug 2020 18:19:15 +0000
Subject: [PATCH v1 05/12] fbdev: aty128fb: use generic power management
Message-Id: <20200805180722.244008-6-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <bjorn@helgaas.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, Antonino Daplas <adaplas@gmail.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Drivers using legacy power management .suspen()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a single
"struct dev_pm_ops" variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 51 ++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index d05d4195acad..dd7762fea058 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -162,10 +162,22 @@ static char * const r128_family[] = {
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
-static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state);
-static int aty128_pci_resume(struct pci_dev *pdev);
+static int aty128_pci_suspend_late(struct device *dev, pm_message_t state);
+static int __maybe_unused aty128_pci_suspend(struct device *dev);
+static int __maybe_unused aty128_pci_hibernate(struct device *dev);
+static int __maybe_unused aty128_pci_freeze(struct device *dev);
+static int __maybe_unused aty128_pci_resume(struct device *dev);
 static int aty128_do_resume(struct pci_dev *pdev);
 
+static const struct dev_pm_ops aty128_pci_pm_ops = {
+	.suspend	= aty128_pci_suspend,
+	.resume		= aty128_pci_resume,
+	.freeze		= aty128_pci_freeze,
+	.thaw		= aty128_pci_resume,
+	.poweroff	= aty128_pci_hibernate,
+	.restore	= aty128_pci_resume,
+};
+
 /* supported Rage128 chipsets */
 static const struct pci_device_id aty128_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LE,
@@ -272,8 +284,7 @@ static struct pci_driver aty128fb_driver = {
 	.id_table	= aty128_pci_tbl,
 	.probe		= aty128_probe,
 	.remove		= aty128_remove,
-	.suspend	= aty128_pci_suspend,
-	.resume		= aty128_pci_resume,
+	.driver.pm	= &aty128_pci_pm_ops,
 };
 
 /* packed BIOS settings */
@@ -2320,7 +2331,6 @@ static int aty128fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 {
 	u32	pmgt;
-	struct pci_dev *pdev = par->pdev;
 
 	if (!par->pdev->pm_cap)
 		return;
@@ -2347,23 +2357,15 @@ static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 		aty_st_le32(BUS_CNTL1, 0x00000010);
 		aty_st_le32(MEM_POWER_MISC, 0x0c830000);
 		msleep(100);
-
-		/* Switch PCI power management to D2 */
-		pci_set_power_state(pdev, PCI_D2);
 	}
 }
 
-static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int aty128_pci_suspend_late(struct device *dev, pm_message_t state)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
 
-	/* Because we may change PCI D state ourselves, we need to
-	 * first save the config space content so the core can
-	 * restore it properly on resume.
-	 */
-	pci_save_state(pdev);
-
 	/* We don't do anything but D2, for now we return 0, but
 	 * we may want to change that. How do we know if the BIOS
 	 * can properly take care of D3 ? Also, with swsusp, we
@@ -2422,6 +2424,21 @@ static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
+static int __maybe_unused aty128_pci_suspend(struct device *dev)
+{
+	return aty128_pci_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused aty128_pci_hibernate(struct device *dev)
+{
+	return aty128_pci_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int __maybe_unused aty128_pci_freeze(struct device *dev)
+{
+	return aty128_pci_suspend_late(dev, PMSG_FREEZE);
+}
+
 static int aty128_do_resume(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
@@ -2468,12 +2485,12 @@ static int aty128_do_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-static int aty128_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused aty128_pci_resume(struct device *dev)
 {
 	int rc;
 
 	console_lock();
-	rc = aty128_do_resume(pdev);
+	rc = aty128_do_resume(to_pci_dev(dev));
 	console_unlock();
 
 	return rc;
-- 
2.27.0
