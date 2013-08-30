From: Chen Gang <gang.chen@asianux.com>
Date: Fri, 30 Aug 2013 08:47:02 +0000
Subject: Re: [PATCH v2] drivers: video: fbcmap: remove the redundency and incorrect checkings
Message-Id: <52205C06.8000208@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5212D594.3020802@asianux.com>
In-Reply-To: <5212D594.3020802@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/30/2013 04:41 PM, Tomi Valkeinen wrote:
> On 20/08/13 05:33, Chen Gang wrote:
>> fb_set_cmap() already checks the parameters, so need remove the
>> redundancy checking.
>>
>> This redundancy checking is also incorrect, the related warning:
>>
>>   drivers/video/fbcmap.c:288:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  drivers/video/fbcmap.c |    7 +------
>>  1 files changed, 1 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
>> index 5c3960d..f89245b 100644
>> --- a/drivers/video/fbcmap.c
>> +++ b/drivers/video/fbcmap.c
>> @@ -285,13 +285,8 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
>>  		rc = -ENODEV;
>>  		goto out;
>>  	}
>> -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
>> -				!info->fbops->fb_setcmap)) {
>> -		rc = -EINVAL;
>> -		goto out1;
>> -	}
>> +
>>  	rc = fb_set_cmap(&umap, info);
>> -out1:
>>  	unlock_fb_info(info);
>>  out:
>>  	fb_dealloc_cmap(&umap);
>>
> 
> Thanks, queued this for 3.12.
> 

Thank you too.

>  Tomi
> 
> 


-- 
Chen Gang
