From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: clipping
Date: Fri, 10 Jan 2003 11:49:11 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301101145250.9440-100000@vervain.sonytel.be>
References: <1042172278.933.145.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Wzsb-00026e-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 06:11:25 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA26762
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 15:10:44 +0100 (MET)
In-Reply-To: <1042172278.933.145.camel@localhost.localdomain>
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.21.0301101510410.9440@vervain.sonytel.be>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On 10 Jan 2003, Antonino Daplas wrote:
> For putcs and putc, I just made it mandatory that when one character is
> to be out of bounds, it just won't get drawn.  A cleaner implementation
> is, of course, to clip the destination window + the passed bitmap.

Except for the geek value, why would it be cleaner to draw half of a character
near the border?

> Do we need to clip the fb_set_logo() too?

I don't think so. The current code already draws only the number of logos that
really fit on the screen. Unless you want to see half penguins as well :-)

> The patch may be a bit difficult to swallow because it is pretty much
> invasive and not so clean :-(, so it's okay if you don't take it.
> But it has the advantage of clipping the coordinates for hardware that 
> does not support clipping (like the i810fb).  For hardware that does 
> support clipping, or wants to implement its own clipping code, we require 
> a 'caps' (capabilities) field in fb_info or fb_fix_screeninfo.  This is 
> checked first and if set, the default clipping code is bypassed.

I prefer fb_info, since user space doesn't need to know.

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
