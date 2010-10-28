From: Daniel Drake <dsd@laptop.org>
Date: Thu, 28 Oct 2010 17:23:01 +0000
Subject: [PATCH 1/2] viafb: General power management infrastructure
Message-Id: <20101028172301.BF7499D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Multiple devices need S/R hooks (framebuffer, GPIO, camera).
Add infrastructure and convert existing framebuffer code to the new
model.

This patch should create no functional change.
Based on earlier work by Jonathan Corbet.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/via/via-core.c |   79 ++++++++++++++++++++++++++++++++++++++++-
 drivers/video/via/viafbdev.c |   34 ++++++++----------
 drivers/video/via/viafbdev.h |    2 -
 include/linux/via-core.h     |   15 ++++++++
 4 files changed, 107 insertions(+), 23 deletions(-)

Jon: please review, I've added a mutex around viafb_pm_hooks and added
an unregister function so that modules can be safely unloaded/reloaded

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 2417332..c3bbcba 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/pm.h>
 
 /*
  * The default port config.
@@ -575,6 +577,78 @@ static void via_teardown_subdevs(void)
 		}
 }
 
+/*
+ * Power management functions
+ */
+#ifdef CONFIG_PM
+static LIST_HEAD(viafb_pm_hooks);
+static DEFINE_MUTEX(viafb_pm_hooks_lock);
+
+void viafb_pm_register(struct viafb_pm_hooks *hooks)
+{
+	INIT_LIST_HEAD(&hooks->list);
+
+	mutex_lock(&viafb_pm_hooks_lock);
+	list_add_tail(&hooks->list, &viafb_pm_hooks);
+	mutex_unlock(&viafb_pm_hooks_lock);
+}
+EXPORT_SYMBOL_GPL(viafb_pm_register);
+
+void viafb_pm_unregister(struct viafb_pm_hooks *hooks)
+{
+	mutex_lock(&viafb_pm_hooks_lock);
+	list_del(&hooks->list);
+	mutex_unlock(&viafb_pm_hooks_lock);
+}
+EXPORT_SYMBOL_GPL(viafb_pm_unregister);
+
+static int via_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct viafb_pm_hooks *hooks;
+
+	if (state.event != PM_EVENT_SUSPEND)
+		return 0;
+	/*
+	 * "I've occasionally hit a few drivers that caused suspend
+	 * failures, and each and every time it was a driver bug, and
+	 * the right thing to do was to just ignore the error and suspend
+	 * anyway - returning an error code and trying to undo the suspend
+	 * is not what anybody ever really wants, even if our model
+	 *_allows_ for it."
+	 * -- Linus Torvalds, Dec. 7, 2009
+	 */
+	mutex_lock(&viafb_pm_hooks_lock);
+	list_for_each_entry_reverse(hooks, &viafb_pm_hooks, list)
+		hooks->suspend(hooks->private);
+	mutex_unlock(&viafb_pm_hooks_lock);
+
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	return 0;
+}
+
+static int via_resume(struct pci_dev *pdev)
+{
+	struct viafb_pm_hooks *hooks;
+
+	/* Get the bus side powered up */
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	if (pci_enable_device(pdev))
+		return 0;
+
+	pci_set_master(pdev);
+
+	/* Now bring back any subdevs */
+	mutex_lock(&viafb_pm_hooks_lock);
+	list_for_each_entry(hooks, &viafb_pm_hooks, list)
+		hooks->resume(hooks->private);
+	mutex_unlock(&viafb_pm_hooks_lock);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
 
 static int __devinit via_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
@@ -584,6 +658,7 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
+
 	/*
 	 * Global device initialization.
 	 */
@@ -663,8 +738,8 @@ static struct pci_driver via_driver = {
 	.probe		= via_pci_probe,
 	.remove		= __devexit_p(via_pci_remove),
 #ifdef CONFIG_PM
-	.suspend	= viafb_suspend,
-	.resume		= viafb_resume,
+	.suspend	= via_suspend,
+	.resume		= via_resume,
 #endif
 };
 
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index d298cfc..289edd5 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1672,31 +1672,19 @@ static int parse_mode(const char *str, u32 *xres, u32 *yres)
 
 
 #ifdef CONFIG_PM
-int viafb_suspend(struct pci_dev *pdev, pm_message_t state)
+static int viafb_suspend(void *unused)
 {
-	if (state.event = PM_EVENT_SUSPEND) {
-		acquire_console_sem();
-		fb_set_suspend(viafbinfo, 1);
-
-		viafb_sync(viafbinfo);
-
-		pci_save_state(pdev);
-		pci_disable_device(pdev);
-		pci_set_power_state(pdev, pci_choose_state(pdev, state));
-		release_console_sem();
-	}
+	acquire_console_sem();
+	fb_set_suspend(viafbinfo, 1);
+	viafb_sync(viafbinfo);
+	release_console_sem();
 
 	return 0;
 }
 
-int viafb_resume(struct pci_dev *pdev)
+static int viafb_resume(void *unused)
 {
 	acquire_console_sem();
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	if (pci_enable_device(pdev))
-		goto fail;
-	pci_set_master(pdev);
 	if (viaparinfo->shared->vdev->engine_mmio)
 		viafb_reset_engine(viaparinfo);
 	viafb_set_par(viafbinfo);
@@ -1704,11 +1692,15 @@ int viafb_resume(struct pci_dev *pdev)
 		viafb_set_par(viafbinfo1);
 	fb_set_suspend(viafbinfo, 0);
 
-fail:
 	release_console_sem();
 	return 0;
 }
 
+static struct viafb_pm_hooks viafb_fb_pm_hooks = {
+	.suspend = viafb_suspend,
+	.resume = viafb_resume
+};
+
 #endif
 
 
@@ -1899,6 +1891,10 @@ int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 
 	viafb_init_proc(viaparinfo->shared);
 	viafb_init_dac(IGA2);
+
+#ifdef CONFIG_PM
+	viafb_pm_register(&viafb_fb_pm_hooks);
+#endif
 	return 0;
 
 out_fb_unreg:
diff --git a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
index 4960e3d..d66f963 100644
--- a/drivers/video/via/viafbdev.h
+++ b/drivers/video/via/viafbdev.h
@@ -108,6 +108,4 @@ void via_fb_pci_remove(struct pci_dev *pdev);
 /* Temporary */
 int viafb_init(void);
 void viafb_exit(void);
-int viafb_suspend(struct pci_dev *pdev, pm_message_t state);
-int viafb_resume(struct pci_dev *pdev);
 #endif /* __VIAFBDEV_H__ */
diff --git a/include/linux/via-core.h b/include/linux/via-core.h
index 38bffd8..9c21cdf 100644
--- a/include/linux/via-core.h
+++ b/include/linux/via-core.h
@@ -60,6 +60,21 @@ struct via_port_cfg {
 };
 
 /*
+ * Allow subdevs to register suspend/resume hooks.
+ */
+#ifdef CONFIG_PM
+struct viafb_pm_hooks {
+	struct list_head list;
+	int (*suspend)(void *private);
+	int (*resume)(void *private);
+	void *private;
+};
+
+void viafb_pm_register(struct viafb_pm_hooks *hooks);
+void viafb_pm_unregister(struct viafb_pm_hooks *hooks);
+#endif /* CONFIG_PM */
+
+/*
  * This is the global viafb "device" containing stuff needed by
  * all subdevs.
  */
-- 
1.7.2.3

