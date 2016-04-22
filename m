From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Fri, 22 Apr 2016 14:17:14 +0000
Subject: Re: [PATCH 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <571A326A.9070407@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-5-git-send-email-noralf@tronnes.org>
 <571921F5.2080007@tronnes.org> <20160422082719.GH2510@phenom.ffwll.local>
In-Reply-To: <20160422082719.GH2510@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


Den 22.04.2016 10:27, skrev Daniel Vetter:
> On Thu, Apr 21, 2016 at 08:54:45PM +0200, Noralf Tr=F8nnes wrote:
>> Den 20.04.2016 17:25, skrev Noralf Tr=F8nnes:
>>> This adds deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
>>> Accumulated fbdev framebuffer changes are signaled using the callback
>>> (struct drm_framebuffer_funcs *)->dirty()
>>>
>>> The drm_fb_helper_sys_*() functions will accumulate changes and
>>> schedule fb_info.deferred_work _if_ fb_info.fbdefio is set.
>>> This worker is used by the deferred io mmap code to signal that it
>>> has been collecting page faults. The page faults and/or other changes
>>> are then merged into a drm_clip_rect and passed to the framebuffer
>>> dirty() function.
>>>
>>> The driver is responsible for setting up the fb_info.fbdefio structure
>>> and calling fb_deferred_io_init() using the provided callback:
>>> (struct fb_deferred_io).deferred_io =3D drm_fb_helper_deferred_io;
>>>
>>> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
>>> ---
>>>   drivers/gpu/drm/drm_fb_helper.c | 119 +++++++++++++++++++++++++++++++=
++++++++-
>>>   include/drm/drm_fb_helper.h     |  15 +++++
>>>   2 files changed, 133 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
>> [...]
>>
>>> +#ifdef CONFIG_FB_DEFERRED_IO
>>> +/**
>>> + * drm_fb_helper_deferred_io() - (struct fb_deferred_io *)->deferred_i=
o callback
>>> + *                               function
>>> + *
>>> + * This function always runs in process context (struct delayed_work) =
and calls
>>> + * the (struct drm_framebuffer_funcs)->dirty function with the collect=
ed
>>> + * damage. There's no need to worry about the possibility that the fb_=
sys_*()
>>> + * functions could be running in atomic context. They only schedule the
>>> + * delayed worker which then calls this deferred_io callback.
>>> + */
>>> +void drm_fb_helper_deferred_io(struct fb_info *info,
>>> +			       struct list_head *pagelist)
>>> +{
>>> +	struct drm_fb_helper *helper =3D info->par;
>>> +	unsigned long start, end, min, max;
>>> +	struct drm_clip_rect clip;
>>> +	unsigned long flags;
>>> +	struct page *page;
>>> +
>>> +	if (!helper->fb->funcs->dirty)
>>> +		return;
>>> +
>>> +	spin_lock_irqsave(&helper->dirty_lock, flags);
>>> +	clip =3D helper->dirty_clip;
>>> +	drm_clip_rect_reset(&helper->dirty_clip);
>>> +	spin_unlock_irqrestore(&helper->dirty_lock, flags);
>>> +
>>> +	min =3D ULONG_MAX;
>>> +	max =3D 0;
>>> +	list_for_each_entry(page, pagelist, lru) {
>>> +		start =3D page->index << PAGE_SHIFT;
>>> +		end =3D start + PAGE_SIZE - 1;
>>> +		min =3D min(min, start);
>>> +		max =3D max(max, end);
>>> +	}
>>> +
>>> +	if (min < max) {
>>> +		struct drm_clip_rect mmap_clip;
>>> +
>>> +		mmap_clip.x1 =3D 0;
>>> +		mmap_clip.x2 =3D info->var.xres;
>>> +		mmap_clip.y1 =3D min / info->fix.line_length;
>>> +		mmap_clip.y2 =3D min_t(u32, max / info->fix.line_length,
>>> +				     info->var.yres);
>>> +		drm_clip_rect_merge(&clip, &mmap_clip, 1, 0, 0, 0);
>>> +	}
>>> +
>>> +	if (!drm_clip_rect_is_empty(&clip))
>>> +		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip, 1);
>>> +}
>>> +EXPORT_SYMBOL(drm_fb_helper_deferred_io);
>> There is one thing I have wondered about when it comes to deferred io and
>> long run times for the defio worker with my displays:
>>
>> Userspace writes to some pages then the deferred io worker kicks off and
>> runs for 100ms holding the page list mutex. While this is happening,
>> userspace writes to a new page triggering a page_mkwrite. Now this
>> function has to wait for the mutex to be released.
>>
>> Who is actually waiting here and is there a problem that this can last
>> for 100ms?
> No idea at all - I haven't looked that closely at  fbdev defio. But one
> reason we have an explicit ioctl in drm to flush out frontbuffer rendering
> is exactly that flushing could take some time, and should only be done
> once userspace has completed some rendering. Not right in the middle of an
> op.
>
> I guess fix up your userspace to use dumb drm fb + drm dirtyfb ioctl?
> Otherwise you'll get to improve fbdev defio, and fbdev is deprecated
> subsystem and a real horror show. I highly recommend against touching it
> ;-)

I have tried to track the call chain and it seems to be part of the
page fault handler. Which means it's userspace wanting to write to the
page that has to wait. And it has to wait at some random point in
whatever rendering it's doing.

Unless someone has any objections, I will make a change and add a worker
like qxl does. This decouples the deferred_io worker holding the mutex
from the framebuffer flushing job. However I intend to differ from qxl in
that I will use a delayed worker (run immediately from the mmap side which
has already been deferred). Since I don't see any point in flushing the
framebuffer immediately when fbcon has put out only one glyph, might as
well defer it a couple of jiffies to be able to capture some more glyphs.

Adding a worker also means that udl doesn't have to initialize deferred_io
because we won't be using the deferred_work worker for flushing fb_*().

And yes, using drm from userspace is "The solution" here :-), however
I want to make the best out of fbdev since some of the tinydrm users
coming from drivers/staging/fbtft will probably continue with fbdev.


Noralf.

