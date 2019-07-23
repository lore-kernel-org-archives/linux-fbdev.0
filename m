From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 23 Jul 2019 15:35:37 +0000
Subject: Re: [PATCH] au1200fb: don't use DMA_ATTR_NON_CONSISTENT
Message-Id: <3fb07ff6-fd89-a42a-607a-1bce6a300805@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625121321.10197-1-hch@lst.de>
        <CGME20190626071727epcas1p137bdd191d49ab127eb92458848a06efb@epcas1p1.samsung.com>
        <CAOLZvyF0NsB6_e0=Vat48Mq1r-Qy45z509jAgQczG7RoaOqjBA@mail.gmail.com>
In-Reply-To: <CAOLZvyF0NsB6_e0=Vat48Mq1r-Qy45z509jAgQczG7RoaOqjBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <manuel.lauss@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Linux-MIPS <linux-mips@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


On 6/26/19 9:16 AM, Manuel Lauss wrote:
> On Tue, Jun 25, 2019 at 2:13 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> au1200fb allocates DMA memory using DMA_ATTR_NON_CONSISTENT, but never
>> calls dma_cache_sync to synchronize the memory between the CPU and the
>> device.  If it was use on a not cache coherent bus that would be fatal,
>> but as far as I can tell from the naming and the mips platform
>> implementation it always is used in cache coherent systems.  Remove
>> the DMA_ATTR_NON_CONSISTENT flag, which is a no-op in that case.
> 
> Very early au1200 chips, on which this driver apparently was developed on,
> had issues with cache coherency, but this was fixed in a later step,
> none of the 3 steppings I have access to exhibit any problems
> with this patch applied.
> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-By: Manuel Lauss <manuel.lauss@gmail.com>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
