From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 08:49:13 +1100
Message-ID: <1110750553.5787.155.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050313081937cde207@mail.gmail.com>
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

On Sun, 2005-03-13 at 11:19 -0500, Jon Smirl wrote:
> On Sun, 13 Mar 2005 23:04:59 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > > AGP as it's currently used is pretty much pointless for software fallbacks
> > > since reading from AGP memory is nearly as slow as reading from video
> > > memory.
> > 
> > Hrm.. I wouldn't expect _that_ slow. It's uncacheable, right, but still
> > on a faster bus. Especially if we use it the way we do on ppc where we
> > actually map the RAM pages directly instead of having processes go
> > through the GART.
> 
> I asked at the Xdev conference if there were page table tricks that
> would work for accessing GART memory.  Everybody said no but I'm still
> wondering if there are any.
> 
> For example the ppc has an instruction for flushing specific pages
> from cache, unlike the x86 where you can only flush everything.
> 
> So on the ppc you could leave the GART memory mapped normally and
> cached. Do all of your fallback calculations, then flush the address
> range from cache. Now tell the GPU to go use it.
> 
> Can't GART memory be normally cached RAM as long as we flush the cache
> before telling the GPU to use it?

For CPU -> GPU transfers, yes, but I'm not sure it would be that
efficient to do so. We have instructions to flush a cache line. A whole
page would require a bunch of them, not sure i would be that efficient
but worth benching maybe.
> 
> If you are doing fallback calculations in a 6MB buffer that is 1,500
> pages. Accessing all of this effectively flushes the data cache. Once
> you are done with it you probably don't want those pages in the cache
> anyway.

I wouldn't count on it flushing anything

Ben.
