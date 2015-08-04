From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Tue, 04 Aug 2015 23:16:45 +0000
Subject: Re: [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <55C147DD.7000600@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/04/2015 02:12 PM, Julien Grall wrote:
>   
>   /*
>    * We detect special mappings in one of two ways:
> @@ -217,9 +232,13 @@ static inline unsigned long bfn_to_local_pfn(unsigned long mfn)
>   
>   /* VIRT <-> MACHINE conversion */
>   #define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
> -#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
>   #define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
>   #define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
> +#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))

This looks like unnecessary change.


> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 09dc447..25e3cce 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -539,7 +539,7 @@ static int xenfb_remove(struct xenbus_device *dev)
>   
>   static unsigned long vmalloc_to_mfn(void *address)
>   {
> -	return pfn_to_mfn(vmalloc_to_pfn(address));
> +	return pfn_to_gfn(vmalloc_to_pfn(address));
>   }

Are you sure? This will return vmalloc_to_pfn(address)).


-boris
