From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 23 Nov 2012 07:54:07 +0000
Subject: Re: [PATCHv13 5/7] fbmon: add of_videomode helpers
Message-Id: <20121123075407.GA20282@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353600015-6974-1-git-send-email-s.trumtrar@pengutronix.de>
 <1353600015-6974-6-git-send-email-s.trumtrar@pengutronix.de>
 <2117247.Eyo66IqYf0@avalon>
In-Reply-To: <2117247.Eyo66IqYf0@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@avionic-design.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Airlie <airlied@linux.ie>

Hi Laurent,

On Thu, Nov 22, 2012 at 06:58:09PM +0100, Laurent Pinchart wrote:
> Hi Steffen,
> 
> On Thursday 22 November 2012 17:00:13 Steffen Trumtrar wrote:
> > Add helper to get fb_videomode from devicetree.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> This patch results in the following build warning:
> 
> drivers/video/fbmon.c: In function 'of_get_fb_videomode':
> drivers/video/fbmon.c:1445: warning: passing argument 1 of 'of_get_videomode' 
> discards qualifiers from pointer target type
> include/linux/of_videomode.h:15: note: expected 'struct device_node *' but 
> argument is of type 'const struct device_node *'
> 

This I don't get. Well, looking at the code, the warning is correct. I fixed
that now. But, I do not get the warning. Just tried it again before fixing:
cleaned, cleaned and touching file, just "make drivers/video/fbmon.o". Nothing.
Weird.

So, thanks for reporting it.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
