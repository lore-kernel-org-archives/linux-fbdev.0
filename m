From: James Simmons <jsimmons@infradead.org>
Date: Thu, 17 Feb 2011 16:14:43 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <alpine.LFD.2.00.1102171545470.21278@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
	<201102161322.08126.arnd@arndb.de>
	<AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
	<AANLkTimMBLhopNq0L-NuJLdX08SrA078VF3tWf9TcEom@mail.gmail.com>
In-Reply-To: <AANLkTimMBLhopNq0L-NuJLdX08SrA078VF3tWf9TcEom@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Clark, Rob" <rob@ti.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linaro-dev@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, DRI development list <dri-devel@lists.freedesktop.org>, Jesse Barker <jesse.barker@linaro.org>, Jakob Bornecrantz <wallbraker@gmail.com>, linux-arm-kernel@lists.infradead.org


> I'm still in the learning-as-I-go phase here, so definitely not ready
> to propose a solution, but it does seem to me like there is room for
> some sort of kms-helper library here to handle more of the boilerplate
> xf86-video-* stuff..  I guess I'll have a better picture once I have a
> chance to add support for the various multi-monitor configurations.
> But certainly would be interested if anyone already has some ideas.

I have been thinking about this as well. One of the short coming for DRM 
on embedded platforms is the lack of a small well defined library that one 
could use. Right now libkms only handles buffer allocation. The mode 
setting is currently tied to the libdrm library. It would be nice to 
seperate the two out more. Move the mode setting code to libkms and then 
have libdrm be a wrapper around this. This way libdrm can both support 
the legacy drm drivers and the new kms drivers at the same time. It also 
makes a clear seperation. Jakob if you are willing to take this work I 
will gladly seen you patches.
