From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Thu, 21 Apr 2016 18:54:45 +0000
Subject: Re: [PATCH 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <571921F5.2080007@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-5-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461165929-11344-5-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org


Den 20.04.2016 17:25, skrev Noralf Trønnes:
> This adds deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
> Accumulated fbdev framebuffer changes are signaled using the callback
> (struct drm_framebuffer_funcs *)->dirty()
>
> The drm_fb_helper_sys_*() functions will accumulate changes and
> schedule fb_info.deferred_work _if_ fb_info.fbdefio is set.
> This worker is used by the deferred io mmap code to signal that it
> has been collecting page faults. The page faults and/or other changes
> are then merged into a drm_clip_rect and passed to the framebuffer
> dirty() function.
>
> The driver is responsible for setting up the fb_info.fbdefio structure
> and calling fb_deferred_io_init() using the provided callback:
> (struct fb_deferred_io).deferred_io = drm_fb_helper_deferred_io;
>
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>   drivers/gpu/drm/drm_fb_helper.c | 119 +++++++++++++++++++++++++++++++++++++++-
>   include/drm/drm_fb_helper.h     |  15 +++++
>   2 files changed, 133 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c

[...]

> +#ifdef CONFIG_FB_DEFERRED_IO
> +/**
> + * drm_fb_helper_deferred_io() - (struct fb_deferred_io *)->deferred_io callback
> + *                               function
> + *
> + * This function always runs in process context (struct delayed_work) and calls
> + * the (struct drm_framebuffer_funcs)->dirty function with the collected
> + * damage. There's no need to worry about the possibility that the fb_sys_*()
> + * functions could be running in atomic context. They only schedule the
> + * delayed worker which then calls this deferred_io callback.
> + */
> +void drm_fb_helper_deferred_io(struct fb_info *info,
> +			       struct list_head *pagelist)
> +{
> +	struct drm_fb_helper *helper = info->par;
> +	unsigned long start, end, min, max;
> +	struct drm_clip_rect clip;
> +	unsigned long flags;
> +	struct page *page;
> +
> +	if (!helper->fb->funcs->dirty)
> +		return;
> +
> +	spin_lock_irqsave(&helper->dirty_lock, flags);
> +	clip = helper->dirty_clip;
> +	drm_clip_rect_reset(&helper->dirty_clip);
> +	spin_unlock_irqrestore(&helper->dirty_lock, flags);
> +
> +	min = ULONG_MAX;
> +	max = 0;
> +	list_for_each_entry(page, pagelist, lru) {
> +		start = page->index << PAGE_SHIFT;
> +		end = start + PAGE_SIZE - 1;
> +		min = min(min, start);
> +		max = max(max, end);
> +	}
> +
> +	if (min < max) {
> +		struct drm_clip_rect mmap_clip;
> +
> +		mmap_clip.x1 = 0;
> +		mmap_clip.x2 = info->var.xres;
> +		mmap_clip.y1 = min / info->fix.line_length;
> +		mmap_clip.y2 = min_t(u32, max / info->fix.line_length,
> +				     info->var.yres);
> +		drm_clip_rect_merge(&clip, &mmap_clip, 1, 0, 0, 0);
> +	}
> +
> +	if (!drm_clip_rect_is_empty(&clip))
> +		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip, 1);
> +}
> +EXPORT_SYMBOL(drm_fb_helper_deferred_io);

There is one thing I have wondered about when it comes to deferred io and
long run times for the defio worker with my displays:

Userspace writes to some pages then the deferred io worker kicks off and
runs for 100ms holding the page list mutex. While this is happening,
userspace writes to a new page triggering a page_mkwrite. Now this
function has to wait for the mutex to be released.

Who is actually waiting here and is there a problem that this can last
for 100ms?

Excerpt from drivers/video/fbdev/core/fb_defio.c:

/* vm_ops->page_mkwrite handler */
static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
                   struct vm_fault *vmf)
{
...
     /* this is a callback we get when userspace first tries to
     write to the page. we schedule a workqueue. that workqueue
     will eventually mkclean the touched pages and execute the
     deferred framebuffer IO. then if userspace touches a page
     again, we repeat the same scheme */
...
     /* protect against the workqueue changing the page list */
     mutex_lock(&fbdefio->lock);
...
     /*
      * We want the page to remain locked from ->page_mkwrite until
      * the PTE is marked dirty to avoid page_mkclean() being called
      * before the PTE is updated, which would leave the page ignored
      * by defio.
      * Do this by locking the page here and informing the caller
      * about it with VM_FAULT_LOCKED.
      */
     lock_page(page);

     /* we loop through the pagelist before adding in order
     to keep the pagelist sorted */
     list_for_each_entry(cur, &fbdefio->pagelist, lru) {
         /* this check is to catch the case where a new
         process could start writing to the same page
         through a new pte. this new access can cause the
         mkwrite even when the original ps's pte is marked
         writable */
         if (unlikely(cur = page))
             goto page_already_added;
         else if (cur->index > page->index)
             break;
     }

     list_add_tail(&page->lru, &cur->lru);

page_already_added:
     mutex_unlock(&fbdefio->lock);

     /* come back after delay to process the deferred IO */
     schedule_delayed_work(&info->deferred_work, fbdefio->delay);
     return VM_FAULT_LOCKED;
}

static int fb_deferred_io_set_page_dirty(struct page *page)
{
     if (!PageDirty(page))
         SetPageDirty(page);
     return 0;
}

/* workqueue callback */
static void fb_deferred_io_work(struct work_struct *work)
{
...
     /* here we mkclean the pages, then do all deferred IO */
     mutex_lock(&fbdefio->lock);
     list_for_each_entry(cur, &fbdefio->pagelist, lru) {
         lock_page(cur);
         page_mkclean(cur);
         unlock_page(cur);
     }

     /* driver's callback with pagelist */
     fbdefio->deferred_io(info, &fbdefio->pagelist);
...
     mutex_unlock(&fbdefio->lock);
}


Noralf.

