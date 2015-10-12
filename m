From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 12 Oct 2015 17:04:18 +0000
Subject: [PATCH RFC 2/2] simplefb: Claim and enable regulators
Message-Id: <1444669458-5588-3-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
In-Reply-To: <1444669458-5588-1-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This claims and enables regulators listed in the simple framebuffer dt
node. This is needed so that regulators powering the display pipeline
and external hardware, described in the device node and known by the
kernel code, will remain properly enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/video/fbdev/simplefb.c | 102 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 52c5c7e63b52..b2e419d9be3d 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -28,7 +28,9 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 
 static struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
@@ -174,6 +176,10 @@ struct simplefb_par {
 	int clk_count;
 	struct clk **clks;
 #endif
+#if defined CONFIG_OF && defined CONFIG_REGULATOR
+	u32 regulator_count;
+	struct regulator **regulators;
+#endif
 };
 
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
@@ -269,6 +275,93 @@ static int simplefb_clocks_init(struct simplefb_par *par,
 static void simplefb_clocks_destroy(struct simplefb_par *par) { }
 #endif
 
+#if defined CONFIG_OF && defined CONFIG_REGULATOR
+/*
+ * Regulator handling code.
+ *
+ * Here we handle the num-supplies and vin*-supply properties of our
+ * "simple-framebuffer" dt node. This is necessary so that we can make sure
+ * that any regulators needed by the display hardware that the bootloader
+ * set up for us (and for which it provided a simplefb dt node), stay up,
+ * for the life of the simplefb driver.
+ *
+ * When the driver unloads, we cleanly disable, and then release the
+ * regulators.
+ *
+ * We only complain about errors here, no action is taken as the most likely
+ * error can only happen due to a mismatch between the bootloader which set
+ * up simplefb, and the regulator definitions in the device tree. Chances are
+ * that there are no adverse effects, and if there are, a clean teardown of
+ * the fb probe will not help us much either. So just complain and carry on,
+ * and hope that the user actually gets a working fb at the end of things.
+ */
+static int simplefb_regulators_init(struct simplefb_par *par,
+	struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct regulator *regulator;
+	int i, ret;
+
+	if (dev_get_platdata(&pdev->dev) || !np)
+		return 0;
+
+	ret = of_property_read_u32(np, "num-supplies", &par->regulator_count);
+	if (ret < 0)
+		return 0;
+
+	par->regulators = devm_kcalloc(&pdev->dev, par->regulator_count,
+				       sizeof(struct regulator *), GFP_KERNEL);
+	if (!par->regulators)
+		return -ENOMEM;
+
+	for (i = 0; i < par->regulator_count; i++) {
+		char name[8];
+
+		snprintf(name, sizeof(name), "vin%d", i);
+		regulator = devm_regulator_get_optional(&pdev->dev, name);
+		if (IS_ERR(regulator)) {
+			if (PTR_ERR(regulator) = -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_err(&pdev->dev, "%s: regulator %d not found: %ld\n",
+				__func__, i, PTR_ERR(regulator));
+			continue;
+		}
+		par->regulators[i] = regulator;
+	}
+
+	for (i = 0; i < par->regulator_count; i++) {
+		if (par->regulators[i]) {
+			ret = regulator_enable(par->regulators[i]);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"%s: failed to enable regulator %d: %d\n",
+					__func__, i, ret);
+				devm_regulator_put(par->regulators[i]);
+				par->regulators[i] = NULL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void simplefb_regulators_destroy(struct simplefb_par *par)
+{
+	int i;
+
+	if (!par->regulators)
+		return;
+
+	for (i = 0; i < par->regulator_count; i++)
+		if (par->regulators[i])
+			regulator_disable(par->regulators[i]);
+}
+#else
+static int simplefb_regulators_init(struct simplefb_par *par,
+	struct platform_device *pdev) { return 0; }
+static void simplefb_regulators_destroy(struct simplefb_par *par) { }
+#endif
+
 static int simplefb_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -340,6 +433,10 @@ static int simplefb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error_unmap;
 
+	ret = simplefb_regulators_init(par, pdev);
+	if (ret < 0)
+		goto error_clocks;
+
 	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
 			     info->fix.smem_start, info->fix.smem_len,
 			     info->screen_base);
@@ -351,13 +448,15 @@ static int simplefb_probe(struct platform_device *pdev)
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
-		goto error_clocks;
+		goto error_regulators;
 	}
 
 	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
 
 	return 0;
 
+error_regulators:
+	simplefb_regulators_destroy(par);
 error_clocks:
 	simplefb_clocks_destroy(par);
 error_unmap:
@@ -373,6 +472,7 @@ static int simplefb_remove(struct platform_device *pdev)
 	struct simplefb_par *par = info->par;
 
 	unregister_framebuffer(info);
+	simplefb_regulators_destroy(par);
 	simplefb_clocks_destroy(par);
 	framebuffer_release(info);
 
-- 
2.5.3

