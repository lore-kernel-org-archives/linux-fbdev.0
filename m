From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Fri, 02 Apr 2010 11:59:31 +0000
Subject: [PATCH v2 2/5] fbdev: section cleanup in hgafb
Message-Id: <1270209574-31890-2-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch cleans up the sections in the hgafb driver, by

* moving hga_default_var and hga_fix from .init.data to .devinit.data

* moving hga_detect() from .init.text to .devinit.text

* moving hga_fb_remove() from .text to .devexit.text

WARNING: drivers/video/hgafb.o(.devinit.text+0x18): Section mismatch in referenc
e from the function hgafb_probe() to the function .init.text:hga_card_detect()
The function __devinit hgafb_probe() references
a function __init hga_card_detect().
If hga_card_detect is only used by hgafb_probe then
annotate hga_card_detect with a matching annotation.

WARNING: drivers/video/hgafb.o(.devinit.text+0xfe): Section mismatch in referenc
e from the function hgafb_probe() to the variable .init.data:hga_fix
The function __devinit hgafb_probe() references
a variable __initdata hga_fix.
If hga_fix is only used by hgafb_probe then
annotate hga_fix with a matching annotation.

WARNING: drivers/video/hgafb.o(.devinit.text+0x105): Section mismatch in reference from the function hgafb_probe() to the variable .init.data:hga_default_var
The function __devinit hgafb_probe() references
a variable __initdata hga_default_var.
If hga_default_var is only used by hgafb_probe then
annotate hga_default_var with a matching annotation.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/hgafb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index db9b785..234a6a5 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -107,7 +107,7 @@ static DEFINE_SPINLOCK(hga_reg_lock);
 
 /* Framebuffer driver structures */
 
-static struct fb_var_screeninfo __initdata hga_default_var = {
+static struct fb_var_screeninfo hga_default_var __devinitdata = {
 	.xres		= 720,
 	.yres 		= 348,
 	.xres_virtual 	= 720,
@@ -121,7 +121,7 @@ static struct fb_var_screeninfo __initdata hga_default_var = {
 	.width 		= -1,
 };
 
-static struct fb_fix_screeninfo __initdata hga_fix = {
+static struct fb_fix_screeninfo hga_fix __devinitdata = {
 	.id 		= "HGA",
 	.type 		= FB_TYPE_PACKED_PIXELS,	/* (not sure) */
 	.visual 	= FB_VISUAL_MONO10,
@@ -277,7 +277,7 @@ static void hga_blank(int blank_mode)
 	spin_unlock_irqrestore(&hga_reg_lock, flags);
 }
 
-static int __init hga_card_detect(void)
+static int __devinit hga_card_detect(void)
 {
 	int count = 0;
 	void __iomem *p, *q;
@@ -597,7 +597,7 @@ static int __devinit hgafb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hgafb_remove(struct platform_device *pdev)
+static int __devexit hgafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
@@ -622,7 +622,7 @@ static int hgafb_remove(struct platform_device *pdev)
 
 static struct platform_driver hgafb_driver = {
 	.probe = hgafb_probe,
-	.remove = hgafb_remove,
+	.remove = __devexit_p(hgafb_remove),
 	.driver = {
 		.name = "hgafb",
 	},
-- 
1.7.0

