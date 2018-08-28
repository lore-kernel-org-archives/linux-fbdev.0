From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Aug 2018 01:52:49 +0000
Subject: [PATCH] backlight: pm8941: Convert to using %pOFn instead of device_node.name
Message-Id: <20180828015252.28511-48-robh@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/backlight/pm8941-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
index 0b6d21955d91..da6aab20fdcb 100644
--- a/drivers/video/backlight/pm8941-wled.c
+++ b/drivers/video/backlight/pm8941-wled.c
@@ -330,7 +330,7 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 
 	rc = of_property_read_string(dev->of_node, "label", &wled->name);
 	if (rc)
-		wled->name = dev->of_node->name;
+		wled->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
 
 	*cfg = pm8941_wled_config_defaults;
 	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
-- 
2.17.1
