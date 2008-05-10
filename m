From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: improved register values on
	TGUI 9680
Date: Sat, 10 May 2008 19:59:38 +0200
Message-ID: <20080510195938.0cfe15a7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JutM6-0003TW-7h for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 May 2008 10:59:34 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JutM4-0001HM-9n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 May 2008 10:59:34 -0700
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
Cc: akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Improved values for some registers after Xorg
Trident driver. The main problem was that values
set by BIOS have been ignored.

This patch completely remove random pixels ("snow") on
the TGUI 9680 and 9440 (not supported yet by the driver).
It does not help with the "snow" on 3DImage and Blade3D cards.

There is also small improvement in timing calculations
(hblank start and vblank start)

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-10 08:37:48.517789390 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-10 19:43:16.893411948 +0200
@@ -87,7 +87,17 @@ MODULE_PARM_DESC(crt, "Define if CRT is 
 
 static int is_oldclock(int id)
 {
-	return (id == TGUI9660);
+	return	(id == TGUI9660) ||
+		(id == CYBER9320);
+}
+
+static int is_oldprotect(int id)
+{
+	return	(id == TGUI9660) ||
+		(id == PROVIDIA9685) ||
+		(id == CYBER9320) ||
+		(id == CYBER9382) ||
+		(id == CYBER9385);
 }
 
 static int is_blade(int id)
@@ -143,6 +153,7 @@ static int iscyber(int id)
 
 	case CYBER9320:
 	case TGUI9660:
+	case PROVIDIA9685:
 	case IMAGE975:
 	case IMAGE985:
 	case BLADE3D:
@@ -905,14 +916,14 @@ static int tridentfb_set_par(struct fb_i
 	hsyncend = (var->xres + var->right_margin + var->hsync_len) / 8 - 1;
 	htotal = (var->xres + var->left_margin + var->right_margin +
 		  var->hsync_len) / 8 - 5;
-	hblankstart = hdispend + 2;
+	hblankstart = hdispend + 1;
 	hblankend = htotal + 3;
 
 	vdispend = var->yres - 1;
 	vsyncstart = var->yres + var->lower_margin;
 	vsyncend = vsyncstart + var->vsync_len;
 	vtotal = var->upper_margin + vsyncend - 2;
-	vblankstart = vdispend + 2;
+	vblankstart = vdispend + 1;
 	vblankend = vtotal;
 
 	crtc_unlock(par);
@@ -1020,15 +1031,18 @@ static int tridentfb_set_par(struct fb_i
 
 	write3X4(par, PixelBusReg, tmp);
 
-	tmp = 0x10;
+	tmp = read3X4(par, DRAMControl);
+	if (!is_oldprotect(par->chip_id))
+		tmp |= 0x10;
 	if (iscyber(par->chip_id))
 		tmp |= 0x20;
 	write3X4(par, DRAMControl, tmp);	/* both IO, linear enable */
 
 	write3X4(par, InterfaceSel, read3X4(par, InterfaceSel) | 0x40);
-	write3X4(par, Performance, 0x92);
+	if (!is_xp(par->chip_id))
+		write3X4(par, Performance, read3X4(par, Performance) | 0x10);
 	/* MMIO & PCI read and write burst enable */
-	write3X4(par, PCIReg, 0x07);
+	write3X4(par, PCIReg, read3X4(par, PCIReg) | 0x06);
 
 	/* convert from picoseconds to kHz */
 	vclk = PICOS2KHZ(info->var.pixclock);
@@ -1230,6 +1244,9 @@ static int __devinit trident_pci_probe(s
 		revision = vga_io_rseq(RevisionID);
 
 		switch (revision) {
+		case 0x21:
+			chip_id = PROVIDIA9685;
+			break;
 		case 0x22:
 		case 0x23:
 			chip_id = CYBER9397;
diff -urp linux-2.6.25/include/video/trident.h linux-new/include/video/trident.h
--- linux-2.6.25/include/video/trident.h	2008-05-08 22:20:07.564536989 +0200
+++ linux-new/include/video/trident.h	2008-05-10 07:37:17.466253192 +0200
@@ -25,6 +25,7 @@
 #define CYBER9520	0x9520
 #define CYBER9525DVD	0x9525
 #define TGUI9660	0x9660
+#define PROVIDIA9685	0x9685
 #define IMAGE975	0x9750
 #define IMAGE985	0x9850
 #define BLADE3D		0x9880

----------------------------------------------------------------------
Andrzej Piaseczny w roli kucharza? Zobacz!
http://link.interia.pl/f1dcb


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
