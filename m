From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: also frustrated with the framebuffer
 and your matrox-card in 2.5.53? hack/patch available!
Date: Fri, 27 Dec 2002 12:05:38 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212271128120.17037-100000@vervain.sonytel.be>
References: <20021227023943.GC1412@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021227023943.GC1412@ppc.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Jurriaan <thunder7@xs4all.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 27 Dec 2002, Petr Vandrovec wrote:
> On Thu, Dec 26, 2002 at 07:47:52PM +0000, James Simmons wrote:
> > Petr is expressing his political view. It has nothing to do with technical 
> > arguments. In fact I place a bet. I will port the matrox driver and it 
> > will have the same functionality as the previous driver except for text 
> > mode support. If I can't do it I will not only revert the changes but I 
> 
> Yes. Without text mode support. But without textmode support that driver is
> of no use for me because of it is not compatible with VMware then.

What exactly in the new fbdev API is preventing you from having text mode
support?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
