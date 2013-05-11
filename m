From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 12:56:06 +0000
Subject: [PATCH 11/15] video: pxa: remove unnecessary platform_set_drvdata()
Message-Id: <000b01ce4e46$e6da5a70$b48f0f50$@samsung.com>
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
---
 drivers/video/pxa3xx-gcu.c |    2 --
 drivers/video/pxafb.c      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

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
-- 
1.7.2.5


