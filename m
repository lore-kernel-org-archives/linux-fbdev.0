From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/17] platinumfb: Fix resource
	management
Date: Sat, 29 Sep 2007 09:29:53 +0800
Message-ID: <46FDAA91.4080205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSNM-000847-Ct for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:16 -0700
Received: from wr-out-0506.google.com ([64.233.184.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSNM-00039C-0z
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:16 -0700
Received: by wr-out-0506.google.com with SMTP id 36so1486750wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:48:15 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Current kernels have a non-working platinumfb due to some resource
management issues. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/platinumfb.c |   48 ++++++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 8503e73..cbe71a5 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -17,6 +17,8 @@
  *  more details.
  */
 
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -535,33 +537,35 @@ static int __devinit platinumfb_probe(st
 	volatile __u8		*fbuffer;
 	int			bank0, bank1, bank2, bank3, rc;
 
-	printk(KERN_INFO "platinumfb: Found Apple Platinum video hardware\n");
+	dev_info(&odev->dev, "Found Apple Platinum video hardware\n");
 
 	info = framebuffer_alloc(sizeof(*pinfo), &odev->dev);
-	if (info == NULL)
+	if (info == NULL) {
+		dev_err(&odev->dev, "Failed to allocate fbdev !\n");
 		return -ENOMEM;
+	}
 	pinfo = info->par;
 
 	if (of_address_to_resource(dp, 0, &pinfo->rsrc_reg) ||
 	    of_address_to_resource(dp, 1, &pinfo->rsrc_fb)) {
-		printk(KERN_ERR "platinumfb: Can't get resources\n");
-		framebuffer_release(info);
-		return -ENXIO;
-	}
-	if (!request_mem_region(pinfo->rsrc_reg.start,
-				pinfo->rsrc_reg.start -
-				pinfo->rsrc_reg.end + 1,
-				"platinumfb registers")) {
+		dev_err(&odev->dev, "Can't get resources\n");
 		framebuffer_release(info);
 		return -ENXIO;
 	}
+	dev_dbg(&odev->dev, " registers  : 0x%llx...0x%llx\n",
+		(unsigned long long)pinfo->rsrc_reg.start,
+		(unsigned long long)pinfo->rsrc_reg.end);
+	dev_dbg(&odev->dev, " framebuffer: 0x%llx...0x%llx\n",
+		(unsigned long long)pinfo->rsrc_fb.start,
+		(unsigned long long)pinfo->rsrc_fb.end);
+
+	/* Do not try to request register space, they overlap with the
+	 * northbridge and that can fail. Only request framebuffer
+	 */
 	if (!request_mem_region(pinfo->rsrc_fb.start,
-				pinfo->rsrc_fb.start
-				- pinfo->rsrc_fb.end + 1,
+				pinfo->rsrc_fb.end - pinfo->rsrc_fb.start + 1,
 				"platinumfb framebuffer")) {
-		release_mem_region(pinfo->rsrc_reg.start,
-				   pinfo->rsrc_reg.end -
-				   pinfo->rsrc_reg.start + 1);
+		printk(KERN_ERR "platinumfb: Can't request framebuffer !\n");
 		framebuffer_release(info);
 		return -ENXIO;
 	}
@@ -600,7 +604,8 @@ static int __devinit platinumfb_probe(st
 	bank2 = fbuffer[0x200000] == 0x56;
 	bank3 = fbuffer[0x300000] == 0x78;
 	pinfo->total_vram = (bank0 + bank1 + bank2 + bank3) * 0x100000;
-	printk(KERN_INFO "platinumfb: Total VRAM = %dMB (%d%d%d%d)\n", (int) (pinfo->total_vram / 1024 / 1024),
+	printk(KERN_INFO "platinumfb: Total VRAM = %dMB (%d%d%d%d)\n",
+	       (unsigned int) (pinfo->total_vram / 1024 / 1024),
 	       bank3, bank2, bank1, bank0);
 
 	/*
@@ -644,16 +649,15 @@ static int __devexit platinumfb_remove(s
         unregister_framebuffer (info);
 	
 	/* Unmap frame buffer and registers */
+	iounmap(pinfo->frame_buffer);
+	iounmap(pinfo->platinum_regs);
+	iounmap(pinfo->cmap_regs);
+
 	release_mem_region(pinfo->rsrc_fb.start,
 			   pinfo->rsrc_fb.end -
 			   pinfo->rsrc_fb.start + 1);
-	release_mem_region(pinfo->rsrc_reg.start,
-			   pinfo->rsrc_reg.end -
-			   pinfo->rsrc_reg.start + 1);
-	iounmap(pinfo->frame_buffer);
-	iounmap(pinfo->platinum_regs);
+
 	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
-	iounmap(pinfo->cmap_regs);
 
 	framebuffer_release(info);
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
