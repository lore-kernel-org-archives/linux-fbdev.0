From: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 24 Nov 2015 06:27:30 +0000
Subject: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

If diu_ops is not implemented on platform, kernel will access a null
pointer. we need to check this pointer in diu initialization.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index b335c1a..288b5e4 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -479,7 +479,10 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
 			port = FSL_DIU_PORT_DLVDS;
 	}
 
-	return diu_ops.valid_monitor_port(port);
+	if (diu_ops.valid_monitor_port)
+		port = diu_ops.valid_monitor_port(port);
+
+	return port;
 }
 
 /*
@@ -1697,6 +1700,9 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	unsigned int i;
 	int ret;
 
+	if (!diu_ops.set_pixel_clock)
+		return -ENODEV;
+
 	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
 				   &dma_addr, GFP_DMA | __GFP_ZERO);
 	if (!data)
-- 
2.1.0.27.g96db324

