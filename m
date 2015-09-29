From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 29 Sep 2015 08:23:23 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <1443515003.21557.12.camel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
 <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
 <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
 <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
 <CANq1E4TN4_NNs32LBcNWeDC2jUtT2TCYHfYeummEC5-TQn7BpA@mail.gmail.com>
 <1443425953.19666.6.camel@redhat.com>
 <20150928123627.GD3383@phenom.ffwll.local>
In-Reply-To: <20150928123627.GD3383@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Mo, 2015-09-28 at 14:36 +0200, Daniel Vetter wrote:
> On Mon, Sep 28, 2015 at 09:39:13AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > As Daniel mentioned, the connector+encoder+crtc combination is one of
> > > those simplifications that would make sense if more such drivers are
> > > added.
> > 
> > Another one is memory management.  It's pretty complex because it can
> > handle _way_ more than what simple drivers need, and the result is
> > _alot_ of ttm boilerplate in the drivers.
> 
> ttm is pretty impressive overkill for most simplistic drm drivers. If you
> just need contiguous framebuffers for display then the cma helpers should
> take care of pretty much all the boilerplate for you. They have ready-made
> simple gem and dumb framebuffer mmap support, which is all a basic kms
> driver needs.

Does that work on !arm meanwhile?  Last time I checked (when writing
bochsdrm, around v3.14) the cma helpers didn't even build on x86 ...

cheers,
  Gerd


