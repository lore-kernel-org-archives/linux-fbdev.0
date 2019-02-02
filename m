From: Vinod Koul <vkoul@kernel.org>
Date: Sat, 02 Feb 2019 10:23:21 +0000
Subject: Re: [PATCH 02/18] dmaengine: imx-sdma: pass struct device to DMA API functions
Message-Id: <20190202101121.GE4296@vkoul-mobl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-3-hch@lst.de>
In-Reply-To: <20190201084801.10983-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On 01-02-19, 09:47, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.

This looks good to me but fails to apply. Can you please base it on
dmaengine-next or linux-next please and resend

Thanks
-- 
~Vinod
