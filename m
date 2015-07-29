From: Julien Grall <julien.grall@citrix.com>
Date: Wed, 29 Jul 2015 11:06:02 +0000
Subject: Re: [Xen-devel] [PATCH 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <55B8B39A.5020308@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
 <55B7B8D2.5060107@citrix.com>
In-Reply-To: <55B7B8D2.5060107@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 28/07/15 18:16, David Vrabel wrote:
> On 28/07/15 16:02, Julien Grall wrote:
>> Based on include/xen/mm.h [1], Linux is mistakenly using MFN when GFN
>> is meant, I suspect this is because the first support for Xen was for
>> PV. This brough some misimplementation of helpers on ARM and make the
>> developper confused the expected behavior.
> 
> For the benefit of other subsystem maintainers, this is a purely
> mechanical change in Xen-specific terminology.  It doesn't need reviews
> or acks from non-Xen people (IMO).
> 
>> For instance, with pfn_to_mfn, we expect to get an MFN based on the name.
>> Although, if we look at the implementation on x86, it's returning a GFN.
>>
>> For clarity and avoid new confusion, replace any reference of mfn into
>> gnf in any helpers used by PV drivers.
>>
>> Take also the opportunity to simplify simple construction such
>> as pfn_to_mfn(page_to_pfn(page)) into page_to_gfn. More complex clean up
>> will come in follow-up patches.
>>
>> I think it may be possible to do further clean up in the x86 code to
>> ensure that helpers returning machine address (such as virt_address) is
>> not used by no auto-translated guests. I will let x86 xen expert doing
>> it.
> 
> Reviewed-by: David Vrabel <david.vrabel@citrix.com>
> 
> It looks a bit odd to use GFN in some of the PV code where the
> hypervisor API uses MFN but overall I think using the correct
> terminology where possible is best.  But I'd like to have Boris's or
> Konrad's opinion on this.

I was thinking to introduce mfn_to_pfn & co which would be used only for
PV-guest (a BUG_ON would be here to ensure it) and hypercall related.

I didn't do it as I haven't much knowledge on x86 Xen and was able to
decide where I have to use pfn_to_mfn.

Regards,

-- 
Julien Grall
