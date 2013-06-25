From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 25 Jun 2013 01:56:07 +0000
Subject: [PATCH V2] video: remove unnecessary platform_set_drvdata()
Message-Id: <000101ce7147$28bd62c0$7a382840$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 drivers/video/au1100fb.c         |    1 -
 drivers/video/bf54x-lq043fb.c    |    1 -
 drivers/video/bfin-lq035q1-fb.c  |    2 --
 drivers/video/bfin-t350mcqb-fb.c |    2 --
 drivers/video/ep93xx-fb.c        |    2 --
 drivers/video/imxfb.c            |    3 ---
 drivers/video/jz4740_fb.c        |    2 --
 drivers/video/mmp/fb/mmpfb.c     |    1 -
 drivers/video/mmp/hw/mmp_ctrl.c  |    1 -
 drivers/video/mxsfb.c            |    2 --
 drivers/video/nuc900fb.c         |    1 -
 drivers/video/pxa3xx-gcu.c       |    2 --
 drivers/video/pxafb.c            |    1 -
 drivers/video/s3c2410fb.c        |    2 --
 drivers/video/sa1100fb.c         |    1 -
 drivers/video/sh7760fb.c         |    1 -
 drivers/video/sh_mipi_dsi.c      |    1 -
 drivers/video/tmiofb.c           |    3 ---
 drivers/video/vga16fb.c          |    1 -
 drivers/video/vt8500lcdfb.c      |    1 -
 20 files changed, 31 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 700cac0..606a3ba 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -579,7 +579,6 @@ failed:
 	if (fbdev->info.cmap.len != 0) {
 		fb_dealloc_cmap(&fbdev->info.cmap);
 	}
-	platform_set_drvdata(dev, NULL);
 
 	return -ENODEV;
 }
diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 2726a5b..87f288b 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -681,7 +681,6 @@ out3:
 out2:
 	free_dma(CH_EPPI0);
 out1:
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 29d8c04..be65bae 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -759,7 +759,6 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
  out2:
 	free_dma(CH_PPI);
  out1:
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -788,7 +787,6 @@ static int bfin_lq035q1_remove(struct platform_device *pdev)
 	bfin_lq035q1_free_ports(info->disp_info->ppi_mode =
 				USE_RGB565_16_BIT_PPI);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	dev_info(&pdev->dev, "unregistered LCD driver\n");
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index d46da01..48c0c4e 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -578,7 +578,6 @@ out3:
 out2:
 	free_dma(CH_PPI);
 out1:
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -608,7 +607,6 @@ static int bfin_t350mcqb_remove(struct platform_device *pdev)
 
 	bfin_t350mcqb_request_ports(0);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	printk(KERN_INFO DRIVER_NAME ": Unregister LCD driver.\n");
diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index ee1ee54..28a837d 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -595,7 +595,6 @@ failed_videomem:
 	fb_dealloc_cmap(&info->cmap);
 failed_cmap:
 	kfree(info);
-	platform_set_drvdata(pdev, NULL);
 
 	return err;
 }
@@ -614,7 +613,6 @@ static int ep93xxfb_remove(struct platform_device *pdev)
 		fbi->mach_info->teardown(pdev);
 
 	kfree(info);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 0a16d82..12af22b 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -923,7 +923,6 @@ failed_getclock:
 failed_req:
 	kfree(info->pseudo_palette);
 failed_init:
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(info);
 	return ret;
 }
@@ -955,8 +954,6 @@ static int imxfb_remove(struct platform_device *pdev)
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 36979b4..2c49112 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -737,8 +737,6 @@ static int jzfb_remove(struct platform_device *pdev)
 	fb_dealloc_cmap(&jzfb->fb->cmap);
 	jzfb_free_devmem(jzfb);
 
-	platform_set_drvdata(pdev, NULL);
-
 	framebuffer_release(jzfb->fb);
 
 	return 0;
diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index 6d1fa96..4ab95b8 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -659,7 +659,6 @@ failed_destroy_mutex:
 	mutex_destroy(&fbi->access_ok);
 failed:
 	dev_err(fbi->dev, "mmp-fb: frame buffer device init failed\n");
-	platform_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
 
diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 4bd31b2..c46bf5a 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -566,7 +566,6 @@ failed:
 		devm_kfree(ctrl->dev, ctrl);
 	}
 
-	platform_set_drvdata(pdev, NULL);
 	dev_err(&pdev->dev, "device init failed\n");
 
 	return ret;
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..10210a0 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -986,8 +986,6 @@ static int mxsfb_remove(struct platform_device *pdev)
 
 	framebuffer_release(fb_info);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 32581c7..8c527e5 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -707,7 +707,6 @@ static int nuc900fb_remove(struct platform_device *pdev)
 	release_resource(fbi->mem);
 	kfree(fbi->mem);
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	return 0;
diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 97563c5..95c3c4ae 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -711,7 +711,6 @@ err_misc_deregister:
 	misc_deregister(&priv->misc_dev);
 
 err_free_priv:
-	platform_set_drvdata(dev, NULL);
 	free_buffers(dev, priv);
 	kfree(priv);
 	return ret;
@@ -729,7 +728,6 @@ static int pxa3xx_gcu_remove(struct platform_device *dev)
 			priv->shared, priv->shared_phys);
 	iounmap(priv->mmio_base);
 	release_mem_region(r->start, resource_size(r));
-	platform_set_drvdata(dev, NULL);
 	clk_disable(priv->clk);
 	free_buffers(dev, priv);
 	kfree(priv);
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 580f80c..eca2de4 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -2256,7 +2256,6 @@ failed_free_res:
 	release_mem_region(r->start, resource_size(r));
 failed_fbi:
 	clk_put(fbi->clk);
-	platform_set_drvdata(dev, NULL);
 	kfree(fbi);
 failed:
 	return ret;
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 76a0e7f..21a32ad 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -1005,7 +1005,6 @@ release_regs:
 release_mem:
 	release_mem_region(res->start, size);
 dealloc_fb:
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 	return ret;
 }
@@ -1051,7 +1050,6 @@ static int s3c2410fb_remove(struct platform_device *pdev)
 
 	release_mem_region(info->mem->start, resource_size(info->mem));
 
-	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
 	return 0;
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index f34c858..de76da0 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1271,7 +1271,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
  failed:
 	if (fbi)
 		iounmap(fbi->base);
-	platform_set_drvdata(pdev, NULL);
 	kfree(fbi);
 	release_mem_region(res->start, resource_size(res));
 	return ret;
diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 5fbb0c7..a8c6c43 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -571,7 +571,6 @@ static int sh7760fb_remove(struct platform_device *dev)
 	iounmap(par->base);
 	release_mem_region(par->ioarea->start, resource_size(par->ioarea));
 	framebuffer_release(info);
-	platform_set_drvdata(dev, NULL);
 
 	return 0;
 }
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 6cad530..8f6e8ff 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -567,7 +567,6 @@ static int sh_mipi_remove(struct platform_device *pdev)
 	iounmap(mipi->base);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	platform_set_drvdata(pdev, NULL);
 	kfree(mipi);
 
 	return 0;
diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index dc4fb86..deb8733 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -794,7 +794,6 @@ err_hw_init:
 		cell->disable(dev);
 err_enable:
 err_find_mode:
-	platform_set_drvdata(dev, NULL);
 	free_irq(irq, info);
 err_request_irq:
 	iounmap(info->screen_base);
@@ -823,8 +822,6 @@ static int tmiofb_remove(struct platform_device *dev)
 		if (cell->disable)
 			cell->disable(dev);
 
-		platform_set_drvdata(dev, NULL);
-
 		free_irq(irq, info);
 
 		iounmap(info->screen_base);
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 545faec..830ded4 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1269,7 +1269,6 @@ static void vga16fb_destroy(struct fb_info *info)
 	iounmap(info->screen_base);
 	fb_dealloc_cmap(&info->cmap);
 	/* XXX unshare VGA regions */
-	platform_set_drvdata(dev, NULL);
 	framebuffer_release(info);
 }
 
diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 9547e18..897484903 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -448,7 +448,6 @@ failed_free_io:
 failed_free_res:
 	release_mem_region(res->start, resource_size(res));
 failed_fbi:
-	platform_set_drvdata(pdev, NULL);
 	kfree(fbi);
 failed:
 	return ret;
-- 
1.7.10.4


