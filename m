From: Rob Clark <robdclark@gmail.com>
Date: Mon, 29 Jul 2013 14:58:26 +0000
Subject: Re: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <CAF6AEGvFPGueM_LHVij9KFzM6NJySHCzmaLstuzZkK5GwP+6gQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
 <51f29ccd.f014b40a.34cc.ffffca2aSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <51f29ccd.f014b40a.34cc.ffffca2aSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Cooksey <tom.cooksey@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Pawel Moll <Pawel.Moll@arm.com>, dri-devel@lists.freedesktop.org

On Fri, Jul 26, 2013 at 11:58 AM, Tom Cooksey <tom.cooksey@arm.com> wrote:
> Hi Rob,
>
>> >  * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
>> >    allocate buffers for the GPU. Still not sure how to resolve this
>> >    as we don't use DRM for our GPU driver.
>>
>> any thoughts/plans about a DRM GPU driver?  Ideally long term (esp.
>> once the dma-fence stuff is in place), we'd have gpu-specific drm
>> (gpu-only, no kms) driver, and SoC/display specific drm/kms driver,
>> using prime/dmabuf to share between the two.
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

You would return the name of the display driver allocating the
buffers.  On the client side you can use generic ioctls to go from
flink -> handle -> dmabuf.  So the client side would end up opening
both the display drm device and the gpu, but without needing to know
too much about the display.

(Probably in (for example) mesa there needs to be a bit of work to
handle this better, but I think that would be needed as well for
sharing between, say, nouveau and udl displaylink driver.. which is
really the same scenario.)

> So then we looked at allocating _all_ buffers with the GPU's
> DRM driver. That solves the DRI2 single-device-name and single
> name-space issue. It also means the GPU would _never_ render
> into buffers allocated through DRM_IOCTL_MODE_CREATE_DUMB.

Well, I think we can differentiate between shared buffers and internal
buffers (textures, vertex upload, etc, etc).

For example, in mesa/gallium driver there are two paths to getting a
buffer...  ->resource_create() and ->resource_from_handle(), the
latter is the path you go for dri2 buffers shared w/ x11.  The former
is buffers that are just internal to gpu (if !(bind &
PIPE_BIND_SHARED)).  I guess you must have something similar in mali
driver.

> One thing I wasn't sure about is if there was an objection
> to using PRIME to export scanout buffers allocated with
> DRM_IOCTL_MODE_CREATE_DUMB and then importing them into a GPU
> driver to be rendered into? Is that a concern?

well.. it wasn't quite the original intention of the 'dumb' ioctls.
But I guess in the end if you hand the gpu a buffer with a
layout/format that it can't grok, then gpu does a staging texture plus
copy.  If you had, for example, some setup w/ gpu that could only
render to tiled format, plus a display that could scanout that format,
then your DDX driver would need to allocate the dri2 buffers with
something other than dumb ioctl.  (But at that point, you probably
need to implement your own EXA so you could hook in your own custom
upload-to/download-from screen fxns for sw fallbacks, so you're not
talking about using generic DDX anyways.)

> Anyway, that latter case also gets quite difficult. The "GPU"
> DRM driver would need to know the constraints of the display
> controller when allocating buffers intended to be scanned out.
> For example, pl111 typically isn't behind an IOMMU and so
> requires physically contiguous memory. We'd have to teach the
> GPU's DRM driver about the constraints of the display HW. Not
> exactly a clean driver model. :-(
>
> I'm still a little stuck on how to proceed, so any ideas
> would greatly appreciated! My current train of thought is
> having a kind of SoC-specific DRM driver which allocates
> buffers for both display and GPU within a single GEM
> namespace. That SoC-specific DRM driver could then know the
> constraints of both the GPU and the display HW. We could then
> use PRIME to export buffers allocated with the SoC DRM driver
> and import them into the GPU and/or display DRM driver.

Usually if the display drm driver is allocating the buffers that might
be scanned out, it just needs to have minimal knowledge of the GPU
(pitch alignment constraints).  I don't think we need a 3rd device
just to allocate buffers.

Really I don't think the separate display drm and gpu drm device is
much different from desktop udl/displaylink case.  Or desktop
integrated-gpu + external gpu.

> Note: While it doesn't use the DRM framework, the Mali T6xx
> kernel driver has supported importing buffers through dma_buf
> for some time. I've even written an EGL extension :-):
>
> <http://www.khronos.org/registry/egl/extensions/EXT/EGL_EXT_image_dma_buf_im
> port.txt>
>
>
>> I'm not entirely sure that the directions that the current CDF
>> proposals are headed is necessarily the right way forward.  I'd prefer
>> to see small/incremental evolution of KMS (ie. add drm_bridge and
>> drm_panel, and refactor the existing encoder-slave).  Keeping it
>> inside drm means that we can evolve it more easily, and avoid layers
>> of glue code for no good reason.
>
> I think CDF could allow vendors to re-use code they've written
> for their Android driver stack in DRM drivers more easily. Though
> I guess ideally KMS would evolve to a point where it could be used
> by an Android driver stack. I.e. Support explicit fences.
>

yeah, the best would be evolving DRM/KMS to the point that it meets
android requirements.  Because I really don't think android has any
special requirements compared to, say, a wayland compositor.  (Other
than the way they do synchronization.  But that doesn't really *need*
to be different, as far as I can tell.)  It would certainly be easier
if android dev's actually participated in upstream linux graphics, and
talked about what they needed, and maybe even contributed a patch or
two.  But that is a whole different topic.

BR,
-R

>
> Cheers,
>
> Tom
>
>
>
>
>
