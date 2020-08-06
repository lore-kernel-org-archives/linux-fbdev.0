From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Thu, 06 Aug 2020 07:38:58 +0000
Subject: [PATCH v1 2/2] fbdev: radeonfb:use generic power management
Message-Id: <20200806072658.592444-3-vaibhavgupta40@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200806072658.592444-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <bjorn@helgaas.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: linux-fbdev@vger.kernel.org, Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org

Drivers using legacy PCI power management .suspend()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a "struct dev_pm_ops"
variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 10 +++++---
 drivers/video/fbdev/aty/radeon_pm.c   | 36 +++++++++++++++++++++------
 drivers/video/fbdev/aty/radeonfb.h    |  3 +--
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index e116a3f9ad56..232dbe154666 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2559,16 +2559,18 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
         framebuffer_release(info);
 }
 
+#ifdef CONFIG_PM
+#define RADEONFB_PCI_PM_OPS (&radeonfb_pci_pm_ops)
+#else
+#define RADEONFB_PCI_PM_OPS NULL
+#endif
 
 static struct pci_driver radeonfb_driver = {
 	.name		= "radeonfb",
 	.id_table	= radeonfb_pci_table,
 	.probe		= radeonfb_pci_register,
 	.remove		= radeonfb_pci_unregister,
-#ifdef CONFIG_PM
-	.suspend       	= radeonfb_pci_suspend,
-	.resume		= radeonfb_pci_resume,
-#endif /* CONFIG_PM */
+	.driver.pm	= RADEONFB_PCI_PM_OPS,
 };
 
 #ifndef MODULE
diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index b9af70bd656a..352d0bb4773a 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -2611,8 +2611,9 @@ static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 	}
 }
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int radeonfb_pci_suspend_late(struct device *dev, pm_message_t mesg)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 
@@ -2660,11 +2661,6 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	pmac_suspend_agp_for_card(pdev);
 #endif /* CONFIG_PPC_PMAC */
 
-	/* It's unclear whether or when the generic code will do that, so let's
-	 * do it ourselves. We save state before we do any power management
-	 */
-	pci_save_state(pdev);
-
 	/* If we support wakeup from poweroff, we save all regs we can including cfg
 	 * space
 	 */
@@ -2689,7 +2685,6 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 			msleep(20);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_DIGON));
 		}
-		pci_disable_device(pdev);
 	}
 	/* If we support D2, we go to it (should be fixed later with a flag forcing
 	 * D3 only for some laptops)
@@ -2705,6 +2700,21 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	return 0;
 }
 
+static int radeonfb_pci_suspend(struct device *dev)
+{
+	return radeonfb_pci_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int radeonfb_pci_hibernate(struct device *dev)
+{
+	return radeonfb_pci_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int radeonfb_pci_freeze(struct device *dev)
+{
+	return radeonfb_pci_suspend_late(dev, PMSG_FREEZE);
+}
+
 static int radeon_check_power_loss(struct radeonfb_info *rinfo)
 {
 	return rinfo->save_regs[4] != INPLL(CLK_PIN_CNTL) ||
@@ -2712,8 +2722,9 @@ static int radeon_check_power_loss(struct radeonfb_info *rinfo)
 	       rinfo->save_regs[3] != INPLL(SCLK_CNTL);
 }
 
-int radeonfb_pci_resume(struct pci_dev *pdev)
+static int radeonfb_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
@@ -2795,6 +2806,15 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
 	return rc;
 }
 
+const struct dev_pm_ops radeonfb_pci_pm_ops = {
+	.suspend	= radeonfb_pci_suspend,
+	.resume		= radeonfb_pci_resume,
+	.freeze		= radeonfb_pci_freeze,
+	.thaw		= radeonfb_pci_resume,
+	.poweroff	= radeonfb_pci_hibernate,
+	.restore	= radeonfb_pci_resume,
+};
+
 #ifdef CONFIG_PPC__disabled
 static void radeonfb_early_resume(void *data)
 {
diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/aty/radeonfb.h
index 131b34dd65af..93f403cbb415 100644
--- a/drivers/video/fbdev/aty/radeonfb.h
+++ b/drivers/video/fbdev/aty/radeonfb.h
@@ -483,8 +483,7 @@ extern void radeon_delete_i2c_busses(struct radeonfb_info *rinfo);
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
-extern int radeonfb_pci_resume(struct pci_dev *pdev);
+extern const struct dev_pm_ops radeonfb_pci_pm_ops;
 extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlist, int force_sleep);
 extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
 
-- 
2.27.0
