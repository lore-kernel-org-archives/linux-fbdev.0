From: Dave Airlie <airlied@gmail.com>
Date: Mon, 21 Feb 2011 03:12:32 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <AANLkTi=c4PFE76QfJUF-2J4DzsxubekKi0uCOSh49bgY@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
	<201102161322.08126.arnd@arndb.de>
	<AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
	<AANLkTimMBLhopNq0L-NuJLdX08SrA078VF3tWf9TcEom@mail.gmail.com>
	<alpine.LFD.2.00.1102171545470.21278@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1102171545470.21278@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linaro-dev@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, DRI development list <dri-devel@lists.freedesktop.org>, Jesse Barker <jesse.barker@linaro.org>, "Clark,
	Rob" <rob@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, Feb 18, 2011 at 2:14 AM, James Simmons <jsimmons@infradead.org> wro=
te:
>
>> I'm still in the learning-as-I-go phase here, so definitely not ready
>> to propose a solution, but it does seem to me like there is room for
>> some sort of kms-helper library here to handle more of the boilerplate
>> xf86-video-* stuff.. =A0I guess I'll have a better picture once I have a
>> chance to add support for the various multi-monitor configurations.
>> But certainly would be interested if anyone already has some ideas.
>
> I have been thinking about this as well. One of the short coming for DRM
> on embedded platforms is the lack of a small well defined library that one
> could use. Right now libkms only handles buffer allocation. The mode
> setting is currently tied to the libdrm library. It would be nice to
> seperate the two out more. Move the mode setting code to libkms and then
> have libdrm be a wrapper around this. This way libdrm can both support
> the legacy drm drivers and the new kms drivers at the same time. It also
> makes a clear seperation. Jakob if you are willing to take this work I
> will gladly seen you patches.

the problem with that is libkms relies on libdrm, so you'd have a
circular dependency.

With the addition of the dumb ioctl to the kernel we can certainly
avoid some of that dependency,
but you guys are missing one important point about libkms, its meant
to be a fallback.

Why?

well because most GPUs in reality have non-generic memory layouts,
they prefer having tiled buffers for different things and different
types of tiling. There is simply no nice way to abstract that out,
since it depends on the userspace libraries that use this. Starting
off with an untiled allocation for the frontbuffer can pretty much
leave you messed up when you plug anything like acceleration in
afterwards.

I have been looking at this from the USB driver pov as well, and we
can probably resurrect the old xf86-video-modesetting driver along
with some code in the X server maybe, mesa also has a libkms fallback
X driver that works quite well if just a bit messy to build (since its
in mesa).

Dave.
