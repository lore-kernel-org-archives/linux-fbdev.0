From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
Date: Fri, 28 Mar 2003 09:00:26 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0303280857240.7286-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 28 Mar 2003, James Simmons wrote:
> > > > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > > > 
> > > > Yes, fb_logo.depth == info->var.bits_per_pixel.
> > > 
> > > Euh, now I get confused... Do you mean
> > > `Yes, it should be replaced by info->var.bits_per_pixel' or
> > > `No, logo.depth is always equal to info->var.bits_per_pixel'?
> > 
> > :)  Sorry about that. I meant:
> > 
> > 
> > `No, fb_logo.depth is always equal to info->var.bits_per_pixel'
> 
> No this is no longer true. For example last night I displayed the 16 color 
> logo perfectly fine on a 16 bpp display!!!! The mono display still has 
> bugs tho. The new logo tries to pick the best image to display. Say for 
> example we have two video cards. One running VESA fbdev at 16 bpp and a 
> another at vga 4 planar via vga16fb. This way we can have the both the 16 
> color and 224 color logo compiled in.  The correct logo will be displayed 
> then on the correct display. Now say we only have a mono display but all 

Didn't it always work like that? You got the 16 color logo on vga16fb and the
224 color logo on displays with more than 256 colors (except for directcolor).

> the cards support 8 bpp or better. That logo still gets displayed.
                                     ^^^^
Which logo do you mean with `that'? On a monochrome display, it should be the
monochrome logo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
