From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: fb_cmap and transparency
Date: Tue, 18 Mar 2003 15:34:36 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303181529590.17808-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vIBl-0007Tl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 06:35:37 -0800
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
To: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


If a colormap contains no transparency information, fb_set_cmap() calls
fb_setcolreg() with trans = 0. This causes all CLUT entries to be fully
transparent on hardware that does have transparency information in the CLUT
registers.

The following patch solves this problem by changing the default transparency
from 0 (full transparent) to 0xffff (full opaque).

The patch applies to both 2.4.20 and 2.5.65.

--- linux/drivers/video/fbcmap.c.orig	Mon Mar  5 09:29:30 2001
+++ linux/drivers/video/fbcmap.c	Mon Mar 17 17:39:59 2003
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
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
