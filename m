From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: status
Date: Sun, 8 Dec 2002 12:47:28 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212081239530.7956-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0211272357060.5044-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18KzvR-00008V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 08 Dec 2002 03:48:46 -0800
In-Reply-To: <Pine.GSO.4.21.0211272357060.5044-100000@vervain.sonytel.be>
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
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 28 Nov 2002, Geert Uytterhoeven wrote:
> On 25 Nov 2002, Johan Bolmsjo wrote:
> > For what it's worth, the interleaved modes on atari works like this:
> > 
> > The bitplanes are interleaved on 16 bit big-endian word basis so if you
> > have two bitplanes, bit 0 of the first 16 pixels would be in the first
> > 16 bit word in the display memory, bit 1 of the first 16 pixels would be
> > in the second word. With bit 0 I mean as masked out by & 0x0001 in C,
> > and bit 1 as masked out by 0x0002.
> 
> Thanks! This is exactly the kind of information I needed!
> 
> I added simple unoptimized support for Atari interleaved bitplanes to fbtest.
> When I know I got the basics right, I can start writing optimized drawing
> routines.
> 
> Anyone who cares to give it a try? Just check out CVS module `fbtest' from
> http://sourceforge.net/cvs/?group_id=908, type `make' and run `fbtest' for all
> available color depths (use fbset first), and tell me whether it works.
> 
> If no one is left with an Atari with Linux/m68k installed, I can create a
> ramdisk containing fbset and fbtest, so you just need ataboot and a kernel to
> test it.

I put the ramdisk at

    http://home.tvd.be/cr26864/Linux/m68k/ramdisk-fbtest-m68k.gz

Just boot it with whatever kernel (incl. atafb, of course) you have, and run
`fbtest' for all available color depths. You can change the color depth with
`fbset -depth <depth>'. Note that it will be slow, since so far I implemented
single pixel drawing only.

Thanks for testing!

Gr{oetje,eeting}s,

						Geert

P.S. Sorry that it took that long, but my Amiga 4000 needed urgent surgery due
     to a leaking NiCd battery that started to corrode the mainboard.
     Fortunately I managed to replace it in time by a new NiMH part.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
