From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 19 Mar 2014 08:22:40 +0000
Subject: Re: [PATCHv2 4/8] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <1395217360.4300.9.camel@paszta.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
 <1395130547-18633-5-git-send-email-tomi.valkeinen@ti.com>
 <1395132234.4134.1.camel@paszta.hi.pengutronix.de>
 <1664822.t9aWz7hh4g@avalon>
 <1395216233.4300.6.camel@paszta.hi.pengutronix.de>
 <53295132.6000003@ti.com>
In-Reply-To: <53295132.6000003@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robherring2@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Am Mittwoch, den 19.03.2014, 10:11 +0200 schrieb Tomi Valkeinen:
> On 19/03/14 10:03, Philipp Zabel wrote:
> 
> >>> Geert's comment also applies to all other connector types. These can be
> >>> input connectors, too.
> >>
> >> We might not need to define all the properties required by input connectors 
> >> now, but we need to make sure that future extensions will be backward-
> >> compatible. I don't see a problem in making the connector DT bindings depend 
> >> on the direction as long as the direction is specified in the DT node, either 
> >> explicitly or implicitly.
> >>
> >> An obvious solution would be to have separate "hdmi-input-connector" and 
> >> "hdmi-output-connector" compatible strings but I don't like that, as there's 
> >> no difference in the HDMI connector itself, only in the usage.
> > 
> > I don't think this is necessary, either. I just meant the wording for
> > the video port should leave the direction unspecified. I imagine
> > somebody somewhere will connect a HDMI connector to a mux so that it can
> > be either input or output.
> 
> I don't disagree, but I think it's better to change the wording when
> someone has a working setup and can try it. These bindings have been
> designed only with video output in mind, and I'd rather have them
> constrained to that purpose for now.
> 
> One reason for keeping them output only is that when someone wants to
> use these for capture, he needs to change the binding docs, and it'll
> gather more attention than just using the bindings in a board's dts.
> 
> That said, we should take care to make the bindings so that nothing
> prevents their use for capture (which I think they allow in their
> current form).

I don't disagree, either. I have no objection against the bindings
themselves.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

