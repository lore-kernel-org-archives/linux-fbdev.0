From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Wed, 26 Jun 2019 07:16:46 +0000
Subject: Re: [PATCH] au1200fb: don't use DMA_ATTR_NON_CONSISTENT
Message-Id: <CAOLZvyF0NsB6_e0=Vat48Mq1r-Qy45z509jAgQczG7RoaOqjBA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625121321.10197-1-hch@lst.de>
In-Reply-To: <20190625121321.10197-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux-MIPS <linux-mips@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Jun 25, 2019 at 2:13 PM Christoph Hellwig <hch@lst.de> wrote:
>
> au1200fb allocates DMA memory using DMA_ATTR_NON_CONSISTENT, but never
> calls dma_cache_sync to synchronize the memory between the CPU and the
> device.  If it was use on a not cache coherent bus that would be fatal,
> but as far as I can tell from the naming and the mips platform
> implementation it always is used in cache coherent systems.  Remove
> the DMA_ATTR_NON_CONSISTENT flag, which is a no-op in that case.

Very early au1200 chips, on which this driver apparently was developed on,
had issues with cache coherency, but this was fixed in a later step,
none of the 3 steppings I have access to exhibit any problems
with this patch applied.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-By: Manuel Lauss <manuel.lauss@gmail.com>
