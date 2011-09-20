From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Tue, 20 Sep 2011 21:20:05 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <CAMeQTsazfb6xoA6mm8OMVhkx_RDaxogqEa8yDstqmKUP5Ub+yg@mail.gmail.com>
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
In-Reply-To: <yunpqivfbtf.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Packard <keithp@keithp.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org, "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

On Tue, Sep 20, 2011 at 5:55 PM, Keith Packard wrote:
> I'm not sure we need a new abstraction that subsumes both DSI and SDVO,

Ok. SDVO fits within the current abstraction, but I guess what I'm fishing
for is more code sharing of encoders. For instance, the SDVO code in GMA500
could be shared with i915. I'm currently working on copying the i915 SDVO code
over to GMA500, but sharing it would be even better.

> but we may need a DSI library that can be used by both DRM and other
> parts of the kernel.

Ok, not sure I understand the complexity of DSI. Can overlay composition
occur after/at the DSI stage (through MCS perhaps)? Or is it a matter of
panels requiring special scanout buffer formats that for instance V4L needs
to know about in order to overlay stuff properly? Or am I getting it all wrong?

Thanks
-Patrik
