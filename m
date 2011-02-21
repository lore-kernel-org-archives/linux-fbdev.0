From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 21 Feb 2011 14:17:31 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <20110221141730.GO24426@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297850199-1688-1-git-send-email-s.hauer@pengutronix.de>
	<1297850199-1688-2-git-send-email-s.hauer@pengutronix.de>
	<20110218122946.GF18085@S2100-06.ap.freescale.net>
In-Reply-To: <20110218122946.GF18085@S2100-06.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 18, 2011 at 08:29:47PM +0800, Shawn Guo wrote:
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/io.h>
> > +#include <mach/fb.h>
> > +#include <mach/hardware.h>
> > +#include <mach/mxs.h>
> > +
> > +#define REG_SET	4
> > +#define REG_CLR	8
> > +
> We already have these defined in mxs.h

I know, but as Wolfram realized this makes the driver architecture
specific. So I decided to duplicate this here and to remove
mach/hardware.h and mach/mxs.h (obviously still present in the last
posted version)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
