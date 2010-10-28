From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Oct 2010 06:29:54 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: mach-shmobile: implement parent clock
Message-Id: <Pine.LNX.4.64.1010280819210.31298@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 28 Oct 2010, Paul Mundt wrote:

> On Wed, Oct 27, 2010 at 06:24:26PM +0200, Guennadi Liakhovetski wrote:
> > On ap4evb PLLC2 is used as a parent clock for the HDMI clock. To configure the
> > HDMI clock with the highest precision this patch scans all available PLLC2
> > frequencies and picks up the best one.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> So, what exactly does ap4evb_clk_optimize() do that you can't already do
> with either clk_rate_table_round() or clk_rate_div_range_round()?

No, it does something pretty different: it selects the best _parent_ 
frequency to optimize that of the _child_. So, it actually tells you "to 
configure your clock as close as possible to frequency X you have to 
reconfigure its parent with frequency Y." Which I don't think any of the 
aforementioned functions does.

> I really don't want to see this sort of rate table access going on
> outside of the clock framework itself, so if we need to add or extend an
> existing helper for a new usecase then that is highly preferable to
> constantly reinventing things.

Well, there is a reason, why this is marked an "RFC":-) I also don't like 
very much touching clock internals in platform code, but in a way it is 
specific for each case. This implementation only works for clocks, whose 
divisors are integer numbers in a certain range (without holes). Ok, with 
clk_get_parent() the other two callbacks .clk_set_rate_parent() and 
.clk_get_rate_parent() are automatically not needed, which is good! And I 
would be happy to try to convert the ap4evb_clk_optimize() function into a 
generic helper too, if we reach such an agreement.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
