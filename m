From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: status
Date: Thu, 28 Nov 2002 00:02:56 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0211272357060.5044-100000@vervain.sonytel.be>
References: <1038260153.1027.26.camel@skalman>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18HBE7-0004Tc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Nov 2002 15:04:16 -0800
In-Reply-To: <1038260153.1027.26.camel@skalman>
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
To: Johan Bolmsjo <johan@nocrew.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@lists.linux-m68k.org>

On 25 Nov 2002, Johan Bolmsjo wrote:
> For what it's worth, the interleaved modes on atari works like this:
> 
> The bitplanes are interleaved on 16 bit big-endian word basis so if you
> have two bitplanes, bit 0 of the first 16 pixels would be in the first
> 16 bit word in the display memory, bit 1 of the first 16 pixels would be
> in the second word. With bit 0 I mean as masked out by & 0x0001 in C,
> and bit 1 as masked out by 0x0002.

Thanks! This is exactly the kind of information I needed!

I added simple unoptimized support for Atari interleaved bitplanes to fbtest.
When I know I got the basics right, I can start writing optimized drawing
routines.

Anyone who cares to give it a try? Just check out CVS module `fbtest' from
http://sourceforge.net/cvs/?group_id=908, type `make' and run `fbtest' for all
available color depths (use fbset first), and tell me whether it works.

If no one is left with an Atari with Linux/m68k installed, I can create a
ramdisk containing fbset and fbtest, so you just need ataboot and a kernel to
test it.

Thanks!

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
