From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 19 Jun 2013 10:44:20 +0000
Subject: RE: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization framework
Message-Id: <00ae01ce6cd9$f4834630$dd89d290$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Wednesday, June 19, 2013 7:22 PM
> To: Inki Dae
> Cc: 'Russell King - ARM Linux'; 'linux-fbdev'; 'Kyungmin Park'; 'DRI
> mailing list'; 'myungjoo.ham'; 'YoungJun Cho'; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization
> framework
> 
> Am Mittwoch, den 19.06.2013, 14:45 +0900 schrieb Inki Dae:
> >
> > > -----Original Message-----
> > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > > Sent: Tuesday, June 18, 2013 6:47 PM
> > > To: Inki Dae
> > > Cc: 'Russell King - ARM Linux'; 'linux-fbdev'; 'Kyungmin Park'; 'DRI
> > > mailing list'; 'myungjoo.ham'; 'YoungJun Cho'; linux-arm-
> > > kernel@lists.infradead.org; linux-media@vger.kernel.org
> > > Subject: Re: [RFC PATCH v2] dmabuf-sync: Introduce buffer
> synchronization
> > > framework
> > >
> > > Am Dienstag, den 18.06.2013, 18:04 +0900 schrieb Inki Dae:
> > > [...]
> > > >
> > > > > a display device driver.  It shouldn't be used within a single
> driver
> > > > > as a means of passing buffers between userspace and kernel space.
> > > >
> > > > What I try to do is not really such ugly thing. What I try to do is
> to
> > > > notify that, when CPU tries to access a buffer , to kernel side
> through
> > > > dmabuf interface. So it's not really to send the buffer to kernel.
> > > >
> > > > Thanks,
> > > > Inki Dae
> > > >
> > > The most basic question about why you are trying to implement this
> sort
> > > of thing in the dma_buf framework still stands.
> > >
> > > Once you imported a dma_buf into your DRM driver it's a GEM object and
> > > you can and should use the native DRM ioctls to prepare/end a CPU
> access
> > > to this BO. Then internally to your driver you can use the dma_buf
> > > reservation/fence stuff to provide the necessary cross-device sync.
> > >
> >
> > I don't really want that is used only for DRM drivers. We really need
> > it for all other DMA devices; i.e., v4l2 based drivers. That is what I
> > try to do. And my approach uses reservation to use dma-buf resources
> > but not dma fence stuff anymore. However, I'm looking into Radeon DRM
> > driver for why we need dma fence stuff, and how we can use it if
> > needed.
> >
> 
> Still I don't see the point why you need syncpoints above dma-buf. In
> both the DRM and the V4L2 world we have defined points in the API where
> a buffer is allowed to change domain from device to CPU and vice versa.
> 
> In DRM if you want to access a buffer with the CPU you do a cpu_prepare.
> The buffer changes back to GPU domain once you do the execbuf
> validation, queue a pageflip to the buffer or similar things.
> 
> In V4L2 the syncpoints for cache operations are the queue/dequeue API
> entry points. Those are also the exact points to synchronize with other
> hardware thus using dma-buf reserve/fence.


If so, what if we want to access a buffer with the CPU _in V4L2_? We should open a drm device node, and then do a cpu_prepare? 

Thanks,
Inki Dae

> 
> In all this I can't see any need for a new syncpoint primitive slapped
> on top of dma-buf.
> 
> Regards,
> Lucas
> --
> Pengutronix e.K.                           | Lucas Stach                 |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

