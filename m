From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Bug in fbcon.c penguin drawing
Date: Sat, 1 Jun 2002 15:31:25 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0206011529010.13188-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.sonytel.be ([193.74.243.200])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17E8yo-00084Q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 01 Jun 2002 06:31:38 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA11764
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 1 Jun 2002 15:31:24 +0200 (MET DST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


By accident I stumbled on this...
Since `src' is the penguin logo, we must not use fb_read() to access it.

--- linux-2.4.19-pre9/drivers/video/fbcon.c.orig	Fri Feb 22 16:28:32 2002
+++ linux-2.4.19-pre9/fbcon.c	Sat Jun  1 15:27:31 2002
@@ -2417,7 +2417,7 @@
 		else
 		    dst = fb + y1*line + x/8;
 		for( x1 = 0; x1 < LOGO_LINE; ++x1 )
-		    fb_writeb(fb_readb(src++) ^ inverse, dst++);
+		    fb_writeb(*src++ ^ inverse, dst++);
 	    }
 	    done = 1;
 	}
--- linux-2.5.19/drivers/video/fbcon.c.orig	Mon Apr 29 09:50:07 2002
+++ linux-2.5.19/fbcon.c	Sat Jun  1 15:27:40 2002
@@ -2401,7 +2401,7 @@
 		else
 		    dst = fb + y1*line + x/8;
 		for( x1 = 0; x1 < LOGO_LINE; ++x1 )
-		    fb_writeb(fb_readb(src++) ^ inverse, dst++);
+		    fb_writeb(*src++ ^ inverse, dst++);
 	    }
 	    done = 1;
 	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
