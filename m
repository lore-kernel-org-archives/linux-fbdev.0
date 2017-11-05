From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 05 Nov 2017 14:43:05 +0000
Subject: [PATCH] video/fbdev/dnfb: Use common error handling code in dnfb_probe()
Message-Id: <af7afaa3-5467-32c3-9e80-a6c9eb220205@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Nov 2017 14:54:52 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/dnfb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
index 09415009d797..5505fa00c634 100644
--- a/drivers/video/fbdev/dnfb.c
+++ b/drivers/video/fbdev/dnfb.c
@@ -242,16 +242,13 @@ static int dnfb_probe(struct platform_device *dev)
 	info->screen_base = (u_char *) info->fix.smem_start;
 
 	err = fb_alloc_cmap(&info->cmap, 2, 0);
-	if (err < 0) {
-		framebuffer_release(info);
-		return err;
-	}
+	if (err < 0)
+		goto release_framebuffer;
 
 	err = register_framebuffer(info);
 	if (err < 0) {
 		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-		return err;
+		goto release_framebuffer;
 	}
 	platform_set_drvdata(dev, info);
 
@@ -265,6 +262,10 @@ static int dnfb_probe(struct platform_device *dev)
 
 	printk("apollo frame buffer alive and kicking !\n");
 	return err;
+
+release_framebuffer:
+	framebuffer_release(info);
+	return err;
 }
 
 static struct platform_driver dnfb_driver = {
-- 
2.15.0

