From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fb_cmap and transparency
Date: Fri, 29 Aug 2003 16:49:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200308291449.h7TEnjX7005827@callisto.of.borg>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19skaq-0005J9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Aug 2003 07:51:16 -0700
Received: from amsfep15-int.chello.nl ([213.46.243.28])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19skap-0000Xt-73
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Aug 2003 07:51:15 -0700
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
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

If a colormap contains no transparency information, fb_set_cmap() calls
fb_setcolreg() with trans = 0. This causes all CLUT entries to be fully
transparent on hardware that does have transparency information in the CLUT
registers.

The following patch solves this problem by changing the default transparency
from 0 (full transparent) to 0xffff (full opaque).

--- linux-2.4.23-pre1/drivers/video/fbcmap.c.orig	Mon Mar  5 09:29:30 2001
+++ linux-2.4.23-pre1/drivers/video/fbcmap.c	Mon Mar 17 17:39:59 2003
@@ -271,7 +271,7 @@
 	    hred = *red;
 	    hgreen = *green;
 	    hblue = *blue;
-	    htransp = transp ? *transp : 0;
+	    htransp = transp ? *transp : 0xffff;
 	} else {
 	    get_user(hred, red);
 	    get_user(hgreen, green);
@@ -279,7 +279,7 @@
 	    if (transp)
 		get_user(htransp, transp);
 	    else
-		htransp = 0;
+		htransp = 0xffff;
 	}
 	red++;
 	green++;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
