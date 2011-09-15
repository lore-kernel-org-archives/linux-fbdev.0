From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Sep 2011 17:05:00 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110915180500.53c70206@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com>
In-Reply-To: <yun8vpp7qk7.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Packard <keithp@keithp.com>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On Thu, 15 Sep 2011 10:50:32 -0500
Keith Packard <keithp@keithp.com> wrote:

> On Thu, 15 Sep 2011 18:29:54 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
> > 1) It's part of DRM, so it doesn't help fb or v4l2 drivers. Except if
> > the plan is to make DRM the core Linux display framework, upon which
> > everything else is built, and fb and v4l2 are changed to use DRM.
> 
> I'd like to think we could make DRM the underlying display framework;
> it already exposes an fb interface, and with overlays, a bit more of the
> v4l2 stuff is done as well. Certainly eliminating three copies of mode
> setting infrastructure would be nice...

V4L2 needs to interface with the DRM anyway. Lots of current hardware
wants things like shared 1080i/p camera buffers with video in order to do
preview on video and the like.

In my semi-perfect world vision fb would be a legacy layer on top of DRM.
DRM would get the silly recovery fail cases fixed, and a kernel console
would be attachable to a GEM object of your choice.

Alan


