From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 25 Jun 2012 11:22:03 +0000
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Message-Id: <20120625112203.GF19226@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti>
In-Reply-To: <1340604478.12683.25.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 25, 2012 at 09:07:58AM +0300, Tomi Valkeinen wrote:
> On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> > In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> > and clk_unprepare() for the omapdss clocks.
> 
> You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
> clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
> is that the clocks are normally not enabled/disabled from atomic
> context.
> 
> What does the prepare/unprepare actually do? Is there any benefit in
> delaying preparing, i.e. is there a difference between prepare right
> after clk_get, or prepare right before clk_enable? (And similarly for
> unprepare)

I think you're looking at this the wrong way.

Think of clk_prepare() as the _sleepable_ part of clk_enable().  So, think
of clk_prepare() as ideally being placed just before clk_enable() with the
exception that if that's not possible (because you're in a non-atomic
context) it should be placed in a position as close to clk_enable() as
possible which is atomic.

Don't think of it as an extra step to be done after clk_get() but as an
extra step needing to be done before clk_enable().
