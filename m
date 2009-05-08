From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 07/15] ps3fb: Correct handling of device opening in ps3fb_probe()
Date: Fri,  8 May 2009 16:01:16 +0200
Message-ID: <1241791284-11490-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762276AbZEHOEI@vger.kernel.org>
In-Reply-To: <1241791284-11490-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

  - ps3_open_hv_device() returns a standard error value,
  - Add missing call to ps3_close_hv_device() in the error path.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index a745018..542ffc3 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -985,7 +985,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 {
 	struct fb_info *info;
 	struct ps3fb_par *par;
-	int retval = -ENOMEM;
+	int retval;
 	u64 ddr_lpar = 0;
 	u64 lpar_dma_control = 0;
 	u64 lpar_driver_info = 0;
@@ -1003,8 +1003,8 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 		return -ENOMEM;
 	}
 
-	status = ps3_open_hv_device(dev);
-	if (status) {
+	retval = ps3_open_hv_device(dev);
+	if (retval) {
 		dev_err(&dev->core, "%s: ps3_open_hv_device failed\n",
 			__func__);
 		goto err;
@@ -1027,7 +1027,8 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 			"%s: lv1_gpu_context_attribute DISPLAY_SYNC failed: "
 			"%d\n",
 			__func__, status);
-		goto err;
+		retval = -ENODEV;
+		goto err_close_device;
 	}
 #endif
 #ifdef HEAD_B
@@ -1040,7 +1041,8 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 			"%s: lv1_gpu_context_attribute DISPLAY_SYNC failed: "
 			"%d\n",
 			__func__, status);
-		goto err;
+		retval = -ENODEV;
+		goto err_close_device;
 	}
 #endif
 
@@ -1057,7 +1059,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	if (status) {
 		dev_err(&dev->core, "%s: lv1_gpu_memory_allocate failed: %d\n",
 			__func__, status);
-		goto err;
+		goto err_close_device;
 	}
 	dev_dbg(&dev->core, "ddr:lpar:0x%llx\n", ddr_lpar);
 
@@ -1221,6 +1223,8 @@ err_gpu_context_free:
 	lv1_gpu_context_free(ps3fb.context_handle);
 err_gpu_memory_free:
 	lv1_gpu_memory_free(ps3fb.memory_handle);
+err_close_device:
+	ps3_close_hv_device(dev);
 err:
 	return retval;
 }
-- 
1.6.2.4
