From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 09 Aug 2013 16:57:06 +0000
Subject: Re: [RFC 1/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <20130809165706.GC31670@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
	<1374772648-19151-2-git-send-email-tom.cooksey@arm.com>
	<CAF6AEGvGG1-4k-3_YHQ2ES6JEb-V-Xuicc8gfw9rPWze5JUEDg@mail.gmail.com>
	<20130807164651.GY22035@phenom.ffwll.local>
	<520515b0.88b70e0a.3ecd.1004SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAF6AEGu68ntQDSueQJmAM1KSsSA86j98GDEf8wOPbZKjECw99Q@mail.gmail.com>
In-Reply-To: <CAF6AEGu68ntQDSueQJmAM1KSsSA86j98GDEf8wOPbZKjECw99Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Pawel Moll <Pawel.Moll@arm.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org

On Fri, Aug 09, 2013 at 12:34:55PM -0400, Rob Clark wrote:
> On Fri, Aug 9, 2013 at 12:15 PM, Tom Cooksey <tom.cooksey@arm.com> wrote:
> >> > fwiw, this is at least different from how other drivers do triple
> >> > (or > double) buffering.  In other drivers (intel, omap, and
> >> > msm/freedreno, that I know of, maybe others too) the xorg driver
> >> > dri2 bits implement the double buffering (ie. send flip event back
> >> > to client immediately and queue up the flip and call page-flip
> >> > after the pageflip event back from kernel.
> >> >
> >> > I'm not saying not to do it this way, I guess I'd like to hear
> >> > what other folks think.  I kinda prefer doing this in userspace
> >> > as it keeps the kernel bits simpler (plus it would then work
> >> > properly on exynosdrm or other kms drivers).
> >>
> >> Yeah, if this is just a sw queue then I don't think it makes sense
> >> to have it in the kernel. Afaik the current pageflip interface drm
> >> exposes allows one oustanding flip only, and you _must_ wait for
> >> the flip complete event before you can submit the second one.
> >
> > Right, I'll have a think about this. I think our idea was to issue
> > enough page-flips into the kernel to make sure that any process
> > scheduling latencies on a heavily loaded system don't cause us to
> > miss a v_sync deadline. At the moment we issue the page flip from DRI2
> > schedule_swap. If we were to move that to the page flip event handler
> > of the previous page-flip, we're potentially adding in extra latency.
> >
> > I.e. Currently we have:
> >
> > DRI2SwapBuffers
> >  - drm_mode_page_flip to buffer B
> > DRI2SwapBuffers
> >  - drm_mode_page_flip to buffer A (gets queued in kernel)
> > ...
> > v_sync! (at this point buffer B is scanned out)
> >  - release buffer A's KDS resource/signal buffer A's fence
> >     - queued GPU job to render next frame to buffer A scheduled on HW
> > ...
> > GPU interrupt! (at this point buffer A is ready to be scanned out)
> >  - release buffer A's KDS resource/signal buffer A's fence
> >     - second page flip executed, buffer A's address written to scanout
> >       register, takes effect on next v_sync.
> >
> >
> > So in the above, after X receives the second DRI2SwapBuffers, it
> > doesn't need to get scheduled again for the next frame to be both
> > rendered by the GPU and issued to the display for scanout.
> 
> well, this is really only an issue if you are so loaded that you don't
> get a chance to schedule for ~16ms.. which is pretty long time.  If
> you are triple buffering, it should not end up in the critical path
> (since the gpu already has the 3rd buffer to start on the next frame).
>  And, well, if you do it all in the kernel you probably need to toss
> things over to a workqueue anyways.

Just a quick comment on the kernel flip queue issue.

16 ms scheduling latency sounds awful but totally doable with a less than
stellar ddx driver going into limbo land and so preventing your single
threaded X from doing more useful stuff. Is this really the linux
scheduler being stupid?

At least my impression was that the hw/kernel flip queue is to save power
so that you can queue up a few frames and everything goes to sleep for
half a second or so (at 24fps or whatever movie your showing). Needing to
schedule 5 frames ahead with pageflips under load is just guaranteed to
result in really horrible interactivity and so awful user experience ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
