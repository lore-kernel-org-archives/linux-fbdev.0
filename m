From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: PPC64 prom logo
Date: Sun, 23 Mar 2003 11:43:55 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303231141590.9116-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18x2yC-0008Rt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Mar 2003 02:44:52 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC64 Development <linuxppc64-dev@lists.linuxppc.org>


Sorry, it seems I missed a RELOC in the PPC64 prom logo code. Is this (patch
against current BK) OK?

--- linux-2.5.x/arch/ppc64/kernel/prom.c.orig	Sun Mar 23 11:37:52 2003
+++ linux-2.5.x/arch/ppc64/kernel/prom.c	Sun Mar 23 11:39:35 2003
@@ -1271,7 +1271,8 @@
 
 #ifdef CONFIG_FB_LOGO_LINUX_CLUT224
 		clut = RELOC(RELOC(&logo_linux_clut224)->clut);
-		for (i = 0; i < logo_linux_clut224.clutsize; i++, clut += 3)
+		for (i = 0; i < RELOC(&logo_linux_clut224)->clutsize;
+		     i++, clut += 3)
 			if (prom_set_color(ih, i + 32, clut[0], clut[1],
 					   clut[2]) != 0)
 				break;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
