From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 30 Nov 2015 21:09:09 +0000
Subject: Re: [RFC PATCH 1/2] drm: add support for for clk and de polarity
Message-Id: <1448917749.3890.42.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <55A67FDB.8010602@gmx.at> <55A6813A.8090706@gmx.at>
 <1448472141.3390.17.camel@pengutronix.de> <56571543.20701@gmx.at>
 <5658084E.7040007@ti.com>
In-Reply-To: <5658084E.7040007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Steve Longerbeam <slongerbeam@gmail.com>, Deepak Das <deepak_das@mentor.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Am Freitag, den 27.11.2015, 09:37 +0200 schrieb Tomi Valkeinen:
> On 26/11/15 16:20, Manfred Schlaegl wrote:
> > Good to see that this discussion is triggered.
> 
> I seem to have missed this one. This is important for omapdrm also.
> We've had similar patch in TI's linux for a while, but I have never had
> time to start upstreaming it.
> 
> Two comments:
> 
> The "pixclock polarity" could be explained a bit, as it's not really
> about polarity. This was discussed when the display-timings stuff was
> worked on, and display-timings.txt explains what the "pixelclk-active"
> property means.

Yes, the relevant part of this setting is whether the panel will sample
the data bus on the falling or rising edge of the pixel clock signal.
The display interface has guarantee that the data bus is stable around
that time.

> So here I think you could maybe have a comment pointing to
> display-timings.txt, or perhaps a short comment about what the flag is.
> Or if you come up with a great name for the define, that's good too =).

We have the choice of describing the flag from point of view of the
display controller (as the DISPLAY_FLAGS do), from point of view of the
panel, or using a somewhat neutral description like in the device tree.
Which choice I'd prefer depends on whether the flags go into
drm_display_mode / drm_mode_modeinfo or in drm_display_info.

In any case, I think that it'd be better to talk about driving or
sampling data on rising or falling edges instead of clock polarity.

> The other comment is not about this patch as such, but similar flags
> that OMAP has, and possibly some other platforms too:
> 
> 1) sync signals driven on rising or falling edge of pixel clock
> 2) hsync and vsync happen at the same time or hsync happens first,
> followed by vsync
> 
> Any other platforms have similar features?

The i.MX6 display interface consists of a number of rather freely
configurable signal generators, so all of this should be possible to do.

regards
Philipp

