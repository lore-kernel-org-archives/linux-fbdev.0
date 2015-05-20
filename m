From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 May 2015 21:02:34 +0000
Subject: Re: [PATCH v3 1/4] pci: add pci_ioremap_wc_bar()
Message-Id: <20150520210234.GD32152@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
 <1429647634-17169-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647634-17169-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mst@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, cocci@systeme.lip6.fr, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org

On Tue, Apr 21, 2015 at 01:20:31PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> This lets drivers take advantage of PAT when available. This
> should help with the transition of converting video drivers over
> to ioremap_wc() to help with the goal of eventually using
> _PAGE_CACHE_UC over _PAGE_CACHE_UC_MINUS on x86 on
> ioremap_nocache() (de33c442e titled "x86 PAT: fix performance
> drop for glx, use UC minus for ioremap(), ioremap_nocache() and
> pci_mmap_page_range()")
>=20
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>

I don't have any objection to this, and I can apply the follow-on patches
as well, given the appropriate acks and prerequisite patches (ioremap_wc()
implementation).

> ---
>  drivers/pci/pci.c   | 14 ++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 687af72..fd14f10 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -138,6 +138,20 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, =
int bar)
>  	return ioremap_nocache(res->start, resource_size(res));
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
> +		return NULL;
> +	}
> +	return ioremap_wc(pci_resource_start(pdev, bar),
> +			  pci_resource_len(pdev, bar));
> +}
> +EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  #endif
> =20
>  #define PCI_FIND_CAP_TTL	48
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bc50bb0..490ca41 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1667,6 +1667,7 @@ static inline void pci_mmcfg_late_init(void) { }
>  int pci_ext_cfg_avail(void);
> =20
>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
> +void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
> =20
>  #ifdef CONFIG_PCI_IOV
>  int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
> --=20
> 2.3.2.209.gd67f9d5.dirty
>=20
