From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Wed, 17 Mar 2004 11:39:00 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
References: <1079518182.13373.27.camel@icampbell-debian>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1079518182.13373.27.camel@icampbell-debian>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Campbell <icampbell@arcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Wed, 17 Mar 2004, Ian Campbell wrote:
> Attached is a patch against the most recent BK tree which implements a
> driver for the on-chip LCD controller of the Xscale PXA255 processor. It
> is based on the SA1100 FB driver and has been hacked on by various
> people on the ARM mailing list.
>
> I would appreciate a review of the code, any comments etc, with the aim
> of getting the driver into good shape to be merged.

> +For example:
> +	modprobe pxafb options=xres:640,yres:480,bpp:8,passive

Not much comments, except: why don't you use the standard modedb mode parameter
style?

> I posted it to the fbdev list @ sf.net (from MAINTAINERS) but that list
> seems to be pretty quiet and www.linux-fbdev.org (also from MAINTAINERS)

It's not quiet, though.

> seems to be down -- is there a more appropriate place these days for
> framebuffer stuff?

linux-fbdev-devel was correct.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
