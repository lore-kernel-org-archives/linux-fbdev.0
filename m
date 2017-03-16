From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Thu, 16 Mar 2017 20:46:51 +0000
Subject: Re: [PATCH v1] x86/mm, asm-generic: Add IOMMU ioremap_uc() variant default
Message-Id: <CABhMZUVybSZPrLPWfFhCJKwk922UbacUzhzkMYNvb_++kGuPQw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436488096-3165-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1436488096-3165-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mingo@kernel.org, bp@suse.de, arnd@arndb.de, dan.j.williams@intel.com, Christoph Hellwig <hch@lst.de>, luto@amacapital.net, hpa@zytor.com, tglx@linutronix.de, geert@linux-m68k.org, ralf@linux-mips.org, hmh@hmh.eng.br, ross.zwisler@linux.intel.com, akpm@linux-foundation.org, jgross@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au, tj@kernel.org, x86 <x86@kernel.org>, tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com, stefan.bader@canonical.com, linux-mm@kvack.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

On Thu, Jul 9, 2015 at 7:28 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:

> +/**
> + * DOC: ioremap() and ioremap_*() variants
> + *
> + * If you have an IOMMU your architecture is expected to have both ioremap()
> + * and iounmap() implemented otherwise the asm-generic helpers will provide a
> + * direct mapping.
> + *
> + * There are ioremap_*() call variants, if you have no IOMMU we naturally will
> + * default to direct mapping for all of them, you can override these defaults.
> + * If you have an IOMMU you are highly encouraged to provide your own
> + * ioremap variant implementation as there currently is no safe architecture
> + * agnostic default. To avoid possible improper behaviour default asm-generic
> + * ioremap_*() variants all return NULL when an IOMMU is available. If you've
> + * defined your own ioremap_*() variant you must then declare your own
> + * ioremap_*() variant as defined to itself to avoid the default NULL return.

Are the references above to "IOMMU" typos?  Should they say "MMU"
instead, so they match the #ifdef below?

> + */
> +
> +#ifdef CONFIG_MMU
> +
> +#ifndef ioremap_uc
> +#define ioremap_uc ioremap_uc
> +static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> +{
> +       return NULL;
> +}
> +#endif
> +
> +#else /* !CONFIG_MMU */
> +
>  /*
>   * Change "struct page" to physical address.
>   *
> @@ -743,7 +772,6 @@ static inline void *phys_to_virt(unsigned long address)
>   * you'll need to provide your own definitions.
>   */
>
> -#ifndef CONFIG_MMU
>  #ifndef ioremap
>  #define ioremap ioremap
>  static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
> --
> 2.3.2.209.gd67f9d5.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
