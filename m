From: James Simmons <jsimmons@infradead.org>
Date: Wed, 22 Feb 2012 16:03:21 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <alpine.LFD.2.02.1202221559510.3721@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com> <1775349.d0yvHiVdjB@avalon> <20120217095554.GA5511@phenom.ffwll.local> <2168398.Pv8ir5xFGf@avalon>
In-Reply-To: <2168398.Pv8ir5xFGf@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Tomasz Stanislawski <t.stanislaws@samsung.com>, linux-fbdev@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Pawel Osciak <pawel@osciak.com>, Magnus Damm <magnus.damm@gmail.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, dri-devel@lists.freedesktop.org, Alexander Deucher <alexander.deucher@amd.com>, Rob Clark <rob@ti.com>, linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>


> > Imo we should ditch this - fb accel doesn't belong into the kernel. Even
> > on hw that still has a blitter for easy 2d accel without a complete 3d
> > state setup necessary, it's not worth it. Chris Wilson from our team once
> > played around with implementing fb accel in the kernel (i915 hw still has
> > a blitter engine in the latest generations). He quickly noticed that to
> > have decent speed, competitive with s/w rendering by the cpu he needs the
> > entire batch and buffer management stuff from userspace. And to really
> > beat the cpu, you need even more magic.
> > 
> > If you want fast 2d accel, use something like cairo.
> 
> Our conclusion on this is that we should not expose an explicit 2D 
> acceleration API at the kernel level. If really needed, hardware 2D 
> acceleration could be implemented as a DRM device to handle memory management, 
> commands ring setup, synchronization, ... but I'm not even sure if that's 
> worth it. I might not have conveyed it well in my notes.

Fbcon scrolling at be painful at HD or better modes. Fbcon needs 3 
possible accels; copyarea, imageblit, and fillrect. The first two could be 
hooked from the TTM layer. Its something I plan to experiment to see if 
its worth it.
