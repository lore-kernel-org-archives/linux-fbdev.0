From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 491] Amifb: update pseudocolor bitfield lenghts
Date: Sat, 2 Oct 2004 19:00:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410021700.i92H0Ova021178@anakin.of.borg>
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267385AbUJBRA3@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

Amiga frame buffer: The new convention (introduced in 2.6.9-rc1) requires that
the usable color depth for pseudocolor visuals is indicated by the lengths of
the color bitfields. Update amifb for this convention, and add a special case
for HAM (Hold-and-Modify) mode (colormap has 16 (HAM6) or 64 (HAM8) entries).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/drivers/video/amifb.c	2004-08-24 13:33:43.000000000 +0200
+++ linux-m68k-2.6.9-rc3/drivers/video/amifb.c	2004-09-10 21:23:26.000000000 +0200
@@ -2949,21 +2949,11 @@ static int ami_encode_var(struct fb_var_
 	var->bits_per_pixel = par->bpp;
 	var->grayscale = 0;
 
-	if (IS_AGA) {
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->red.msb_right = 0;
-	} else {
-		if (clk_shift == TAG_SHRES) {
-			var->red.offset = 0;
-			var->red.length = 2;
-			var->red.msb_right = 0;
-		} else {
-			var->red.offset = 0;
-			var->red.length = 4;
-			var->red.msb_right = 0;
-		}
-	}
+	var->red.offset = 0;
+	var->red.msb_right = 0;
+	var->red.length = par->bpp;
+	if (par->bplcon0 & BPC0_HAM)
+	    var->red.length -= 2;
 	var->blue = var->green = var->red;
 	var->transp.offset = 0;
 	var->transp.length = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
