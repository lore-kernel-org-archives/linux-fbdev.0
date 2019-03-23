From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 23 Mar 2019 11:28:55 +0000
Subject: Re: [PATCH 7/7] x86: remove the x86_dma_fallback_dev hack
Message-Id: <alpine.DEB.2.21.1903231227240.2157@nanos.tec.linutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de> <20190321225235.30648-8-hch@lst.de>
In-Reply-To: <20190321225235.30648-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Christoph Hellwig wrote:

Please change the subject to:

 x86/dma: Remove the .... hack

> Now that we removed support for the NULL device argument in the DMA API,
> there is no need to cater for that in the x86 code.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/dma-mapping.h | 10 ----------
>  arch/x86/kernel/amd_gart_64.c      |  6 ------
>  arch/x86/kernel/pci-dma.c          | 20 --------------------
>  kernel/dma/mapping.c               |  7 -------
>  4 files changed, 43 deletions(-)

Feel free to route that through your DMA tree.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
