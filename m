From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 29 May 2013 02:21:37 +0000
Subject: RE: Introduce a new helper framework for buffer synchronization
Message-Id: <003c01ce5c13$3f2e8370$bd8b8a50$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51909DB4.2060208@canonical.com>
In-Reply-To: <51909DB4.2060208@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: daniel.vetter@ffwll.ch [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> Daniel Vetter
> Sent: Wednesday, May 29, 2013 1:50 AM
> To: Inki Dae
> Cc: Rob Clark; Maarten Lankhorst; linux-fbdev; YoungJun Cho; Kyungmin
Park;
> myungjoo.ham; DRI mailing list; linux-arm-kernel@lists.infradead.org;
> linux-media@vger.kernel.org
> Subject: Re: Introduce a new helper framework for buffer synchronization
> 
> On Tue, May 28, 2013 at 4:50 PM, Inki Dae <inki.dae@samsung.com> wrote:
> > I think I already used reservation stuff any time in that way except
> > ww-mutex. And I'm not sure that embedded system really needs ww-mutex.
> If
> > there is any case,
> > could you tell me the case? I really need more advice and
> understanding :)
> 
> If you have only one driver, you can get away without ww_mutex.
> drm/i915 does it, all buffer state is protected by dev->struct_mutex.
> But as soon as you have multiple drivers sharing buffers with dma_buf
> things will blow up.
> 
> Yep, current prime is broken and can lead to deadlocks.
> 
> In practice it doesn't (yet) matter since only the X server does the
> sharing dance, and that one's single-threaded. Now you can claim that
> since you have all buffers pinned in embedded gfx anyway, you don't
> care. But both in desktop gfx and embedded gfx the real fun starts
> once you put fences into the mix and link them up with buffers, then
> every command submission risks that deadlock. Furthermore you can get
> unlucky and construct a circle of fences waiting on each another (only
> though if the fence singalling fires off the next batchbuffer
> asynchronously).

In our case, we haven't ever experienced deadlock yet but there is still
possible to face with deadlock in case that a process is sharing two buffer
with another process like below,
	Process A committed buffer A and  waits for buffer B,
	Process B committed buffer B and waits for buffer A

That is deadlock and it seems that you say we can resolve deadlock issue
with ww-mutexes. And it seems that we can replace our block-wakeup mechanism
with mutex lock for more performance.

> 
> To prevent such deadlocks you _absolutely_ need to lock _all_ buffers
> that take part in a command submission at once. To do that you either
> need a global lock (ugh) or ww_mutexes.
> 
> So ww_mutexes are the fundamental ingredient of all this, if you don't
> see why you need them then everything piled on top is broken. I think
> until you've understood why exactly we need ww_mutexes there's not
> much point in discussing the finer issues of fences, reservation
> objects and how to integrate it with dma_bufs exactly.
> 
> I'll try to clarify the motivating example in the ww_mutex
> documentation a bit, but I dunno how else I could explain this ...
> 

I don't really want for you waste your time on me. I will trying to apply
ww-mutexes (v4) to the proposed framework for more understanding.

Thanks for your advices.:) 
Inki Dae

> Yours, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

