From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: status
Date: Thu, 28 Nov 2002 13:32:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0211281330200.9187-100000@vervain.sonytel.be>
References: <20582D3416EEFC429CAAFBD42278DBC60328F4C7@eatpsv02.dmt.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18HNrf-0001RJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Nov 2002 04:33:56 -0800
In-Reply-To: <20582D3416EEFC429CAAFBD42278DBC60328F4C7@eatpsv02.dmt.de>
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
To: "Szymanski, Frank-Peter" <F.Szymanski@dmt.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@lists.linux-m68k.org>

On Thu, 28 Nov 2002, Szymanski, Frank-Peter wrote:
> >Anyone who cares to give it a try? Just check out CVS module `fbtest' from
> >http://sourceforge.net/cvs/?group_id=908, type `make' and run `fbtest' for
> all
> >available color depths (use fbset first), and tell me whether it works.
> 
> >If no one is left with an Atari with Linux/m68k installed, I can create a
> >ramdisk containing fbset and fbtest, so you just need ataboot and a kernel
> to
> >test it.
> 
> Due to the fact that since kernel 2.2.x X11 doesn't work any longer on
> ATARIs I don't have a working Linux/m68k configuration ATM but I have both a
> 2.0.3x/2.2.x kernel and ataboot to test it if you like.

You don't need X to run fbtest. Even better, do _not_ run it under X! All you
need is a kernel with atafb.

> Just tell me where I can find the above mentioned ramdisk.

It's not yet available. Don't expect it before next weekend, though.

To compile your own fbtest, all you need is a working C compiler, netpbm, and
cvs to get the sources.

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
