From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 23 Jan 2018 11:34:56 +0000
Subject: [PATCH] fbdev: simplefb: add support for 'memory-region' property on DT node
Message-Id: <1516707296-23667-1-git-send-email-hayashi.kunihiko@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Enables 'memory-region' property referring to the memory description on
the reserved-memory node in case of devicetree use.
If there is no 'reg' property that specifies the address and size of
the framebuffer, the address and size written in the memory description
on the reserved-memory node can be used for the framebuffer.

Furthermore, the reserved-memory node needs to have "no-map" attributes
because simplefb driver maps the region by ioremap_wc().

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/display/simple-framebuffer.txt        |  3 ++
 drivers/video/fbdev/simplefb.c                     | 32 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.txt b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
index 5a9ce51..be5139f 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
@@ -56,6 +56,9 @@ Optional properties:
   framebuffer remains active.
 
 - display : phandle pointing to the primary display hardware node
+- memory-region: phandle to a node describing memory region as framebuffer
+		 memory instead of reg property. The node should include
+		 'no-map'.
 
 Example:
 
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..aefc4b1 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -29,6 +29,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
 #include <linux/regulator/consumer.h>
@@ -294,6 +295,35 @@ static void simplefb_clocks_enable(struct simplefb_par *par,
 static void simplefb_clocks_destroy(struct simplefb_par *par) { }
 #endif
 
+#if defined CONFIG_OF
+static struct resource *simplefb_parse_dt_reserved_mem(struct device *dev)
+{
+	static struct resource res;
+	struct device_node *np;
+	int ret;
+
+	np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!np)
+		return NULL;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret < 0)
+		return NULL;
+
+	if (!of_find_property(np, "no-map", NULL)) {
+		dev_err(dev, "Can't apply mapped reserved-memory\n");
+		return NULL;
+	}
+
+	return &res;
+}
+#else
+static struct resource *simplefb_parse_dt_reserved_mem(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 
 #define SUPPLY_SUFFIX "-supply"
@@ -428,6 +458,8 @@ static int simplefb_probe(struct platform_device *pdev)
 		return ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		mem = simplefb_parse_dt_reserved_mem(&pdev->dev);
 	if (!mem) {
 		dev_err(&pdev->dev, "No memory resource\n");
 		return -EINVAL;
-- 
2.7.4

