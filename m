From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 12:14:42 +0000
Subject: Re: [PATCH 2/3] au1200fb: fix DMA API abuse
Message-Id: <76042970-34b0-87a9-6aac-5fa27a113e21@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de>
        <20190509173849.11825-3-hch@lst.de>
        <CGME20190515111114epcas1p10322ccf505be725a188b664baed2e183@epcas1p1.samsung.com>
        <CAOLZvyG14NvbgX4PA5aafk=reLcHbqDswqS-8j4+7QJMx02d7A@mail.gmail.com>
In-Reply-To: <CAOLZvyG14NvbgX4PA5aafk=reLcHbqDswqS-8j4+7QJMx02d7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <manuel.lauss@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Linux-MIPS <linux-mips@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


On 5/15/19 1:10 PM, Manuel Lauss wrote:
> Servus Christoph,
> 
> On Thu, May 9, 2019 at 7:39 PM Christoph Hellwig <hch@lst.de> wrote:
>> Virtual addresses return from dma(m)_alloc_attrs are opaque in what
>> backs then, and drivers must not poke into them.  Similarly caching
>> modes are not supposed to be directly set by the driver.  Switch the
>> driver to use the generic DMA API mmap helper to avoid these problems.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/video/fbdev/au1200fb.c | 19 ++++---------------
>>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> Runs fine on my test system.
> 
> Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
