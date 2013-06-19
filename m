From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 19 Jun 2013 05:45:15 +0000
Subject: RE: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization framework
Message-Id: <008601ce6cb0$2c8cec40$85a6c4c0$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Tuesday, June 18, 2013 6:47 PM
> To: Inki Dae
> Cc: 'Russell King - ARM Linux'; 'linux-fbdev'; 'Kyungmin Park'; 'DRI
> mailing list'; 'myungjoo.ham'; 'YoungJun Cho'; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization
> framework
> 
> Am Dienstag, den 18.06.2013, 18:04 +0900 schrieb Inki Dae:
> [...]
> >
> > > a display device driver.  It shouldn't be used within a single driver
> > > as a means of passing buffers between userspace and kernel space.
> >
> > What I try to do is not really such ugly thing. What I try to do is to
> > notify that, when CPU tries to access a buffer , to kernel side through
> > dmabuf interface. So it's not really to send the buffer to kernel.
> >
> > Thanks,
> > Inki Dae
> >
> The most basic question about why you are trying to implement this sort
> of thing in the dma_buf framework still stands.
> 
> Once you imported a dma_buf into your DRM driver it's a GEM object and
> you can and should use the native DRM ioctls to prepare/end a CPU access
> to this BO. Then internally to your driver you can use the dma_buf
> reservation/fence stuff to provide the necessary cross-device sync.
> 

I don't really want that is used only for DRM drivers. We really need it for all other DMA devices; i.e., v4l2 based drivers. That is what I try to do. And my approach uses reservation to use dma-buf resources but not dma fence stuff anymore. However, I'm looking into Radeon DRM driver for why we need dma fence stuff, and how we can use it if needed.

Thanks,
Inki Dae

> Regards,
> Lucas
> --
> Pengutronix e.K.                           | Lucas Stach                 |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

