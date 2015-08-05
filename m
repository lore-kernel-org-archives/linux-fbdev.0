From: Julien Grall <julien.grall@citrix.com>
Date: Wed, 05 Aug 2015 10:51:01 +0000
Subject: Re: [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <55C1EA95.5060504@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
 <55C147DD.7000600@oracle.com>
In-Reply-To: <55C147DD.7000600@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Boris,

On 05/08/15 00:16, Boris Ostrovsky wrote:
> On 08/04/2015 02:12 PM, Julien Grall wrote:
>>     /*
>>    * We detect special mappings in one of two ways:
>> @@ -217,9 +232,13 @@ static inline unsigned long
>> bfn_to_local_pfn(unsigned long mfn)
>>     /* VIRT <-> MACHINE conversion */
>>   #define virt_to_machine(v)    (phys_to_machine(XPADDR(__pa(v))))
>> -#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
>>   #define virt_to_mfn(v)        (pfn_to_mfn(virt_to_pfn(v)))
>>   #define mfn_to_virt(m)        (__va(mfn_to_pfn(m) << PAGE_SHIFT))
>> +#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
> 
> This looks like unnecessary change.

Right, I made the mistake when I re-introduced virt_to_mfn in this
version. It was dropped in the previous one.

>> diff --git a/drivers/video/fbdev/xen-fbfront.c
>> b/drivers/video/fbdev/xen-fbfront.c
>> index 09dc447..25e3cce 100644
>> --- a/drivers/video/fbdev/xen-fbfront.c
>> +++ b/drivers/video/fbdev/xen-fbfront.c
>> @@ -539,7 +539,7 @@ static int xenfb_remove(struct xenbus_device *dev)
>>     static unsigned long vmalloc_to_mfn(void *address)
>>   {
>> -    return pfn_to_mfn(vmalloc_to_pfn(address));
>> +    return pfn_to_gfn(vmalloc_to_pfn(address));
>>   }
> 
> Are you sure? This will return vmalloc_to_pfn(address)).

I guess you mean vmalloc_to_mfn will return vmalloc_to_pfn?

If so, it will be only the case on auto-translated case (because pfn =
gfn). In the case of PV, the mfn will be returned.

Although, this function is misnamed. It's fixed in a follow-up patch
(see #6) because it's required more renaming than this function. I
didn't want to add such changes within this patch.

Regards,

-- 
Julien Grall
