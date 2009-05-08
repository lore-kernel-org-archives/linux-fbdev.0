From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 13/15] ps3vram: Remove no longer used
	ps3vram_priv.ddr_base
Date: Fri,  8 May 2009 16:01:22 +0200
Message-ID: <1241791284-11490-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
	<1241791284-11490-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1M2Qdt-0001rL-6J
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:37 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1M2Qds-0003XO-Af
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:37 +0000
In-Reply-To: <1241791284-11490-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
---
 drivers/block/ps3vram.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index e85f09d..5f5b828 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -73,7 +73,6 @@ struct ps3vram_priv {
 	u64 context_handle;
 	u32 *ctrl;
 	u32 *reports;
-	u8 __iomem *ddr_base;
 	u8 *xdr_buf;
 
 	u32 *fifo_base;
@@ -705,19 +704,11 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 		goto out_free_context;
 	}
 
-	priv->ddr_base = ioremap_flags(ddr_lpar, ddr_size, _PAGE_NO_CACHE);
-
-	if (!priv->ddr_base) {
-		dev_err(&dev->core, "ioremap DDR failed\n");
-		error = -ENOMEM;
-		goto out_unmap_context;
-	}
-
 	priv->ctrl = ioremap(ctrl_lpar, 64 * 1024);
 	if (!priv->ctrl) {
 		dev_err(&dev->core, "ioremap CTRL failed\n");
 		error = -ENOMEM;
-		goto out_unmap_vram;
+		goto out_unmap_context;
 	}
 
 	priv->reports = ioremap(reports_lpar, reports_size);
@@ -794,8 +785,6 @@ out_unmap_reports:
 	iounmap(priv->reports);
 out_unmap_ctrl:
 	iounmap(priv->ctrl);
-out_unmap_vram:
-	iounmap(priv->ddr_base);
 out_unmap_context:
 	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF, xdr_lpar,
 			      XDR_BUF_SIZE, IOPTE_M);
@@ -825,7 +814,6 @@ static int ps3vram_remove(struct ps3_system_bus_device *dev)
 	ps3vram_cache_cleanup(dev);
 	iounmap(priv->reports);
 	iounmap(priv->ctrl);
-	iounmap(priv->ddr_base);
 	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF,
 			      ps3_mm_phys_to_lpar(__pa(priv->xdr_buf)),
 			      XDR_BUF_SIZE, IOPTE_M);
-- 
1.6.2.4


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
