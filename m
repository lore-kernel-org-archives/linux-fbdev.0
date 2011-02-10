From: Li Frank-B20596 <B20596@freescale.com>
Date: Thu, 10 Feb 2011 09:23:34 +0000
Subject: RE: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> +
> +	/* if it was disabled, re-enable the mode again */
> +	reg = readl(host->base + CTRL);
> +	reg |= CTRL_DOTCLK_MODE;
> +	writel(reg, host->base + CTRL);

writel(CTRL_DOTCLK_MODE, host->base + CTRL_SET)
CTRL_SET is CTRL+0x4
SET and CLR register is easier than Read and write back.



