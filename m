From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: add TGUI 9440 support
Date: Sat, 10 May 2008 20:20:02 +0200
Message-ID: <20080510202002.96dbbb22.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jutfj-0005L3-3H for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 May 2008 11:19:51 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jutfh-0007ku-H0
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 May 2008 11:19:50 -0700
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

Add support for TGUI 9440 chip.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-10 19:45:56.829416294 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-10 20:11:09.481412059 +0200
@@ -87,13 +87,15 @@ MODULE_PARM_DESC(crt, "Define if CRT is 
 
 static int is_oldclock(int id)
 {
-	return	(id == TGUI9660) ||
+	return	(id == TGUI9440) ||
+		(id == TGUI9660) ||
 		(id == CYBER9320);
 }
 
 static int is_oldprotect(int id)
 {
-	return	(id == TGUI9660) ||
+	return	(id == TGUI9440) ||
+		(id == TGUI9660) ||
 		(id == PROVIDIA9685) ||
 		(id == CYBER9320) ||
 		(id == CYBER9382) ||
@@ -1042,7 +1044,8 @@ static int tridentfb_set_par(struct fb_i
 	if (!is_xp(par->chip_id))
 		write3X4(par, Performance, read3X4(par, Performance) | 0x10);
 	/* MMIO & PCI read and write burst enable */
-	write3X4(par, PCIReg, read3X4(par, PCIReg) | 0x06);
+	if (par->chip_id != TGUI9440)
+		write3X4(par, PCIReg, read3X4(par, PCIReg) | 0x06);
 
 	/* convert from picoseconds to kHz */
 	vclk = PICOS2KHZ(info->var.pixclock);
@@ -1418,6 +1421,7 @@ static struct pci_device_id trident_devi
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEE4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_TRIDENT,	TGUI9440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	TGUI9660, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	IMAGE975, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_TRIDENT,	IMAGE985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
diff -urp linux-2.6.25/include/video/trident.h linux-new/include/video/trident.h
--- linux-2.6.25/include/video/trident.h	2008-05-10 19:45:56.841411929 +0200
+++ linux-new/include/video/trident.h	2008-05-10 20:05:11.581416561 +0200
@@ -24,6 +24,7 @@
 #define CYBER9397DVD	0x939A
 #define CYBER9520	0x9520
 #define CYBER9525DVD	0x9525
+#define TGUI9440	0x9440
 #define TGUI9660	0x9660
 #define PROVIDIA9685	0x9685
 #define IMAGE975	0x9750

----------------------------------------------------------------------
> Praca moze zabijac.
> Sprawdz >> 
> http://link.interia.pl/f1dd3


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
