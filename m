From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Wed, 19 Aug 2020 18:59:06 +0000
Subject: [PATCH v3 01/12] fbdev: gxfb: use generic power management
Message-Id: <20200819185654.151170-2-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <bjorn@helgaas.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>, Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. This way we can
remove the legacy .suspend & .resume bindings from "gxfb_driver".

The gxfb_suspend() is designed to function only in the case of Suspend.
Thus, the code was kept inside "if (state.event = PM_EVENT_SUSPEND)"
container. This is because, in the legacy framework, this callback was
invoked even in the event of Freeze and Hibernate. Hence, added the load of
unnecessary function-calls.

The goal can be achieved by binding the callback with only
"gxfb_pm_ops.suspend" in the new framework. This also avoids the step of
checking "if (state.event = PM_EVENT_SUSPEND)" every time the callback is
invoked.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/geode/gxfb.h       |  5 ----
 drivers/video/fbdev/geode/gxfb_core.c  | 36 ++++++++++++++------------
 drivers/video/fbdev/geode/suspend_gx.c |  4 ---
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/geode/gxfb.h b/drivers/video/fbdev/geode/gxfb.h
index d2e9c5c8e294..792c111c21e4 100644
--- a/drivers/video/fbdev/geode/gxfb.h
+++ b/drivers/video/fbdev/geode/gxfb.h
@@ -21,7 +21,6 @@ struct gxfb_par {
 	void __iomem *dc_regs;
 	void __iomem *vid_regs;
 	void __iomem *gp_regs;
-#ifdef CONFIG_PM
 	int powered_down;
 
 	/* register state, for power management functionality */
@@ -36,7 +35,6 @@ struct gxfb_par {
 	uint64_t fp[FP_REG_COUNT];
 
 	uint32_t pal[DC_PAL_COUNT];
-#endif
 };
 
 unsigned int gx_frame_buffer_size(void);
@@ -49,11 +47,8 @@ void gx_set_dclk_frequency(struct fb_info *info);
 void gx_configure_display(struct fb_info *info);
 int gx_blank_display(struct fb_info *info, int blank_mode);
 
-#ifdef CONFIG_PM
 int gx_powerdown(struct fb_info *info);
 int gx_powerup(struct fb_info *info);
-#endif
-
 
 /* Graphics Processor registers (table 6-23 from the data book) */
 enum gp_registers {
diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index d38a148d4746..44089b331f91 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -322,17 +322,14 @@ static struct fb_info *gxfb_init_fbinfo(struct device *dev)
 	return info;
 }
 
-#ifdef CONFIG_PM
-static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused gxfb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 
-	if (state.event = PM_EVENT_SUSPEND) {
-		console_lock();
-		gx_powerdown(info);
-		fb_set_suspend(info, 1);
-		console_unlock();
-	}
+	console_lock();
+	gx_powerdown(info);
+	fb_set_suspend(info, 1);
+	console_unlock();
 
 	/* there's no point in setting PCI states; we emulate PCI, so
 	 * we don't end up getting power savings anyways */
@@ -340,9 +337,9 @@ static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int gxfb_resume(struct pci_dev *pdev)
+static int __maybe_unused gxfb_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	int ret;
 
 	console_lock();
@@ -356,7 +353,6 @@ static int gxfb_resume(struct pci_dev *pdev)
 	console_unlock();
 	return 0;
 }
-#endif
 
 static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -467,15 +463,23 @@ static const struct pci_device_id gxfb_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, gxfb_id_table);
 
+static const struct dev_pm_ops gxfb_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= gxfb_suspend,
+	.resume		= gxfb_resume,
+	.freeze		= NULL,
+	.thaw		= gxfb_resume,
+	.poweroff	= NULL,
+	.restore	= gxfb_resume,
+#endif
+};
+
 static struct pci_driver gxfb_driver = {
 	.name		= "gxfb",
 	.id_table	= gxfb_id_table,
 	.probe		= gxfb_probe,
 	.remove		= gxfb_remove,
-#ifdef CONFIG_PM
-	.suspend	= gxfb_suspend,
-	.resume		= gxfb_resume,
-#endif
+	.driver.pm	= &gxfb_pm_ops,
 };
 
 #ifndef MODULE
diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
index 1110a527c35c..8c49d4e98772 100644
--- a/drivers/video/fbdev/geode/suspend_gx.c
+++ b/drivers/video/fbdev/geode/suspend_gx.c
@@ -11,8 +11,6 @@
 
 #include "gxfb.h"
 
-#ifdef CONFIG_PM
-
 static void gx_save_regs(struct gxfb_par *par)
 {
 	int i;
@@ -259,5 +257,3 @@ int gx_powerup(struct fb_info *info)
 	par->powered_down  = 0;
 	return 0;
 }
-
-#endif
-- 
2.28.0
