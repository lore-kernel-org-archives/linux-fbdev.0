From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Tue, 28 Jul 2015 19:12:11 +0000
Subject: Re: [PATCH 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <55B7D40B.5080903@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/28/2015 11:02 AM, Julien Grall wrote:
> Based on include/xen/mm.h [1], Linux is mistakenly using MFN when GFN
> is meant, I suspect this is because the first support for Xen was for
> PV. This brough some misimplementation of helpers on ARM and make the
> developper confused the expected behavior.
>
> For instance, with pfn_to_mfn, we expect to get an MFN based on the name.
> Although, if we look at the implementation on x86, it's returning a GFN.
>
> For clarity and avoid new confusion, replace any reference of mfn into
> gnf in any helpers used by PV drivers.




> @@ -730,7 +730,7 @@ static void xen_do_pin(unsigned level, unsigned long pfn)
>   	struct mmuext_op op;
>
>   	op.cmd = level;
> -	op.arg1.mfn = pfn_to_mfn(pfn);
> +	op.arg1.mfn = pfn_to_gfn(pfn);


This looks slightly odd. It is correct but given that purpose of this 
series is to make things more clear perhaps we can add another union 
member (gfn) to mmuext_op.arg1?

(Of course, the hypervisor will continue referring to mfn which could 
still be confusing)


>
>   	xen_extend_mmuext_op(&op);
>   }
> @@ -1323,7 +1323,7 @@ static void __xen_write_cr3(bool kernel, unsigned long cr3)
>   	trace_xen_mmu_write_cr3(kernel, cr3);
>
>   	if (cr3)
> -		mfn = pfn_to_mfn(PFN_DOWN(cr3));
> +		mfn = pfn_to_gfn(PFN_DOWN(cr3));

Here too. And further down, thoughout this patch.




-boris
