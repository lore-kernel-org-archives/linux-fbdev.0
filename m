From: Christoph Hellwig <hch@lst.de>
Date: Sat, 02 Feb 2019 17:21:21 +0000
Subject: Re: [PATCH 02/18] dmaengine: imx-sdma: pass struct device to DMA API functions
Message-Id: <20190202172121.GA3739@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-3-hch@lst.de> <20190202101121.GE4296@vkoul-mobl>
In-Reply-To: <20190202101121.GE4296@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vkoul@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Sat, Feb 02, 2019 at 03:41:21PM +0530, Vinod Koul wrote:
> On 01-02-19, 09:47, Christoph Hellwig wrote:
> > The DMA API generally relies on a struct device to work properly, and
> > only barely works without one for legacy reasons.  Pass the easily
> > available struct device from the platform_device to remedy this.
> 
> This looks good to me but fails to apply. Can you please base it on
> dmaengine-next or linux-next please and resend

commit ceaf52265148d3a5ca24237fd1c709caa5f46184
Author: Andy Duan <fugang.duan@nxp.com>
Date:   Fri Jan 11 14:29:49 2019 +0000

    dmaengine: imx-sdma: pass ->dev to dma_alloc_coherent() API

in linux-next actually is equivalent to this patch, so we can drop
this one.

> 
> Thanks
> -- 
> ~Vinod
---end quoted text---
