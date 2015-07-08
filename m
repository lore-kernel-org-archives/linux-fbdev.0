From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Wed, 08 Jul 2015 13:00:16 +0000
Subject: [PATCH 09/10] fbdev: omap2: connector-dvi: use of_get_i2c_adapter_by_node interface
Message-Id: <1436360416-9556-1-git-send-email-vladimir_zapolskiy@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Markus Elfring <elfring@users.sourceforge.net>, linux-arm-kernel@lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

Prior to this change i2c_put_adapter() is misused, which may lead to
an overflow over zero of I2C bus driver user counter.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
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
2.1.4

