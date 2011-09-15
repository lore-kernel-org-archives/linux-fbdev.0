From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Sep 2011 15:29:54 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <1316100594.23214.65.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
In-Reply-To: <yunboul7sx7.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Packard <keithp@keithp.com>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On Thu, 2011-09-15 at 09:59 -0500, Keith Packard wrote:
> On Thu, 15 Sep 2011 15:07:05 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
> > This was a very rough and quite short proposal, but I'm happy to improve
> > and extend it if it's not totally shot down.
> 
> Jesse Barnes has put together a proposal much like this to work within
> the existing DRM environment. This is pretty much the last piece of
> missing mode-setting functionality that we know of, making DRM capable
> of fully supporting existing (and planned) devices.
> 
> Here's a link to some older discussion on the issue, things have changed
> a bit since then and we had a long talk about this during the X
> Developers' Conference this week in Chicago. Expect an update to his
> proposal in the coming weeks.
> 
> http://lists.freedesktop.org/archives/dri-devel/2011-April/010559.html
> 

Thanks for the link.

Right, DRM has already components I described in my proposal, and adding
overlays brings it even closer. However, I think there are two major
differences:

1) It's part of DRM, so it doesn't help fb or v4l2 drivers. Except if
the plan is to make DRM the core Linux display framework, upon which
everything else is built, and fb and v4l2 are changed to use DRM.

But even if it was done like that, I see that it's combining two
separate things: 1) the lower level HW control, and 2) the upper level
buffer management, policies and userspace interfaces.

2) It's missing the panel driver part. This is rather important on
embedded systems, as the panels often are not "dummy" panels, but they
need things like custom initialization, sending commands to adjust
backlight, etc.

 Tomi


