From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 09/33] ps3fb: Correct handling of device
	opening in ps3fb_probe()
Date: Wed, 10 Jun 2009 16:38:44 +0200
Message-ID: <1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1MEOxU-0000ML-Rb
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:39:20 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MEOxS-0006k8-Vy
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:39:20 +0000
In-Reply-To: <1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org

  - ps3_open_hv_device() returns a standard error value,
  - Add missing call to ps3_close_hv_device() in the error path.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
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


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
