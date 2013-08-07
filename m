From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 07 Aug 2013 16:46:51 +0000
Subject: Re: [RFC 1/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <20130807164651.GY22035@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
	<1374772648-19151-2-git-send-email-tom.cooksey@arm.com>
	<CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>
In-Reply-To: <CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, pawel.moll@arm.com, linux-arm-kernel@lists.infradead.org

Just comment a bit on Rob's review with my own opinion.

On Wed, Aug 07, 2013 at 12:17:21PM -0400, Rob Clark wrote:
> On Thu, Jul 25, 2013 at 1:17 PM,  <tom.cooksey@arm.com> wrote:
> > From: Tom Cooksey <tom.cooksey@arm.com>
> >
> > This is a mode-setting driver for the pl111 CLCD display controller
> > found on various ARM reference platforms such as the Versatile
> > Express. The driver supports setting of a single mode (640x480) and
> > has only been tested on Versatile Express with a Cortex-A9 core tile.
> >
> > Known issues:
> >  * It still includes code to use KDS, which is not going upstream.
> 
> review's on http://lists.freedesktop.org/archives/dri-devel/2013-July/042462.html
> can't hurt
> 
> although you might consider submitting a reduced functionality driver
> w/ KDS bits removed in the mean time.. then when the fence stuff is
> merged it is just an incremental patch rather than a whole driver ;-)

Yeah, I think the KDS bits and comments need to go first before merginge.


