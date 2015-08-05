From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Wed, 05 Aug 2015 12:44:03 +0000
Subject: Re: [Xen-devel] [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <55C20513.2070407@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>	<1438711972-18752-5-git-send-email-julien.grall@citrix.com>	<55C147DD.7000600@oracle.com>
 <55C1EA95.5060504@citrix.com> <55C1FF54.8060409@oracle.com>
 <55C2029C.9030705@citrix.com>
In-Reply-To: <55C2029C.9030705@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/05/2015 08:33 AM, Julien Grall wrote:
> On 05/08/15 13:19, Boris Ostrovsky wrote:
>> On 08/05/2015 06:51 AM, Julien Grall wrote:
>>>>> diff --git a/drivers/video/fbdev/xen-fbfront.c
>>>>> b/drivers/video/fbdev/xen-fbfront.c
>>>>> index 09dc447..25e3cce 100644
>>>>> --- a/drivers/video/fbdev/xen-fbfront.c
>>>>> +++ b/drivers/video/fbdev/xen-fbfront.c
>>>>> @@ -539,7 +539,7 @@ static int xenfb_remove(struct xenbus_device *dev)
>>>>>       static unsigned long vmalloc_to_mfn(void *address)
>>>>>     {
>>>>> -    return pfn_to_mfn(vmalloc_to_pfn(address));
>>>>> +    return pfn_to_gfn(vmalloc_to_pfn(address));
>>>>>     }
>>>> Are you sure? This will return vmalloc_to_pfn(address)).
>>> I guess you mean vmalloc_to_mfn will return vmalloc_to_pfn?
>>>
>>> If so, it will be only the case on auto-translated case (because pfn =
>>> gfn). In the case of PV, the mfn will be returned.
>> How will mfn be returned on PV when pfn_to_gfn() is an identity function?
>>
>> static inline unsigned long pfn_to_gfn(unsigned long pfn)
>>   {
>>       return pfn;
>>   }
> The identity function is only for ARM guest which are always
> auto-translated (arch/arm/include/asm/xen/page.h).
>
> The x86 version contains a check if the guest is auto-translated or not
> (arch/x86/include/asm/xen/page.):
>
> static inline unsigned long pfn_to_gfn(unsigned long pfn)
> {
>          if (xen_feature(XENFEAT_auto_translated_physmap))
>                  return pfn;
>          else
>                  return pfn_to_mfn(pfn);
> }

Of course --- I was looking at the top of the patch and didn't realize 
it was ARM changes. Sorry for the noise.

-boris
