From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in color_imageblit
Date: Mon, 23 Dec 2002 10:07:35 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212231004040.12134-100000@vervain.sonytel.be>
References: <20021221092744.A23531@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021221092744.A23531@flint.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 21 Dec 2002, Russell King wrote:
> On Sat, Dec 21, 2002 at 11:45:44AM +0800, Antonino Daplas wrote:
> > The pseudopalette will only matter for truecolor and directcolor as the
> > rest of the visuals bypasses the pseudopalette.  Typecasting to
> > "unsigned long" rather than "u32" is also safer (even for bpp16) since
> > in 64-bit machines, the drawing functions use fb_writeq instead of
> > fb_writel.
> 
> Erm, what does the size of the drawing functions have to do with the
> size of the pseudo palette.  The pseudo palette is only there to encode
> the pixel values for the 16 console colours.

Indeed.

> This means that a 64-bit pseudo palette would only be useful if you have
> a graphics card that supports > 32bpp, otherwise a 32-bit pseudo palette
> is perfectly adequate, even if you are using fb_writeq.

Yep. Cards with bpp > 32 are rumoured to exist, but there is no fbdev support
for them right now.

> (note that fbcon doesn't support > 32bpp, so we will only ever look at
> the first 32 bits, and having it be 64-bit would just be a needless
> waste of space imho.)

And this can be fixed, once we have some fbdev driver that uses bpp > 32.

Note that the size of the entries in the pseudo palette used to depend on the
mode, i.e. u16 for bpp = 16, u32 for bpp = 24 or 32.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
