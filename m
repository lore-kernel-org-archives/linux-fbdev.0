From: Daniel Drake <dsd@laptop.org>
Date: Thu, 28 Oct 2010 17:23:21 +0000
Subject: [PATCH 2/2] viafb: suspend/resume for GPIOs
Message-Id: <20101028172321.F01C09D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Jonathan Corbet <corbet@tpl.lwn.net>

Be sure to re-enable GPIO lines on resume.  Users still have to
be sure to set them properly.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/via/via-gpio.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/via-gpio.c b/drivers/video/via/via-gpio.c
index 39acb37..c2a0a1c 100644
--- a/drivers/video/via/via-gpio.c
+++ b/drivers/video/via/via-gpio.c
@@ -172,6 +172,28 @@ static void viafb_gpio_disable(struct viafb_gpio *gpio)
 	via_write_reg_mask(VIASR, gpio->vg_port_index, 0, 0x02);
 }
 
+#ifdef CONFIG_PM
+
+static int viafb_gpio_suspend(void *private)
+{
+	return 0;
+}
+
+static int viafb_gpio_resume(void *private)
+{
+	int i;
+
+	for (i = 0; i < gpio_config.gpio_chip.ngpio; i += 2)
+		viafb_gpio_enable(gpio_config.active_gpios[i]);
+	return 0;
+}
+
+static struct viafb_pm_hooks viafb_gpio_pm_hooks = {
+	.suspend = viafb_gpio_suspend,
+	.resume = viafb_gpio_resume
+};
+#endif /* CONFIG_PM */
+
 /*
  * Look up a specific gpio and return the number it was assigned.
  */
@@ -236,6 +258,9 @@ static __devinit int viafb_gpio_probe(struct platform_device *platdev)
 		printk(KERN_ERR "viafb: failed to add gpios (%d)\n", ret);
 		gpio_config.gpio_chip.ngpio = 0;
 	}
+#ifdef CONFIG_PM
+	viafb_pm_register(&viafb_gpio_pm_hooks);
+#endif
 	return ret;
 }
 
@@ -245,6 +270,10 @@ static int viafb_gpio_remove(struct platform_device *platdev)
 	unsigned long flags;
 	int ret = 0, i;
 
+#ifdef CONFIG_PM
+	viafb_pm_unregister(&viafb_gpio_pm_hooks);
+#endif
+
 	/*
 	 * Get unregistered.
 	 */
-- 
1.7.2.3

