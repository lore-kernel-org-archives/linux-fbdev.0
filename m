From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 16:04:04 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXXVqX8jevJ-R-0qXccarKvUa5Vek4Kx=8biP28BFTeQJg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 24, 2015 at 5:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 24/11/15 08:27, Dongsheng Wang wrote:
>> @@ -1697,6 +1700,9 @@ static int fsl_diu_probe(struct platform_device *pdev)
>>       unsigned int i;
>>       int ret;
>>
>> +     if (!diu_ops.set_pixel_clock)
>> +             return -ENODEV;
>> +
>>       data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
>>                                  &dma_addr, GFP_DMA | __GFP_ZERO);
>>       if (!data)
>>
>
> Thanks, queued for 4.5.

Could you please wait for me to review the patch first?  I am the
maintainer for the driver, and I see a problem with it.
