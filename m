From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 13 Jul 2017 07:53:14 +0000
Subject: [PATCH v2] video: fbdev: imxfb: use after free in imxfb_remove()
Message-Id: <20170713075314.qeywcgswbrrvzjza@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We free "info" then dereference it on the next line.  Really this whole
function would be better if we wrote it to unwind in the mirror of how
things are allocated in the probe.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: re-order the whole function

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index c166e0725be5..ba82f97fb42b 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1073,20 +1073,16 @@ static int imxfb_remove(struct platform_device *pdev)
 	imxfb_disable_controller(fbi);
 
 	unregister_framebuffer(info);
-
+	fb_dealloc_cmap(&info->cmap);
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
-
-	fb_dealloc_cmap(&info->cmap);
-	kfree(info->pseudo_palette);
-	framebuffer_release(info);
-
 	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
 		    fbi->map_dma);
-
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
+	kfree(info->pseudo_palette);
+	framebuffer_release(info);
 
 	return 0;
 }
