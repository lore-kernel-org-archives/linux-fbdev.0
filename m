From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 09 Jan 2013 20:42:47 +0000
Subject: Re: [PATCHv16 0/7] of: add display helper
Message-Id: <4468930.nIKSs7INEb@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355850256-16135-1-git-send-email-s.trumtrar@pengutronix.de>
	<20130109201541.GB4780@pengutronix.de>
In-Reply-To: <20130109201541.GB4780@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robherring2@gmail.com>, kernel@pengutronix.de, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org

On Wednesday 09 January 2013 21:15:41 Steffen Trumtrar wrote:
> On Tue, Dec 18, 2012 at 06:04:09PM +0100, Steffen Trumtrar wrote:
> > Hi!
> > 
> > Finally, right in time before the end of the world on friday, v16 of the
> > display helpers.
> 
> So, any more criticism on the series? Any takers for the series as is?
> I guess it could be merged via the fbdev-tree if David Airlie can agree
> to the DRM patches ?! Does that sound about right?
> 
> I think the series was tested at least with
> 	- imx6q: sabrelite, sabresd
> 	- imx53: tqma53/mba53
> 	- omap: DA850 EVM, AM335x EVM, EVM-SK
> 
> I don't know what Laurent Pinchart, Marek Vasut and Leela Krishna Amudala
> are using.

I've used the sh-mobile-lcdcfb driver.

> Those are the people I know from the top of my head, that use or at least
> did use the patches in one of its iterations. If I forgot anyone, please
> speak up and possibly add your new HW to the list of tested devices.

-- 
Regards,

Laurent Pinchart

