From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: also frustrated with the framebuffer and your matrox-card in
 2.5.53? hack/patch available!
Date: Sat, 28 Dec 2002 00:18:26 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212280010160.17067-100000@vervain.sonytel.be>
References: <20021227225812.GC1403@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021227225812.GC1403@ppc.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Jurriaan <thunder7@xs4all.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 27 Dec 2002, Petr Vandrovec wrote:
> On Fri, Dec 27, 2002 at 12:05:38PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 27 Dec 2002, Petr Vandrovec wrote:
> > > On Thu, Dec 26, 2002 at 07:47:52PM +0000, James Simmons wrote:
> > > > Petr is expressing his political view. It has nothing to do with technical 
> > > > arguments. In fact I place a bet. I will port the matrox driver and it 
> > > > will have the same functionality as the previous driver except for text 
> > > > mode support. If I can't do it I will not only revert the changes but I 
> > > 
> > > Yes. Without text mode support. But without textmode support that driver is
> > > of no use for me because of it is not compatible with VMware then.
> > 
> > What exactly in the new fbdev API is preventing you from having text mode
> > support?
> 
> Problem is that in new framework driver does not get in touch with characters.

Oops, I forgot about that...

> It gets only prepared bitmap passed to imageblit callback (because of fbcon_putcs
> unconditionally calls accel_putcs, which does character -> bitmap conversion). Of 
> course it is possible to convert bitmap back to character number, but it is very 
> time consuming, and it looks illogical to me first convert character number to its
> graphic image, and then convert graphic image back to character number... Not even
> talking about 9x16 character cell.
> 
> Next problem is that fbdev driver is no more notified (if I understand code correctly)
> about font changes, so it even cannot upload correct font into the hardware, and
> so it must rely on accel_putcs at the time of character print.

So we need to find a way to provide putcs() and font operations by a fbdev,
without sucking in the whole fbcon layer.

Basically you need putcs(), which is really just a simple way to do multiple
image blits in one call, and set_font(), right? And if the fbdev doesn't
provide those, we must fallback to accel_putcs().

James (and Petr, of course), what do you think? And I guess this will make
Davem happy as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
