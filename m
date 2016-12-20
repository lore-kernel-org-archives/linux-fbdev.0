From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Dec 2016 01:17:36 +0000
Subject: Re: [PATCH] fbdev: remove current maintainer
Message-Id: <5102616.aqlTlCbrFA@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481186052-4987-1-git-send-email-tomi.valkeinen@ti.com>
 <20161208100447.cyidy3l2vtn6ozfs@phenom.ffwll.local>
In-Reply-To: <20161208100447.cyidy3l2vtn6ozfs@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

Hi Daniel,

On Thursday 08 Dec 2016 11:04:47 Daniel Vetter wrote:
> On Thu, Dec 08, 2016 at 10:34:12AM +0200, Tomi Valkeinen wrote:
> > Remove Tomi Valkeinen from fbdev maintainer and mark fbdev as orphan.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> > 
> > I just don't have time to even pretend I maintain fbdev, so mark it as
> > Orphan.
> > 
> > Anyone want to pick fbdev maintainership?
> 
> I think for fbdev stuff that we need for the fbdev emulation in drm we
> could merge it through drm-misc.

Or we could instead invest time on getting rid of that last dependency on 
fbdev ? :-)

> And I'd very much welcome if you can
> still review those patches (e.g. the nommu enabling that's floating right
> now). If you want can also give you commit rights to drm-misc for that
> area. Or drm-misc maintainers can apply those patches.
> 
> Anything else would be still out of scope ofc.
> 
> What we might want to do is add dri-devel to the mailing lists, to make
> sure patch submissions get redicted to the right subsystem. Mail volume
> seems pretty low compared to dri-devel, I think we can absorb that.
> -Daniel
> 
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 851b89b9edcb..fc2790eb4e84 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4968,10 +4968,9 @@ F:	drivers/net/wan/dlci.c
> > 
> >  F:	drivers/net/wan/sdla.c
> >  
> >  FRAMEBUFFER LAYER
> > 
> > -M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> >  L:	linux-fbdev@vger.kernel.org
> >  Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
> > 
> > -S:	Maintained
> > +S:	Orphan
> > 
> >  F:	Documentation/fb/
> >  F:	drivers/video/
> >  F:	include/video/

-- 
Regards,

Laurent Pinchart

