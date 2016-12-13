From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2016 15:17:40 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <36161238.SskTX730U1@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
In-Reply-To: <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

Hi Daniel,

On Thursday 08 Dec 2016 11:10:05 Daniel Vetter wrote:
> On Thu, Dec 08, 2016 at 12:01:19PM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2016-11-23 at 10:03 +0200, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > Since the fbdev framework is in maintenance mode and all new display
> > > drivers should be made with the DRM framework, remove the fbdev drivers
> > > from staging.
> > > 
> > > Note: the patches are created with git format-patch -D, so they can't be
> > > applied. Only for review.
> > 
> > I missed the discussion where this decision was made, I admit I am
> > unimpressed by it.
> > 
> > DRM drivers don't strike me as suitable for small/slow cores with dumb
> > framebuffers or simple 2D only accel, such as the one found in the ASpeed
> > BMCs.
> 
> We have a helper for simple drivers now, if you take into account the
> massive helper libraries for everything that comes along with drm I expect
> if even dumb panels behind slow spi buses drm is now the more suitable
> subsytem.
> 
> > With drmfb you basically have to shadow everything into memory & copy
> > over everything, and locks you out of simple 2D accel. For a simple text
> > console the result is orders of magnitude slower and memory hungry than
> > a simple fbdev.
> 
> Not true, we have full fbdev emulation, and drivers can implement the 2d
> accel in there. And a bunch of them do. It's just that most teams decided
> that this is pointless waste of their time.j

And I'd argue that a better use of time would be to implement an accelerated 
console that does not use fbdev at all.

> > At least that was the case last I looked at the DRM stuff with Dave,
> > maybe things have changed...
> > 
> > Not everything has a powerful 3D GPU.
> 
> That's correct, and drm can cope. And compared to fbdev there's a very
> active community who improves&refactors it every kernel release to make it
> even better. Since about 2 years (when atomic landed) we merge new drivers
> at a rate of 2-3 per kernel release, and those new drivers get ever simpler
> and smaller thanks to all this work.

-- 
Regards,

Laurent Pinchart

