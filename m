From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 07:17:19 +0000
Subject: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <1407914239-12054-5-git-send-email-libv@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
In-Reply-To: <1407914239-12054-1-git-send-email-libv@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This claims and enables clocks listed in the simple framebuffer dt node.
This is needed so that the display engine, in case the required clocks
are known by the kernel code and are described in the dt, will remain
properly enabled.

Signed-off-by: Luc Verhaegen <libv@skynet.be>
---
 drivers/video/fbdev/simplefb.c |  103 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 74c4b2a..481dbfd 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/clk-provider.h>
 
 static struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
@@ -191,8 +192,101 @@ static int simplefb_parse_pd(struct platform_device *pdev,
 	return 0;
 }
 
+/*
+ * Clock handling code.
+ *
+ * Here we handle the clocks property of our "simple-framebuffer" dt node.
+ * This is necessary so that we can make sure that any clocks needed by
+ * the display engine that the bootloader set up for us (and for which it
+ * provided a simplefb dt node), stay up, for the life of the simplefb
+ * driver.
+ *
+ * When the driver unloads, we cleanly disable, and then release the clocks.
+ */
+struct simplefb_clock {
+	struct list_head list;
+	struct clk *clock;
+};
+
+/*
+ * We only complain about errors here, no action is taken as the most likely
+ * error can only happen due to a mismatch between the bootloader which set
+ * up simplefb, and the clock definitions in the device tree. Chances are
+ * that there are no adverse effects, and if there are, a clean teardown of
+ * the fb probe will not help us much either. So just complain and carry on,
+ * and hope that the user actually gets a working fb at the end of things.
+ */
+static void
+simplefb_clocks_init(struct platform_device *pdev, struct list_head *list)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int clock_count, i;
+
+	INIT_LIST_HEAD(list);
+
+	if (dev_get_platdata(&pdev->dev) || !np)
+		return;
+
+	clock_count = of_clk_get_parent_count(np);
+	for (i = 0; i < clock_count; i++) {
+		struct simplefb_clock *entry;
+		struct clk *clock = of_clk_get(np, i);
+		int ret;
+
+		if (IS_ERR(clock)) {
+			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
+			       __func__, i, PTR_ERR(clock));
+			continue;
+		}
+
+		ret = clk_prepare_enable(clock);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"%s: failed to enable clock %d: %d\n",
+			       __func__, i, ret);
+			clk_put(clock);
+			continue;
+		}
+
+		entry = kzalloc(sizeof(struct simplefb_clock), GFP_KERNEL);
+		if (!entry) {
+			dev_err(&pdev->dev,
+				"%s: failed to alloc clock %d list entry.\n",
+			       __func__, i);
+			clk_disable_unprepare(clock);
+			clk_put(clock);
+			continue;
+		}
+
+		entry->clock = clock;
+		/*
+		 * add to the front of the list, so we disable clocks in the
+		 * correct order.
+		 */
+		list_add(&entry->list, list);
+	}
+}
+
+static void
+simplefb_clocks_destroy(struct list_head *list)
+{
+	struct list_head *pos, *n;
+
+	list_for_each_safe(pos, n, list) {
+		struct simplefb_clock *entry +			container_of(pos, struct simplefb_clock, list);
+
+		list_del(&entry->list);
+
+		clk_disable_unprepare(entry->clock);
+		clk_put(entry->clock);
+		kfree(entry);
+	}
+}
+
 struct simplefb_par {
 	u32 palette[PSEUDO_PALETTE_SIZE];
+	struct list_head clock_list[1];
 };
 
 static int simplefb_probe(struct platform_device *pdev)
@@ -265,6 +359,8 @@ static int simplefb_probe(struct platform_device *pdev)
 	}
 	info->pseudo_palette = (void *) par->palette;
 
+	simplefb_clocks_init(pdev, par->clock_list);
+
 	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
 			     info->fix.smem_start, info->fix.smem_len,
 			     info->screen_base);
@@ -276,14 +372,15 @@ static int simplefb_probe(struct platform_device *pdev)
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
-		goto error_unmap;
+		goto error_clocks;
 	}
 
 	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
 
 	return 0;
 
- error_unmap:
+ error_clocks:
+	simplefb_clocks_destroy(par->clock_list);
 	iounmap(info->screen_base);
 
  error_fb_release:
@@ -299,8 +396,10 @@ static int simplefb_probe(struct platform_device *pdev)
 static int simplefb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
+	struct simplefb_par *par = info->par;
 
 	unregister_framebuffer(info);
+	simplefb_clocks_destroy(par->clock_list);
 	framebuffer_release(info);
 	if (!dev_get_platdata(&pdev->dev) && pdev->dev.of_node)
 		simplefb_dt_disable(pdev);
-- 
1.7.7

