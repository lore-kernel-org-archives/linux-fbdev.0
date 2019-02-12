From: Paul Burton <paul.burton@mips.com>
Date: Tue, 12 Feb 2019 17:41:27 +0000
Subject: Re: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API functions
Message-Id: <MWHPR2201MB12775A18B8F8F034F44D61BAC1650@MWHPR2201MB1277.namprd22.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-2-hch@lst.de>
In-Reply-To: <20190201084801.10983-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>

Hello,

Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
> 
> Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
> allocation, as we aren't in interrupt context or under a lock.
> 
> Note that this whole function looks somewhat bogus given that we never
> even look at the returned dma address, and the CPHYSADDR magic on
> a returned noncached mapping looks "interesting".  But I'll leave
> that to people more familiar with the code to sort out.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
