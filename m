From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 19:45:53 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051940450.18954-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qdvB-0002oA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 10:47:18 -0800
In-Reply-To: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org>
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
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 5 Mar 2003, James Simmons wrote:
> > 0. Update all drivers
> > 
> > Absolutely required
> 
> Its getting there. Drivers not ported are:
> 
> 68328fb.c
> S3triofb.c
> amifb.c

You can consider amifb done. I haven't sent it in yet, because I have a few
more cleanups to do.

> atafb.c

This one is tricky, since it needs new copyrect/fillrect/imageblit code for
Atari-style interleaved bitplanes. But since Atari is in a bad shape anyway
it's not that important.

> clgenfb.c
> cyber2000fb.c
> cyberfb.c
> imsttfb.c    <- I have a nearly done driver. The old driver doesn't work 
> 		on ix86. I tried it. Oh wells.
> leofb.c

Davem will probably take care of leofb.

> pm2fb.c
> pm3fb.c
> pvr2fb.c
> retz3fb.c
> sun3fb.c

Sun3fb will probably be replaced with the sbuslib stuff Davem wrote for SPARC.

> valkyriefb.c
> virgefb.c

The others cannot be that difficult to port. Most of them are unaccelerated
cfb-style cards.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
