From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fb_cmap and transparency
Date: Sun, 15 Jun 2003 21:10:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306151910.h5FJAWWG008604@callisto.of.borg>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amsfep11-int.chello.nl ([213.46.243.20])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Rcwv-00075t-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Jun 2003 12:13:57 -0700
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
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

If a colormap contains no transparency information, fb_set_cmap() calls
fb_setcolreg() with trans = 0. This causes all CLUT entries to be fully
transparent on hardware that does have transparency information in the CLUT
registers.

The following patch solves this problem by changing the default transparency
from 0 (full transparent) to 0xffff (full opaque).

--- linux-2.4.x/drivers/video/fbcmap.c.orig	Mon Mar  5 09:29:30 2001
+++ linux-2.4.x/drivers/video/fbcmap.c	Mon Mar 17 17:39:59 2003
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
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
