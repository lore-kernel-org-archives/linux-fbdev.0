From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 11 Aug 2018 10:28:43 +0000
Subject: Re: [PATCH v3] fbcon: Do not takeover the console from atomic context
Message-Id: <be1c126d-c6cf-52d5-8f10-25fee6451f56@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180810112805epcas1p17ec5ad2f046683aad683edcae22777b2@epcas1p1.samsung.com>
 <20180810112757.3936-1-hdegoede@redhat.com> <18266775.E32RSncY74@amdc3058>
In-Reply-To: <18266775.E32RSncY74@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

On 10-08-18 17:22, Bartlomiej Zolnierkiewicz wrote:
> On Friday, August 10, 2018 01:27:57 PM Hans de Goede wrote:
>> Taking over the console involves allocating mem with GFP_KERNEL, talking
>> to drm drivers, etc. So this should not be done from an atomic context.
>>
>> But the console-output trigger deferred console takeover may happen from an
>> atomic context, which leads to "BUG: sleeping function called from invalid
>> context" errors.
>>
>> This commit fixes these errors by doing the deferred takeover from a
>> workqueue.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Patch queued for 4.19, thanks.
> 
>> @@ -3607,8 +3620,8 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>>   	deferred_takeover = false;
>>   	logo_shown = FBCON_LOGO_DONTSHOW;
>>   
>> -	for_each_registered_fb(i)
>> -		fbcon_fb_registered(registered_fb[i]);
>> +	/* We may get called in atomic context */
>> +	schedule_work(&fbcon_deferred_takeover_work);
> 
> After above change gcc now complains about unused variable:
> 
> drivers/video/fbdev/core/fbcon.c: In function ‘fbcon_output_notifier’:
> drivers/video/fbdev/core/fbcon.c:3613:6: warning: unused variable ‘i’ [-Wunused-variable]
>    int i;
>        ^
> 
> I fixed this while applying the patch.

Ah yes, thank you for fixing this,

Regards,

Hans
