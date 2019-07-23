From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 23 Jul 2019 15:37:06 +0000
Subject: Re: [PATCH v3 24/24] video: fbdev-MMP: Remove call to memset after dma_alloc_coherent
Message-Id: <e66d213d-7a66-6c53-d453-6f4bbfa79c52@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715032017.7311-1-huangfq.daxian@gmail.com>
        <CGME20190715104058epcas1p2da7ed04b6c6d0d9e81c75e2b118d2dcb@epcas1p2.samsung.com>
        <20190715104049.GC20839@arch-x1c3>
In-Reply-To: <20190715104049.GC20839@arch-x1c3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>, Fuqian Huang <huangfq.daxian@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 7/15/19 12:40 PM, Emil Velikov wrote:
> On 2019/07/15, Fuqian Huang wrote:
>> In commit 518a2f1925c3
>> ("dma-mapping: zero memory returned from dma_alloc_*"),
>> dma_alloc_coherent has already zeroed the memory.
>> So memset is not needed.
>>
>> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
>> ---
>> Changes in v3:
>>   - Use actual commit rather than the merge commit in the commit message
>>
>>  drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
> 
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
