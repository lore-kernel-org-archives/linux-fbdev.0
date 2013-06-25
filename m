From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 25 Jun 2013 14:22:45 +0000
Subject: [PATCH 17/23] video: da8xx-fb: minimal dt support
Message-Id: <1372170171-9561-18-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

Driver is provided a means to have the probe triggered by DT.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 .../devicetree/bindings/video/fb-da8xx.txt         |   16 ++++++++++++++++
 drivers/video/da8xx-fb.c                           |    7 +++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.txt

diff --git a/Documentation/devicetree/bindings/video/fb-da8xx.txt b/Documentation/devicetree/bindings/video/fb-da8xx.txt
new file mode 100644
index 0000000..581e014
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fb-da8xx.txt
@@ -0,0 +1,16 @@
+TI LCD Controller on DA830/DA850/AM335x SoC's
+
+Required properties:
+- compatible:
+	DA830 - "ti,da830-lcdc"
+	AM335x SoC's - "ti,am3352-lcdc", "ti,da830-lcdc"
+- reg: Address range of lcdc register set
+- interrupts: lcdc interrupt
+
+Example:
+
+lcdc@4830e000 {
+	compatible = "ti,am3352-lcdc", "ti,da830-lcdc";
+	reg =  <0x4830e000 0x1000>;
+	interrupts = <36>;
+};
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index b6ea5e9..08ee8eb 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1595,6 +1595,12 @@ static int fb_resume(struct platform_device *dev)
 #define fb_resume NULL
 #endif
 
+static const struct of_device_id da8xx_fb_of_match[] = {
+	{.compatible = "ti,da830-lcdc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, da8xx_fb_of_match);
+
 static struct platform_driver da8xx_fb_driver = {
 	.probe = fb_probe,
 	.remove = fb_remove,
@@ -1603,6 +1609,7 @@ static struct platform_driver da8xx_fb_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(da8xx_fb_of_match),
 		   },
 };
 
-- 
1.7.0.4

