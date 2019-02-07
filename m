From: Paul Burton <paul.burton@mips.com>
Date: Thu, 07 Feb 2019 23:29:14 +0000
Subject: Re: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API functions
Message-Id: <20190207232912.wfgejc5c6d6lk5so@pburton-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-2-hch@lst.de>
In-Reply-To: <20190201084801.10983-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

Hi Christoph,

On Fri, Feb 01, 2019 at 09:47:44AM +0100, Christoph Hellwig wrote:
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
> ---
>  arch/mips/lantiq/xway/vmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Would you like this to go through the MIPS tree or elsewhere? If the
latter:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
