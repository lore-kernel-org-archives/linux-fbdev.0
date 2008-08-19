From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] neofb: kill some redundant code
Date: Tue, 19 Aug 2008 21:48:35 +0200
Message-ID: <20080819214835.909c9551.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVX6D-0007Gm-6J for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 12:42:37 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVX6B-000873-If
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 12:42:37 -0700
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

Move common code outside if/else or switch/case
clauses.
Drop checks done twice inside the neofb_check_var().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-ref/drivers/video/neofb.c linux-2.6/drivers/video/neofb.c
--- linux-ref/drivers/video/neofb.c	2008-08-20 22:03:40.000000000 +0200
+++ linux-2.6/drivers/video/neofb.c	2008-08-20 22:05:52.000000000 +0200
@@ -426,11 +426,11 @@ static void vgaHWProtect(int on)
 {
 	unsigned char tmp;
 
+	tmp = vga_rseq(NULL, 0x01);
 	if (on) {
 		/*
 		 * Turn off screen and disable sequencer.
 		 */
-		tmp = vga_rseq(NULL, 0x01);
 		vga_wseq(NULL, 0x00, 0x01);		/* Synchronous Reset */
 		vga_wseq(NULL, 0x01, tmp | 0x20);	/* disable the display */
 
@@ -439,7 +439,6 @@ static void vgaHWProtect(int on)
 		/*
 		 * Reenable sequencer, then turn on screen.
 		 */
-		tmp = vga_rseq(NULL, 0x01);
 		vga_wseq(NULL, 0x01, tmp & ~0x20);	/* reenable display */
 		vga_wseq(NULL, 0x00, 0x03);		/* clear synchronousreset */
 
@@ -648,10 +647,10 @@ neofb_check_var(struct fb_var_screeninfo
 	var->blue.msb_right = 0;
 	var->transp.msb_right = 0;
 
+	var->transp.offset = 0;
+	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
 	case 8:		/* PSEUDOCOLOUR, 256 */
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		var->red.offset = 0;
 		var->red.length = 8;
 		var->green.offset = 0;
@@ -661,8 +660,6 @@ neofb_check_var(struct fb_var_screeninfo
 		break;
 
 	case 16:		/* DIRECTCOLOUR, 64k */
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		var->red.offset = 11;
 		var->red.length = 5;
 		var->green.offset = 5;
@@ -672,8 +669,6 @@ neofb_check_var(struct fb_var_screeninfo
 		break;
 
 	case 24:		/* TRUECOLOUR, 16m */
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		var->red.offset = 16;
 		var->red.length = 8;
 		var->green.offset = 8;
@@ -704,8 +699,6 @@ neofb_check_var(struct fb_var_screeninfo
 	if (vramlen > 4 * 1024 * 1024)
 		vramlen = 4 * 1024 * 1024;
 
-	if (var->yres_virtual < var->yres)
-		var->yres_virtual = var->yres;
 	if (var->xres_virtual < var->xres)
 		var->xres_virtual = var->xres;
 
@@ -722,8 +715,6 @@ neofb_check_var(struct fb_var_screeninfo
 	   if it was possible. We should return -EINVAL, but I disagree */
 	if (var->yres_virtual < var->yres)
 		var->yres = var->yres_virtual;
-	if (var->xres_virtual < var->xres)
-		var->xres = var->xres_virtual;
 	if (var->xoffset + var->xres > var->xres_virtual)
 		var->xoffset = var->xres_virtual - var->xres;
 	if (var->yoffset + var->yres > var->yres_virtual)

---------------------------------------------------------------------- 	
Prosty kredyt na wszystkie potrzeby. 
Od 1000 zl do 120 000 zl. 
Bez poreczycieli i zabezpieczen >>> http://link.interia.pl/f1edf


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
