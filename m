From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Date: Mon, 3 Mar 2003 22:25:32 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0303032222550.12650-100000@vervain.sonytel.be>
References: <20030303203500.GA2916@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 3 Mar 2003, Petr Vandrovec wrote:
>   My main concern now is 12x22 font... Accelerator setup
> is so costly for each separate painted character that for 8bpp 
> accelerated version is even slower than unaccelerated one :-(
> (and almost twice as slow when compared with 2.4.x).

Have you already tried Antonino's patches to use one imageblit for multiple
characters with (fontwidth % 8) != 0? It should help.

BTW, I still have to try it with amifb.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
