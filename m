From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 02 Aug 2011 07:57:55 +0000
Subject: Re: [PATCHv2 17/28] OMAP2420: HWMOD: Add DSS opt clocks
Message-Id: <1312271875.1917.34.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-18-git-send-email-tomi.valkeinen@ti.com>
	 <alpine.DEB.2.00.1107150047160.16606@utopia.booyaka.com>
	 <alpine.DEB.2.00.1108011910410.28427@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1108011910410.28427@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

Hi,

On Mon, 2011-08-01 at 19:14 -0600, Paul Walmsley wrote:
> Hello Tomi
> 
> On Fri, 15 Jul 2011, Paul Walmsley wrote:
> 
> > On Thu, 9 Jun 2011, Tomi Valkeinen wrote:
> > 
> > > Add DSS optional clocks to HWMOD data for OMAP2420.
> 
> This patch has been combined with the 2430 patch and the OMAP2xxx portion 
> of the temporary hack in the DSS driver has been removed.  Care to review 
> the new changes before it's sent to Tony?

Same thing here, I can revert the dss hacks separately.

> 
> - Paul
> 
> 
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Mon, 1 Aug 2011 19:02:23 -0600
> Subject: [PATCH 1/2] OMAP2xxx: HWMOD: Add DSS opt clocks
> 
> Add DSS optional clocks to HWMOD data for OMAP2420 and OMAP2430.
> 
> Revert OMAP2xxx portion of commit
> 9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
> for OMAP2/3").
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> [paul@pwsan.com: merge 2420 and 2430 patches; remove temporary DSS driver hack;
>  update changelog]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   17 ++++++++---------
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   17 ++++++++---------
>  drivers/video/omap2/dss/rfbi.c             |    2 +-
>  3 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index a015c69..b075188 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -873,11 +873,6 @@ static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
>  	&omap2420_l4_core__dss,
>  };
>  
> -static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> -	{ .role = "tv_clk", .clk = "dss_54m_fck" },
> -	{ .role = "sys_clk", .clk = "dss2_fck" },
> -};

I removed the opt clocks as the TRM doesn't say that the clocks need to
be enabled when resetting the DSS, but now thinking about it, I feel
it's safer to enable the clocks like we do on OMAP3. I think it's
unlikely that the HW could finish the reset if the clocks are off.

So let's forget this removal of dss opt clocks and add them back. And
also I think HWMOD_CONTROL_OPT_CLKS_IN_RESET is needed for dss_core.

I can make a new patch for this also.

 Tomi


