From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: tridentfb: resource management fixes in probe
	function
Date: Mon, 25 Feb 2008 15:40:29 +0100
Message-ID: <20080225154029.03051c06.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JTehh-00005H-3V for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Feb 2008 06:53:17 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JTehf-0004cs-4i
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Feb 2008 06:53:17 -0800
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, adaplas@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch corrects error paths in probe function.

The probe function enables mmio mode so it important to disable 
the mmio mode before exiting the probe function.
Otherwise, the console is left in unusable state (garbled fonts
at least, lock up at worst).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-mm-ref/drivers/video/tridentfb.c linux-mm/drivers/video/tridentfb.c
--- linux-mm-ref/drivers/video/tridentfb.c	2008-02-20 07:26:39.000000000 +0100
+++ linux-mm/drivers/video/tridentfb.c	2008-02-20 07:27:26.932006373 +0100
@@ -569,17 +569,42 @@ static inline void write3CE(int reg, uns
 
 static inline void enable_mmio(void)
 {
+	unsigned char tmp;
 	/* Goto New Mode */
 	outb(0x0B, 0x3C4);
 	inb(0x3C5);
 
 	/* Unprotect registers */
 	outb(NewMode1, 0x3C4);
+	tmp = inb(0x3C5);
 	outb(0x80, 0x3C5);
 
 	/* Enable MMIO */
 	outb(PCIReg, 0x3D4);
 	outb(inb(0x3D5) | 0x01, 0x3D5);
+
+	t_outb(NewMode1, 0x3C4);
+	t_outb(tmp, 0x3C5);
+}
+
+static inline void disable_mmio(void)
+{
+	unsigned char tmp;
+	/* Goto New Mode */
+	t_outb(0x0B, 0x3C4);
+	t_inb(0x3C5);
+
+	/* Unprotect registers */
+	t_outb(NewMode1, 0x3C4);
+	tmp = t_inb(0x3C5);
+	t_outb(0x80, 0x3C5);
+
+	/* Disable MMIO */
+	t_outb(PCIReg, 0x3D4);
+	t_outb(t_inb(0x3D5) & ~0x01, 0x3D5);
+
+	outb(NewMode1, 0x3C4);
+	outb(tmp, 0x3C5);
 }
 
 #define crtc_unlock()	write3X4(CRTVSyncEnd, read3X4(CRTVSyncEnd) & 0x7F)
@@ -1242,9 +1267,9 @@ static int __devinit trident_pci_probe(s
 	default_par.io_virt = ioremap_nocache(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 
 	if (!default_par.io_virt) {
-		release_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 		debug("ioremap failed\n");
-		return -1;
+		err = -1;
+		goto out_unmap1;
 	}
 
 	enable_mmio();
@@ -1255,25 +1280,21 @@ static int __devinit trident_pci_probe(s
 
 	if (!request_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len, "tridentfb")) {
 		debug("request_mem_region failed!\n");
+		disable_mmio();
 		err = -1;
-		goto out_unmap;
+		goto out_unmap1;
 	}
 
 	fb_info.screen_base = ioremap_nocache(tridentfb_fix.smem_start,
 					      tridentfb_fix.smem_len);
 
 	if (!fb_info.screen_base) {
-		release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
 		debug("ioremap failed\n");
 		err = -1;
-		goto out_unmap;
+		goto out_unmap2;
 	}
 
 	output("%s board found\n", pci_name(dev));
-#if 0
-	output("Trident board found : mem = %X, io = %X, mem_v = %X, io_v = %X\n",
-		tridentfb_fix.smem_start, tridentfb_fix.mmio_start, fb_info.screen_base, default_par.io_virt);
-#endif
 	displaytype = get_displaytype();
 
 	if (flatpanel)
@@ -1292,9 +1313,12 @@ static int __devinit trident_pci_probe(s
 	if (!fb_find_mode(&default_var, &fb_info,
 			  mode_option, NULL, 0, NULL, bpp)) {
 		err = -EINVAL;
-		goto out_unmap;
+		goto out_unmap2;
 	}
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	err = fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	if (err < 0)
+		goto out_unmap2;
+
 	if (defaultaccel && acc)
 		default_var.accel_flags |= FB_ACCELF_TEXT;
 	else
@@ -1304,19 +1328,24 @@ static int __devinit trident_pci_probe(s
 	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		printk(KERN_ERR "tridentfb: could not register Trident framebuffer\n");
+		fb_dealloc_cmap(&fb_info.cmap);
 		err = -EINVAL;
-		goto out_unmap;
+		goto out_unmap2;
 	}
 	output("fb%d: %s frame buffer device %dx%d-%dbpp\n",
 	   fb_info.node, fb_info.fix.id, default_var.xres,
 	   default_var.yres, default_var.bits_per_pixel);
 	return 0;
 
-out_unmap:
-	if (default_par.io_virt)
-		iounmap(default_par.io_virt);
+out_unmap2:
 	if (fb_info.screen_base)
 		iounmap(fb_info.screen_base);
+	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
+	disable_mmio();
+out_unmap1:
+	if (default_par.io_virt)
+		iounmap(default_par.io_virt);
+	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 	return err;
 }
 
@@ -1327,7 +1356,7 @@ static void __devexit trident_pci_remove
 	iounmap(par->io_virt);
 	iounmap(fb_info.screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
-	release_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
+	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 }
 
 /* List of boards that we are trying to support */

----------------------------------------------------------------------
Rozmiar ma znaczenie... czy nie?
kliknij >>> http://link.interia.pl/f1d1f


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
