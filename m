From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
Date: Mon, 23 Dec 2002 10:18:05 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212231014460.12134-100000@vervain.sonytel.be>
References: <20021220213056.A25155@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021220213056.A25155@flint.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 20 Dec 2002, Russell King wrote:
> On Fri, Dec 20, 2002 at 06:10:17PM +0000, James Simmons wrote:
> > > I'll get back to bashing the sa1100fb driver to work out why fbcon is
> > > producing a _completely_ blank display, despite characters being written
> > > to it.
> > 
> > Did you figure out what was wrong?
> 
> Firstly, setting fix.line_length to zero (which the old API didn't care
> about) caused one set of problems.

That's because originally there was no fix.line_length field, and the line
length was derived from var.xres_virtual and var.bits_per_pixel.

With some hardware, the line length must be a multiple of 32 or 64 bits, and we
needed a way to specify that, so fix.line_length was introduced. If it was
zero, user code should fallback to the old behavior.

Anyway, I think it's good to make fix.line_length mandatory with the new fbdev
API.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
