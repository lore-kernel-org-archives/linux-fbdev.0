From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 28 Feb 2014 13:47:44 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <1393595264.3802.39.camel@paszta.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<531087C0.1090501@gmail.com>
In-Reply-To: <531087C0.1090501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org

Hi,

Am Freitag, den 28.02.2014, 13:57 +0100 schrieb Sebastian Hesselbarth:
> On 02/28/14 13:20, Tomi Valkeinen wrote:
> > This series is a re-send of
> > http://article.gmane.org/gmane.linux.drivers.devicetree/61739
> >
> ...
> > Shortly about the display components in the series, in the order of probable
> > public interest:
> >
> > * Analog TV, DVI and HDMI Connectors represent a respective connector on the
> >    board. They don't do much, but they do mark the end of the video pipeline (from
> >    the board's pov), and they should also in the future offer ways to handle
> >    things like the +5V pin on DVI and HDMI connector and HPD pin.
> >
> > * MIPI DPI panel and MIPI DSI CM panels represent bindings for simple panels
> >    using the respective video bus.
> >
> > * Sony acx565akm is an SPI controlled panel using flatlink video bus.
> >
> > * TFP410 is a DPI to DVI encoder.
> >
> > * TPD12S015 is a HDMI companion chip, used on OMAP boards.
> 
> Tomi,
> 
> Out of curiosity, will there be DT nodes for pull-up resistors soon,
> too? ;)
>
> Honestly, TPD12S015 is a level shifter, there is nothing in it that
> would justify a DT node nor a driver.
> 
> Above you already note, that connector nodes should offer HPD in the
> future, but I guess the binding should represent that now already.
> I will be a DT stub anyway, the corresponding video sink driver will
> have to look it up.
> 
> Looking through the bindings for DVI and HDMI, I guess HPD gpio is
> better kept in those nodes. From the relevant (DT) properties DVI and
> HDMI connectors are in no way different.

I like the idea of adding actual connector nodes to the board device
trees. A TV encoder driver for example could this way detect from the
device tree whether it is connected to a VGA, Composite, or S-Video
connector (or maybe to both Composite and S-Video connectors at the same
time).

regards
Philipp

