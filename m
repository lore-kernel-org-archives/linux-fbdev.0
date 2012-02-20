From: David Airlie <airlied@redhat.com>
Date: Mon, 20 Feb 2012 16:19:09 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC	2012 - Notes
Message-Id: <23a20eb7-2ce0-447a-a991-100dfaeb8571@zmail16.collab.prod.int.phx2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1202201633100.2836@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202201633100.2836@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Tomasz Stanislawski <t.stanislaws@samsung.com>, linux-fbdev@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Pawel Osciak <pawel@osciak.com>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Alexander Deucher <alexander.deucher@amd.com>, Rob Clark <rob@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>


> 
> I'm certainly absolutely in favour of creating a common EDID parser,
> and
> the DRM/KMS implementation might indeed be the most complete /
> advanced
> one, but at least back in 2010 as I was working on the sh-mobile HDMI
> driver, some functinality was still missing there, which I had to add
> to
> fbdev independently. Unless those features have been added to DRM /
> KMS
> since then you might want to use the fbdev version. See
> 
> http://thread.gmane.org/gmane.linux.ports.arm.omap/55193/focusU337
> 
> as well as possibly some other discussions from that period
> 
> http://marc.info/?l=linux-fbdev&r=1&b 1010&w=4

One feature missing from the drm EDID parser doesn't mean the fbdev one is better in all cases.

Whoever takes over the merging process will have to check for missing bits anyways to avoid regressions.

> > 
> > I think we should include kernel cmdline video mode parsing here,
> > afaik
> > kms and fbdev are rather similar (won't work if they're too
> > different,
> > obviously).
> 
> This has been a pretty hot discussion topic wrt sh-mobile LCDC / HDMI
> too:-) The goal was to (1) take into account driver's capabilities:
> not
> all standard HDMI modes were working properly, (2) use EDID data, (3)
> give
> the user a chance to select a specific mode. Also here a generic
> solution
> would be very welcome, without breaking existing configurations, of
> course:)

The reason the drm has a more enhanced command line parser is to allow
for multiple devices otherwise it should parse mostly the same I thought
I based the drm one directly on the fbdev one + connector specifiers.

Dave.
