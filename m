From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 16:11:16 +0000
Subject: Re: [PATCH 10/18] smc911x: pass struct device to DMA API functions
Message-Id: <20190201161116.GG6532@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-11-hch@lst.de> <a8653acc-e0db-69a1-a8d3-2190f3767ce3@arm.com>
In-Reply-To: <a8653acc-e0db-69a1-a8d3-2190f3767ce3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 02:14:34PM +0000, Robin Murphy wrote:
> And equivalently for rxdma here. However, given that this all seems only 
> relevant to antique ARCH_PXA platforms which are presumably managing to 
> work as-is, it's probably not worth tinkering too much. I'd just stick a 
> note in the commit message that we're still only making these 
> self-consistent with the existing dma_map_single() calls rather than 
> necessarily correct.

Sounds good.
