From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Tue, 15 Sep 2015 13:12:33 +0000
Subject: [PATCH v2] fbdev: omap2: connector-dvi: use of_get_i2c_adapter_by_node interface
Message-Id: <1442322753-32043-1-git-send-email-vladimir_zapolskiy@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This change is needed to properly lock I2C bus driver, which serves DDC.

Prior to this change i2c_put_adapter() is misused, which may lead to
an overflow over zero of I2C bus driver user counter.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
- none, v1 is http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354990.html

The original series http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354982.html
is separated to i2c, dri and fbdev parts, at the moment i2c part
with new of_get_i2c_adapter_by_node() interface has been applied.

 drivers/video/fbdev/omap2/displays-new/connector-dvi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
index a8ce920..d811e6d 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
@@ -294,7 +294,7 @@ static int dvic_probe_of(struct platform_device *pdev)
 
 	adapter_node = of_parse_phandle(node, "ddc-i2c-bus", 0);
 	if (adapter_node) {
-		adapter = of_find_i2c_adapter_by_node(adapter_node);
+		adapter = of_get_i2c_adapter_by_node(adapter_node);
 		if (adapter = NULL) {
 			dev_err(&pdev->dev, "failed to parse ddc-i2c-bus\n");
 			omap_dss_put_device(ddata->in);
-- 
2.5.0

