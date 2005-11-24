From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: Console rotation problems
Date: Thu, 24 Nov 2005 10:43:20 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0511241042360.6400@numbat.sonytel.be>
References: <1132793150.26560.357.camel@gaston>  <1132793556.26560.361.camel@gaston>
 <1132796831.26560.392.camel@gaston> <1132801542.26560.402.camel@gaston>
 <43855DBA.1050302@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751341AbVKXJnx@vger.kernel.org>
In-Reply-To: <43855DBA.1050302@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, 24 Nov 2005, Antonino A. Daplas wrote:
> Benjamin Herrenschmidt wrote:
> > Remove bogus usage of test/set_bit() from fbcon rotation code and just
> > manipulate the bits directly. This fixes an oops on powerpc among others
> > and should be faster. Seems to work fine on the G5 here.
> 
> Thanks, I reached a point when my head became muddled with bit 
> manipulations, so I used arch-specific bitops but complete forgot
> that they were atomic :-)

I haven't really looked at the rotation code, but I guess it can be optimized a
lot by using similar techniques like c2p (chunky-to-planar) conversions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
