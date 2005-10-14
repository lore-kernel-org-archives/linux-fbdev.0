From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] GBE framebuffer fixes
Date: Fri, 14 Oct 2005 22:52:23 +0100
Message-ID: <20051014215222.GA3311@linux-mips.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERRyB-0004Fj-B7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 03:11:51 -0700
Received: from extgw-uk.mips.com ([62.254.210.129] helo=bacchus.net.dhis.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1ERRy9-0000po-M7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 03:11:51 -0700
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>

For reviewing pleassure.  If nobody objects I'd like to submit this one
as part of my pile of MIPS patches.  GBE is the framebuffer of the SGI O2
which also exists in similar form

diff-tree 6f3fe836b5f14212063223562ee74f710291c2c8 (from 13f947cd035027c404390cb4f598fa8d60152a67)
Author: Thiemo Seufer <ths@networkno.de>
Date:   Fri Mar 4 19:40:45 2005 +0000

It helps to not use a _mem_ function for requesting I/O space.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


Index: manual.git/drivers/video/gbefb.c
===================================================================
--- manual.git.orig/drivers/video/gbefb.c
+++ manual.git/drivers/video/gbefb.c
@@ -1126,7 +1126,7 @@ static int __init gbefb_probe(struct dev
 	gbefb_setup(options);
 #endif
 
-	if (!request_mem_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
+	if (!request_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
 		printk(KERN_ERR "gbefb: couldn't reserve mmio region\n");
 		ret = -EBUSY;
 		goto out_release_framebuffer;
@@ -1152,12 +1152,24 @@ static int __init gbefb_probe(struct dev
 	if (gbe_mem_phys) {
 		/* memory was allocated at boot time */
 		gbe_mem = ioremap_nocache(gbe_mem_phys, gbe_mem_size);
+		if (!gbe_mem) {
+			printk(KERN_ERR "gbefb: couldn't map framebuffer\n");
+			ret = -ENOMEM;
+			goto out_tiles_free;
+		}
+
 		gbe_dma_addr = 0;
 	} else {
 		/* try to allocate memory with the classical allocator
 		 * this has high chance to fail on low memory machines */
 		gbe_mem = dma_alloc_coherent(NULL, gbe_mem_size, &gbe_dma_addr,
 					     GFP_KERNEL);
+		if (!gbe_mem) {
+			printk(KERN_ERR "gbefb: couldn't allocate framebuffer memory\n");
+			ret = -ENOMEM;
+			goto out_tiles_free;
+		}
+
 		gbe_mem_phys = (unsigned long) gbe_dma_addr;
 	}
 
@@ -1165,12 +1177,6 @@ static int __init gbefb_probe(struct dev
 	mtrr_add(gbe_mem_phys, gbe_mem_size, MTRR_TYPE_WRCOMB, 1);
 #endif
 
-	if (!gbe_mem) {
-		printk(KERN_ERR "gbefb: couldn't map framebuffer\n");
-		ret = -ENXIO;
-		goto out_tiles_free;
-	}
-
 	/* map framebuffer memory into tiles table */
 	for (i = 0; i < (gbe_mem_size >> TILE_SHIFT); i++)
 		gbe_tiles.cpu[i] = (gbe_mem_phys >> TILE_SHIFT) + i;


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
