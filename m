From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] Interlace for rivafb driver
Date: 26 Jan 2003 00:08:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043536112.1281.53.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from maile.telia.com ([194.22.190.16])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cZOs-0002cx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Jan 2003 15:07:47 -0800
Received: from h9n1fls20o980.telia.com (h9n1fls20o980.telia.com [213.65.208.9])
	by maile.telia.com (8.12.5/8.12.5) with ESMTP id h0PN7DVj028061
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 26 Jan 2003 00:07:13 +0100 (CET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Attached patch implements interlace for the rivafb driver and
the hardware that supports it (Riva 128, TNT, TNT2, some GeForce 
cards and possibly others).

It's a patch against 2.4.21-pre2 (with polarity and sync patches)
but it should fit with 2.5.x too skipping riva_hw.c and riva_hw.h 
which already are adopted from XFree86.

	Fredrik


--- linux-2.4.21-pre2/drivers/video/riva/riva_hw.c.orig	2003-01-25 00:36:10.000000000 +0100
+++ linux-2.4.21-pre2/drivers/video/riva/riva_hw.c	2003-01-25 00:38:14.000000000 +0100
@@ -1547,6 +1547,8 @@
     VGA_WR08(chip->PCIO, 0x03D5, state->cursor0);
     VGA_WR08(chip->PCIO, 0x03D4, 0x31);
     VGA_WR08(chip->PCIO, 0x03D5, state->cursor1);
+    VGA_WR08(chip->PCIO, 0x03D4, 0x39);
+    VGA_WR08(chip->PCIO, 0x03D5, state->interlace);
     chip->PRAMDAC[0x00000300/4]  = state->cursor2;
     chip->PRAMDAC[0x00000508/4]  = state->vpll;
     chip->PRAMDAC[0x0000050C/4]  = state->pllsel;
--- linux-2.4.21-pre2/drivers/video/riva/riva_hw.h.orig	2003-01-25 00:36:15.000000000 +0100
+++ linux-2.4.21-pre2/drivers/video/riva/riva_hw.h	2003-01-25 00:38:49.000000000 +0100
@@ -421,6 +421,7 @@
     U032 bpp;
     U032 width;
     U032 height;
+    U032 interlace;
     U032 repaint0;
     U032 repaint1;
     U032 screen;
--- linux-2.4.21-pre2/drivers/video/riva/fbdev.c.orig	2003-01-25 23:41:18.000000000 +0100
+++ linux-2.4.21-pre2/drivers/video/riva/fbdev.c	2003-01-25 23:45:07.000000000 +0100
@@ -14,6 +14,9 @@
  *
  *	Jindrich Makovicka:  Accel code help, hw cursor, mtrr
  *
+ *	Fredrik Noring <noring@nocrew.org>:  Sync polarity and
+ *	interlace code with XFree86 4.2 as reference.
+ *
  * Initial template from skeletonfb.c, created 28 Dec 1997 by Geert Uytterhoeven
  * Includes riva_hw.c from nVidia, see copyright below.
  * KGI code provided the basis for state storage, init, and mode switching.
@@ -26,6 +29,12 @@
  *	restoring text mode fails
  *	doublescan modes are broken
  *	option 'noaccel' has no effect
+ *
+ * Interlace is supported on Riva 128, TNT, TNT2 and some early
+ * GeForce cards. Many newer cards do not support interlace.
+ *
+ * Interlace and hardware accelerated video overlay are not compatible
+ * (likely a limitation in hardware).
  */
 
 #include <linux/config.h>
@@ -890,6 +899,9 @@
 
 	memcpy(&newmode, &reg_template, sizeof(struct riva_regs));
 
+	if((video_mode->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) 
+		vTotal |= 1;
+
 	newmode.crtc[0x0] = Set8Bits (hTotal - 4);
 	newmode.crtc[0x1] = Set8Bits (hDisplay);
 	newmode.crtc[0x2] = Set8Bits (hDisplay);
@@ -929,6 +941,15 @@
 	else
 		newmode.misc_output |= 0x80;
 	
+	if((video_mode->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+	{
+	        int tmp = (hTotal >> 1) & ~1;
+		newmode.ext.interlace = Set8Bits(tmp);
+		newmode.ext.horiz |= SetBitField(tmp, 8:8,4:4);
+	} else {
+		newmode.ext.interlace = 0xff;  /* interlace off */
+	}
+
 	rinfo->riva.CalcStateExt(&rinfo->riva, &newmode.ext, bpp, width,
 				  hDisplaySize, hDisplay, hStart, hEnd,
 				  hTotal, height, vDisplay, vStart, vEnd,



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
