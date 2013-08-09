From: Rob Clark <robdclark@gmail.com>
Date: Fri, 09 Aug 2013 16:34:55 +0000
Subject: Re: [RFC 1/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <CAF6AEGu68ntQDSueQJmAM1KSsSA86j98GDEf8wOPbZKjECw99Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <1374772648-19151-2-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>
 <20130807164651.GY22035@phenom.ffwll.local>
 <520515b0.88b70e0a.3ecd.1004SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <520515b0.88b70e0a.3ecd.1004SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Cooksey <tom.cooksey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Pawel Moll <Pawel.Moll@arm.com>, linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>

On Fri, Aug 9, 2013 at 12:15 PM, Tom Cooksey <tom.cooksey@arm.com> wrote:
> Hi Daniel, Rob.
>
> Thank you both for your reviews - greatly appreciated!
>
>> > > Known issues:
>> > >  * It still includes code to use KDS, which is not going upstream.
>> >
>> > review's on <http://lists.freedesktop.org/archives/dri-devel/2013-
>> > July/042462.html> can't hurt
>> >
>> > although you might consider submitting a reduced functionality driver
>> > w/ KDS bits removed in the mean time.. then when the fence stuff is
>> > merged it is just an incremental patch rather than a whole driver ;-)
>>
>> Yeah, I think the KDS bits and comments need to go first before
>> merginge.
>
> Right, as I expected really. Though as I said we'll probably wait for
> fences to land and switch over to that before asking for it to be
> merged. A pl111 KMS driver with neither KDS nor implicit fences is
> useless to us. Having said that, if someone else would have a use for
> a fence/KDS-less pl111 KMS driver, please let me know!
>

well, it would make it easier to review the patches adding fence
support if it was on top of basic KMS support.  So there still is some
benefit to a fence-less pl111, even if it is just for purposes of git
history and patch review ;-)

