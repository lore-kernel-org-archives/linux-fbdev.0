From: Inki Dae <inki.dae@samsung.com>
Date: Thu, 20 Jun 2013 08:24:53 +0000
Subject: RE: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization framework
Message-Id: <00db01ce6d8f$a3c23dd0$eb46b970$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Thursday, June 20, 2013 4:47 PM
> To: Inki Dae
> Cc: 'Russell King - ARM Linux'; 'Inki Dae'; 'linux-fbdev'; 'YoungJun Cho';
> 'Kyungmin Park'; 'myungjoo.ham'; 'DRI mailing list'; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization
> framework
> 
> Am Donnerstag, den 20.06.2013, 15:43 +0900 schrieb Inki Dae:
> >
> > > -----Original Message-----
> > > From: dri-devel-bounces+inki.dae=samsung.com@lists.freedesktop.org
> > > [mailto:dri-devel-bounces+inki.dae=samsung.com@lists.freedesktop.org]
> On
> > > Behalf Of Russell King - ARM Linux
> > > Sent: Thursday, June 20, 2013 3:29 AM
> > > To: Inki Dae
> > > Cc: linux-fbdev; DRI mailing list; Kyungmin Park; myungjoo.ham;
> YoungJun
> > > Cho; linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [RFC PATCH v2] dmabuf-sync: Introduce buffer
> synchronization
> > > framework
> > >
> > > On Thu, Jun 20, 2013 at 12:10:04AM +0900, Inki Dae wrote:
> > > > On the other hand, the below shows how we could enhance the
> conventional
> > > > way with my approach (just example):
> > > >
> > > > CPU -> DMA,
> > > >         ioctl(qbuf command)              ioctl(streamon)
> > > >               |                                               |
> > > >               |                                               |
> > > >         qbuf  <- dma_buf_sync_get   start streaming <- syncpoint
> > > >
> > > > dma_buf_sync_get just registers a sync buffer(dmabuf) to sync object.
> > > And
> > > > the syncpoint is performed by calling dma_buf_sync_lock(), and then
> DMA
> > > > accesses the sync buffer.
> > > >
> > > > And DMA -> CPU,
> > > >         ioctl(dqbuf command)
> > > >               |
> > > >               |
> > > >         dqbuf <- nothing to do
> > > >
> > > > Actual syncpoint is when DMA operation is completed (in interrupt
> > > handler):
> > > > the syncpoint is performed by calling dma_buf_sync_unlock().
> > > > Hence,  my approach is to move the syncpoints into just before dma
> > > access
> > > > as long as possible.
> > >
> > > What you've just described does *not* work on architectures such as
> > > ARMv7 which do speculative cache fetches from memory at any time that
> > > that memory is mapped with a cacheable status, and will lead to data
> > > corruption.
> >
> > I didn't explain that enough. Sorry about that. 'nothing to do' means
> that a
> > dmabuf sync interface isn't called but existing functions are called. So
> > this may be explained again:
> >         ioctl(dqbuf command)
> >             |
> >             |
> >         dqbuf <- 1. dma_unmap_sg
> >                     2. dma_buf_sync_unlock (syncpoint)
> >
> > The syncpoint I mentioned means lock mechanism; not doing cache
> operation.
> >
> > In addition, please see the below more detail examples.
> >
> > The conventional way (without dmabuf-sync) is:
> > Task A
> > ----------------------------
> >  1. CPU accesses buf
> >  2. Send the buf to Task B
> >  3. Wait for the buf from Task B
> >  4. go to 1
> >
> > Task B
> > ---------------------------
> > 1. Wait for the buf from Task A
> > 2. qbuf the buf
> >     2.1 insert the buf to incoming queue
> > 3. stream on
> >     3.1 dma_map_sg if ready, and move the buf to ready queue
> >     3.2 get the buf from ready queue, and dma start.
> > 4. dqbuf
> >     4.1 dma_unmap_sg after dma operation completion
> >     4.2 move the buf to outgoing queue
> > 5. back the buf to Task A
> > 6. go to 1
> >
> > In case that two tasks share buffers, and data flow goes from Task A to
> Task
> > B, we would need IPC operation to send and receive buffers properly
> between
> > those two tasks every time CPU or DMA access to buffers is started or
> > completed.
> >
> >
> > With dmabuf-sync:
> >
> > Task A
> > ----------------------------
> >  1. dma_buf_sync_lock <- synpoint (call by user side)
> >  2. CPU accesses buf
> >  3. dma_buf_sync_unlock <- syncpoint (call by user side)
> >  4. Send the buf to Task B (just one time)
> >  5. go to 1
> >
> >
> > Task B
> > ---------------------------
> > 1. Wait for the buf from Task A (just one time)
> > 2. qbuf the buf
> >     1.1 insert the buf to incoming queue
> > 3. stream on
> >     3.1 dma_buf_sync_lock <- syncpoint (call by kernel side)
> >     3.2 dma_map_sg if ready, and move the buf to ready queue
> >     3.3 get the buf from ready queue, and dma start.
> > 4. dqbuf
> >     4.1 dma_buf_sync_unlock <- syncpoint (call by kernel side)
> >     4.2 dma_unmap_sg after dma operation completion
> >     4.3 move the buf to outgoing queue
> > 5. go to 1
> >
> > On the other hand, in case of using dmabuf-sync, as you can see the
> above
> > example, we would need IPC operation just one time. That way, I think we
> > could not only reduce performance overhead but also make user
> application
> > simplified. Of course, this approach can be used for all DMA device
> drivers
> > such as DRM. I'm not a specialist in v4l2 world so there may be missing
> > point.
> >
> 
> You already need some kind of IPC between the two tasks, as I suspect
> even in your example it wouldn't make much sense to queue the buffer
> over and over again in task B without task A writing anything to it. So
> task A has to signal task B there is new data in the buffer to be
> processed.
> 
> There is no need to share the buffer over and over again just to get the
> two processes to work together on the same thing. Just share the fd
> between both and then do out-of-band completion signaling, as you need
> this anyway. Without this you'll end up with unpredictable behavior.
> Just because sync allows you to access the buffer doesn't mean it's
> valid for your use-case. Without completion signaling you could easily
> end up overwriting your data from task A multiple times before task B
> even tries to lock the buffer for processing.
> 
> So the valid flow is (and this already works with the current APIs):
> Task A                                    Task B
> ------                                    ------
> CPU access buffer
>          ----------completion signal--------->
>                                           qbuf (dragging buffer into
>                                           device domain, flush caches,
>                                           reserve buffer etc.)
>                                                     |
>                                           wait for device operation to
>                                           complete
>                                                     |
>                                           dqbuf (dragging buffer back
>                                           into CPU domain, invalidate
>                                           caches, unreserve)
>         <---------completion signal------------
> CPU access buffer
> 

