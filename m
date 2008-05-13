From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: fix hi-color modes for TGUI
	9440
Date: Tue, 13 May 2008 18:06:41 +0200
Message-ID: <20080513180641.2eeb1f95.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jvx1I-0006UM-Hn for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 09:06:29 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jvx1B-00007k-B2
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 09:06:28 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The TGUI 9440 requires doubling clock for 16bpp (hi-color) modes.

The patch also moves back enable_mmio() call to the right position.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

--- 

This is patch number 18. A list of previous patches:

01 tridentfb-replace-macros-with-functions.patch
02 tridentfb-convert-fb_info-into-allocated-one.patch
03 tridentfb-move-global-pseudo-palette-into-structure.patch
04 tridentfb-move-global-chip_id-into-structure.patch
05 tridentfb-move-global-flat-panel-variable-into-structure.patch
06 tridentfb-convert-is_blade-and-is_xp-macros-into-functions.patch
07 tridentfb-move-global-acceleration-hooks-into-structure.patch
08 tridentfb-make-use-of-functions-and-constants-from-the-vgah.patch
09 tridentfb-fix-timing-calculations.patch
10 tridentfb-use-mmio-access-for-clock-setting.patch
11 tridentfb-fix-clock-settings-for-older-trident-96xx-chips.patch
12 tridentfb-improve-probe-function.patch
13 tridentfb-improved-register-values-on-tgui-9680.patch
14 tridentfb-add-tgui-9440-support.patch
15 tridentfb-fix-unitialized-pseudo_palette.patch
16 tridentfb-improve-check_var-function.patch
17 tridentfb-preserve-memory-type-settings.patch

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-13 17:07:10.307094440 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-13 17:08:39.887094348 +0200
@@ -835,6 +835,8 @@ static int tridentfb_check_var(struct fb
 	/* check color depth */
 	if (bpp == 24)
 		bpp = var->bits_per_pixel = 32;
+	if (par->chip_id == TGUI9440 && bpp == 32)
+		return -EINVAL;
 	/* check whether resolution fits on panel and in memory */
 	if (par->flatpanel && nativex && var->xres > nativex)
 		return -EINVAL;
@@ -881,7 +883,7 @@ static int tridentfb_check_var(struct fb
 
 	switch (par->chip_id) {
 	case TGUI9440:
-		ramdac = 90000;
+		ramdac = (bpp >= 16) ? 45000 : 90000;
 		break;
 	case CYBER9320:
 	case TGUI9660:
@@ -1081,12 +1083,6 @@ static int tridentfb_set_par(struct fb_i
 	if (par->chip_id != TGUI9440)
 		write3X4(par, PCIReg, read3X4(par, PCIReg) | 0x06);
 
-	/* convert from picoseconds to kHz */
-	vclk = PICOS2KHZ(info->var.pixclock);
-	if (bpp == 32)
-		vclk *= 2;
-	set_vclk(par, vclk);
-
 	vga_mm_wseq(par->io_virt, 0, 3);
 	vga_mm_wseq(par->io_virt, 1, 1); /* set char clock 8 dots wide */
 	/* enable 4 maps because needed in chain4 mode */
@@ -1094,10 +1090,16 @@ static int tridentfb_set_par(struct fb_i
 	vga_mm_wseq(par->io_virt, 3, 0);
 	vga_mm_wseq(par->io_virt, 4, 0x0E); /* memory mode enable bitmaps ?? */
 
+	/* convert from picoseconds to kHz */
+	vclk = PICOS2KHZ(info->var.pixclock);
+
 	/* divide clock by 2 if 32bpp chain4 mode display and CPU path */
 	tmp = read3CE(par, MiscExtFunc) & 0xF0;
-	if (bpp == 32)
+	if (bpp == 32 || (par->chip_id == TGUI9440 && bpp == 16)) {
 		tmp |= 8;
+		vclk *= 2;
+	}
+	set_vclk(par, vclk);
 	write3CE(par, MiscExtFunc, tmp | 0x12);
 	write3CE(par, 0x5, 0x40);	/* no CGA compat, allow 256 col */
 	write3CE(par, 0x6, 0x05);	/* graphics mode */
@@ -1361,6 +1363,8 @@ static int __devinit trident_pci_probe(s
 	tridentfb_fix.smem_start = pci_resource_start(dev, 0);
 	tridentfb_fix.smem_len = get_memsize(default_par);
 
+	enable_mmio();
+
 	if (!request_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len, "tridentfb")) {
 		debug("request_mem_region failed!\n");
 		disable_mmio(info->par);
@@ -1368,8 +1372,6 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap1;
 	}
 
-	enable_mmio();
-
 	info->screen_base = ioremap_nocache(tridentfb_fix.smem_start,
 					    tridentfb_fix.smem_len);
 

----------------------------------------------------------------------
> Blachara + solarium = ...sam zobacz!
> Video>> http://link.interia.pl/f1ddd


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
