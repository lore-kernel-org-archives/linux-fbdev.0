From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: fix clock settings for older
	Trident 96XX chips
Date: Fri, 9 May 2008 08:30:40 +0200
Message-ID: <20080509083040.f6d9e1f6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuMc3-0000kV-SA for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 00:01:51 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuMc2-00086s-9h
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 00:01:51 -0700
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

The Xorg code shows that Trident models 9660, 9680 and 9682 require
a different clock setting method.
Add the second clock setting method for older models.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-rc1/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-rc1/drivers/video/tridentfb.c	2008-05-08 20:12:56.287574627 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-08 20:30:43.259364052 +0200
@@ -85,6 +85,11 @@ MODULE_PARM_DESC(fp, "Define if flatpane
 module_param(crt, int, 0);
 MODULE_PARM_DESC(crt, "Define if CRT is connected");
 
+static int is_oldclock(int id)
+{
+	return (id == TGUI9660);
+}
+
 static int is_blade(int id)
 {
 	return	(id == BLADE3D) ||
@@ -659,23 +664,33 @@ static void set_screen_start(struct trid
 static void set_vclk(struct tridentfb_par *par, unsigned long freq)
 {
 	int m, n, k;
-	unsigned long f, fi, d, di;
-	unsigned char lo = 0, hi = 0;
+	unsigned long fi, d, di;
+	unsigned char best_m = 0, best_n = 0, best_k = 0;
+	unsigned char hi, lo;
 
 	d = 20000;
-	for (k = 2; k >= 0; k--)
-		for (m = 0; m < 63; m++)
-			for (n = 0; n < 128; n++) {
+	for (k = 1; k >= 0; k--)
+		for (m = 0; m < 32; m++)
+			for (n = 0; n < 122; n++) {
 				fi = ((14318l * (n + 8)) / (m + 2)) >> k;
 				if ((di = abs(fi - freq)) < d) {
 					d = di;
-					f = fi;
-					lo = n;
-					hi = (k << 6) | m;
+					best_n = n;
+					best_m = m;
+					best_k = k;
 				}
 				if (fi > freq)
 					break;
 			}
+
+	if (is_oldclock(par->chip_id)) {
+		lo = best_n | (best_m << 7);
+		hi = (best_m >> 1) | (best_k << 4);
+	} else {
+		lo = best_n;
+		hi = best_m | (best_k << 6);
+	}
+
 	if (is3Dchip(par->chip_id)) {
 		vga_mm_wseq(par->io_virt, ClockHigh, hi);
 		vga_mm_wseq(par->io_virt, ClockLow, lo);

----------------------------------------------------------------------
> Blachara + solarium = ...sam zobacz!
> Video>> http://link.interia.pl/f1ddd


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
