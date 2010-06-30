From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 Jun 2010 09:26:35 +0000
Subject: [PATCH] fbdev: sh-mobile-lcdc: fix potential Oops in SH-Mobile LCDC
Message-Id: <Pine.LNX.4.64.1006301120560.17489@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

sh_mobile_lcdc_setup_clocks() can perform IO, therefore it has to be called
after ioremap(). Also check return code of ioremap() and use resource_size()
instead of open-coding it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index e8c7699..1ece226 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1020,14 +1020,16 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	priv->base = ioremap_nocache(res->start, resource_size(res));
+	if (!priv->base)
+		goto err1;
+
 	error = sh_mobile_lcdc_setup_clocks(pdev, pdata->clock_source, priv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to setup clocks\n");
 		goto err1;
 	}
 
-	priv->base = ioremap_nocache(res->start, (res->end - res->start) + 1);
-
 	for (i = 0; i < j; i++) {
 		cfg = &priv->ch[i].cfg;
 
-- 
1.6.2.4

