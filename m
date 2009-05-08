From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 10/15] ps3vram: GPU memory mapping
	cleanup
Date: Fri,  8 May 2009 16:01:19 +0200
Message-ID: <1241791284-11490-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1M2Qe1-0001r1-6l
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:45 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1M2Qdq-0007Sa-2A
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:35 +0000
In-Reply-To: <1241791284-11490-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>, linux-kernel@vger.kernel.org

  - Make the IOMMU flags used for mapping main memory into the GPU's I/O space
    explicit, instead of relying on the default in the hypervisor,
  - Add missing calls to lv1_gpu_context_iomap(..., IOPTE_M) to unmap the
    memory during cleanup.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
---
 drivers/block/ps3vram.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 1396038..c58ac15 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -14,6 +14,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/firmware.h>
+#include <asm/iommu.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
 
@@ -628,8 +629,8 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	int error, status;
 	struct request_queue *queue;
 	struct gendisk *gendisk;
-	u64 ddr_lpar, ctrl_lpar, info_lpar, reports_lpar, ddr_size,
-	    reports_size;
+	u64 ddr_size, ddr_lpar, ctrl_lpar, info_lpar, reports_lpar,
+	    reports_size, xdr_lpar;
 	char *rest;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -700,9 +701,10 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	}
 
 	/* Map XDR buffer to RSX */
+	xdr_lpar = ps3_mm_phys_to_lpar(__pa(priv->xdr_buf));
 	status = lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF,
-				       ps3_mm_phys_to_lpar(__pa(priv->xdr_buf)),
-				       XDR_BUF_SIZE, 0);
+				       xdr_lpar, XDR_BUF_SIZE,
+				       IOPTE_PP_W | IOPTE_PP_R | IOPTE_M);
 	if (status) {
 		dev_err(&dev->core, "lv1_gpu_context_iomap failed %d\n",
 			status);
@@ -715,7 +717,7 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	if (!priv->ddr_base) {
 		dev_err(&dev->core, "ioremap DDR failed\n");
 		error = -ENOMEM;
-		goto out_free_context;
+		goto out_unmap_context;
 	}
 
 	priv->ctrl = ioremap(ctrl_lpar, 64 * 1024);
@@ -801,6 +803,9 @@ out_unmap_ctrl:
 	iounmap(priv->ctrl);
 out_unmap_vram:
 	iounmap(priv->ddr_base);
+out_unmap_context:
+	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF, xdr_lpar,
+			      XDR_BUF_SIZE, IOPTE_M);
 out_free_context:
 	lv1_gpu_context_free(priv->context_handle);
 out_free_memory:
@@ -828,6 +833,9 @@ static int ps3vram_remove(struct ps3_system_bus_device *dev)
 	iounmap(priv->reports);
 	iounmap(priv->ctrl);
 	iounmap(priv->ddr_base);
+	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF,
+			      ps3_mm_phys_to_lpar(__pa(priv->xdr_buf)),
+			      XDR_BUF_SIZE, IOPTE_M);
 	lv1_gpu_context_free(priv->context_handle);
 	lv1_gpu_memory_free(priv->memory_handle);
 	ps3_close_hv_device(dev);
-- 
1.6.2.4


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
