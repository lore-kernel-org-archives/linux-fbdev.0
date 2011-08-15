From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 15 Aug 2011 15:48:54 +0000
Subject: Re: [PATCH] backlight: Fix broken regulator API usage in l4f00242t03
Message-Id: <20110815154854.GT31404@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313372500-28017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110815064242.GR31404@pengutronix.de>
	<20110815130619.GB3927@opensource.wolfsonmicro.com>
In-Reply-To: <20110815130619.GB3927@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 15, 2011 at 10:06:22PM +0900, Mark Brown wrote:
> On Mon, Aug 15, 2011 at 08:42:42AM +0200, Sascha Hauer wrote:
> 
> > Maybe you could change these pr_err to dev_err on the way. The rest of
> > the driver already uses dev_*.
> 
> Minimal diff and all that...

It just came to my mind because you touch the lines anyway, but I'm fine
with the posted version aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
