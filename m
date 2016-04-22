From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 22 Apr 2016 08:27:19 +0000
Subject: Re: [PATCH 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <20160422082719.GH2510@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-5-git-send-email-noralf@tronnes.org>
 <571921F5.2080007@tronnes.org>
In-Reply-To: <571921F5.2080007@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Thu, Apr 21, 2016 at 08:54:45PM +0200, Noralf Tr=F8nnes wrote:
>=20
> Den 20.04.2016 17:25, skrev Noralf Tr=F8nnes:
> >This adds deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
> >Accumulated fbdev framebuffer changes are signaled using the callback
> >(struct drm_framebuffer_funcs *)->dirty()
> >
> >The drm_fb_helper_sys_*() functions will accumulate changes and
> >schedule fb_info.deferred_work _if_ fb_info.fbdefio is set.
> >This worker is used by the deferred io mmap code to signal that it
> >has been collecting page faults. The page faults and/or other changes
> >are then merged into a drm_clip_rect and passed to the framebuffer
> >dirty() function.
> >
> >The driver is responsible for setting up the fb_info.fbdefio structure
> >and calling fb_deferred_io_init() using the provided callback:
> >(struct fb_deferred_io).deferred_io =3D drm_fb_helper_deferred_io;
> >
> >Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> >---
> >  drivers/gpu/drm/drm_fb_helper.c | 119 ++++++++++++++++++++++++++++++++=
+++++++-
> >  include/drm/drm_fb_helper.h     |  15 +++++
> >  2 files changed, 133 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_he=
lper.c
>=20
> [...]
>=20
> >+#ifdef CONFIG_FB_DEFERRED_IO
> >+/**
> >+ * drm_fb_helper_deferred_io() - (struct fb_deferred_io *)->deferred_io=
 callback
> >+ *                               function
> >+ *
> >+ * This function always runs in process context (struct delayed_work) a=
nd calls
> >+ * the (struct drm_framebuffer_funcs)->dirty function with the collected
> >+ * damage. There's no need to worry about the possibility that the fb_s=
ys_*()
> >+ * functions could be running in atomic context. They only schedule the
> >+ * delayed worker which then calls this deferred_io callback.
> >+ */
> >+void drm_fb_helper_deferred_io(struct fb_info *info,
> >+			       struct list_head *pagelist)
> >+{
> >+	struct drm_fb_helper *helper =3D info->par;
> >+	unsigned long start, end, min, max;
> >+	struct drm_clip_rect clip;
> >+	unsigned long flags;
> >+	struct page *page;
> >+
> >+	if (!helper->fb->funcs->dirty)
> >+		return;
> >+
> >+	spin_lock_irqsave(&helper->dirty_lock, flags);
> >+	clip =3D helper->dirty_clip;
> >+	drm_clip_rect_reset(&helper->dirty_clip);
> >+	spin_unlock_irqrestore(&helper->dirty_lock, flags);
> >+
> >+	min =3D ULONG_MAX;
> >+	max =3D 0;
> >+	list_for_each_entry(page, pagelist, lru) {
> >+		start =3D page->index << PAGE_SHIFT;
> >+		end =3D start + PAGE_SIZE - 1;
> >+		min =3D min(min, start);
> >+		max =3D max(max, end);
> >+	}
> >+
> >+	if (min < max) {
> >+		struct drm_clip_rect mmap_clip;
> >+
> >+		mmap_clip.x1 =3D 0;
> >+		mmap_clip.x2 =3D info->var.xres;
> >+		mmap_clip.y1 =3D min / info->fix.line_length;
> >+		mmap_clip.y2 =3D min_t(u32, max / info->fix.line_length,
> >+				     info->var.yres);
> >+		drm_clip_rect_merge(&clip, &mmap_clip, 1, 0, 0, 0);
> >+	}
> >+
> >+	if (!drm_clip_rect_is_empty(&clip))
> >+		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip, 1);
> >+}
> >+EXPORT_SYMBOL(drm_fb_helper_deferred_io);
>=20
> There is one thing I have wondered about when it comes to deferred io and
> long run times for the defio worker with my displays:
>=20
> Userspace writes to some pages then the deferred io worker kicks off and
> runs for 100ms holding the page list mutex. While this is happening,
> userspace writes to a new page triggering a page_mkwrite. Now this
> function has to wait for the mutex to be released.
>=20
> Who is actually waiting here and is there a problem that this can last
> for 100ms?

No idea at all - I haven't looked that closely at  fbdev defio. But one
reason we have an explicit ioctl in drm to flush out frontbuffer rendering
is exactly that flushing could take some time, and should only be done
once userspace has completed some rendering. Not right in the middle of an
op.

I guess fix up your userspace to use dumb drm fb + drm dirtyfb ioctl?
Otherwise you'll get to improve fbdev defio, and fbdev is deprecated
subsystem and a real horror show. I highly recommend against touching it
;-)

Cheers, Daniel

>=20
> Excerpt from drivers/video/fbdev/core/fb_defio.c:
>=20
> /* vm_ops->page_mkwrite handler */
> static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
>                   struct vm_fault *vmf)
> {
> ...
>     /* this is a callback we get when userspace first tries to
>     write to the page. we schedule a workqueue. that workqueue
>     will eventually mkclean the touched pages and execute the
>     deferred framebuffer IO. then if userspace touches a page
>     again, we repeat the same scheme */
> ...
>     /* protect against the workqueue changing the page list */
>     mutex_lock(&fbdefio->lock);
> ...
>     /*
>      * We want the page to remain locked from ->page_mkwrite until
>      * the PTE is marked dirty to avoid page_mkclean() being called
>      * before the PTE is updated, which would leave the page ignored
>      * by defio.
>      * Do this by locking the page here and informing the caller
>      * about it with VM_FAULT_LOCKED.
>      */
>     lock_page(page);
>=20
>     /* we loop through the pagelist before adding in order
>     to keep the pagelist sorted */
>     list_for_each_entry(cur, &fbdefio->pagelist, lru) {
>         /* this check is to catch the case where a new
>         process could start writing to the same page
>         through a new pte. this new access can cause the
>         mkwrite even when the original ps's pte is marked
>         writable */
>         if (unlikely(cur =3D page))
>             goto page_already_added;
>         else if (cur->index > page->index)
>             break;
>     }
>=20
>     list_add_tail(&page->lru, &cur->lru);
>=20
> page_already_added:
>     mutex_unlock(&fbdefio->lock);
>=20
>     /* come back after delay to process the deferred IO */
>     schedule_delayed_work(&info->deferred_work, fbdefio->delay);
>     return VM_FAULT_LOCKED;
> }
>=20
> static int fb_deferred_io_set_page_dirty(struct page *page)
> {
>     if (!PageDirty(page))
>         SetPageDirty(page);
>     return 0;
> }
>=20
> /* workqueue callback */
> static void fb_deferred_io_work(struct work_struct *work)
> {
> ...
>     /* here we mkclean the pages, then do all deferred IO */
>     mutex_lock(&fbdefio->lock);
>     list_for_each_entry(cur, &fbdefio->pagelist, lru) {
>         lock_page(cur);
>         page_mkclean(cur);
>         unlock_page(cur);
>     }
>=20
>     /* driver's callback with pagelist */
>     fbdefio->deferred_io(info, &fbdefio->pagelist);
> ...
>     mutex_unlock(&fbdefio->lock);
> }
>=20
>=20
> Noralf.
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
