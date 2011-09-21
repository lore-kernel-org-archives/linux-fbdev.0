From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 21 Sep 2011 18:07:15 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <CAMeQTsbCXEb01C4X3nKdNyE5FJuQojaMKbcY1dSk5y3kKwkiXg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com>
	<1316107275.23214.99.camel@deskari>
	<yunfwjxwbjq.fsf@aiko.keithp.com>
	<20110916175326.54567b14@lxorguk.ukuu.org.uk>
	<1316414014.1978.12.camel@deskari>
	<yunfwjtauqg.fsf@aiko.keithp.com>
	<1316417361.1978.48.camel@deskari>
	<CAMeQTsbP-_ut7BA3YQ+qgtqfM1tzM4qn3jxHT8B8_0hdPbP3Jg@mail.gmail.com>
	<yunpqivfbtf.fsf@aiko.keithp.com>
	<CAMeQTsazfb6xoA6mm8OMVhkx_RDaxogqEa8yDstqmKUP5Ub+yg@mail.gmail.com>
	<1316584875.1949.4.camel@deskari>
In-Reply-To: <1316584875.1949.4.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linaro-dev@lists.linaro.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On Wed, Sep 21, 2011 at 8:01 AM, Tomi Valkeinen wrote:
> I don't know what MCS is.

MCS is manufacturer specific commands (Manufacturer Command Set).

> But DSI is just a bi-directional transfer
> protocol between the SoC and the peripheral, you can send arbitrary data
> over it.
>
> Normally the SoC composes a pixel stream using overlays and whatnot,
> which goes to the DSI hardware, which then serializes the data and sends
> it to the peripheral.
>
> But you can as well send any data, like commands, and the peripheral can
> respond with any relevant data.

Ok it makes sense now, and I see how it can get more complicated than SDVO.
A DSI lib is a good idea and interfaces for stuff like backlight and mechanisms
for queuing commands that need to go in during blanking.

Thanks for clearing it up
-Patrik
