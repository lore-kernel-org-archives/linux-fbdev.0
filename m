From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Wed, 17 Mar 2004 12:15:37 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0403171215050.21104@waterleaf.sonytel.be>
References: <1079518182.13373.27.camel@icampbell-debian>
 <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
 <1079521633.13370.39.camel@icampbell-debian>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1079521633.13370.39.camel@icampbell-debian>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Campbell <icampbell@arcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

	Hi Ian,

On Wed, 17 Mar 2004, Ian Campbell wrote:
> > > +For example:
> > > +	modprobe pxafb options=xres:640,yres:480,bpp:8,passive
> >
> > Not much comments, except: why don't you use the standard modedb mode parameter
> > style?
>
> I was trying too (I mostly copied the i810 driver). How wrong did I get
> it? I'm willing to rework it to make it the same as the standard.

Take a look at drivers/video/modedb.c and fb_find_mode().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
