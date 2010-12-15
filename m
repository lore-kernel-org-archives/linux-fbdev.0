From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 15 Dec 2010 16:34:45 +0000
Subject: Re: [PATCH 1/9] ARM i.MX51: Add ipu clock support
Message-Id: <20101215163445.GE9937@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-2-git-send-email-s.hauer@pengutronix.de>
	<201012151640.03789.arnd@arndb.de>
In-Reply-To: <201012151640.03789.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 15, 2010 at 04:40:03PM +0100, Arnd Bergmann wrote:
> On Thursday 09 December 2010, Sascha Hauer wrote:
> > +static int clk_ipu_enable(struct clk *clk)
> > +{
> > +       u32 reg;
> > +
> > +       _clk_ccgr_enable(clk);
> > +
> > +       /* Enable handshake with IPU when certain clock rates are changed */
> > +       reg = __raw_readl(MXC_CCM_CCDR);
> > +       reg &= ~MXC_CCM_CCDR_IPU_HS_MASK;
> > +       __raw_writel(reg, MXC_CCM_CCDR);
> > +
> > +       /* Enable handshake with IPU when LPM is entered */
> > +       reg = __raw_readl(MXC_CCM_CLPCR);
> > +       reg &= ~MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
> > +       __raw_writel(reg, MXC_CCM_CLPCR);
> > +
> > +       return 0;
> > +}
> 
> Why __raw_readl?
> 
> The regular accessor function for I/O registers is readl, which handles
> the access correctly with regard to atomicity, I/O ordering and byteorder.

There's no possibility of those two being mis-ordered - they will be in
program order whatever.

What isn't guaranteed is the ordering between I/O accesses (accesses to
device memory) and SDRAM accesses (normal memory) which can pass each other
without additional barriers.  Memory accesses can pass I/O accesses.

So, (eg), if you're writing to a register which causes the hardware to
begin reading DMA descriptors from an area allocated from dma_alloc_coherent(),
you need a barrier to ensure that writes to the dma_alloc_coherent() are
visible to the hardware before you write the enable register.

If you don't need normal vs device access ordering, using readl_relaxed()/
writel_relaxed() is preferred, and avoids the (apparantly rather high)
performance overhead of having to issue barriers all the way down to the
L2 cache.

Lastly, I don't see where atomicity comes into it - __raw_writel vs writel
have the same atomicity.  Both are single access atomic provided they're
naturally aligned.  Misaligned device accesses are not predictable.
