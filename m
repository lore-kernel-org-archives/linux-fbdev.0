From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 19 Nov 2018 01:23:57 +0000
Subject: Re: [PATCH -next] video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"
Message-Id: <e8ab2a91-9779-5062-3a39-1b5ee1c824c7@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181116110255.19736-1-yuehaibing@huawei.com>
 <ac93008d-05a0-834f-fcdd-649b0d12c212@zonque.org>
In-Reply-To: <ac93008d-05a0-834f-fcdd-649b0d12c212@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Mack <daniel@zonque.org>, b.zolnierkie@samsung.com, robert.jarzmik@free.fr
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


On 2018/11/17 4:05, Daniel Mack wrote:
> On 16/11/2018 12:02 PM, YueHaibing wrote:
>> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
>>
>> This gives this error message:
>>    ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Oh, yes. Thanks for spotting this!
> 
> Could you please add these lines to the patch and resubmit?
> 

Sure, will send v2.

> 
> Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
> Cc: stable@kernel.org [v4.19+]
> Reviewed-by: Daniel Mack <daniel@zonque.org>
> 
> 
> 
> 
>> ---
>>   drivers/video/fbdev/pxafb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
>> index bbed039..d59c8a5 100644
>> --- a/drivers/video/fbdev/pxafb.c
>> +++ b/drivers/video/fbdev/pxafb.c
>> @@ -2234,10 +2234,8 @@ static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
>>       if (!info)
>>           return ERR_PTR(-ENOMEM);
>>       ret = of_get_pxafb_mode_info(dev, info);
>> -    if (ret) {
>> -        kfree(info->modes);
>> +    if (ret)
>>           return ERR_PTR(ret);
>> -    }
>>         /*
>>        * On purpose, neither lccrX registers nor video memory size can be
>>
> 
> 
> .
> 
