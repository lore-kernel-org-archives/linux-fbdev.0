From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 15 May 2013 05:19:09 +0000
Subject: RE: Introduce a new helper framework for buffer synchronization
Message-Id: <00cf01ce512b$bacc5540$3064ffc0$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51909DB4.2060208@canonical.com>
In-Reply-To: <51909DB4.2060208@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Rob Clark [mailto:robdclark@gmail.com]
> Sent: Tuesday, May 14, 2013 10:39 PM
> To: Inki Dae
> Cc: linux-fbdev; DRI mailing list; Kyungmin Park; myungjoo.ham; YoungJun
> Cho; linux-arm-kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: Introduce a new helper framework for buffer synchronization
> 
> On Mon, May 13, 2013 at 10:52 PM, Inki Dae <inki.dae@samsung.com> wrote:
> >> well, for cache management, I think it is a better idea.. I didn't
> >> really catch that this was the motivation from the initial patch, but
> >> maybe I read it too quickly.  But cache can be decoupled from
> >> synchronization, because CPU access is not asynchronous.  For
> >> userspace/CPU access to buffer, you should:
> >>
> >>   1) wait for buffer
> >>   2) prepare-access
> >>   3)  ... do whatever cpu access to buffer ...
> >>   4) finish-access
> >>   5) submit buffer for new dma-operation
> >>
> >
> >
> > For data flow from CPU to DMA device,
> > 1) wait for buffer
> > 2) prepare-access (dma_buf_begin_cpu_access)
> > 3) cpu access to buffer
> >
> >
> > For data flow from DMA device to CPU
> > 1) wait for buffer
> 
> Right, but CPU access isn't asynchronous (from the point of view of
> the CPU), so there isn't really any wait step at this point.  And if
> you do want the CPU to be able to signal a fence from userspace for
> some reason, you probably what something file/fd based so the
> refcnting/cleanup when process dies doesn't leave some pending DMA
> action wedged.  But I don't really see the point of that complexity
> when the CPU access isn't asynchronous in the first place.
>

There was my missing comments, please see the below sequence.

For data flow from CPU to DMA device and then from DMA device to CPU,
1) wait for buffer <- at user side - ioctl(fd, DMA_BUF_GET_FENCE, ...)
	- including prepare-access (dma_buf_begin_cpu_access)
2) cpu access to buffer
3) wait for buffer <- at device driver
	- but CPU is already accessing the buffer so blocked.
4) signal <- at user side - ioctl(fd, DMA_BUF_PUT_FENCE, ...)
5) the thread, blocked at 3), is waked up by 4).
	- and then finish-access (dma_buf_end_cpu_access)
6) dma access to buffer
7) wait for buffer <- at user side - ioctl(fd, DMA_BUF_GET_FENCE, ...)
	- but DMA is already accessing the buffer so blocked.
8) signal <- at device driver
9) the thread, blocked at 7), is waked up by 8)
	- and then prepare-access (dma_buf_begin_cpu_access)
10 cpu access to buffer

Basically, 'wait for buffer' includes buffer synchronization, committing
processing, and cache operation. The buffer synchronization means that a
current thread should wait for other threads accessing a shared buffer until
the completion of their access. And the committing processing means that a
current thread possesses the shared buffer so any trying to access the
shared buffer by another thread makes the thread to be blocked. However, as
I already mentioned before, it seems that these user interfaces are so ugly
yet. So we need better way.

Give me more comments if there is my missing point :)

Thanks,
Inki Dae

> BR,
> -R
> 
> 
> > 2) finish-access (dma_buf_end _cpu_access)
> > 3) dma access to buffer
> >
> > 1) and 2) are coupled with one function: we have implemented
> > fence_helper_commit_reserve() for it.
> >
> > Cache control(cache clean or cache invalidate) is performed properly
> > checking previous access type and current access type.
> > And the below is actual codes for it,

