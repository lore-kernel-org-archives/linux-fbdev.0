From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: UML and fbdev
Date: Wed, 13 Aug 2003 18:07:29 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0308131805050.11378-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: UML Development <user-mode-linux-devel@lists.sourceforge.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi,

Are you aware of anyone working on frame buffer devices for UML?

I was thinking about creating a frame buffer device that displays as an X
window. Making it work for user space applications can be tricky, because
writes to the frame buffer must be trapped to update the screen (or use
periodic update, or a combination). But it should work fine for text consoles
(fbcon) and virtual terminals, and for debugging multi-head support.

Gr{oetje,eeting}s,

						Geert

P.S. Please CC me, as I'm not (yet) subscribed to user-mode-linux-devel.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
