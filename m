From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 18 Jun 2013 09:04:44 +0000
Subject: RE: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization framework
Message-Id: <008a01ce6c02$e00a9f50$a01fddf0$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1371467722-665-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, June 18, 2013 5:43 PM
> To: Inki Dae
> Cc: 'Maarten Lankhorst'; 'linux-fbdev'; 'Kyungmin Park'; 'DRI mailing
> list'; 'Rob Clark'; 'myungjoo.ham'; 'YoungJun Cho'; 'Daniel Vetter';
> linux-arm-kernel@lists.infradead.org; linux-media@vger.kernel.org
> Subject: Re: [RFC PATCH v2] dmabuf-sync: Introduce buffer synchronization
> framework
> 
> On Tue, Jun 18, 2013 at 02:27:40PM +0900, Inki Dae wrote:
> > So I'd like to ask for other DRM maintainers. How do you think about it?
> it
> > seems like that Intel DRM (maintained by Daniel), OMAP DRM (maintained
> by
> > Rob) and GEM CMA helper also have same issue Russell pointed out. I
> think
> > not only the above approach but also the performance is very important.
> 
> CMA uses coherent memory to back their buffers, though that might not be
> true of memory obtained from other drivers via dma_buf.  Plus, there is
> no support in the CMA helper for exporting or importng these buffers.
> 

It's not so. Please see Dave's drm next. recently dmabuf support for the CMA
helper has been merged to there.

> I guess Intel i915 is only used on x86, which is a coherent platform and
> requires no cache maintanence for DMA.
> 
> OMAP DRM does not support importing non-DRM buffers buffers back into

Correct. TODO yet.

> DRM.  Moreover, it will suffer from the problems I described if any
> attempt is made to write to the buffer after it has been re-imported.
> 
> Lastly, I should point out that the dma_buf stuff is really only useful
> when you need to export a dma buffer from one driver and import it into
> another driver - for example to pass data from a camera device driver to

Most people know that.

> a display device driver.  It shouldn't be used within a single driver
> as a means of passing buffers between userspace and kernel space.

What I try to do is not really such ugly thing. What I try to do is to
notify that, when CPU tries to access a buffer , to kernel side through
dmabuf interface. So it's not really to send the buffer to kernel.

Thanks,
Inki Dae

