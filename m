From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 16 Sep 2011 16:53:26 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110916175326.54567b14@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com>
	<1316107275.23214.99.camel@deskari>
	<yunfwjxwbjq.fsf@aiko.keithp.com>
In-Reply-To: <yunfwjxwbjq.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Keith Packard <keithp@keithp.com>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

> I'm not sure a common interface to all of these different
> channels makes sense, but surely a DSI library and an aux channel
> library would fit nicely alongside the existing DDC library.

DSI and the various other MIPI bits tend to be horribly panel and device
specific. In one sense yes its a standard with standard commands,
processes, queries etc, on the other a lot of stuff is oriented around
the 'its a fixed configuration unit we don't need to have queries' view.
There also tends to be a lot of vendor magic initialisation logic both
chipset and device dependant, and often 'plumbing dependant' on SoC
systems. This is doubly ugly with the I²C abstractions for DDC because
SoC systems are not above putting the DDC on a standard I²C port being
shared with other functionality.

> Oh, I think you're also trying to get at how we expose some of these
> controls outside of the display driver -- right now, they're mostly
> exposed as properties on the output device. Things like backlight
> brightness, a million analog TV output values, dithering control and
> other more esoteric controls.

This is how the MIPI handling in the GMA500 driver works, although the
existing code needs to be taken out and shot, which should be happening
soon. There is a lot, like panel initialisation which is however not
really going to fit a properties model.

Alan
