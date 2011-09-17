From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 17 Sep 2011 21:36:07 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <201109172336.08624.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti> <yun8vpp7qk7.fsf@aiko.keithp.com> <20110915180500.53c70206@lxorguk.ukuu.org.uk>
In-Reply-To: <20110915180500.53c70206@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Packard <keithp@keithp.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org, "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

On Thursday 15 September 2011 19:05:00 Alan Cox wrote:
> On Thu, 15 Sep 2011 10:50:32 -0500
> Keith Packard wrote:
> > On Thu, 15 Sep 2011 18:29:54 +0300, Tomi Valkeinen wrote:
> > > 1) It's part of DRM, so it doesn't help fb or v4l2 drivers. Except if
> > > the plan is to make DRM the core Linux display framework, upon which
> > > everything else is built, and fb and v4l2 are changed to use DRM.
> > 
> > I'd like to think we could make DRM the underlying display framework;
> > it already exposes an fb interface, and with overlays, a bit more of the
> > v4l2 stuff is done as well. Certainly eliminating three copies of mode
> > setting infrastructure would be nice...
> 
> V4L2 needs to interface with the DRM anyway. Lots of current hardware
> wants things like shared 1080i/p camera buffers with video in order to do
> preview on video and the like.

Buffers sharing is a hot topic that has been discussed during Linaro Connect 
in August 2011. Even though the discussions were aimed at solving ARM-related 
embedded issues, the solution we're working on is not limited to the ARM 
platform and will allow applications to pass buffers around between device 
drivers from different subsystems.

> In my semi-perfect world vision fb would be a legacy layer on top of DRM.
> DRM would get the silly recovery fail cases fixed, and a kernel console
> would be attachable to a GEM object of your choice.

-- 
Regards,

Laurent Pinchart
