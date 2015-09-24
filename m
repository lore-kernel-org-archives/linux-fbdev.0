From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 24 Sep 2015 15:59:12 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150924155912.GW3383@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <560414EB.508@gmail.com>
In-Reply-To: <560414EB.508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Thu, Sep 24, 2015 at 11:21:15AM -0400, Austin S Hemmelgarn wrote:
> On 2015-09-24 08:46, Thomas Petazzoni wrote:
> >Hello,
> >
> >On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:
> >
> >>fbdev is (more or less) maintained, but it's a deprecated framework. All
> >>new Linux display drivers should be done on DRM.
> >>
> >>So let's not add any more new fbdev drivers.
> >>
> >>I will continue to maintain the current fbdev drivers, and I don't mind
> >>adding some new features to those current drivers, as long as the amount
> >>of code required to add the features stays sensible.
> >>
> >>I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
> >>and the question is what to do with those.
> >>
> >>xgifb was added in 2010, and is still in staging.
> >>
> >>fbtft looks like maybe some kind of framework on top of fbdev, with
> >>fbtft specific subdrivers... I didn't look at it in detail, but my gut
> >>says "never".
> >
> >fbtft mainly drives some very simple I2C-based or SPI-based displays,
> >and DRM is I believe overkill for such displays. Last time I talked
> >with Laurent Pinchart about such drivers, I believe he said that such
> >simple drivers could probably continue to use the fbdev subsystem.
> I have to agree, using DRM _really_ doesn't make sense for these, the
> devices in question are (AFAIK) simple I2C or SPI connected frame-buffer
> chips that are hooked up to equally simple TFT displays.  There's no 3d
> acceleration at all from what I can tell, there's _very_ limited 2d
> acceleration, and most of the stuff that the DRM framework provides
> call-backs for would have to be done on the CPU anyway.  On top of that,
> it's targeted at small embedded systems with limited memory, and the DRM
> framework is by no-means lightweight (TBH, fbdev isn't really either, but
> it's much more light weight than DRM).

See my other mail, but you can write very simple drm drivers. And if
there's really a bloat problem for small systems we can add Kconfig knobs
to throw out everything not needed for simple drivers. The only problem
really is that everyone with such simple drivers doesn't even consider drm
"because I don't have a desktop gpu" which is just silly - drm has become
rather flexible. And that's essentially why writing simple drm drivers
still has a bit too much boilerplate, since no one yet bothered to add a
bit of helper support needed.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
