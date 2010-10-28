From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Oct 2010 00:28:03 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: mach-shmobile: implement parent clock optimization for HDMI
Message-Id: <20101028002802.GA10365@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Oct 27, 2010 at 06:24:26PM +0200, Guennadi Liakhovetski wrote:
> On ap4evb PLLC2 is used as a parent clock for the HDMI clock. To configure the
> HDMI clock with the highest precision this patch scans all available PLLC2
> frequencies and picks up the best one.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

So, what exactly does ap4evb_clk_optimize() do that you can't already do
with either clk_rate_table_round() or clk_rate_div_range_round()?

I really don't want to see this sort of rate table access going on
outside of the clock framework itself, so if we need to add or extend an
existing helper for a new usecase then that is highly preferable to
constantly reinventing things.
