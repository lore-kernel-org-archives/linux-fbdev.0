From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: fonts
Date: Sat, 11 Jan 2003 20:15:26 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301112010020.18673-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XR6z-0006hQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 11:16:05 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id UAA09322
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 20:15:26 +0100 (MET)
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


I'm trying out different fonts with amifb (based on 2.5.56 from Linus).
  - PEARL8x8: OK
  - SUN12x22: garbage (random characters)
  - ProFont6x11: garbage (each different line is filled with a different
    character)
  - MINI4x6: garbage (each different line is filled with a different
    character)

At first I thought it may be caused by xres and yres not divisible by the
fontsize, so I tried a 800x600 mode with MINI4x6. But the problem stayed the
same, except that only a 640x600 window in the right part of the screen was
used.

Is my planar code in amifb to blane, or have other people seen the same?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
