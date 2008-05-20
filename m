From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 4/4] tridentfb: fix console freeze when
	switching from X11
Date: Tue, 20 May 2008 07:14:21 +0200
Message-ID: <20080520071421.4d1727d0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyKdo-0005TD-MI for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 May 2008 22:44:04 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JyKdn-0001Lj-2g
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 May 2008 22:44:04 -0700
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

This patch fixes two problems when acceleration is
enabled:

 - console switch from the Xorg locks up the computer
   because the Xorg code locks some registers and disables
   the mmio mode, so reenable these in the
   tridentfb_set_par() and enable_mmio()

 - blacklist the Image975 chipset from setting PCI burst
   mode. This helps with random lock ups of the
   framebuffer on this chip. The same fix is probably
   needed for the Xorg as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is tridentfb patch number 25.

I thought that it would be the last patch in the batch of changes but there
seemed to be another bug for every fixed or enabled feature. I hope that
all these 25 patches will make in next kernel release (2.6.27).

Unfortunately, more fixes will follow. I hope they will be only minor ones.

diff -urp linux-old/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-18 22:59:31.062273649 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-18 23:03:38.878267000 +0200
@@ -558,13 +558,15 @@ static inline void write3CE(struct tride
 	vga_mm_wgfx(par->io_virt, reg, val);
 }
 
-static void enable_mmio(void)
+static void enable_mmio(struct tridentfb_par *par)
 {
 	/* Goto New Mode */
 	vga_io_rseq(0x0B);
 
 	/* Unprotect registers */
 	vga_io_wseq(NewMode1, 0x80);
+	if (!is_oldprotect(par->chip_id))
+		vga_io_wseq(Protection, 0x92);
 
 	/* Enable MMIO */
 	outb(PCIReg, 0x3D4);
@@ -578,6 +580,8 @@ static void disable_mmio(struct tridentf
 
 	/* Unprotect registers */
 	vga_mm_wseq(par->io_virt, NewMode1, 0x80);
+	if (!is_oldprotect(par->chip_id))
+		vga_mm_wseq(par->io_virt, Protection, 0x92);
 
 	/* Disable MMIO */
 	t_outb(par, PCIReg, 0x3D4);
@@ -993,6 +997,7 @@ static int tridentfb_set_par(struct fb_i
 		vblankend /= 2;
 	}
 
+	enable_mmio(par);
 	crtc_unlock(par);
 	write3CE(par, CyberControl, 8);
 	tmp = 0xEB;
@@ -1114,7 +1119,7 @@ static int tridentfb_set_par(struct fb_i
 	if (!is_xp(par->chip_id))
 		write3X4(par, Performance, read3X4(par, Performance) | 0x10);
 	/* MMIO & PCI read and write burst enable */
-	if (par->chip_id != TGUI9440)
+	if (par->chip_id != TGUI9440 && par->chip_id != IMAGE975)
 		write3X4(par, PCIReg, read3X4(par, PCIReg) | 0x06);
 
 	vga_mm_wseq(par->io_virt, 0, 3);
@@ -1401,7 +1406,7 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap1;
 	}
 
-	enable_mmio();
+	enable_mmio(default_par);
 
 	/* setup framebuffer memory */
 	tridentfb_fix.smem_start = pci_resource_start(dev, 0);

----------------------------------------------------------------------
Od slicznej Mariolki swieze pomidorki!
http://link.interia.pl/f1de2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
