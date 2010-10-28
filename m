From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Oct 2010 06:53:04 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: mach-shmobile: implement parent clock optimization for HDMI
Message-Id: <20101028065304.GB16806@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Oct 28, 2010 at 08:29:54AM +0200, Guennadi Liakhovetski wrote:
> On Thu, 28 Oct 2010, Paul Mundt wrote:
> 
> > On Wed, Oct 27, 2010 at 06:24:26PM +0200, Guennadi Liakhovetski wrote:
> > > On ap4evb PLLC2 is used as a parent clock for the HDMI clock. To configure the
> > > HDMI clock with the highest precision this patch scans all available PLLC2
> > > frequencies and picks up the best one.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > So, what exactly does ap4evb_clk_optimize() do that you can't already do
> > with either clk_rate_table_round() or clk_rate_div_range_round()?
> 
> No, it does something pretty different: it selects the best _parent_ 
> frequency to optimize that of the _child_. So, it actually tells you "to 
> configure your clock as close as possible to frequency X you have to 
> reconfigure its parent with frequency Y." Which I don't think any of the 
> aforementioned functions does.
> 
Ok, that sounds fine.

> Well, there is a reason, why this is marked an "RFC":-) I also don't like 
> very much touching clock internals in platform code, but in a way it is 
> specific for each case. This implementation only works for clocks, whose 
> divisors are integer numbers in a certain range (without holes). Ok, with 
> clk_get_parent() the other two callbacks .clk_set_rate_parent() and 
> .clk_get_rate_parent() are automatically not needed, which is good! And I 
> would be happy to try to convert the ap4evb_clk_optimize() function into a 
> generic helper too, if we reach such an agreement.
> 
I wonder if this is something you can use/adapt clk_rate_round_helper()
for? In any event, the best place for this is in drivers/sh/clk/core.c
along with the other helpers. The ranged div iterator already takes the
parent frequency in to account, so you might be able to use a similar
approach for an iterator here, too (albeit probably inverted). If you
introduce a generic clk_rate_parent_round() or whatever then that's
pretty easy to support without any of the nasty layering violations.

I don't like having this sort of knowledge in the platform code because
there is really nothing platform specific about it. If a platform happens
to be the first to exhibit a certain type of clock topology interactivity,
then that's something the clock framework needs to expand to accomodate.
Most of these things will invariably show up on other platforms in the
future, and by then the same algorithm will have been copied all over the
place, mangled, and probably broken in a dozen different hard to debug
ways. Keeping all of the rounders centrally managed will help prevent
this, regardless of what sort of obscure topology perversion the hardware
folks come up with :-)
