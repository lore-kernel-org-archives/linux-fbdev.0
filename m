From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Tue, 28 Jul 2020 12:45:49 +0000
Subject: [PATCH v1] staging: sm750fb: use generic power management
Message-Id: <20200728123349.1331679-1-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <bjorn@helgaas.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org

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
 drivers/staging/sm750fb/sm750.c | 91 ++++++---------------------------
 1 file changed, 17 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index a1a82e59dfee..84fb585a5739 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -407,61 +407,29 @@ static inline unsigned int chan_to_field(unsigned int chan,
 	return chan << bf->offset;
 }
 
-#ifdef CONFIG_PM
-static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int __maybe_unused lynxfb_suspend(struct device *dev)
 {
 	struct fb_info *info;
 	struct sm750_dev *sm750_dev;
-	int ret;
-
-	if (mesg.event = pdev->dev.power.power_state.event)
-		return 0;
-
-	ret = 0;
-	sm750_dev = pci_get_drvdata(pdev);
-	switch (mesg.event) {
-	case PM_EVENT_FREEZE:
-	case PM_EVENT_PRETHAW:
-		pdev->dev.power.power_state = mesg;
-		return 0;
-	}
+	sm750_dev = dev_get_drvdata(dev);
 
 	console_lock();
-	if (mesg.event & PM_EVENT_SLEEP) {
-		info = sm750_dev->fbinfo[0];
-		if (info)
-			/* 1 means do suspend */
-			fb_set_suspend(info, 1);
-		info = sm750_dev->fbinfo[1];
-		if (info)
-			/* 1 means do suspend */
-			fb_set_suspend(info, 1);
-
-		ret = pci_save_state(pdev);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"error:%d occurred in pci_save_state\n", ret);
-			goto lynxfb_suspend_err;
-		}
-
-		ret = pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
-		if (ret) {
-			dev_err(&pdev->dev,
-				"error:%d occurred in pci_set_power_state\n",
-				ret);
-			goto lynxfb_suspend_err;
-		}
-	}
-
-	pdev->dev.power.power_state = mesg;
+	info = sm750_dev->fbinfo[0];
+	if (info)
+		/* 1 means do suspend */
+		fb_set_suspend(info, 1);
+	info = sm750_dev->fbinfo[1];
+	if (info)
+		/* 1 means do suspend */
+		fb_set_suspend(info, 1);
 
-lynxfb_suspend_err:
 	console_unlock();
-	return ret;
+	return 0;
 }
 
-static int lynxfb_resume(struct pci_dev *pdev)
+static int __maybe_unused lynxfb_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info;
 	struct sm750_dev *sm750_dev;
 
@@ -469,32 +437,10 @@ static int lynxfb_resume(struct pci_dev *pdev)
 	struct lynxfb_crtc *crtc;
 	struct lynx_cursor *cursor;
 
-	int ret;
-
-	ret = 0;
 	sm750_dev = pci_get_drvdata(pdev);
 
 	console_lock();
 
-	ret = pci_set_power_state(pdev, PCI_D0);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"error:%d occurred in pci_set_power_state\n", ret);
-		goto lynxfb_resume_err;
-	}
-
-	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
-		pci_restore_state(pdev);
-		ret = pci_enable_device(pdev);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"error:%d occurred in pci_enable_device\n",
-				ret);
-			goto lynxfb_resume_err;
-		}
-		pci_set_master(pdev);
-	}
-
 	hw_sm750_inithw(sm750_dev, pdev);
 
 	info = sm750_dev->fbinfo[0];
@@ -523,11 +469,9 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	pdev->dev.power.power_state.event = PM_EVENT_RESUME;
 
-lynxfb_resume_err:
 	console_unlock();
-	return ret;
+	return 0;
 }
-#endif
 
 static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info)
@@ -1210,15 +1154,14 @@ static const struct pci_device_id smi_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, smi_pci_table);
 
+static SIMPLE_DEV_PM_OPS(lynxfb_pm_ops, lynxfb_suspend, lynxfb_resume);
+
 static struct pci_driver lynxfb_driver = {
 	.name =		"sm750fb",
 	.id_table =	smi_pci_table,
 	.probe =	lynxfb_pci_probe,
 	.remove =	lynxfb_pci_remove,
-#ifdef CONFIG_PM
-	.suspend = lynxfb_suspend,
-	.resume = lynxfb_resume,
-#endif
+	.driver.pm =	&lynxfb_pm_ops,
 };
 
 static int __init lynxfb_init(void)
-- 
2.27.0
