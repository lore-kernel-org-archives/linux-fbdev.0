From: Juergen Beisert <jbe@pengutronix.de>
Date: Thu, 10 Feb 2011 09:46:33 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <201102101046.33994.jbe@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Li Frank-B20596 wrote:
> > +
> > +	/* if it was disabled, re-enable the mode again */
> > +	reg = readl(host->base + CTRL);
> > +	reg |= CTRL_DOTCLK_MODE;
> > +	writel(reg, host->base + CTRL);
>
> writel(CTRL_DOTCLK_MODE, host->base + CTRL_SET)
> CTRL_SET is CTRL+0x4
> SET and CLR register is easier than Read and write back.

But you must always check, if the register really has such a SET and CLEAR 
feature. Not all registers have this feature...

But in this case you are right.

But I would prefer:
#define SET 4
#define CLEAR 8
[...]
writel(CTRL_DOTCLK_MODE, host->base + CTRL + SET)
:-)

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
