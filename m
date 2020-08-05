From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Wed, 05 Aug 2020 18:19:20 +0000
Subject: [PATCH v1 10/12] fbdev: vt8623fb: use generic power management
Message-Id: <20200805180722.244008-11-vaibhavgupta40@gmail.com>
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
 drivers/video/fbdev/vt8623fb.c | 41 ++++++++++++++--------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 7b3eef1b893f..c488e0117758 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -815,12 +815,11 @@ static void vt8623_pci_remove(struct pci_dev *dev)
 }
 
 
-#ifdef CONFIG_PM
 /* PCI suspend */
 
-static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused vt8623_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -828,7 +827,7 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event = PM_EVENT_FREEZE) || (par->ref_count = 0)) {
+	if (par->ref_count = 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -836,10 +835,6 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -849,9 +844,9 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int vt8623_pci_resume(struct pci_dev* dev)
+static int __maybe_unused vt8623_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
 	dev_info(info->device, "resume\n");
@@ -862,14 +857,6 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 	if (par->ref_count = 0)
 		goto fail;
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-
-	if (pci_enable_device(dev))
-		goto fail;
-
-	pci_set_master(dev);
-
 	vt8623fb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -879,10 +866,17 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 
 	return 0;
 }
-#else
-#define vt8623_pci_suspend NULL
-#define vt8623_pci_resume NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops vt8623_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= vt8623_pci_suspend,
+	.resume		= vt8623_pci_resume,
+	.freeze		= NULL,
+	.thaw		= vt8623_pci_resume,
+	.poweroff	= vt8623_pci_suspend,
+	.restore	= vt8623_pci_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
 
 /* List of boards that we are trying to support */
 
@@ -898,8 +892,7 @@ static struct pci_driver vt8623fb_pci_driver = {
 	.id_table	= vt8623_devices,
 	.probe		= vt8623_pci_probe,
 	.remove		= vt8623_pci_remove,
-	.suspend	= vt8623_pci_suspend,
-	.resume		= vt8623_pci_resume,
+	.driver.pm	= &vt8623_pci_pm_ops,
 };
 
 /* Cleanup */
-- 
2.27.0
