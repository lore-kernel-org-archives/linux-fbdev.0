From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 30 Apr 2010 16:07:14 +0000
Subject: [PATCH 2/2] sh: make interrupt resource optional in SH framebuffer
Message-Id: <Pine.LNX.4.64.1004301805371.4055@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The SH LCDC driver can also function without the IRQ, in which case the
FBIO_WAITFORVSYNC ioctl() cannot be supported. Enable such a mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index e498fb5..b8f7811 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -791,6 +791,9 @@ static int sh_mobile_wait_for_vsync(struct fb_info *info)
 	unsigned long ldintr;
 	int ret;
 
+	if (!ch->lcdc->irq)
+		return -ENOIOCTLCMD;
+
 	/* Enable VSync End interrupt */
 	ldintr = lcdc_read(ch->lcdc, _LDINTR);
 	ldintr |= LDINTR_VEE;
@@ -962,7 +965,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i = platform_get_irq(pdev, 0);
-	if (!res || i < 0) {
+	if (!res) {
 		dev_err(&pdev->dev, "cannot get platform resources\n");
 		return -ENOENT;
 	}
@@ -975,14 +978,16 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	error = request_irq(i, sh_mobile_lcdc_irq, IRQF_DISABLED,
-			    dev_name(&pdev->dev), priv);
-	if (error) {
-		dev_err(&pdev->dev, "unable to request irq\n");
-		goto err1;
+	if (i >= 0) {
+		error = request_irq(i, sh_mobile_lcdc_irq, IRQF_DISABLED,
+				    dev_name(&pdev->dev), priv);
+		if (error) {
+			dev_err(&pdev->dev, "unable to request irq\n");
+			goto err1;
+		}
+		priv->irq = i;
 	}
 
-	priv->irq = i;
 	pdata = pdev->dev.platform_data;
 
 	j = 0;
-- 
1.6.2.4

