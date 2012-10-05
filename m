From: Robert Schwebel <r.schwebel@pengutronix.de>
Date: Fri, 05 Oct 2012 07:17:40 +0000
Subject: Re: [PATCH 1/2 v6] of: add helper to parse display timings
Message-Id: <20121005071740.GI23204@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
 <1349373560-11128-2-git-send-email-s.trumtrar@pengutronix.de>
 <Pine.LNX.4.64.1210042307300.3744@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210042307300.3744@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Philipp Zabel <pza@pengutronix.de>

On Thu, Oct 04, 2012 at 11:35:35PM +0200, Guennadi Liakhovetski wrote:
> > +optional properties:
> > + - hsync-active-high (bool): Hsync pulse is active high
> > + - vsync-active-high (bool): Vsync pulse is active high
>
> For the above two we also considered using bool properties but eventually
> settled down with integer ones:
>
> - hsync-active = <1>
>
> for active-high and 0 for active low. This has the added advantage of
> being able to omit this property in the .dts, which then doesn't mean,
> that the polarity is active low, but rather, that the hsync line is not
> used on this hardware. So, maybe it would be good to use the same binding
> here too?

Philipp, this is the same argumentation as we discussed yesterday for
the dual-link LVDS option, so that one could be modelled in a similar
way.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
