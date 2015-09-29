From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 29 Sep 2015 07:05:08 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <20150929070508.GZ3383@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
 <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
 <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
 <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
 <CAF1V4O_9LC9QM_AcE7gaV4hp4jcEe47nzKj=CXxvsnH_L=YRYw@mail.gmail.com>
In-Reply-To: <CAF1V4O_9LC9QM_AcE7gaV4hp4jcEe47nzKj=CXxvsnH_L=YRYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernie Thompson <bernie@plugable.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Arnaud Patard <apatard@mandriva.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Mon, Sep 28, 2015 at 01:52:31PM -0700, Bernie Thompson wrote:
> On Sat, Sep 26, 2015 at 11:01 AM, Geert Uytterhoeven <geert@linux-m68k.org>
>  wrote:
> > The smallest of these (udl) still counts in at ca. 2800 LoC,
> 
> Note udlfb.c, the original fbdev driver that I helped write and that the
> udl DRM driver was based on, is ~1800 LoC ... so we're actually talking in
> the ballpark of 2x (rather than 10x) between fbdev and DRM in this case.
> That said, the complexity difference is probably higher than the LoC
> difference. I know I personally have struggled in the shift from
> understanding fbdev to understanding DRM.

udl has a bit of room for improvement, we really should push the worker
logicy for fbdev emulation into the core drm fbdev helpers using the
->dirtyfb callback. That should rip out quite a few lines.

The other thing to consider is that drm/udl supports PRIME buffer sharing
for seamlessly extending your desktop by just plugging in an usb dongle.

> The fact that there's drivers of both types and USB hardware might make udl
> may be a good driver to use as a base for any additional simplification /
> helper work. David Airlie and David Herrmann both have this hardware. David
> Airlie did the port from fbdev to DRM, so he's made it an exemplary
> driver.  And if anyone needs any hardware which works with udlfb and udl,
> we're happy to send free hardware to any programmers who are willing to
> contribute in the form of code or testing:
> http://plugable.com/projects/plugable-open-source-hardware-samples-program

For example drivers I think it's better to look at the latest drm driver
merged - those are up-to-date wrt best practices. udl has already
accumulated a bit of cruft (e.g. still using legacy modeset helpers and
not the atomic ones).

> More simplification and documentation would be great. In particular, the
> optimization for the connector+encoder+crtc combination others have
> mentioned seems like it would be worthwhile.

Atomic helpers already make almost everything optional except for the
crtc-level enable/disable callbacks and the per-plane atomic_plane_update
(for buffer flips/panning/rotation/...). So a comibined helper would be
mostly for cutting down the structure setup/teardown boilerplate. So
should be fairly easy to implement even for drm beginners (when using one
of the latest drivers as a template for what needs to be done).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
