From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari Atyfb fixes
Date: Sun, 13 Apr 2003 15:06:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200304131306.h3DD6V13001313@callisto.of.borg>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amsfep12-int.chello.nl ([213.46.243.18])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 194hEa-00076Y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Apr 2003 06:09:24 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

Atyfb fixes for Atari:
  - Add missing allocation of default_par
  - Kill warnings in assignments

--- linux-2.5.x/drivers/video/aty/atyfb_base.c	Mon Feb 10 21:59:19 2003
+++ linux-m68k-2.5.x/drivers/video/aty/atyfb_base.c	Tue Feb 25 18:31:27 2003
@@ -2319,15 +2319,25 @@
 			return -ENOMEM;
 		}
 		memset(info, 0, sizeof(struct fb_info));
-		info->fix = atyfb_fix;		
+
+		default_par = kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
+		if (!default_par) {
+			printk
+			    ("atyfb_init: can't alloc atyfb_par\n");
+			kfree(info);
+			return -ENXIO;
+		}
+		memset(default_par, 0, sizeof(struct atyfb_par));
+
+		info->fix = atyfb_fix;
 
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
 		 *  kernel address space.
 		 */
-		info->screen_base = (unsigned long)ioremap(phys_vmembase[m64_num],
+		info->screen_base = ioremap(phys_vmembase[m64_num],
 					 		   phys_size[m64_num]);	
-		info->fix.smem_start = info->screen_base;	/* Fake! */
+		info->fix.smem_start = (unsigned long)info->screen_base;	/* Fake! */
 		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
 							  0x10000) + 0xFC00ul;
 		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
