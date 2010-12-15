From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Dec 2010 15:40:03 +0000
Subject: Re: [PATCH 1/9] ARM i.MX51: Add ipu clock support
Message-Id: <201012151640.03789.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-2-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 09 December 2010, Sascha Hauer wrote:
> +static int clk_ipu_enable(struct clk *clk)
> +{
> +       u32 reg;
> +
> +       _clk_ccgr_enable(clk);
> +
> +       /* Enable handshake with IPU when certain clock rates are changed */
> +       reg = __raw_readl(MXC_CCM_CCDR);
> +       reg &= ~MXC_CCM_CCDR_IPU_HS_MASK;
> +       __raw_writel(reg, MXC_CCM_CCDR);
> +
> +       /* Enable handshake with IPU when LPM is entered */
> +       reg = __raw_readl(MXC_CCM_CLPCR);
> +       reg &= ~MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
> +       __raw_writel(reg, MXC_CCM_CLPCR);
> +
> +       return 0;
> +}

Why __raw_readl?

The regular accessor function for I/O registers is readl, which handles
the access correctly with regard to atomicity, I/O ordering and byteorder.

	Arnd
