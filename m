From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Feb 2011 11:51:09 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <20110210115109.GR9041@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
	<201102101046.33994.jbe@pengutronix.de>
	<20110210104725.GC2206@pengutronix.de>
In-Reply-To: <20110210104725.GC2206@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 10, 2011 at 11:47:25AM +0100, Wolfram Sang wrote:
> > But I would prefer:
> > #define SET 4
> > #define CLEAR 8
> > [...]
> > writel(CTRL_DOTCLK_MODE, host->base + CTRL + SET)

For this we already have __mxs_setl.

> 
> NACK.
> 
> This will indeed not be caught by the compiler.
> 
> And while I like the shorter macros better as well, an MXSFB_ prefix
> should be added IMO. Macros like CTRL and TIMING are not too well
> protected.

+1 for a prefix, be it MXSFB_ or LCDIF_, will change this.

Otherwise can we please stop about arguing about register defines? It's
too much a matter of taste and there is no perfect way to solve this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