>
>> > > +/*
>> > > + * Number of flips allowed in flight at any one time. Any more
>> > > + * flips requested beyond this value will cause the caller to
>> > > + * block until earlier flips have completed.
>> > > + *
>> > > + * For performance reasons, this must be greater than the number
>> > > + * of buffers used in the rendering pipeline. Note that the
>> > > + * rendering pipeline can contain different types of buffer, e.g.:
>> > > + * - 2 final framebuffers
>> > > + * - >2 geometry buffers for GPU use-cases
>> > > + * - >2 vertex buffers for GPU use-cases
>> > > + *
>> > > + * For example, a system using 5 geometry buffers could have 5
>> > > + * flips in flight, and so NR_FLIPS_IN_FLIGHT_THRESHOLD must be
>> > > + * 5 or greater.
>> > > + *
>> > > + * Whilst there may be more intermediate buffers (such as
>> > > + * vertex/geometry) than final framebuffers, KDS is used to
>> > > + * ensure that GPU rendering waits for the next off-screen
>> > > + * buffer, so it doesn't overwrite an on-screen buffer and
>> > > + * produce tearing.
>> > > + */
>> > > +
>> >
>> > fwiw, this is at least different from how other drivers do triple
>> > (or > double) buffering.  In other drivers (intel, omap, and
>> > msm/freedreno, that I know of, maybe others too) the xorg driver
>> > dri2 bits implement the double buffering (ie. send flip event back
>> > to client immediately and queue up the flip and call page-flip
>> > after the pageflip event back from kernel.
>> >
>> > I'm not saying not to do it this way, I guess I'd like to hear
>> > what other folks think.  I kinda prefer doing this in userspace
>> > as it keeps the kernel bits simpler (plus it would then work
>> > properly on exynosdrm or other kms drivers).
>>
>> Yeah, if this is just a sw queue then I don't think it makes sense
>> to have it in the kernel. Afaik the current pageflip interface drm
>> exposes allows one oustanding flip only, and you _must_ wait for
>> the flip complete event before you can submit the second one.
>
> Right, I'll have a think about this. I think our idea was to issue
> enough page-flips into the kernel to make sure that any process
> scheduling latencies on a heavily loaded system don't cause us to
> miss a v_sync deadline. At the moment we issue the page flip from DRI2
> schedule_swap. If we were to move that to the page flip event handler
> of the previous page-flip, we're potentially adding in extra latency.
>
> I.e. Currently we have:
>
> DRI2SwapBuffers
>  - drm_mode_page_flip to buffer B
> DRI2SwapBuffers
>  - drm_mode_page_flip to buffer A (gets queued in kernel)
> ...
> v_sync! (at this point buffer B is scanned out)
>  - release buffer A's KDS resource/signal buffer A's fence
>     - queued GPU job to render next frame to buffer A scheduled on HW
> ...
> GPU interrupt! (at this point buffer A is ready to be scanned out)
>  - release buffer A's KDS resource/signal buffer A's fence
>     - second page flip executed, buffer A's address written to scanout
>       register, takes effect on next v_sync.
>
>
> So in the above, after X receives the second DRI2SwapBuffers, it
> doesn't need to get scheduled again for the next frame to be both
> rendered by the GPU and issued to the display for scanout.

well, this is really only an issue if you are so loaded that you don't
get a chance to schedule for ~16ms.. which is pretty long time.  If
you are triple buffering, it should not end up in the critical path
(since the gpu already has the 3rd buffer to start on the next frame).
 And, well, if you do it all in the kernel you probably need to toss
things over to a workqueue anyways.

>
>
> If we were to move to a user-space queue, I think we have something
> like this:
>
> DRI2SwapBuffers
>  - drm_mode_page_flip to buffer B
> DRI2SwapBuffers
>  - queue page flip to buffer A in DDX
> ...
> v_sync! (at this point buffer B is scanned out)
>  - release buffer A's KDS resource/signal buffer A's fence
>     - queued GPU job to render next frame to buffer A scheduled on HW
>  - Send page flip event to X
> ...
> GPU interrupt! (at this point buffer A is ready to be scanned out)
>  - Release buffer A's KDS resource/signal buffer A's fence - but nothing
>    is waiting on it....
> ...
> X gets scheduled, runs page flip handler
>  - drm_mode_page_flip to buffer A
>    - buffer A's address written to scanout register, takes effect on
>      next v_sync.
>
>
> So here, X must get scheduled again after processing the second
> DRI2SwapBuffers in order to have the next frame displayed. This
> increases the likely-hood that we're not able to write the address of
> buffer A to the display HW's scan-out buffer in time to catch the next
> v_sync, especially on a loaded system.
>
> Anyway, I think that's our rational for keeping the queue in kernel
> space, but I don't see there's much value in queuing more than 2 page
> flips in kernel space.
>
>> Ofc if your hardware as a hw-based flip queue (maybe even with frame
>> targets) that's a different matter, but currently we don't have a drm
>> interface to expose this. I'd say for merging the basic driver first we
>> should go with the existing simple pageflip semantics.
>
> Sure - I think it would mean slightly increased jank, but probably
> something we can address later.
>
>
>> > > +enum pl111_bo_type {
>> > > +       PL111_BOT_DMA,
>> > > +       PL111_BOT_SHM
>> > > +};
>> > > +
>> > > +struct pl111_gem_bo_dma {
>> > > +       dma_addr_t fb_dev_addr;
>> > > +       void *fb_cpu_addr;
>> > > +};
>> > > +
>> > > +struct pl111_gem_bo_shm {
>> > > +       struct page **pages;
>> > > +       dma_addr_t *dma_addrs;
>> > > +};
>> > > +
>> > > +struct pl111_gem_bo {
>> > > +       struct drm_gem_object gem_object;
>> > > +       enum pl111_bo_type type;
>> > > +       union {
>> > > +               struct pl111_gem_bo_dma dma;
>> > > +               struct pl111_gem_bo_shm shm;
>> > > +       } backing_data;
>> > > +       struct drm_framebuffer *fb;
>> >
>> > this is at least a bit odd.. normally the fb has ref to the bo(s) and
>> > not the other way around.  And the same bo could be referenced by
>> > multiple fb's which would kinda fall down with this approach.
>>
>> I'd say that's just backwards, framebuffers are created from backing
>> storage objects (which for a gem based driver is a gem object), not the
>> other way round. What's this exactly used for?
>
> Yup.
>
>
>> > > +static void vsync_worker(struct work_struct *work)
>> > > +{
>> > > +       struct pl111_drm_flip_resource *flip_res;
>> > > +       struct pl111_gem_bo *bo;
>> > > +       struct pl111_drm_crtc *pl111_crtc;
>> > > +       struct drm_device *dev;
>> > > +       int flips_in_flight;
>> > > +       flip_res >> > > +               container_of(work, struct pl111_drm_flip_resource,
>> > > +                            vsync_work);
>> > > +
>> > > +       pl111_crtc = to_pl111_crtc(flip_res->crtc);
>> > > +       dev = pl111_crtc->crtc.dev;
>> > > +
>> > > +       DRM_DEBUG_KMS("DRM Finalizing flip_res=%p\n", flip_res);
>> > > +
>> > > +       bo = PL111_BO_FROM_FRAMEBUFFER(flip_res->fb);
>> > > +#ifdef CONFIG_DMA_SHARED_BUFFER_USES_KDS
>> > > +       if (flip_res->worker_release_kds = true) {
>> > > +               spin_lock(&pl111_crtc->current_displaying_lock);
>> > > +               release_kds_resource_and_display(flip_res);
>> > > +               spin_unlock(&pl111_crtc->current_displaying_lock);
>> > > +       }
>> > > +#endif
>> > > +       /* Release DMA buffer on this flip */
>> > > +       if (bo->gem_object.export_dma_buf != NULL)
>> > > +               dma_buf_put(bo->gem_object.export_dma_buf);
>> >
>> > I think you just want to unref the outgoing bo, and let it drop the
>> > dmabuf ref when the file ref of the imported bo goes.  Or actually,
>> > it would be better to hold/drop ref's to the fb, rather than the bo.
>> > At least this will make things simpler if you ever have multi-planar
>> > support.
>>
>> Drivers have no business frobbing around the dma-buf refcount of
>> imported objects imo, at least if they use all the standard drm
>> prime infrastructure. And if they're bugs they need to be fixed
>> there, not in drivers.
>
> Good point. I guess the fb holds a ref on the bo and the bo holds a
> ref on the imported dma_buf. Don't know what this was for...
>
>
>> > > +       BUG_ON(bo->type != PL111_BOT_DMA);
>> >
>> > umm, no BUG_ON() is not really a good way to validate userspace
>> > input..
>>
>> Yep.
>
> :-D
>
>
>> > > +
>> > > +       switch ((char)(mode_cmd->pixel_format & 0xFF)) {
>> > > +       case 'Y':
>> > > +       case 'U':
>> > > +       case 'V':
>> > > +       case 'N':
>> > > +       case 'T':
>> >
>> > perhaps we should instead add a drm_format_is_yuv().. or you could
>> > (ab)use drm_fb_get_bpp_depth()..
>>
>> Yeah, I think a new drm_format_is_yuv is asked-for here. Now the bigger
>> question is why you need this, since the drm core should filter out
>> formats not in your list of supported ones. Or at least it should ...
>
> Probably unnecessary belts & braces. I'll see if I can find some DRM
> test which tries to create an fb using a yuv format and see where, if
> anywhere, it gets rejected.
>

fwiw, it should fail, not when you create the (at least for most
drivers) but when you try to attach it to a plane or crtc.

If we had primary plane's in drm core, we could do a bit better error
checking in the core and bail out on fb creation for a format that no
crtc/plane could scanout.

BR,
-R

>
> Thanks again!!
>
>
> Cheers,
>
> Tom
>
>
>
>
>
