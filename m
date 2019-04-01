From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 15:38:40 +0000
Subject: Re: [PATCH 3/7] gbefb: switch to managed version of the DMA allocator
Message-Id: <a61e5aa5-53ed-168c-9b75-cb0509e0c065@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
        <CGME20190321225318epcas1p2a3b1fc89a14c4ab1241d8b48293fb9e0@epcas1p2.samsung.com>
        <20190321225235.30648-4-hch@lst.de>
In-Reply-To: <20190321225235.30648-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org


On 03/21/2019 11:52 PM, Christoph Hellwig wrote:
> gbefb uses managed resources, so it should do the same for DMA
> allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
