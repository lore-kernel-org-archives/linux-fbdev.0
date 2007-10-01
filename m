From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/6] Xilinxfb: rename failout labels to
	reflect failure
Date: Mon, 01 Oct 2007 09:57:43 -0600
Message-ID: <20071001155743.6114.558.stgit@trillian.cg.shawcable.net>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcNfB-0003vK-QN for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 08:58:30 -0700
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]
	helo=pd3mo1so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcNfA-0002tJ-L1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 08:58:29 -0700
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP8002ZAPO98UE0@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:45 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP800D8SPO8GV30@pd3mr2so.prod.shaw.ca> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:45 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JP80098DPO7APB1@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:43 -0600 (MDT)
In-reply-to: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
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
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc@ozlabs.org, adaplas@gmail.com

From: Grant Likely <grant.likely@secretlab.ca>

Labels and gotos are used in xilinxfb_assign to unwind allocations
on device registration failures.  Rename the labels to reflect the
error which occured.  This change is being made to make it easier
to add new failout paths (which occurs in a subsuquent patch) and
to make reviewing the failout path easier.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index e63cbd1..9aa754a 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -225,14 +225,14 @@ xilinxfb_drv_probe(struct device *dev)
 	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
 		dev_err(dev, "Couldn't get registers resource\n");
 		retval = -EFAULT;
-		goto failed1;
+		goto err_region;
 	}
 
 	if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
 		dev_err(dev, "Couldn't lock memory region at 0x%08X\n",
 		       regs_res->start);
 		retval = -EBUSY;
-		goto failed1;
+		goto err_region;
 	}
 	drvdata->regs = (u32 __iomem*) ioremap(regs_res->start, 8);
 	drvdata->regs_phys = regs_res->start;
@@ -243,7 +243,7 @@ xilinxfb_drv_probe(struct device *dev)
 	if (!drvdata->fb_virt) {
 		dev_err(dev, "Could not allocate frame buffer memory\n");
 		retval = -ENOMEM;
-		goto failed2;
+		goto err_fbmem;
 	}
 
 	/* Clear (turn to black) the framebuffer */
@@ -270,7 +270,7 @@ xilinxfb_drv_probe(struct device *dev)
 		dev_err(dev, "Fail to allocate colormap (%d entries)\n",
 			PALETTE_ENTRIES_NO);
 		retval = -EFAULT;
-		goto failed3;
+		goto err_cmap;
 	}
 
 	drvdata->info.flags = FBINFO_DEFAULT;
@@ -284,7 +284,7 @@ xilinxfb_drv_probe(struct device *dev)
 	if (register_framebuffer(&drvdata->info) < 0) {
 		dev_err(dev, "Could not register frame buffer\n");
 		retval = -EINVAL;
-		goto failed4;
+		goto err_regfb;
 	}
 
 	/* Put a banner in the log (for DEBUG) */
@@ -294,10 +294,10 @@ xilinxfb_drv_probe(struct device *dev)
 		(void*)drvdata->fb_phys, drvdata->fb_virt, FB_SIZE);
 	return 0;	/* success */
 
-failed4:
+err_regfb:
 	fb_dealloc_cmap(&drvdata->info.cmap);
 
-failed3:
+err_cmap:
 	dma_free_coherent(dev, PAGE_ALIGN(FB_SIZE), drvdata->fb_virt,
 		drvdata->fb_phys);
 
@@ -305,10 +305,10 @@ failed3:
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
 	iounmap(drvdata->regs);
 
-failed2:
+err_fbmem:
 	release_mem_region(regs_res->start, 8);
 
-failed1:
+err_region:
 	kfree(drvdata);
 	dev_set_drvdata(dev, NULL);
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
