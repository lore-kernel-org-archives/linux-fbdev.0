From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Feb 2011 12:22:07 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <201102161322.08126.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
In-Reply-To: <AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 15 February 2011, Clark, Rob wrote:
> I'd been experimenting a bit on the side w/ the DRM driver framework (
> http://gitorious.com/~robclark/pandaboard/robclarks-kernel-omap4/commits/omap_gpu
> ), but had to add a good chunk of mostly boilerplate code to our xorg
> driver in order just to test it.  Maybe some generic support for KMS
> in xf86-video-fbdev would have made this easier to develop the kernel
> part without in parallel having to implement the userspace part.  I'm
> not sure if this is the sort of thing the linaro-wg has in mind?

I'm not sure what the the linaro multimedia wg thinks of this, but the
kernel code you linked looks like it's doing exactly the right thing.

	Arnd
