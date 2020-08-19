From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Wed, 19 Aug 2020 19:08:54 +0000
Subject: [PATCH v3 12/12] fbdev: arkfb: use generic power management
Message-Id: <20200819185654.151170-13-vaibhavgupta40@gmail.com>
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

The ark_pci_suspend() is not designed to function in the case of Freeze.
Thus, the code checked for "if (state.event = PM_EVENT_FREEZE....)". This
is because, in the legacy framework, this callback was invoked even in the
event of Freeze. Hence, added the load of unnecessary function-call.

The goal can be achieved by binding the callback with only ".suspend" and
".poweroff" in the "ark_pci_pm_ops" const variable. This also avoids the
step of checking "state.event = PM_EVENT_FREEZE" every time the callback
is invoked.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/arkfb.c | 41 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 11ab9a153860..edf169d0816e 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -1085,12 +1085,11 @@ static void ark_pci_remove(struct pci_dev *dev)
 }
 
 
-#ifdef CONFIG_PM
 /* PCI suspend */
 
-static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused ark_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct arkfb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -1098,7 +1097,7 @@ static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event = PM_EVENT_FREEZE) || (par->ref_count = 0)) {
+	if (par->ref_count = 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -1106,10 +1105,6 @@ static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -1119,9 +1114,9 @@ static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int ark_pci_resume (struct pci_dev* dev)
+static int __maybe_unused ark_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct arkfb_info *par = info->par;
 
 	dev_info(info->device, "resume\n");
@@ -1132,14 +1127,6 @@ static int ark_pci_resume (struct pci_dev* dev)
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
 	arkfb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -1148,10 +1135,17 @@ static int ark_pci_resume (struct pci_dev* dev)
 	console_unlock();
 	return 0;
 }
-#else
-#define ark_pci_suspend NULL
-#define ark_pci_resume NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops ark_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= ark_pci_suspend,
+	.resume		= ark_pci_resume,
+	.freeze		= NULL,
+	.thaw		= ark_pci_resume,
+	.poweroff	= ark_pci_suspend,
+	.restore	= ark_pci_resume,
+#endif
+};
 
 /* List of boards that we are trying to support */
 
@@ -1168,8 +1162,7 @@ static struct pci_driver arkfb_pci_driver = {
 	.id_table	= ark_devices,
 	.probe		= ark_pci_probe,
 	.remove		= ark_pci_remove,
-	.suspend	= ark_pci_suspend,
-	.resume		= ark_pci_resume,
+	.driver.pm	= &ark_pci_pm_ops,
 };
 
 /* Cleanup */
-- 
2.28.0
