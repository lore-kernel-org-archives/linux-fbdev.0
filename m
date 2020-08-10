From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 10 Aug 2020 19:09:22 +0000
Subject: [PATCH v2 11/12] fbdev: s3fb: use generic power management
Message-Id: <20200810185723.15540-12-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200810165458.GA292825@ravnborg.org>
 <20200810185723.15540-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200810185723.15540-1-vaibhavgupta40@gmail.com>
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

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/s3fb.c | 39 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 60c424fae988..5c74253e7b2c 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1410,9 +1410,9 @@ static void s3_pci_remove(struct pci_dev *dev)
 
 /* PCI suspend */
 
-static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused s3_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct s3fb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -1420,7 +1420,7 @@ static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event = PM_EVENT_FREEZE) || (par->ref_count = 0)) {
+	if (par->ref_count = 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -1428,10 +1428,6 @@ static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -1441,11 +1437,10 @@ static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int s3_pci_resume(struct pci_dev* dev)
+static int __maybe_unused s3_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct s3fb_info *par = info->par;
-	int err;
 
 	dev_info(info->device, "resume\n");
 
@@ -1458,17 +1453,6 @@ static int s3_pci_resume(struct pci_dev* dev)
 		return 0;
 	}
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	err = pci_enable_device(dev);
-	if (err) {
-		mutex_unlock(&(par->open_lock));
-		console_unlock();
-		dev_err(info->device, "error %d enabling device for resume\n", err);
-		return err;
-	}
-	pci_set_master(dev);
-
 	s3fb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -1478,6 +1462,16 @@ static int s3_pci_resume(struct pci_dev* dev)
 	return 0;
 }
 
+static const struct dev_pm_ops s3_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= s3_pci_suspend,
+	.resume		= s3_pci_resume,
+	.freeze		= NULL,
+	.thaw		= s3_pci_resume,
+	.poweroff	= s3_pci_suspend,
+	.restore	= s3_pci_resume,
+#endif
+};
 
 /* List of boards that we are trying to support */
 
@@ -1510,8 +1504,7 @@ static struct pci_driver s3fb_pci_driver = {
 	.id_table	= s3_devices,
 	.probe		= s3_pci_probe,
 	.remove		= s3_pci_remove,
-	.suspend	= s3_pci_suspend,
-	.resume		= s3_pci_resume,
+	.driver.pm	= &s3_pci_pm_ops,
 };
 
 /* Parse user specified options */
-- 
2.27.0
