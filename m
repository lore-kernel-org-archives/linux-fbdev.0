From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:42:30 +0000
Subject: [PATCH 13/13] FB: sa11x0: convert shannon display enable accesses to use GPIO subsystem
Message-Id: <E1Rtc8c-0000bB-4w@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Rather than accessing GPSR and GPCR directly, use the GPIO subsystem
instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/shannon.h |    2 +-
 drivers/video/sa1100fb.c                    |   24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/shannon.h b/arch/arm/mach-sa1100/include/mach/shannon.h
index ec27d6e..a0d1114 100644
--- a/arch/arm/mach-sa1100/include/mach/shannon.h
+++ b/arch/arm/mach-sa1100/include/mach/shannon.h
@@ -21,7 +21,7 @@
 #define SHANNON_GPIO_U3_RTS		GPIO_GPIO (19)	/* ?? */
 #define SHANNON_GPIO_U3_CTS		GPIO_GPIO (20)	/* ?? */
 #define SHANNON_GPIO_SENSE_12V		GPIO_GPIO (21)	/* Input, 12v flash unprotect detected */
-#define SHANNON_GPIO_DISP_EN		GPIO_GPIO (22)	/* out */
+#define SHANNON_GPIO_DISP_EN		22		/* out */
 /* XXX GPIO 23 unaccounted for */
 #define SHANNON_GPIO_EJECT_0		GPIO_GPIO (24)	/* in */
 #define SHANNON_IRQ_GPIO_EJECT_0	IRQ_GPIO24
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index f3f55eb..379b2c5 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -173,6 +173,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/cpufreq.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/mutex.h>
@@ -796,10 +797,8 @@ static void sa1100fb_enable_controller(struct sa1100fb_info *fbi)
 	DBAR2 = fbi->dbar2;
 	LCCR0 |= LCCR0_LEN;
 
-	if (machine_is_shannon()) {
-		GPDR |= SHANNON_GPIO_DISP_EN;
-		GPSR = SHANNON_GPIO_DISP_EN;
-	}
+	if (machine_is_shannon())
+		gpio_set_value(SHANNON_GPIO_DISP_EN, 1);
 
 	dev_dbg(fbi->dev, "DBAR1 = 0x%08lx\n", DBAR1);
 	dev_dbg(fbi->dev, "DBAR2 = 0x%08lx\n", DBAR2);
@@ -815,9 +814,8 @@ static void sa1100fb_disable_controller(struct sa1100fb_info *fbi)
 
 	dev_dbg(fbi->dev, "Disabling LCD controller\n");
 
-	if (machine_is_shannon()) {
-		GPCR = SHANNON_GPIO_DISP_EN;
-	}	
+	if (machine_is_shannon())
+		gpio_set_value(SHANNON_GPIO_DISP_EN, 0);
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&fbi->ctrlr_wait, &wait);
@@ -1230,6 +1228,13 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
+	if (machine_is_shannon()) {
+		ret = gpio_request_one(SHANNON_GPIO_DISP_EN,
+			GPIOF_OUT_INIT_LOW, "display enable");
+		if (ret)
+			goto err_free_irq;
+	}
+
 	/*
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
@@ -1240,7 +1245,7 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 
 	ret = register_framebuffer(&fbi->fb);
 	if (ret < 0)
-		goto err_free_irq;
+		goto err_reg_fb;
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = sa1100fb_freq_transition;
@@ -1252,6 +1257,9 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 	/* This driver cannot be unloaded at the moment */
 	return 0;
 
+ err_reg_fb:
+	if (machine_is_shannon())
+		gpio_free(SHANNON_GPIO_DISP_EN);
  err_free_irq:
 	free_irq(irq, fbi);
  failed:
-- 
1.7.4.4

