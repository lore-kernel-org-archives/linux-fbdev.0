From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 07 Mar 2014 14:17:39 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <1394201859.16309.14.camel@paszta.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<5310B567.7040605@ti.com>
	<20140228162327.GT21483@n2100.arm.linux.org.uk>	<5316E31F.9050308@ti.com>
	<CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>
	<53183730.5060205@ti.com>
In-Reply-To: <53183730.5060205@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, DRI Development <dri-devel@lists.freedesktop.org>, Andrzej Hajda <a.hajda@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi,

Am Donnerstag, den 06.03.2014, 10:52 +0200 schrieb Tomi Valkeinen:
> On 06/03/14 10:39, Geert Uytterhoeven wrote:
> > On Wed, Mar 5, 2014 at 9:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> On 28/02/14 18:23, Russell King - ARM Linux wrote:
> >>
> >>> That's rather a lot of compatible strings.  Another possibility is:
> >>>
> >>>       compatible = "dvi-connector";
> >>>       analog;
> >>>       digital;
> >>>       single-link;
> >>>       dual-link;
> >>
> >> I made the following changes compared to the posted version. I decided
> >> to leave the "single-link" out, as it's implied if "digital" is set.
> >>
> >>  Tomi
> >>
> >> @@ -6,11 +6,16 @@ Required properties:
> >>
> >>  Optional properties:
> >>  - label: a symbolic name for the connector
> >> -- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> >> +- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> >> +- analog: the connector has DVI analog pins
> >> +- digital: the connector has DVI digital pins
> >> +- dual-link: the connector has pins for DVI dual-link
> >>
> >>  Required nodes:
> >>  - Video port for DVI input
> >>
> >> +Note: One (or both) of 'analog' or 'digital' must be set.
> > 
> > So dual-link needs both "digital" and "dual-link"?
> 
> Yes. It is extra, but it felt clearer to me to have 'digital' as a
> matching property for 'analog'.
> 
> Alternatively we could have three options:
> 
> analog;
> digital-single-link;
> digital-dual-link;
> 
> My reasoning to the format I chose was basically that when a connector
> supports 'digital', it contains TMDS clock and TMDS data for link 1.
> Adding dual link to that adds only TMDS data for link 2, so the second
> data link is kind of an additional feature, marked with a flag.
> 
> Not a very big argument, and I'm fine with other format suggestions.

I'd prefer the analog / digital / dual-link variant for aesthetic
reasons. But looking at other connector types, I wonder if this should
be generalized even more:

For HDMI/DVI (digital) single-link means one clock pair and 3 TMDS data
pairs, dual-link means one clock pair and 6 data pairs.

On LVDS connectors, there usually are one clock pair and three (18-bit)
or four (24-bit) LVDS data pairs, in dual channel configuration two
clock pairs and 6 or 8 data pairs are used.

For DisplayPort there is no separate clock pair, but 1 to 4 data pairs,
and MIPI DSI again has one clock pair and a one or more data pairs.

There are already optional endpoint configuration properties
'data-lanes' and 'clock-lanes' for MIPI CSI-2 defined in
Documentation/devicetree/bindings/media/video-interfaces.txt.
Could/should this be aligned with the same?

regards
Philipp

