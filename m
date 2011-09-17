From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 17 Sep 2011 20:25:29 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110917212529.6b452bf2@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
	<4E724659.5080709@gmx.de>
	<20110915195804.4e6d965b@lxorguk.ukuu.org.uk>
	<CAMP44s1ywhCV+FaudnwjwJUvj5Cf3_oz1M++kjXxRDGQpJ6-0w@mail.gmail.com>
	<CAF6AEGu2-O+2KuCrQPJ6-xejg8TCScrFVZSimgkAV_5Xs-bgkg@mail.gmail.com>
	<4E74C6C3.2000704@gmx.de>
	<CAPM=9twmPVrBPmUuEuTYHSzjDGHtfsmiVX6cozpAFYEaV-NcCg@mail.gmail.com>
	<4E74E3D6.8080401@gmx.de>
	<CAPM=9txHu7mzH8p8g=FmHsjvmAT-aMy-xEFj4odXEvnbs-bhMw@mail.gmail.com>
In-Reply-To: <CAPM=9txHu7mzH8p8g=FmHsjvmAT-aMy-xEFj4odXEvnbs-bhMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>

> Just tell the X driver to not use acceleration, and it you won't get
> any acceleration used, then you get complete stability. If a driver
> writer wants to turn off all accel in the kernel driver, it can, its

In fact one thing we actually need really is a "dumb" KMS X server to
replace the fbdev X server that unaccel stuff depends upon and which
can't do proper mode handling, multi-head or resizing as a result. A dumb
fb generic request for a back to front copy might also be useful for
shadowfb, or at least indicators so you know what the cache behaviour is
so the X server can pick the right policy.

> We've fixed this in KMS, we don't pass direct mappings to userspace
> that we can't tear down and refault. We only provide objects via
> handles. The only place its a problem is where we expose fbdev legacy
> emulation, since we have to fix the pages.

Which is doable. Horrible but doable. The usb framebuffer code has to
play games like this with the virtual framebuffer in order to track
changes by faulting.

There are still some architectural screwups however. DRM continues the
fbdev worldview that outputs, memory and accelerators are tied together
in lumps we call video cards. That isn't really true for all cases and
with capture/overlay it gets even less true.

Alan
