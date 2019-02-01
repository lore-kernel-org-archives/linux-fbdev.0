From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 16:10:45 +0000
Subject: Re: [PATCH 03/18] net: caif: pass struct device to DMA API functions
Message-Id: <20190201161045.GF6532@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-4-hch@lst.de> <1cafba51-b652-5457-0dd7-77d64264c85e@arm.com>
In-Reply-To: <1cafba51-b652-5457-0dd7-77d64264c85e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 01:53:09PM +0000, Robin Murphy wrote:
>>   #define LOW_WATER_MARK   100
>>   #define HIGH_WATER_MARK  (LOW_WATER_MARK*5)
>>   -#ifdef CONFIG_UML
>> +#ifdef CONFIG_HAS_DMA
>
> #ifndef, surely?

Indeed.
