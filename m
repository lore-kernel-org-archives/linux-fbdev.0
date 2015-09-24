From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 24 Sep 2015 15:23:12 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150924152312.GV3383@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
In-Reply-To: <20150924144621.40e26f0a@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Thu, Sep 24, 2015 at 02:46:21PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:
> 
> > fbdev is (more or less) maintained, but it's a deprecated framework. All
> > new Linux display drivers should be done on DRM.
> > 
> > So let's not add any more new fbdev drivers.
> > 
> > I will continue to maintain the current fbdev drivers, and I don't mind
> > adding some new features to those current drivers, as long as the amount
> > of code required to add the features stays sensible.
> > 
> > I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
> > and the question is what to do with those.
> > 
> > xgifb was added in 2010, and is still in staging.
> > 
> > fbtft looks like maybe some kind of framework on top of fbdev, with
> > fbtft specific subdrivers... I didn't look at it in detail, but my gut
> > says "never".
> 
> fbtft mainly drives some very simple I2C-based or SPI-based displays,
> and DRM is I believe overkill for such displays. Last time I talked
> with Laurent Pinchart about such drivers, I believe he said that such
> simple drivers could probably continue to use the fbdev subsystem.
> 
> Or are there some plans to make the writing of DRM drivers for very
> simple/trivial devices a bit simpler?

Since years I'm trying to sell someone on implementing support for
drm_simple_outputs which would collapse the crtc->encoder->connector
chain into 1 entity. Would be trivial to implement and then trivial to
write simple drivers on top of that. And besides that drm already has
piles of reallly simple drivers with just one output and one framebuffer.

There's no reason not to use drm for gfx drivers at all.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
