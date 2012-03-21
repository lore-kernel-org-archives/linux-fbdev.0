From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Mar 2012 00:57:56 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi: add extra phyctrl for sh_mipi_dsi_info
Message-Id: <87r4wmwz1q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87y5rdnmmu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5rdnmmu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Florian

Thank you for checking patch

> > sh_mipi uses some clocks, but the method of setup depends on CPU.
> > 
> > Current SuperH (like sh73a0) can control all of these clocks
> > by CPG (Clock Pulse Generator).
> > It means we can control it by clock framework only.
> > But on sh7372, it needs CPG settings AND sh_mipi PHYCTRL::PLLDS,
> > and only sh7372 has PHYCTRL::PLLDS.
> > 
> > But on current sh_mipi driver, PHYCTRL::PLLDS of sh7372 was
> > overwrote since the callback timing of clock setting was changed
> > by c2658b70f06108361aa5024798f9c1bf47c73374
> > (fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()).
> > 
> > The difference of PHYCTRL between current SuperH (=sh73a0) and
> > old SuperH (=sh7372) is not only PLLDS.
> > So this patch adds extra .phyctrl.
> > 
> > It also adds detail explanation for unclear mipi settings for ap4evb.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
(snip)
> >  	if (enable) {
> > +		/*
> > +		 * DSIPCLK	= 24MHz
> > +		 * D-PHY	= DSIPCLK * ((0x6*2)+1) = 321MHz (see .phyctrl)
> 
> Shouldn't this be 312?

Oops, indeed.
I fix it.

> > +		 * HsByteCLK	= D-PHY/8 = 39MHz
> > +		 *
> > +		 *  X * Y * FPS > > +		 * (544+72+600+16) * (961+8+8+2) * 30 = 36.1MHz
> > +		 */
> >  		clk_set_rate(pck, clk_round_rate(pck, 24000000));
> > -		iowrite32(ioread32(phy) | (0xb << 8), phy);
> 
> Here you remove writing a 0xb<<8 (0xb = 11 = 8+2+1)...
> 
> >  		clk_enable(pck);
> >  	} else {
> >  		clk_disable(pck);
> > @@ -598,6 +603,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
> >  	.lcd_chan	= &lcdc_info.ch[0],
> >  	.lane		= 2,
> >  	.vsynw_offset	= 17,
> > +	.phyctrl	= 0x6 << 8,
> 
> ...and here you set a 0x6<<8 (0x6 = 6 = 4+2). Looks suspicious, was this
> change intended?

Sorry. the git log didn't explain that this patch fixup it.
0x6 is correct here. This used for D-PHY.

 D-PHY	= DSIPCLK * ((0x6*2)+1) = 321MHz (see .phyctrl)
                      ~~~

I add it on v2 patch.

Best regards
---
Kuninori Morimoto