Correct. In case that data flow goes from A to B, it needs some kind of IPC between the two tasks every time as you said. Then, without dmabuf-sync, how do think about the case that two tasks share the same buffer but these tasks access the buffer(buf1) as write, and data of the buffer(buf1) isn't needed to be shared?


With dmabuf-sync is:

 Task A
 ----------------------------
 1. dma_buf_sync_lock <- synpoint (call by user side)
 2. CPU writes something to buf1
 3. dma_buf_sync_unlock <- syncpoint (call by user side)
 4. copy buf1 to buf2
 5. go to 1


 Task B
 ---------------------------
 1. dma_buf_sync_lock
 2. CPU writes something to buf3
 3. dma_buf_sync_unlock
 4. qbuf the buf3(src) and buf1(dst)
     4.1 insert buf3,1 to incoming queue
     4.2 dma_buf_sync_lock <- syncpoint (call by kernel side)
 5. stream on
     5.1 dma_map_sg if ready, and move the buf to ready queue
     5.2 get the buf from ready queue, and dma start.
 6. dqbuf
     6.1 dma_buf_sync_unlock <- syncpoint (call by kernel side)
     6.2 dma_unmap_sg after dma operation completion
     6.3 move the buf3,1 to outgoing queue
7. go to 1


Thanks,
Inki Dae

> 
> Regards,
> Lucas
> --
> Pengutronix e.K.                           | Lucas Stach                 |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

