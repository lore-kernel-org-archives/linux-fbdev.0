From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 26 Jul 2013 18:56:05 +0000
Subject: Re: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <20130726185604.GK6084@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
 <51f29cd1.e686440a.66b2.fffff9d5SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <51f29cd1.e686440a.66b2.fffff9d5SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Cooksey <tom.cooksey@arm.com>
Cc: dri-devel@lists.freedesktop.org, 'Rob Clark' <robdclark@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 26, 2013 at 04:58:55PM +0100, Tom Cooksey wrote:
> Hi Rob,
> 
> > >  * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
> > >    allocate buffers for the GPU. Still not sure how to resolve this
> > >    as we don't use DRM for our GPU driver.
> > 
> > any thoughts/plans about a DRM GPU driver?  Ideally long term (esp.
> > once the dma-fence stuff is in place), we'd have gpu-specific drm
> > (gpu-only, no kms) driver, and SoC/display specific drm/kms driver,
> > using prime/dmabuf to share between the two.
> 
> The "extra" buffers we were allocating from armsoc DDX were really
> being allocated through DRM/GEM so we could get an flink name
> for them and pass a reference to them back to our GPU driver on
> the client side. If it weren't for our need to access those
> extra off-screen buffers with the GPU we wouldn't need to
> allocate them with DRM at all. So, given they are really "GPU"
> buffers, it does absolutely make sense to allocate them in a
> different driver to the display driver.
> 
> However, to avoid unnecessary memcpys & related cache
> maintenance ops, we'd also like the GPU to render into buffers
> which are scanned out by the display controller. So let's say
> we continue using DRM_IOCTL_MODE_CREATE_DUMB to allocate scan
> out buffers with the display's DRM driver but a custom ioctl
> on the GPU's DRM driver to allocate non scanout, off-screen
> buffers. Sounds great, but I don't think that really works
> with DRI2. If we used two drivers to allocate buffers, which
> of those drivers do we return in DRI2ConnectReply? Even if we
> solve that somehow, GEM flink names are name-spaced to a
> single device node (AFAIK). So when we do a DRI2GetBuffers,
> how does the EGL in the client know which DRM device owns GEM
> flink name "1234"? We'd need some pretty dirty hacks.

I don't know the details, but having different gem driver nodes is exactly
what prime support in X allows. The X server then passes the buffer object
between the different ddx drivers using dma-buf sharing.

So if we have two drm drivers, one a kms-only scanout driver and one a
gem-only mali driver, then the userspace gl mali driver would only ever
talk to the mali drm node. So flink for DRI2 would use that node
exclusively. The scanout drm node would then be treated like e.g. an usb
display-link device which is also display-only.

> So then we looked at allocating _all_ buffers with the GPU's
> DRM driver. That solves the DRI2 single-device-name and single
> name-space issue. It also means the GPU would _never_ render
> into buffers allocated through DRM_IOCTL_MODE_CREATE_DUMB.
> One thing I wasn't sure about is if there was an objection
> to using PRIME to export scanout buffers allocated with
> DRM_IOCTL_MODE_CREATE_DUMB and then importing them into a GPU
> driver to be rendered into? Is that a concern?

Imo sharing dumb buffers should be ok. The "dumb" concept is only really
relevant when the display and render part are integrated into one IP block
and driver.

> Anyway, that latter case also gets quite difficult. The "GPU"
> DRM driver would need to know the constraints of the display
> controller when allocating buffers intended to be scanned out.
> For example, pl111 typically isn't behind an IOMMU and so
> requires physically contiguous memory. We'd have to teach the
> GPU's DRM driver about the constraints of the display HW. Not
> exactly a clean driver model. :-(

Well the current dma-buf sharing code essentially only really works on x86
where everyone has a decent graphics tt and no cache flushing is required.

For ARM I expect that we need to have a common dma-buf backing storage
layer which walks all attached devices on the dma-buf, checks allocation
constraints and then picks a suitable pool to allocate the buffer.

Since dma-bufs should only be allocated once they're getting used (and not
when establishing the sharing) that should work out. But with the current
dma apis exposed to drivers that's not possible really. Essentially we
need ion but please not expose the heaps explicitly to userspace.  The
kernel already knows all this, so could take care of this for userspace
without breaking the current dma api abstractions we have.

Of course if you start to share buffers between different userspace drives
they need to talk to each another about what stride/pixel layout/tiling is
suitable. Since I'm a kernel guy I'll punt on this problem ;-)

> I'm still a little stuck on how to proceed, so any ideas
> would greatly appreciated! My current train of thought is
> having a kind of SoC-specific DRM driver which allocates
> buffers for both display and GPU within a single GEM
> namespace. That SoC-specific DRM driver could then know the
> constraints of both the GPU and the display HW. We could then
> use PRIME to export buffers allocated with the SoC DRM driver
> and import them into the GPU and/or display DRM driver.

That's pretty much how ION works and I'm not in favour of leaking
allocation constraints to userspace like that ...

> Note: While it doesn't use the DRM framework, the Mali T6xx
> kernel driver has supported importing buffers through dma_buf
> for some time. I've even written an EGL extension :-):
> 
> <http://www.khronos.org/registry/egl/extensions/EXT/EGL_EXT_image_dma_buf_im
> port.txt>
> 
> 
> > I'm not entirely sure that the directions that the current CDF
> > proposals are headed is necessarily the right way forward.  I'd prefer
> > to see small/incremental evolution of KMS (ie. add drm_bridge and
> > drm_panel, and refactor the existing encoder-slave).  Keeping it
> > inside drm means that we can evolve it more easily, and avoid layers
> > of glue code for no good reason.
> 
> I think CDF could allow vendors to re-use code they've written
> for their Android driver stack in DRM drivers more easily. Though
> I guess ideally KMS would evolve to a point where it could be used
> by an Android driver stack. I.e. Support explicit fences.

Just fyi with intel we have some DSI/MIPI support patches floating around.
Our plan is to just merge them and then once we have a 2nd drm driver with
DSI support grow some common infrastructure out of this.

The same approach seems to work neatly for hdmi (infoframes) and dp
(although the dp helpers can be seriously extended).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
