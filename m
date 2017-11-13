From: Johan Hovold <johan@kernel.org>
Date: Mon, 13 Nov 2017 10:20:48 +0000
Subject: [PATCH 2/3] backlight: max8925_bl: fix device-tree node lookup
Message-Id: <20171113102049.9342-2-johan@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171113102049.9342-1-johan@kernel.org>
In-Reply-To: <20171113102049.9342-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Qing Xu <qingx@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent mfd node was also prematurely freed,
while the child backlight node was leaked.

Fixes: 47ec340cb8e2 ("mfd: max8925: Support dt for backlight")
Cc: stable <stable@vger.kernel.org>     # 3.9
Cc: Qing Xu <qingx@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/video/backlight/max8925_bl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
index 7b738d60ecc2..f3aa6088f1d9 100644
--- a/drivers/video/backlight/max8925_bl.c
+++ b/drivers/video/backlight/max8925_bl.c
@@ -116,7 +116,7 @@ static void max8925_backlight_dt_init(struct platform_device *pdev)
 	if (!pdata)
 		return;
 
-	np = of_find_node_by_name(nproot, "backlight");
+	np = of_get_child_by_name(nproot, "backlight");
 	if (!np) {
 		dev_err(&pdev->dev, "failed to find backlight node\n");
 		return;
@@ -125,6 +125,8 @@ static void max8925_backlight_dt_init(struct platform_device *pdev)
 	if (!of_property_read_u32(np, "maxim,max8925-dual-string", &val))
 		pdata->dual_string = val;
 
+	of_node_put(np);
+
 	pdev->dev.platform_data = pdata;
 }
 
-- 
2.15.0

