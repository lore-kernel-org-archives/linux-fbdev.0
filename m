From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Wed, 8 Jan 2003 11:47:12 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301081142190.21171-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301072147070.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WDpK-0004Tt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 02:52:50 -0800
In-Reply-To: <Pine.LNX.4.44.0301072147070.17129-100000@phoenix.infradead.org>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>

On Tue, 7 Jan 2003, James Simmons wrote:
> > Why? (a) only those which will use putcs, and (b) I see no 512 chars limit
> > anywhere in new code. And in old code it is there only because of passed
> > data are only 16bit, not 32bit wide... With simple search&replace you can
> > extend it to any size you want, as long as you'll not use sparse font
> > bitmap.
> 
> The current "core" console code screen_buf layout is designed after VGA 
> text mode. 16 bits which only 8 bits are used to represent a character, 9 
> if you have high_fonts flag set. The other 8,7 bits are for attributes. 
> This is very limiting and it does effect fbcon.c :-( I like to the console
> system remove these awful limitation in the future. This why I like to see 
> fbdev drivers avoid touching strings from the console layer.

Please note that Tony's new accel_putcs() code uses __u32 to pass the character
indices.  So it's not limited to 256/512 characters per font. Fonts can be as
large as you want. Sparse fonts can be handled as well, if accel_putcs() takes
care of the conversion from sparse character indices to dense character
indices.

His code can be viewed as a way to do multiple monochrome to color expansions
with one single call, using a predefined table of patterns. Quite generic,
unless you want to have multi-color fonts later :-)

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
