From: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Wed, 02 Dec 2015 13:20:16 +0000
Subject: [PATCH v2] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <1449062416-12245-1-git-send-email-dongsheng.wang@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

If diu_ops is not implemented on platform, kernel will access a null
pointer. we need to check this pointer in diu initialization.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
v2:
- Move set_pixel_clock judgement to fsl_diu_init.

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index b335c1a..7052200 100644
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
@@ -1915,6 +1918,10 @@ static int __init fsl_diu_init(void)
 #else
 	monitor_port = fsl_diu_name_to_port(monitor_string);
 #endif
+
+	if (!diu_ops.set_pixel_clock)
+		return -ENODEV;
+
 	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
-- 
2.1.0.27.g96db324

