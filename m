From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Fbdev magics
Date: Thu, 6 May 2004 11:17:50 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405061112110.12096@waterleaf.sonytel.be>
References: <200405050027.58630.lucasvr@terra.com.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLf0v-0003Ey-E1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 02:17:57 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLf0u-0003N4-Rs
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 02:17:57 -0700
In-Reply-To: <200405050027.58630.lucasvr@terra.com.br>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lucas Correia Villa Real <lucasvr@terra.com.br>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 5 May 2004, Lucas Correia Villa Real wrote:
> I'm starting to write a device driver for a display managed by a controller.
> It's an LCD with 65x132 pixels produced by Sitronix (ST7565), and is being
> used on an ARM-based embedded through an SPI interface (that is, I cannot
> directly memory-map it's address, since the communication will be done by
> this serial interface).

So you cannot access the frame buffer memory from the CPU, except through
sending commands to the LCD controller, right?

> I've read some device drivers code for other LCD devices, and I could have a
> good idea of how things work. By the way, a few questions couldn't be
> answered just by looking into their sources:
>
> - how is the "refresh" done by fbdev? I don't want to keep sending the same
> data to the display if there isn't any update to be done.

If the frame buffer memory is accessible directly by the CPU, it will be
updated automatically. If not, things get more difficult:
  - For text console output, 2.4.x will do direct accesses to the frame buffer,
    which won't work.
    In 2.6.x, fbcon will call the fb_{fillrect,copyarea,imageblit}() routines
    of your fbdev driver, so you can handle that easily
  - For graphics from user space, things are more complex, since the
    application cannot mmap() your frame buffer memory. Either you use a shadow
    frame buffer that updates the hardware periodically, or teach your
    application to talk to the LCD controller directly.

> - also related to this refresh: I haven't seen any interrupt being handled by
> many fbdev drivers. Is this ok? How will fbdev knows when the card is trying
> to communicate with the CPU?

Most drivers don't use interrupts yet, because until recently (speaking about
2.6), you could not use them there.

> - given that I can be told when the user is going to write some data to the
> fbdev (should I implement my own fb_read and fb_write operations?), is there
> an automatic way to get only the pixels that he's modifying? This would save
> a lot of unnecessary transfers to the display as well.

You should implement your own fb_{read,write}() if the CPU cannot access the
frame buffer memory directly.

> Just forgot to tell that I'm running Linux 2.4.20 for ARM.

2.6 would make life simpler for you :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
