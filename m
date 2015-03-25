From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Wed, 25 Mar 2015 20:03:46 +0000
Subject: Re: [Xen-devel] [PATCH v1 04/47] pci: add pci_ioremap_wc_bar()
Message-Id: <20150325200346.GO25884@l.oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-5-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-5-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-fbdev@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Luis R. Rodriguez" <mcgrof@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Fri, Mar 20, 2015 at 04:17:54PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This lets drivers take advanate of PAT when available. This

s/advanate/advantage/
> should help with the transition of converting video drivers over
> to ioremap_wc() to help with the goal of eventually using
> _PAGE_CACHE_UC over _PAGE_CACHE_UC_MINUS on x86 on
> ioremap_nocache() (de33c442e)

Please mention the title of the patch too:

"x86 PAT: fix performance drop for glx, use UC minus for ioremap(), ioremap_nocache() and pci_mmap_page_range()"
> 
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/pci/pci.c   | 14 ++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 81f06e8..6afd507 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -137,6 +137,20 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
>  				     pci_resource_len(pdev, bar));
>  }
>  EXPORT_SYMBOL_GPL(pci_ioremap_bar);
> +
> +void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
> +{
> +	/*
> +	 * Make sure the BAR is actually a memory resource, not an IO resource
> +	 */
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> +		WARN_ON(1);

Would it be better to use dev_warn ? That way you can see which BDF it is?

Thought WARN will give a nice stack-trace that should easily point to the
driver so perhaps not.. Either way - up to you.

> +		return NULL;
> +	}
> +	return ioremap_wc(pci_resource_start(pdev, bar),
> +			  pci_resource_len(pdev, bar));
> +}
> +EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  #endif
>  
>  #define PCI_FIND_CAP_TTL	48
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 211e9da..c235b09 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1667,6 +1667,7 @@ static inline void pci_mmcfg_late_init(void) { }
>  int pci_ext_cfg_avail(void);
>  
>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
> +void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
>  
>  #ifdef CONFIG_PCI_IOV
>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
> -- 
> 2.3.2.209.gd67f9d5.dirty
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
