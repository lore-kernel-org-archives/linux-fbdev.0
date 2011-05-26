From: Andy Lutomirski <luto@MIT.EDU>
Date: Thu, 26 May 2011 14:13:32 +0000
Subject: [PATCH 2/4] efifb: Fix mismatched request/release_mem_region
Message-Id: <66cbd008789c83ed102f94adf5f3a58392a3519d.1306418703.git.luto@mit.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 drivers/video/efifb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index a81c944..43af770 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -16,6 +16,8 @@
 #include <linux/pci.h>
 #include <video/vga.h>
 
+static bool request_mem_succeeded = false;
+
 static struct fb_var_screeninfo efifb_defined __devinitdata = {
 	.activate		= FB_ACTIVATE_NOW,
 	.height			= -1,
@@ -281,7 +283,9 @@ static void efifb_destroy(struct fb_info *info)
 {
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
+	if (request_mem_succeeded)
+		release_mem_region(info->apertures->ranges[0].base,
+				   info->apertures->ranges[0].size);
 	framebuffer_release(info);
 }
 
@@ -333,7 +337,6 @@ static int __devinit efifb_probe(struct platform_device *dev)
 	unsigned int size_vmode;
 	unsigned int size_remap;
 	unsigned int size_total;
-	int request_succeeded = 0;
 
 	if (!screen_info.lfb_depth)
 		screen_info.lfb_depth = 32;
@@ -387,7 +390,7 @@ static int __devinit efifb_probe(struct platform_device *dev)
 	efifb_fix.smem_len = size_remap;
 
 	if (request_mem_region(efifb_fix.smem_start, size_remap, "efifb")) {
-		request_succeeded = 1;
+		request_mem_succeeded = true;
 	} else {
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
@@ -491,7 +494,7 @@ err_unmap:
 err_release_fb:
 	framebuffer_release(info);
 err_release_mem:
-	if (request_succeeded)
+	if (request_mem_succeeded)
 		release_mem_region(efifb_fix.smem_start, size_total);
 	return err;
 }
-- 
1.7.5.1

