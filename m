From: Christoph Hellwig <hch@lst.de>
Date: Wed, 03 Apr 2019 19:42:20 +0000
Subject: Re: remove NULL struct device support in the DMA API
Message-Id: <20190403194220.GA30376@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de> <20190403182640.2ca6w2hngjqp35mt@shell.armlinux.org.uk>
In-Reply-To: <20190403182640.2ca6w2hngjqp35mt@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:26:40PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Mar 21, 2019 at 03:52:28PM -0700, Christoph Hellwig wrote:
> > We still have a few drivers which pass a NULL struct device pointer
> > to DMA API functions, which generally is a bad idea as the API
> > implementations rely on the device not only for ops selection, but
> > also the dma mask and various other attributes, and many implementations
> > have been broken for NULL device support for a while.
> 
> I think I must be missing something, but...
> 
> My understanding is that ISA DMA is normally limited to 24 bits of
> address

Yes.

> - indeed, the x86 version only programs 24 bits of DMA address.
> Looking through this series, it appears that the conversions mean that
> the DMA mask for ISA becomes the full all-ones DMA mask, which would
> of course lead to memory corruption if only 24 bits of the address end
> up being programmed into the hardware.

In the generic dma mapping code no struct device has always meant a
32-bit DMA mask - take a look at the dma_get_mask() function.

> Maybe you could say why you think this series is safe in regard to ISA
> DMA?

ISA DMA has always been rather painful in a myriad of ways, and the
DMA API so far hasn't helped, given that we don't do bounce buffering
for the 24-bit limit, but just the higher limits.  So far even if you
do use the DMA API and pass a device ISA DMA so far always meant
that the higher layers had to assure things are addressable, either
by using GFP_DMA allocation in the drivers, or mid-layer hacks like
the unchecked_isa_dma flag in SCSI and/or BLK_BOUNCE_ISA in the
block layer.

This series doesn't change those facts at all.  I have some half
started series to clean some of this up but it isn't high up on
the priority list.
