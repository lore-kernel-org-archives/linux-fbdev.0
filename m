From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 162] fbdev monochrome lines
Date: Sat, 2 Oct 2004 19:05:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410021705.i92H5Ova021802@anakin.of.borg>
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267409AbUJBRME@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

Fbdev: Clear the underline attribute when erasing the logo space on monochrome
screens. This removes the bogus horizontal lines next to the logo.
(from Petr Stehlik and Antonino A. Daplas)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.28-pre3/drivers/video/fbcon.c	26 Aug 2003 03:13:09 -0000	1.1.1.2.2.6
+++ linux-m68k-2.4.28-pre3/drivers/video/fbcon.c	12 Aug 2004 11:59:22 -0000
@@ -660,9 +660,8 @@
     
     if (logo) {
     	/* Need to make room for the logo */
-	int cnt;
-	int step;
-    
+	int cnt, step, erase_char;
+
     	logo_lines = (LOGO_H + fontheight(p) - 1) / fontheight(p);
     	q = (unsigned short *)(conp->vc_origin + conp->vc_size_row * old_rows);
     	step = logo_lines * old_cols;
@@ -692,8 +691,10 @@
     		conp->vc_pos += logo_lines * conp->vc_size_row;
     	    }
     	}
-    	scr_memsetw((unsigned short *)conp->vc_origin,
-		    conp->vc_video_erase_char, 
+	erase_char = conp->vc_video_erase_char;
+	if (! conp->vc_can_do_color)
+	    erase_char &= ~0x400; /* disable underline */
+	scr_memsetw((unsigned short *)conp->vc_origin, erase_char,
 		    conp->vc_size_row * logo_lines);
     }
     

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
