From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date: Mon, 10 Aug 2015 20:13:51 +0000
Subject: [PATCH v2] backlight: pm8941-wled: Add default-brightness property
Message-Id: <1439237631-11243-1-git-send-email-bjorn.andersson@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Default the brightness to 2048 and add possibility to override this in
device tree.

Suggested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

After going back and forth on this one I decided that the best unit of this
property (which could become a common backlight property) would be to use
"units of brightness". The value will either come from the boot loader picking
a value in some way or from a user finding a good value by tweaking sysfs -
both which will be in "units of brightness".

 Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt | 2 ++
 drivers/video/backlight/pm8941-wled.c                             | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
index 424f8444a6cd..e5b294dafc58 100644
--- a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
+++ b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
@@ -5,6 +5,8 @@ Required properties:
 - reg: slave address
 
 Optional properties:
+- default-brightness: brightness value on boot, value from: 0-4095
+	default: 2048
 - label: The name of the backlight device
 - qcom,cs-out: bool; enable current sink output
 - qcom,cabc: bool; enable content adaptive backlight control
diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
index c704c3236034..e1298147bcbb 100644
--- a/drivers/video/backlight/pm8941-wled.c
+++ b/drivers/video/backlight/pm8941-wled.c
@@ -17,6 +17,9 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 
+/* From DT binding */
+#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
+
 #define PM8941_WLED_REG_VAL_BASE		0x40
 #define  PM8941_WLED_REG_VAL_MAX		0xFFF
 
@@ -373,6 +376,7 @@ static int pm8941_wled_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct pm8941_wled *wled;
 	struct regmap *regmap;
+	u32 val;
 	int rc;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
@@ -395,8 +399,12 @@ static int pm8941_wled_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	val = PM8941_WLED_DEFAULT_BRIGHTNESS;
+	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
+
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
+	props.brightness = val;
 	props.max_brightness = PM8941_WLED_REG_VAL_MAX;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
-- 
1.8.2.2

