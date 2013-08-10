From: Rob Clark <robdclark@gmail.com>
Date: Sat, 10 Aug 2013 12:30:20 +0000
Subject: Re: [RFC 1/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <CAF6AEGuPHB1HRUjQ4WUTp9mWKGh6frSc1JfFF5TEoN_DN33qqA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
	<1374772648-19151-2-git-send-email-tom.cooksey@arm.com>
	<CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>
	<20130807164651.GY22035@phenom.ffwll.local>
	<520515b0.88b70e0a.3ecd.1004SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAF6AEGu68ntQDSueQJmAM1KSsSA86j98GDEf8wOPbZKjECw99Q@mail.gmail.com>
	<20130809165706.GC31670@phenom.ffwll.local>
	<5205277e.84320f0a.1cdf.ffff8816SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5205277e.84320f0a.1cdf.ffff8816SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Cooksey <tom.cooksey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Pawel Moll <Pawel.Moll@arm.com>, linux-arm-kernel@lists.infradead.org

On Fri, Aug 9, 2013 at 1:31 PM, Tom Cooksey <tom.cooksey@arm.com> wrote:
>> > > So in the above, after X receives the second DRI2SwapBuffers, it
>> > > doesn't need to get scheduled again for the next frame to be both
>> > > rendered by the GPU and issued to the display for scanout.
>> >
>> > well, this is really only an issue if you are so loaded that you
>> > don't get a chance to schedule for ~16ms.. which is pretty long time.
>
> Yes - it really is 16ms (minus interrupt/workqueue latency) isn't it?
> Hmmm, that does sound very long. Will try out some experiments and see.
>

yeah

>
>> > If you are triple buffering, it should not end up in the critical
>> > path (since the gpu already has the 3rd buffer to start on the next
>> > frame). And, well, if you do it all in the kernel you probably need
>> > to toss things over to a workqueue anyways.
>>
>> Just a quick comment on the kernel flip queue issue.
>>
>> 16 ms scheduling latency sounds awful but totally doable with a less
>> than stellar ddx driver going into limbo land and so preventing your
>> single threaded X from doing more useful stuff. Is this really the
>> linux scheduler being stupid?
>
> Ahahhaaa!! Yes!!! Really good point. We generally don't have 2D HW and
> so rely on pixman to perform all 2D operations which does indeed tie
> up that thread for fairly long periods of time.
>
> We've had internal discussions about introducing a thread (gulp) in
> the DDX to off-load drawing operations to. I think we were all a bit
> scared by that idea though.
>

thread does sound a bit scary.. it probably could be done if you treat
it like a virtual cpu and have WaitMarker or PrepareAccess for sw
fallbacks synchronize properly..

I bet you'd be much better off just making non-scanout pixmaps cached
and doing cache sync ops when needed for dri2 buffers.  Sw fallbacks
on uncached buffers probably aren't exactly the hot ticket.

>
> BTW: I wasn't suggesting it was the linux scheduler being stupid, just
> that there is sometimes lots of contention over the CPU cores and X
> is just one thread among many wanting to run.
>
>
>> At least my impression was that the hw/kernel flip queue is to save
>> power so that you can queue up a few frames and everything goes to
>> sleep for half a second or so (at 24fps or whatever movie your
>> showing). Needing to schedule 5 frames ahead with pageflips under
>> load is just guaranteed to result in really horrible interactivity
>> and so awful user experience
>
> Agreed. There's always a tradeoff between tolerance to variable frame
> rendering time/system latency (lot of buffers) and UI latency (few
> buffers).
>
> As a side note, video playback is one use-case for explicit sync
> objects which implicit/buffer-based sync doesn't handle: Queue up lots
> of video frames for display, but mark those "display buffer"
> operations as depending on explicit sync objects which get signalled
> by the audio clock. Not sure Android actually does that yet though.
> Anyway, off topic.
>

w/ dmafence, rather than explicit fences, I suppose you could add some
way to queue the buffer to the audio device and have the audio device
signal the fence.  I suppose it does sound a bit funny for ALSA to
have a DMA_BUF_AV_SYNC ioctl for this sort of case?

I don't think there is anything like it in EGL, but there is
oml_sync_control extension for more precise control of presentation
time.  But this is all implemented in userspace and doesn't really
work out w/ >double buffering.  This is part of the reason for the
timing information in vblank events.  Of course it doesn't have any
tie in to audio subsystem, but in practice this really shouldn't be
needed.  Audio samples are either rendered at a very predictable rate,
or sound like sh** with lots of pops and cut outs.

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
