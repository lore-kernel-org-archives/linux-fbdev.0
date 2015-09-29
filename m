From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 29 Sep 2015 08:33:27 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <3297297.aAyMzK5j4J@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150928123627.GD3383@phenom.ffwll.local>
 <1443515003.21557.12.camel@redhat.com>
In-Reply-To: <1443515003.21557.12.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi Gerd,

On Tuesday 29 September 2015 10:23:23 Gerd Hoffmann wrote:
> On Mo, 2015-09-28 at 14:36 +0200, Daniel Vetter wrote:
> > On Mon, Sep 28, 2015 at 09:39:13AM +0200, Gerd Hoffmann wrote:
> > >   Hi,
> > >   
> > > > As Daniel mentioned, the connector+encoder+crtc combination is one of
> > > > those simplifications that would make sense if more such drivers are
> > > > added.
> > > 
> > > Another one is memory management.  It's pretty complex because it can
> > > handle _way_ more than what simple drivers need, and the result is
> > > _alot_ of ttm boilerplate in the drivers.
> > 
> > ttm is pretty impressive overkill for most simplistic drm drivers. If you
> > just need contiguous framebuffers for display then the cma helpers should
> > take care of pretty much all the boilerplate for you. They have ready-made
> > simple gem and dumb framebuffer mmap support, which is all a basic kms
> > driver needs.
> 
> Does that work on !arm meanwhile?  Last time I checked (when writing
> bochsdrm, around v3.14) the cma helpers didn't even build on x86 ...

config DRM_GEM_CMA_HELPER
        bool
        depends on DRM && HAVE_DMA_ATTRS
        help
          Choose this if you need the GEM CMA helper functions

x86 defines HAVE_DMA_ATTRS.

-- 
Regards,

Laurent Pinchart

