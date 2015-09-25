From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 25 Sep 2015 18:44:07 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150925184407.GD3383@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <560524E7.4020707@gmail.com>
 <5605479A.2020903@ti.com>
In-Reply-To: <5605479A.2020903@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kamil Lulko <kamil.lulko@gmail.com>

On Fri, Sep 25, 2015 at 04:09:46PM +0300, Tomi Valkeinen wrote:
> 
> 
> On 25/09/15 13:41, Kamil Lulko wrote:
> > Hi,
> > 
> >> fbdev is (more or less) maintained, but it's a deprecated framework. All
> >> new Linux display drivers should be done on DRM.
> > 
> > What about no-mmu platforms? DRM has a big fat MMU dependency in the
> > kconfig, is there a way to write DRM driver for such devices?
> 
> I guess not.
> 
> Then again, I don't see why DRM would have a hard dependency to MMU, if
> the work is done to make DRM work optionally without MMU. How much work
> that is, I have no idea.

We have plenty drivers in drm without hw mmu, and yeah there's probably no
reason at all why the drm subsystem has a hard depency on cpu MMUs. Might
be some #ifdef fallout that needs to be done, but there shouldn't be
anything fundamental. Maybe the old dri1 days code has something, but
that's all historical cruft anyway.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
