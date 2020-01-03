From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:00:23 +0000
Subject: Re: [PATCH] pxa168fb: Fix the function used to release some memory in an error handling path
Message-Id: <1700b70d-7766-bd6b-10ad-149c73e3998e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190831100024.3248-1-christophe.jaillet@wanadoo.fr>
 <CGME20190902091106epcas2p3519910dfea9c3515cdbe08263a1bcada@epcas2p3.samsung.com>
 <ca0213fd439a2b569e0d3bdb000712ee62ff4836.camel@v3.sk>
In-Reply-To: <ca0213fd439a2b569e0d3bdb000712ee62ff4836.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lubomir Rintel <lkundrak@v3.sk>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, yuehaibing@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 9/2/19 11:10 AM, Lubomir Rintel wrote:
> On Sat, 2019-08-31 at 12:00 +0200, Christophe JAILLET wrote:
>> In the probe function, some resources are allocated using 'dma_alloc_wc()',
>> they should be released with 'dma_free_wc()', not 'dma_free_coherent()'.
>>
>> We already use 'dma_free_wc()' in the remove function, but not in the
>> error handling path of the probe function.
>>
>> Also, remove a useless 'PAGE_ALIGN()'. 'info->fix.smem_len' is already
>> PAGE_ALIGNed.
>>
>> Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks,
> Lubo
> 
>> ---
>> The change about PAGE_ALIGN should probably be part of a separate commit.
>> However, git history for this driver is really quiet. If you think it
>> REALLY deserves a separate patch, either split it by yourself or axe this
>> part of the patch. I won't bother resubmitting for this lonely cleanup.
>> Hoping for your understanding.
>> ---
>>  drivers/video/fbdev/pxa168fb.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
>> index 1410f476e135..1fc50fc0694b 100644
>> --- a/drivers/video/fbdev/pxa168fb.c
>> +++ b/drivers/video/fbdev/pxa168fb.c
>> @@ -766,8 +766,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
>>  failed_free_clk:
>>  	clk_disable_unprepare(fbi->clk);
>>  failed_free_fbmem:
>> -	dma_free_coherent(fbi->dev, info->fix.smem_len,
>> -			info->screen_base, fbi->fb_start_dma);
>> +	dma_free_wc(fbi->dev, info->fix.smem_len,
>> +		    info->screen_base, fbi->fb_start_dma);
>>  failed_free_info:
>>  	kfree(info);
>>  
>> @@ -801,7 +801,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
>>  
>>  	irq = platform_get_irq(pdev, 0);
>>  
>> -	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
>> +	dma_free_wc(fbi->dev, info->fix.smem_len,
>>  		    info->screen_base, info->fix.smem_start);
>>  
>>  	clk_disable_unprepare(fbi->clk);
> 
