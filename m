From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] penguin logo code
Date: Wed, 24 Jul 2002 17:15:13 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0207241714220.5289-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17XNtV-0000eu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Jul 2002 08:17:42 -0700
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
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


### Comments for changeset
The penguin logo resides in normal RAM, not in frame buffer memory, so we must
not use fb_readb()

### Comments for drivers/video/fbcon.c
The penguin logo resides in normal RAM, not in frame buffer memory, so we must
not use fb_readb()

--- linux-2.4.19-rc3/drivers/video/fbcon.c	Fri Feb 22 16:28:32 2002
+++ linux-m68k-2.4.19-rc3/drivers/video/fbcon.c	Mon Jul 22 21:45:01 2002
@@ -2417,7 +2417,7 @@
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



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
