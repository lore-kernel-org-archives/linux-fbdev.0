From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Logo crash
Date: Sun, 5 Jan 2003 17:47:35 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0301051744260.10559-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>


The local variable palette_cmap.transp is not initialized, so it can contain
garbage, causing a crash during logo drawing.

--- linux-2.5.54/drivers/video/fbmem.c	Thu Jan  2 12:54:58 2003
+++ linux-m68k-2.5.54/drivers/video/fbmem.c	Sun Jan  5 17:22:57 2003
@@ -386,6 +386,7 @@
 	palette_cmap.red = palette_red;
 	palette_cmap.green = palette_green;
 	palette_cmap.blue = palette_blue;
+	palette_cmap.transp = 0;
 
 	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
 		n = LINUX_LOGO_COLORS - i;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
