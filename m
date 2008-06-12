From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 02/10] pxafb: cleanup and fix
	order of failure handling
Date: Thu, 12 Jun 2008 12:59:13 -0400
Message-ID: <1213289961-1562-3-git-send-email-jayakumar.lkml@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6r2E-0003eD-PO for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:56:30 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6r2E-0008E0-I4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:56:30 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3712034wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 10:56:30 -0700 (PDT)
In-Reply-To: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

This issue was found by Krzysztof Helt and Eric Miao.

pxafb had issues in the order with which it cleaned up if errors occurred
during a probe. This patch reorders the failure handling sequence and also
frees the cmap and clk.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/pxafb.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index dd013f3..037881a 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1683,14 +1683,14 @@ static int __init pxafb_probe(struct platform_device *dev)
 	if (r == NULL) {
 		dev_err(&dev->dev, "no I/O memory resource defined\n");
 		ret = -ENODEV;
-		goto failed;
+		goto failed_fbi;
 	}
 
 	r = request_mem_region(r->start, r->end - r->start + 1, dev->name);
 	if (r == NULL) {
 		dev_err(&dev->dev, "failed to request I/O memory\n");
 		ret = -EBUSY;
-		goto failed;
+		goto failed_fbi;
 	}
 
 	fbi->mmio_base = ioremap(r->start, r->end - r->start + 1);
@@ -1733,8 +1733,17 @@ static int __init pxafb_probe(struct platform_device *dev)
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
 	 */
-	pxafb_check_var(&fbi->fb.var, &fbi->fb);
-	pxafb_set_par(&fbi->fb);
+	ret = pxafb_check_var(&fbi->fb.var, &fbi->fb);
+	if (ret) {
+		dev_err(&dev->dev, "failed to get suitable mode\n");
+		goto failed_free_irq;
+	}
+
+	ret = pxafb_set_par(&fbi->fb);
+	if (ret) {
+		dev_err(&dev->dev, "Failed to set parameters\n");
+		goto failed_free_irq;
+	}
 
 	platform_set_drvdata(dev, fbi);
 
@@ -1742,7 +1751,7 @@ static int __init pxafb_probe(struct platform_device *dev)
 	if (ret < 0) {
 		dev_err(&dev->dev,
 			"Failed to register framebuffer device: %d\n", ret);
-		goto failed_free_irq;
+		goto failed_free_cmap;
 	}
 
 #ifdef CONFIG_CPU_FREQ
@@ -1761,18 +1770,23 @@ static int __init pxafb_probe(struct platform_device *dev)
 
 	return 0;
 
+failed_free_cmap:
+	if (fbi->fb.cmap.len)
+		fb_dealloc_cmap(&fbi->fb.cmap);
 failed_free_irq:
 	free_irq(irq, fbi);
-failed_free_res:
-	release_mem_region(r->start, r->end - r->start + 1);
-failed_free_io:
-	iounmap(fbi->mmio_base);
 failed_free_mem:
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 			fbi->map_cpu, fbi->map_dma);
-failed:
+failed_free_io:
+	iounmap(fbi->mmio_base);
+failed_free_res:
+	release_mem_region(r->start, r->end - r->start + 1);
+failed_fbi:
+	clk_put(fbi->clk);
 	platform_set_drvdata(dev, NULL);
 	kfree(fbi);
+failed:
 	return ret;
 }
 
-- 
1.5.3.6


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
