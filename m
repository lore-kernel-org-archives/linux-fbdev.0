From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Sat, 16 Mar 2013 01:05:09 +0000
Subject: [PATCH 2/3] video: ep93xx-fb.c: fix section mismatch and use module_platform_driver
Message-Id: <201303151805.10277.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, Ryan Mallon <rmallon@gmail.com>, FlorianSchandinat@gmx.de

Remove the __init tags from the ep93xxfb_calc_fbsize() and
ep93xxfb_alloc_videomem() functions to fix the section mismatch
warnings.

Use module_platform_driver() to remove the init/exit boilerplate.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/ep93xx-fb.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index e06cd5d..ee1ee54 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -419,7 +419,7 @@ static struct fb_ops ep93xxfb_ops = {
 	.fb_mmap	= ep93xxfb_mmap,
 };
 
-static int __init ep93xxfb_calc_fbsize(struct ep93xxfb_mach_info *mach_info)
+static int ep93xxfb_calc_fbsize(struct ep93xxfb_mach_info *mach_info)
 {
 	int i, fb_size = 0;
 
@@ -441,7 +441,7 @@ static int __init ep93xxfb_calc_fbsize(struct ep93xxfb_mach_info *mach_info)
 	return fb_size;
 }
 
-static int __init ep93xxfb_alloc_videomem(struct fb_info *info)
+static int ep93xxfb_alloc_videomem(struct fb_info *info)
 {
 	struct ep93xx_fbi *fbi = info->par;
 	char __iomem *virt_addr;
@@ -627,19 +627,7 @@ static struct platform_driver ep93xxfb_driver = {
 		.owner	= THIS_MODULE,
 	},
 };
-
-static int ep93xxfb_init(void)
-{
-	return platform_driver_register(&ep93xxfb_driver);
-}
-
-static void __exit ep93xxfb_exit(void)
-{
-	platform_driver_unregister(&ep93xxfb_driver);
-}
-
-module_init(ep93xxfb_init);
-module_exit(ep93xxfb_exit);
+module_platform_driver(ep93xxfb_driver);
 
 MODULE_DESCRIPTION("EP93XX Framebuffer Driver");
 MODULE_ALIAS("platform:ep93xx-fb");
-- 
1.8.1.4

