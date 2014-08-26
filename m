From: Luc Verhaegen <libv@skynet.be>
Date: Tue, 26 Aug 2014 12:33:57 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826123357.GB22395@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com> <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com> <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com> <20140825150900.GB21020@skynet.be>
 <20140826075247.GC17263@ulmo> <20140826120258.GA22395@skynet.be>
 <20140826122112.GC641@ulmo>
In-Reply-To: <20140826122112.GC641@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 26, 2014 at 02:21:16PM +0200, Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 02:02:58PM +0200, Luc Verhaegen wrote:
> > On Tue, Aug 26, 2014 at 09:52:49AM +0200, Thierry Reding wrote:
> > > On Mon, Aug 25, 2014 at 05:09:00PM +0200, Luc Verhaegen wrote:
> > > > On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> > > > > 
> > > > > No. simplefb just wants to write to some memory that hardware has been
> > > > > set up to scan out. The platform requires that the clocks be on.
> > > > 
> > > > Simplefb also requires that the memory is there and is persistent. Fine 
> > > > for discrete graphics cards, fine for rpi where most things are hidden 
> > > > from the ARM core anyway, not so fine for anybody else.
> > > 
> > > I don't understand. This patch series isn't changing anything about the
> > > memory aspects of the driver yet it's working for you on sunxi, isn't
> > > it? So it can't be all that broken.
> > > 
> > > Thierry
> > 
> > Oh, i had to go wrestle with UBoot options and reserve 8MB off the top, 
> > which the kernel never gets told about. A nice throwback to x86 IGP 
> > bioses, a past i had thought i had left behind forgood.
> 
> Can you not use the reserved memory code (drivers/of/of_reserved_mem.c
> in the kernel)? I think that's the generally accepted way to do this
> with DT.
> 
> Thierry

It was mentioned to me, and I probably could do that, but this seemed 
even more DT wrangling from within u-boot, and it didn't seem finished 
yet. Plus, all of this already was way more wrangling than i bargained 
for, especially with the promise of "simple"-fb. Then there is the 
really awkward way in which one gets to define clocks outside of a 
dts/compiler (you've seen the code, right?), i really did not feel like 
repeating something like that.

Luc Verhaegen.
