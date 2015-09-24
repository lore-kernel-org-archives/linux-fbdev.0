From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 24 Sep 2015 18:05:04 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150924180504.GX3383@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com> <560414EB.508@gmail.com>
 <20150924155912.GW3383@phenom.ffwll.local>
 <201509241912.28739.linux@rainbow-software.org>
In-Reply-To: <201509241912.28739.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Austin S Hemmelgarn <ahferroin7@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Thu, Sep 24, 2015 at 07:12:27PM +0200, Ondrej Zary wrote:
> On Thursday 24 September 2015 17:59:12 Daniel Vetter wrote:
> > On Thu, Sep 24, 2015 at 11:21:15AM -0400, Austin S Hemmelgarn wrote:
> > > On 2015-09-24 08:46, Thomas Petazzoni wrote:
> > > >Hello,
> > > >
> > > >On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:
> > > >>fbdev is (more or less) maintained, but it's a deprecated framework.
> > > >> All new Linux display drivers should be done on DRM.
> > > >>
> > > >>So let's not add any more new fbdev drivers.
> > > >>
> > > >>I will continue to maintain the current fbdev drivers, and I don't mind
> > > >>adding some new features to those current drivers, as long as the
> > > >> amount of code required to add the features stays sensible.
> > > >>
> > > >>I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
> > > >>and the question is what to do with those.
> > > >>
> > > >>xgifb was added in 2010, and is still in staging.
> > > >>
> > > >>fbtft looks like maybe some kind of framework on top of fbdev, with
> > > >>fbtft specific subdrivers... I didn't look at it in detail, but my gut
> > > >>says "never".
> > > >
> > > >fbtft mainly drives some very simple I2C-based or SPI-based displays,
> > > >and DRM is I believe overkill for such displays. Last time I talked
> > > >with Laurent Pinchart about such drivers, I believe he said that such
> > > >simple drivers could probably continue to use the fbdev subsystem.
> > >
> > > I have to agree, using DRM _really_ doesn't make sense for these, the
> > > devices in question are (AFAIK) simple I2C or SPI connected frame-buffer
> > > chips that are hooked up to equally simple TFT displays.  There's no 3d
> > > acceleration at all from what I can tell, there's _very_ limited 2d
> > > acceleration, and most of the stuff that the DRM framework provides
> > > call-backs for would have to be done on the CPU anyway.  On top of that,
> > > it's targeted at small embedded systems with limited memory, and the DRM
> > > framework is by no-means lightweight (TBH, fbdev isn't really either, but
> > > it's much more light weight than DRM).
> >
> > See my other mail, but you can write very simple drm drivers. And if
> > there's really a bloat problem for small systems we can add Kconfig knobs
> > to throw out everything not needed for simple drivers. The only problem
> > really is that everyone with such simple drivers doesn't even consider drm
> > "because I don't have a desktop gpu" which is just silly - drm has become
> > rather flexible. And that's essentially why writing simple drm drivers
> > still has a bit too much boilerplate, since no one yet bothered to add a
> > bit of helper support needed.
> 
> Is there a simple way to convert existing fbdev drivers to DRM? Let's say I 
> want to convert tridentfb to DRM, keeping the 2D acceleration (pan, fillrect, 
> copyarea, imageblit) to be usable by the console (and maybe extend it to X11 
> using some generic 2D driver?)

DRM doesn't do generic 2d accel, it's all driver specific. And consensus
for 2d accel (at least in X) is pretty much that if you have a 3d gpu use
glamour. If you don't have that then use the cpu. There's a hint for drm
userspace whether to use shadowfb for cpu rendering or not.

What you can do though if you want is keep your accel code for the fbdev
emulation on top of the drm modesetting driver, there's a few oddball
drivers who do that. And panning is of course already supported by the
modeset api.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
