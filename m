From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve
	diagnostics
Date: Tue, 18 Sep 2007 13:18:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IXc2y-00005z-Ko for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 05:19:20 -0700
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IXc2x-0000k4-VJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 05:19:20 -0700
In-Reply-To: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@pol.net>
Cc: linux-mips@linux-mips.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

 Add error messages to the probe call.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 While they may rarely trigger, they may be useful when something weird is 
going on.  Also this is good style.

 This is an updated version that addresses an issue raised by Mariusz 
Kozlowski for the sibling patch.  Checked with checkpatch.pl.

 Please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-pmag-ba-err-2
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c	2007-02-21 05:56:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c	2007-09-18 10:56:51.000000000 +0000
@@ -147,16 +147,23 @@ static int __init pmagbafb_probe(struct 
 	resource_size_t start, len;
 	struct fb_info *info;
 	struct pmagbafb_par *par;
+	int err = 0;
 
 	info = framebuffer_alloc(sizeof(struct pmagbafb_par), dev);
-	if (!info)
+	if (!info) {
+		printk(KERN_ERR "%s: Cannot allocate memory\n", dev->bus_id);
 		return -ENOMEM;
+	}
 
 	par = info->par;
 	dev_set_drvdata(dev, info);
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		printk(KERN_ERR "%s: Cannot allocate color map\n",
+		       dev->bus_id);
+		err = -ENOMEM;
 		goto err_alloc;
+	}
 
 	info->fbops = &pmagbafb_ops;
 	info->fix = pmagbafb_fix;
@@ -166,28 +173,41 @@ static int __init pmagbafb_probe(struct 
 	/* Request the I/O MEM resource.  */
 	start = tdev->resource.start;
 	len = tdev->resource.end - start + 1;
-	if (!request_mem_region(start, len, dev->bus_id))
+	if (!request_mem_region(start, len, dev->bus_id)) {
+		printk(KERN_ERR "%s: Cannot reserve FB region\n", dev->bus_id);
+		err = -EBUSY;
 		goto err_cmap;
+	}
 
 	/* MMIO mapping setup.  */
 	info->fix.mmio_start = start;
 	par->mmio = ioremap_nocache(info->fix.mmio_start, info->fix.mmio_len);
-	if (!par->mmio)
+	if (!par->mmio) {
+		printk(KERN_ERR "%s: Cannot map MMIO\n", dev->bus_id);
+		err = -ENOMEM;
 		goto err_resource;
+	}
 	par->dac = par->mmio + PMAG_BA_BT459;
 
 	/* Frame buffer mapping setup.  */
 	info->fix.smem_start = start + PMAG_BA_FBMEM;
 	info->screen_base = ioremap_nocache(info->fix.smem_start,
 					    info->fix.smem_len);
-	if (!info->screen_base)
+	if (!info->screen_base) {
+		printk(KERN_ERR "%s: Cannot map FB\n", dev->bus_id);
+		err = -ENOMEM;
 		goto err_mmio_map;
+	}
 	info->screen_size = info->fix.smem_len;
 
 	pmagbafb_erase_cursor(info);
 
-	if (register_framebuffer(info) < 0)
+	err = register_framebuffer(info);
+	if (err < 0) {
+		printk(KERN_ERR "%s: Cannot register framebuffer\n",
+		       dev->bus_id);
 		goto err_smem_map;
+	}
 
 	get_device(dev);
 
@@ -211,7 +231,7 @@ err_cmap:
 
 err_alloc:
 	framebuffer_release(info);
-	return -ENXIO;
+	return err;
 }
 
 static int __exit pmagbafb_remove(struct device *dev)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
