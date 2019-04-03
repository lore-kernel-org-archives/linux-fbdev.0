From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Date: Wed, 03 Apr 2019 18:26:40 +0000
Subject: Re: remove NULL struct device support in the DMA API
Message-Id: <20190403182640.2ca6w2hngjqp35mt@shell.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:52:28PM -0700, Christoph Hellwig wrote:
> We still have a few drivers which pass a NULL struct device pointer
> to DMA API functions, which generally is a bad idea as the API
> implementations rely on the device not only for ops selection, but
> also the dma mask and various other attributes, and many implementations
> have been broken for NULL device support for a while.

I think I must be missing something, but...

My understanding is that ISA DMA is normally limited to 24 bits of
address - indeed, the x86 version only programs 24 bits of DMA address.
Looking through this series, it appears that the conversions mean that
the DMA mask for ISA becomes the full all-ones DMA mask, which would
of course lead to memory corruption if only 24 bits of the address end
up being programmed into the hardware.

Maybe you could say why you think this series is safe in regard to ISA
DMA?

> 
> This series removes the few remaning users that weren't picked up in
> the last merge window and then removes core support for this "feature".
> 
> A git tree is also available at:
> 
>     git://git.infradead.org/users/hch/misc.git dma-remove-NULL-dev-support
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-remove-NULL-dev-support
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
