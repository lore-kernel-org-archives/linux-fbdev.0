From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: new fbdev
Date: Sun, 22 Dec 2002 09:47:09 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212220944490.11631-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Q1mQ-00017t-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 22 Dec 2002 00:48:14 -0800
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


Just returned from a long trip, I'm trying to get m68k to work with >
2.5.50 again.

Issues/questions:
  o drivers/video/console/font.h is needed by arch/m68k/kernel/m68k_defs.c
    (for struct font_desc)
  o What is (or will be) CONFIG_PCI_CONSOLE used for?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
