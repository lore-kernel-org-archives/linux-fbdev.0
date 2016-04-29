From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Apr 2016 15:38:08 +0000
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <CAKMK7uGHcfcJv0gU3Tn2x3BxhozxKUuHrX6j0AODwo2+A0hJ+A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
 <572358A0.8010002@ti.com>
 <20160429145524.GC14148@phenom.ffwll.local>
 <57237702.8060305@ti.com>
 <20160429153636.GE14148@phenom.ffwll.local>
In-Reply-To: <20160429153636.GE14148@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Herrmann <dh.herrmann@gmail.com>

Adding David, forgot that before hitting send.
-Daniel

On Fri, Apr 29, 2016 at 5:36 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Apr 29, 2016 at 06:00:18PM +0300, Tomi Valkeinen wrote:
>>
>> On 29/04/16 17:55, Daniel Vetter wrote:
>>
>> >> Who's calling {write,fillrect,copyarea,imageblit} in an atomic context?
>> >> That sounds like a very bad idea to me...
>> >>
>> >> If this is only for accumulating changes, I think it may be better to
>> >> leave that to the driver as it may have better idea of how to accumulate.
>> >>
>> >> But, of course, this is a helper, so if all the drivers use this kind of
>> >> accumulation, it makes sense =).
>> >
>> > Apparently panic context and cursor timer and stuff like that. I think
>> > this started with udl, and just to make sure (it's fbdev after all, no one
>> > wants to read the code itself) we've put those checks onto all entry
>> > points that draw stuff. It could be overkill, but this is what udl/qxl
>> > already do, so better to keep imo for now.
>> >
>> > I guess if it's really not needed we could later on change that, but not
>> > sure that's worth the effort. And we can't get rid of it entirely.
>>
>> Yep... Sounds fine to me.
>>
>> Someone should implement (minimal) fbdev userspace API support to DRM
>> without using the current fbdev, and implement fbcon on top of that. I
>> don't like how DRM and fbdev gets mixed...
>>
>> I offer a beer to anyone who does that =).
>
> The big plan that has been floated years back already (before David
> Herrmann disappeared into the rh systemd gang) was to have a pure
> userspace kmscon for console (including vt-switching in userspace like X
> does), plus a super-minimal panic console on top of kms in the kernel.
> That looked like a really solid design, unfornutately it didn't go
> anywhere. But basic patches are still around, and it really just boils
> down to that some distro would need to integrate kmscon properly, and
> polish of the kernel side too for integration.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