> > +/*
> > + * Number of flips allowed in flight at any one time. Any more flips requested
> > + * beyond this value will cause the caller to block until earlier flips have
> > + * completed.
> > + *
> > + * For performance reasons, this must be greater than the number of buffers
> > + * used in the rendering pipeline. Note that the rendering pipeline can contain
> > + * different types of buffer, e.g.:
> > + * - 2 final framebuffers
> > + * - >2 geometry buffers for GPU use-cases
> > + * - >2 vertex buffers for GPU use-cases
> > + *
> > + * For example, a system using 5 geometry buffers could have 5 flips in flight,
> > + * and so NR_FLIPS_IN_FLIGHT_THRESHOLD must be 5 or greater.
> > + *
> > + * Whilst there may be more intermediate buffers (such as vertex/geometry) than
> > + * final framebuffers, KDS is used to ensure that GPU rendering waits for the
> > + * next off-screen buffer, so it doesn't overwrite an on-screen buffer and
> > + * produce tearing.
> > + */
> > +
> 
> fwiw, this is at least different from how other drivers do triple (or
> > double) buffering.  In other drivers (intel, omap, and
> msm/freedreno, that I know of, maybe others too) the xorg driver dri2
> bits implement the double buffering (ie. send flip event back to
> client immediately and queue up the flip and call page-flip after the
> pageflip event back from kernel.
> 
> I'm not saying not to do it this way, I guess I'd like to hear what
> other folks think.  I kinda prefer doing this in userspace as it keeps
> the kernel bits simpler (plus it would then work properly on exynosdrm
> or other kms drivers).

Yeah, if this is just a sw queue then I don't think it makes sense to have
it in the kernel. Afaik the current pageflip interface drm exposes allows
one oustanding flip only, and you _must_ wait for the flip complete event
before you can submit the second one.

Ofc if your hardware as a hw-based flip queue (maybe even with frame
targets) that's a different matter, but currently we don't have a drm
interface to expose this. I'd say for merging the basic driver first we
should go with the existing simple pageflip semantics.

And tbh I don't understand why the amount of buffers you keep in the
render pipeline side of things matters here at all. But I also haven't
read the details of your driver code.

> 
> > +/*
> > + * Here, we choose a conservative value. A lower value is most likely
> > + * suitable for GPU use-cases.
> > + */
> > +#define NR_FLIPS_IN_FLIGHT_THRESHOLD 16
> > +
> > +#define CLCD_IRQ_NEXTBASE_UPDATE (1u<<2)
> > +
> > +struct pl111_drm_flip_resource;
> > +struct pl111_drm_cursor_plane;
> > +
> > +enum pl111_bo_type {
> > +       PL111_BOT_DMA,
> > +       PL111_BOT_SHM
> > +};
> > +
> > +struct pl111_gem_bo_dma {
> > +       dma_addr_t fb_dev_addr;
> > +       void *fb_cpu_addr;
> > +};
> > +
> > +struct pl111_gem_bo_shm {
> > +       struct page **pages;
> > +       dma_addr_t *dma_addrs;
> > +};
> > +
> > +struct pl111_gem_bo {
> > +       struct drm_gem_object gem_object;
> > +       enum pl111_bo_type type;
> > +       union {
> > +               struct pl111_gem_bo_dma dma;
> > +               struct pl111_gem_bo_shm shm;
> > +       } backing_data;
> > +       struct drm_framebuffer *fb;
> 
> this is at least a bit odd.. normally the fb has ref to the bo(s) and
> not the other way around.  And the same bo could be referenced by
> multiple fb's which would kinda fall down with this approach.

I'd say that's just backwards, framebuffers are created from backing
storage objects (which for a gem based driver is a gem object), not the
other way round. What's this exactly used for?

[snip]

> > +
> > +       /*
> > +        * Used to prevent race between pl111_dma_buf_release and
> > +        * drm_gem_prime_handle_to_fd
> > +        */
> > +       struct mutex export_dma_buf_lock;
> 
> hmm, seems a bit suspicious.. the handle reference should keep the
> object live.  Ie. either drm_gem_object_lookup() will fail because the
> object is gone (userspace has closed it's handle ref and
> dmabuf->release() already dropped it's ref) or it will succeed and
> you'll have a reference to the bo keeping it from going away if the
> release() comes after.

The race is real, I have an evil testcase here which Oopses my kernel. I'm
working on a fix (v1 of my patches is submitted a few weeks back, awaiting
review), but I need to rework a few things since now I've also spotted a
leak or two ;-)

[snip]

> > +static void vsync_worker(struct work_struct *work)
> > +{
> > +       struct pl111_drm_flip_resource *flip_res;
> > +       struct pl111_gem_bo *bo;
> > +       struct pl111_drm_crtc *pl111_crtc;
> > +       struct drm_device *dev;
> > +       int flips_in_flight;
> > +       flip_res > > +               container_of(work, struct pl111_drm_flip_resource, vsync_work);
> > +
> > +       pl111_crtc = to_pl111_crtc(flip_res->crtc);
> > +       dev = pl111_crtc->crtc.dev;
> > +
> > +       DRM_DEBUG_KMS("DRM Finalizing flip_res=%p\n", flip_res);
> > +
> > +       bo = PL111_BO_FROM_FRAMEBUFFER(flip_res->fb);
> > +#ifdef CONFIG_DMA_SHARED_BUFFER_USES_KDS
> > +       if (flip_res->worker_release_kds = true) {
> > +               spin_lock(&pl111_crtc->current_displaying_lock);
> > +               release_kds_resource_and_display(flip_res);
> > +               spin_unlock(&pl111_crtc->current_displaying_lock);
> > +       }
> > +#endif
> > +       /* Release DMA buffer on this flip */
> > +       if (bo->gem_object.export_dma_buf != NULL)
> > +               dma_buf_put(bo->gem_object.export_dma_buf);
> 
> I think you just want to unref the outgoing bo, and let it drop the
> dmabuf ref when the file ref of the imported bo goes.  Or actually, it
> would be better to hold/drop ref's to the fb, rather than the bo.  At
> least this will make things simpler if you ever have multi-planar
> support.

Drivers have no business frobbing around the dma-buf refcount of imported
objects imo, at least if they use all the standard drm prime
infrastructure. And if they're bugs they need to be fixed there, not in
drivers.

[snip]

> > +struct drm_framebuffer *pl111_fb_create(struct drm_device *dev,
> > +                                       struct drm_file *file_priv,
> > +                                       struct drm_mode_fb_cmd2 *mode_cmd)
> > +{
> > +       struct pl111_drm_framebuffer *pl111_fb = NULL;
> > +       struct drm_framebuffer *fb = NULL;
> > +       struct drm_gem_object *gem_obj;
> > +       struct pl111_gem_bo *bo;
> > +
> > +       pr_info("DRM %s\n", __func__);
> > +       gem_obj = drm_gem_object_lookup(dev, file_priv, mode_cmd->handles[0]);
> > +       if (gem_obj = NULL) {
> > +               DRM_ERROR("Could not get gem obj from handle to create fb\n");
> > +               goto out;
> > +       }
> > +
> > +       bo = PL111_BO_FROM_GEM(gem_obj);
> > +       /* Don't even attempt PL111_BOT_SHM, it's not contiguous */
> > +       BUG_ON(bo->type != PL111_BOT_DMA);
> 
> umm, no BUG_ON() is not really a good way to validate userspace input..
> 
>   if (bo->type != ...)
>     return ERR_PTR(-EINVAL);

Yep.

> > +
> > +       switch ((char)(mode_cmd->pixel_format & 0xFF)) {
> > +       case 'Y':
> > +       case 'U':
> > +       case 'V':
> > +       case 'N':
> > +       case 'T':
> 
> perhaps we should instead add a drm_format_is_yuv().. or you could
> (ab)use drm_fb_get_bpp_depth()..

Yeah, I think a new drm_format_is_yuv is asked-for here. Now the bigger
question is why you need this, since the drm core should filter out
formats not in your list of supported ones. Or at least it should ...

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
