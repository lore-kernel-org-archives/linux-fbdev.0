From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Date: Fri, 21 Feb 2003 12:02:38 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0302211159000.9232-100000@vervain.sonytel.be>
References: <1045824362.1202.4.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1045824362.1202.4.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@codemonkey.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 21 Feb 2003, Antonino Daplas wrote:
> On Fri, 2003-02-21 at 17:09, Geert Uytterhoeven wrote:
> > On 21 Feb 2003, Antonino Daplas wrote:
> > > Note: I cannot test with 12x22 fonts in 2.4 because some/most drivers do
> > > not support it.
> > 
> > Which specific drivers are you talking about? All drivers for popular cards
> > support fontwidth 12 (Matrox, ATI, nVidia, 3Dfx, Permedia, VESA, ...).
> >
> You're absolutely correct, I'm wondering why I thought that :-)  Here's
> a benchmark for 12x22, and it's 2x slower than 8x16, 2.4.x or 2.5.x. 
> Still, the 2.5.x version is slower than 2.4.x.

Because accel_putcs() falls back to individual character drawing if the
fontwidth is not a multiple of 8. Using one fb_imageblit() for other fontwidths
too would speed this up a lot (but needs some additional coding first).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
