From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 09:20:01 +1100
Message-ID: <1110752401.19810.177.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031314101c89e50e@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Sun, 2005-03-13 at 17:10 -0500, Jon Smirl wrote:
> On Mon, 14 Mar 2005 08:49:13 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > > If you are doing fallback calculations in a 6MB buffer that is 1,500
> > > pages. Accessing all of this effectively flushes the data cache. Once
> > > you are done with it you probably don't want those pages in the cache
> > > anyway.
> > 
> > I wouldn't count on it flushing anything
> 
> I meant flushes out everything except the 1,500 pages you just
> accessed. Since you don't want those pages any more a total cache
> flush shouldn't make a difference, you don't want any of these pages
> in the cache anyway.

I wouldn't count on it again. Not all caches have a strict PLRU
algorithm, some caches do random replacement (or a mix of those), some
CPUs do agressive speculative loads and may bring back stuffs in the
cache just for fun, etc ....

Though the flushes may be fast if there is no actual hit in the cache, I
agree. Again, that should be benched.

In fact, i would _love_ to be able to mark AGP memory as cacheable on
ppc, even if there is no performance benefit in the end. The issue is
that currently, we end up having both a cacheable and a non-cacheable
mapping for those pages (the kernel linear mapping still maps those
pages cacheable, and it's almost impossible to get rid of that unless
you are prepared to disable the large pages mapping of kernel space or
the BATs on ppc32, which would harm kernel performances significantly).

It works, but it's illegal. That means that the CPU might well speculate
a load from one of these pages in kernel-land just because it happens to
be next to a page where you are iterating an array, and may then bring a
bit in the cache from that page.

At that point, a non-cacheable access from userland to that same line
that was brought to the cache may lead to undefined behaviour, ranging
from just works, to checkstops the CPU, with cases of writing corrupted
data, etc... depending on the CPU.

I yet have to see the problem happening in practice, but we are
definitely not on the safe side currently. I suspect ppc32 in practice
won't hit it, but ppc64 will...

Ben.
