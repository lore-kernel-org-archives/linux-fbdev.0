From: David Eger <eger@havoc.gtf.org>
Subject: Re: radeon_pm.c locking problem
Date: Mon, 5 Jul 2004 17:24:37 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040705212436.GA25860@havoc.gtf.org>
References: <40E59B82.7000807@undead.cc> <20040702185241.GA25832@dreamland.darkstar.lan> <1089035092.3014.7.camel@gaston> <20040705164104.GA14968@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhaxD-0000ID-9k
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 14:24:47 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BhaxC-0002lK-Ua
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 14:24:47 -0700
Content-Disposition: inline
In-Reply-To: <20040705164104.GA14968@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@people.it>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Jul 05, 2004 at 06:41:04PM +0200, Kronos wrote:
> Il Mon, Jul 05, 2004 at 08:44:53AM -0500, Benjamin Herrenschmidt ha scritto: 
> > > is expanded in:
> > > 
> > > do {
> > >         unsigned long flags;
> > >         spin_lock_irqsave(&rinfo->reg_lock, flags);
> > >         __OUTPLL(pllPIXCLKS_CNTL, INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
> > >         spin_unlock_irqrestore(&rinfo->reg_lock, flags);
> > > } while(0)
> > > 
> > > and INPLL will try to reacquire the lock ->reg_lock. We could either use
> > > __INPLL (which does not take the lock) or make OUTPLL an inline function
> > > (in this way INPLL is called before entering the function).
> > 
> > Make it an inline function...
> 
> Here it is:

Your patch is much, much prettier than mine (which is in mainline),
and Linus is hoping for such a prettier solution.

On the other hand, is there any reason we're taking this
rinfo->reg_lock?   Would it be possible for the fb driver to be called
in two separate contexts at the same time?

Also, having this macro be pretty sort of obsccures the fact that, 
the way the code is now, we're doing

	OUTPLL(foo0, bar0);
	OUTPLL(foo1, bar1);
	OUTPLL(foo2, bar2);

which translates to taking this lock three times in quick succession.
Bleah.

I had half a mind to put a radeon_fifo_wait() call in the
OUTREG() macro (because there needs to be a 1-1 correspondence 
between empty fifo slots and OUTREG calls, but then you add a
chunk of a loop, udelay, and printk to every register write...
again lots of overhead for a simple register write.... 
better to sprinkle the code with the write counts and hope they stay
in line?  Maybe.  That's the route I took, anyways.

-dte


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
