From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 22 Feb 2011 01:52:42 +0000
Subject: [PATCH] video: da8xx-fb: fix section mismatch warning
Message-Id: <1298339562.3903.3.camel@mola>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sudhakar Rajashekhara <sudhakar.raj@ti.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

This patch includes below fixes:
1. Mark fb_probe as __devinit to fix below section mismatch warning.
WARNING: drivers/video/built-in.o(.data+0x13c): Section mismatch in reference from the variable da8xx_fb_driver to the function .init.text:fb_probe()
The variable da8xx_fb_driver references
the function __init fb_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

2. fb_remove is marked __devexit,
thus add __devexit_p around reference to fb_remove.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/da8xx-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 8d61ef9..246f1c0 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -899,7 +899,7 @@ static struct fb_ops da8xx_fb_ops = {
 	.fb_blank = cfb_blank,
 };
 
-static int __init fb_probe(struct platform_device *device)
+static int __devinit fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata  						device->dev.platform_data;
@@ -1165,7 +1165,7 @@ static int fb_resume(struct platform_device *dev)
 
 static struct platform_driver da8xx_fb_driver = {
 	.probe = fb_probe,
-	.remove = fb_remove,
+	.remove = __devexit_p(fb_remove),
 	.suspend = fb_suspend,
 	.resume = fb_resume,
 	.driver = {
-- 
1.7.2



