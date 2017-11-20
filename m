From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Nov 2017 10:45:46 +0000
Subject: [PATCH v2 3/4] backlight: tps65217_bl: fix device-tree node lookup
Message-Id: <20171120104547.2639-4-johan@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
In-Reply-To: <20171120104547.2639-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Matthias Kaehlcke <matthias@kaehlcke.net>

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

This would only cause trouble if the child node is missing while there
is an unrelated node named "backlight" elsewhere in the tree.

Fixes: eebfdc17cc6c ("backlight: Add TPS65217 WLED driver")
Cc: stable <stable@vger.kernel.org>     # 3.7
Cc: Matthias Kaehlcke <matthias@kaehlcke.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/video/backlight/tps65217_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
index 380917c86276..762e3feed097 100644
--- a/drivers/video/backlight/tps65217_bl.c
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -184,11 +184,11 @@ static struct tps65217_bl_pdata *
 tps65217_bl_parse_dt(struct platform_device *pdev)
 {
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
-	struct device_node *node = of_node_get(tps->dev->of_node);
+	struct device_node *node;
 	struct tps65217_bl_pdata *pdata, *err;
 	u32 val;
 
-	node = of_find_node_by_name(node, "backlight");
+	node = of_get_child_by_name(tps->dev->of_node, "backlight");
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-- 
2.15.0

