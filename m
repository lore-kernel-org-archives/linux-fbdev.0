From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 11/33] ps3fb: GPU memory mapping cleanup
Date: Wed, 10 Jun 2009 16:38:46 +0200
Message-ID: <1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1MEOxU-0000MF-Ne
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:39:20 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MEOxS-0006kE-Vy
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:39:20 +0000
In-Reply-To: <1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

  - Make the IOMMU flags used for mapping main memory into the GPU's I/O space
    explicit, instead of relying on the default in the hypervisor,
  - Add missing calls to lv1_gpu_context_iomap(..., CBE_IOPTE_M) to unmap the
    memory during cleanup.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
v2: Add CBE_ prefix

 drivers/video/ps3fb.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 542ffc3..a61c1d8 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 
 #include <asm/abs_addr.h>
+#include <asm/iommu.h>
 #include <asm/lv1call.h>
 #include <asm/ps3av.h>
 #include <asm/ps3fb.h>
@@ -1122,7 +1123,9 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	xdr_lpar = ps3_mm_phys_to_lpar(__pa(ps3fb_videomemory.address));
 
 	status = lv1_gpu_context_iomap(ps3fb.context_handle, GPU_IOIF,
-				       xdr_lpar, ps3fb_videomemory.size, 0);
+				       xdr_lpar, ps3fb_videomemory.size,
+				       CBE_IOPTE_PP_W | CBE_IOPTE_PP_R |
+				       CBE_IOPTE_M);
 	if (status) {
 		dev_err(&dev->core, "%s: lv1_gpu_context_iomap failed: %d\n",
 			__func__, status);
@@ -1143,12 +1146,12 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 			"%s: lv1_gpu_context_attribute FB_SETUP failed: %d\n",
 			__func__, status);
 		retval = -ENXIO;
-		goto err_free_irq;
+		goto err_context_unmap;
 	}
 
 	info = framebuffer_alloc(sizeof(struct ps3fb_par), &dev->core);
 	if (!info)
-		goto err_free_irq;
+		goto err_context_unmap;
 
 	par = info->par;
 	par->mode_id = ~ps3fb_mode;	/* != ps3fb_mode, to trigger change */
@@ -1213,6 +1216,9 @@ err_fb_dealloc:
 	fb_dealloc_cmap(&info->cmap);
 err_framebuffer_release:
 	framebuffer_release(info);
+err_context_unmap:
+	lv1_gpu_context_iomap(ps3fb.context_handle, GPU_IOIF, xdr_lpar,
+			      ps3fb_videomemory.size, CBE_IOPTE_M);
 err_free_irq:
 	free_irq(ps3fb.irq_no, &dev->core);
 err_destroy_plug:
@@ -1232,6 +1238,7 @@ err:
 static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 {
 	struct fb_info *info = dev->core.driver_data;
+	u64 xdr_lpar = ps3_mm_phys_to_lpar(__pa(ps3fb_videomemory.address));
 
 	dev_dbg(&dev->core, " -> %s:%d\n", __func__, __LINE__);
 
@@ -1254,6 +1261,8 @@ static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 		info = dev->core.driver_data = NULL;
 	}
 	iounmap((u8 __force __iomem *)ps3fb.dinfo);
+	lv1_gpu_context_iomap(ps3fb.context_handle, GPU_IOIF, xdr_lpar,
+			      ps3fb_videomemory.size, CBE_IOPTE_M);
 	lv1_gpu_context_free(ps3fb.context_handle);
 	lv1_gpu_memory_free(ps3fb.memory_handle);
 	ps3_close_hv_device(dev);
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
