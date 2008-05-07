From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: fix timing calculations
Date: Wed, 7 May 2008 17:41:41 +0200
Message-ID: <20080507174141.1e04e789.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtmU1-0000UH-8P for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 09:27:10 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtmC6-0000YS-Ul
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 09:08:40 -0700
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
Cc: akpm@linux-foundation.org, adaplas@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix broken timings calculations. This patch helps with following
problems:
 - no left part of screen visible (up to half of the screen)
 - monitor's frequencies are not the ones intended for selected modes
 - if mode with resoultion y > 1024 is selected at least once then
   all modes with y < 1024 are "out of sync" (no display)

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-06 19:49:15.607453941 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-07 06:52:14.175279482 +0200
@@ -886,20 +886,19 @@ static int tridentfb_set_par(struct fb_i
 
 	debug("enter\n");
 	hdispend = var->xres / 8 - 1;
-	hsyncstart = (var->xres + var->right_margin) / 8;
-	hsyncend = var->hsync_len / 8;
-	htotal =
-		(var->xres + var->left_margin + var->right_margin +
-		 var->hsync_len) / 8 - 10;
-	hblankstart = hdispend + 1;
-	hblankend = htotal + 5;
+	hsyncstart = (var->xres + var->right_margin) / 8 - 1;
+	hsyncend = (var->xres + var->right_margin + var->hsync_len) / 8 - 1;
+	htotal = (var->xres + var->left_margin + var->right_margin +
+		  var->hsync_len) / 8 - 5;
+	hblankstart = hdispend + 2;
+	hblankend = htotal + 3;
 
 	vdispend = var->yres - 1;
 	vsyncstart = var->yres + var->lower_margin;
-	vsyncend = var->vsync_len;
-	vtotal = var->upper_margin + vsyncstart + vsyncend - 2;
-	vblankstart = var->yres;
-	vblankend = vtotal + 2;
+	vsyncend = vsyncstart + var->vsync_len;
+	vtotal = var->upper_margin + vsyncend - 2;
+	vblankstart = vdispend + 2;
+	vblankend = vtotal;
 
 	crtc_unlock(par);
 	write3CE(par, CyberControl, 8);
@@ -930,7 +929,7 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(par, VGA_CRTC_V_SYNC_START, vsyncstart & 0xFF);
 	write3X4(par, VGA_CRTC_V_SYNC_END, (vsyncend & 0x0F));
 	write3X4(par, VGA_CRTC_V_BLANK_START, vblankstart & 0xFF);
-	write3X4(par, VGA_CRTC_V_BLANK_END, 0 /* p->vblankend & 0xFF */);
+	write3X4(par, VGA_CRTC_V_BLANK_END, vblankend & 0xFF);
 
 	/* horizontal timing values */
 	write3X4(par, VGA_CRTC_H_TOTAL, htotal & 0xFF);
@@ -939,7 +938,7 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(par, VGA_CRTC_H_SYNC_END,
 		 (hsyncend & 0x1F) | ((hblankend & 0x20) << 2));
 	write3X4(par, VGA_CRTC_H_BLANK_START, hblankstart & 0xFF);
-	write3X4(par, VGA_CRTC_H_BLANK_END, 0 /* (p->hblankend & 0x1F) */);
+	write3X4(par, VGA_CRTC_H_BLANK_END, hblankend & 0x1F);
 
 	/* higher bits of vertical timing values */
 	tmp = 0x10;
@@ -953,16 +952,18 @@ static int tridentfb_set_par(struct fb_i
 	if (vsyncstart & 0x200) tmp |= 0x80;
 	write3X4(par, VGA_CRTC_OVERFLOW, tmp);
 
-	tmp = read3X4(par, CRTHiOrd) | 0x08;	/* line compare bit 10 */
+	tmp = read3X4(par, CRTHiOrd) & 0x07;
+	tmp |= 0x08;	/* line compare bit 10 */
 	if (vtotal & 0x400) tmp |= 0x80;
 	if (vblankstart & 0x400) tmp |= 0x40;
 	if (vsyncstart & 0x400) tmp |= 0x20;
 	if (vdispend & 0x400) tmp |= 0x10;
 	write3X4(par, CRTHiOrd, tmp);
 
-	tmp = 0;
-	if (htotal & 0x800) tmp |= 0x800 >> 11;
-	if (hblankstart & 0x800) tmp |= 0x800 >> 7;
+	tmp = (htotal >> 8) & 0x01;
+	tmp |= (hdispend >> 7) & 0x02;
+	tmp |= (hsyncstart >> 5) & 0x08;
+	tmp |= (hblankstart >> 4) & 0x10;
 	write3X4(par, HorizOverflow, tmp);
 
 	tmp = 0x40;

----------------------------------------------------------------------
Andrzej Piaseczny w roli kucharza? Zobacz!
http://link.interia.pl/f1dcb


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
