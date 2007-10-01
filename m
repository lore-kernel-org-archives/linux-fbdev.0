From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/6] Xilinxfb: Replace calls to printk with dev_dbg, dev_err,
	etc.
Date: Mon, 01 Oct 2007 09:57:38 -0600
Message-ID: <20071001155738.6114.51384.stgit@trillian.cg.shawcable.net>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755584AbXJAP5x@vger.kernel.org>
In-reply-to: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc@ozlabs.org, adaplas@gmail.com

From: Grant Likely <grant.likely@secretlab.ca>

The dev_dbg, dev_err, etc functions provide more context that plain
vanilla printk which is useful for debugging.  Where appropriate,
change printk calls to the appropriate dev_*() call.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 1a5f1e4..e63cbd1 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -18,6 +18,7 @@
  * Geert Uytterhoeven.
  */
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/version.h>
@@ -214,7 +215,7 @@ xilinxfb_drv_probe(struct device *dev)
 
 	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
-		printk(KERN_ERR "Couldn't allocate device private record\n");
+		dev_err(dev, "Couldn't allocate device private record\n");
 		return -ENOMEM;
 	}
 	dev_set_drvdata(dev, drvdata);
@@ -222,14 +223,13 @@ xilinxfb_drv_probe(struct device *dev)
 	/* Map the control registers in */
 	regs_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
-		printk(KERN_ERR "Couldn't get registers resource\n");
+		dev_err(dev, "Couldn't get registers resource\n");
 		retval = -EFAULT;
 		goto failed1;
 	}
 
 	if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
-		printk(KERN_ERR
-		       "Couldn't lock memory region at 0x%08X\n",
+		dev_err(dev, "Couldn't lock memory region at 0x%08X\n",
 		       regs_res->start);
 		retval = -EBUSY;
 		goto failed1;
@@ -241,7 +241,7 @@ xilinxfb_drv_probe(struct device *dev)
 	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(FB_SIZE),
 				&drvdata->fb_phys, GFP_KERNEL);
 	if (!drvdata->fb_virt) {
-		printk(KERN_ERR "Could not allocate frame buffer memory\n");
+		dev_err(dev, "Could not allocate frame buffer memory\n");
 		retval = -ENOMEM;
 		goto failed2;
 	}
@@ -267,7 +267,7 @@ xilinxfb_drv_probe(struct device *dev)
 	drvdata->info.pseudo_palette = drvdata->pseudo_palette;
 
 	if (fb_alloc_cmap(&drvdata->info.cmap, PALETTE_ENTRIES_NO, 0) < 0) {
-		printk(KERN_ERR "Fail to allocate colormap (%d entries)\n",
+		dev_err(dev, "Fail to allocate colormap (%d entries)\n",
 			PALETTE_ENTRIES_NO);
 		retval = -EFAULT;
 		goto failed3;
@@ -282,7 +282,7 @@ xilinxfb_drv_probe(struct device *dev)
 
 	/* Register new frame buffer */
 	if (register_framebuffer(&drvdata->info) < 0) {
-		printk(KERN_ERR "Could not register frame buffer\n");
+		dev_err(dev, "Could not register frame buffer\n");
 		retval = -EINVAL;
 		goto failed4;
 	}
