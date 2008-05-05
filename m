From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 4/8] tridentfb: move global chip_id into
	structure
Date: Mon, 5 May 2008 18:55:10 +0200
Message-ID: <20080505185510.e6f3c3cb.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt3yH-0007Xi-QZ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:55:25 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt3yA-0005mu-NN
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:55:20 -0700
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
Cc: adaplas@pol.net, akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch moves the chip_id into tridentfb_par
structure and removes global chip_id related constants.

It also bumps version of the driver to 0.7.9

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-02 13:28:35.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-02 13:28:39.000000000 +0200
@@ -24,11 +24,12 @@
 #include <linux/delay.h>
 #include <video/trident.h>
 
-#define VERSION		"0.7.8-NEWAPI"
+#define VERSION		"0.7.9-NEWAPI"
 
 struct tridentfb_par {
 	void __iomem *io_virt;	/* iospace virtual memory address */
 	u32 pseudo_pal[16];
+	int chip_id;
 };
 
 static unsigned char eng_oper;	/* engine operation... */
@@ -42,9 +43,6 @@ static struct fb_fix_screeninfo tridentf
 	.accel = FB_ACCEL_NONE,
 };
 
-static int chip_id;
-
-static int defaultaccel;
 static int displaytype;
 
 /* defaults which are normally overriden by user values */
@@ -79,9 +77,6 @@ module_param(nativex, int, 0);
 module_param(fp, int, 0);
 module_param(crt, int, 0);
 
-static int chip3D;
-static int chipcyber;
-
 static int is3Dchip(int id)
 {
 	return ((id == BLADE3D) || (id == CYBERBLADEE4) ||
@@ -658,7 +653,7 @@ static void set_lwidth(struct tridentfb_
 /* For resolutions smaller than FP resolution stretch */
 static void screen_stretch(struct tridentfb_par *par)
 {
-	if (chip_id != CYBERBLADEXPAi1)
+	if (par->chip_id != CYBERBLADEXPAi1)
 		write3CE(par, BiosReg, 0);
 	else
 		write3CE(par, BiosReg, 8);
@@ -706,7 +701,7 @@ static void set_vclk(struct tridentfb_pa
 				if (fi > freq)
 					break;
 			}
-	if (chip3D) {
+	if (is3Dchip(par->chip_id)) {
 		write3C4(par, ClockHigh, hi);
 		write3C4(par, ClockLow, lo);
 	} else {
@@ -739,7 +734,7 @@ static unsigned int __devinit get_displa
 {
 	if (fp)
 		return DISPLAY_FP;
-	if (crt || !chipcyber)
+	if (crt || !iscyber(par->chip_id))
 		return DISPLAY_CRT;
 	return (read3CE(par, FPConfig) & 0x10) ? DISPLAY_FP : DISPLAY_CRT;
 }
@@ -754,7 +749,7 @@ static unsigned int __devinit get_memsiz
 	if (memsize)
 		k = memsize * Kb;
 	else
-		switch (chip_id) {
+		switch (par->chip_id) {
 		case CYBER9525DVD:
 			k = 2560 * Kb;
 			break;
@@ -1034,7 +1029,7 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(par, PixelBusReg, tmp);
 
 	tmp = 0x10;
-	if (chipcyber)
+	if (iscyber(par->chip_id))
 		tmp |= 0x20;
 	write3X4(par, DRAMControl, tmp);	/* both IO, linear enable */
 
@@ -1062,7 +1057,7 @@ static int tridentfb_set_par(struct fb_i
 	write3CE(par, 0x6, 0x05);	/* graphics mode */
 	write3CE(par, 0x7, 0x0F);	/* planes? */
 
-	if (chip_id == CYBERBLADEXPAi1) {
+	if (par->chip_id == CYBERBLADEXPAi1) {
 		/* This fixes snow-effect in 32 bpp */
 		write3X4(par, CRTHSyncStart, 0x84);
 	}
@@ -1217,6 +1212,9 @@ static int __devinit trident_pci_probe(s
 	unsigned char revision;
 	struct fb_info *info;
 	struct tridentfb_par *default_par;
+	int defaultaccel;
+	int chip3D;
+	int chip_id;
 
 	err = pci_enable_device(dev);
 	if (err)
@@ -1269,7 +1267,6 @@ static int __devinit trident_pci_probe(s
 	}
 
 	chip3D = is3Dchip(chip_id);
-	chipcyber = iscyber(chip_id);
 
 	if (is_xp(chip_id)) {
 		acc = &accel_xp;
@@ -1279,6 +1276,8 @@ static int __devinit trident_pci_probe(s
 		acc = &accel_image;
 	}
 
+	default_par->chip_id = chip_id;
+
 	/* acceleration is on by default for 3D chips */
 	defaultaccel = chip3D && !noaccel;
 

----------------------------------------------------------------------
Lepszy niz zakladki. 	
Kliknij >>> http://link.interia.pl/f1db1


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
