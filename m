From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.5 atyfb on Sparc question
Date: Tue, 22 Oct 2002 21:05:21 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210222057050.8374-100000@vervain.sonytel.be>
References: <Pine.LNX.4.33.0210181103380.10832-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1844N6-0008Di-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Oct 2002 12:07:20 -0700
In-Reply-To: <Pine.LNX.4.33.0210181103380.10832-100000@maxwell.earthlink.net>
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
Cc: Sven LUTHER <luther@dpt-info.u-strasbg.fr>, "Holzrichter, Bruce" <bruce.holzrichter@monster.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 18 Oct 2002, James Simmons wrote:
> fb_rastering:	I don't know if we are going to keep this one?

AFAIK these are used by the SPARC people only, to switch the graphics hardware
to frame buffer mode so the logo can be drawn. All other operations are done
using the accel engine on the cards that need fb_rasterimg().

So yes, once the logo is drawn by fb_imageblit(), fb_rasterimg() can be
eliminated by moving its functionality inside the fbdev-specific
fb_imageblit().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
