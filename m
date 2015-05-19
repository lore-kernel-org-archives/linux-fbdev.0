From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 May 2015 22:44:52 +0000
Subject: Re: [PATCH v5 1/5] pci: add pci_iomap_wc() variants
Message-Id: <20150519224452.GT31666@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mst@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, airlied@linux.ie, daniel.vetter@intel.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, venkatesh.pallipadi@intel.com, Stefan Bader <stefan.bader@canonical.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>, konrad.wilk@oracle.com, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, jbeulich@suse.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Thu, Apr 30, 2015 at 10:36:04AM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> This allows drivers to take advantage of write-combining
> when possible. The PCI specification does not allow for us
> to automatically identify a memory region which needs
> write-combining so drivers have to identify these areas
> on their own. There is IORESOURCE_PREFETCH but as clarified
> by Michael and confirmed later by Bjorn, PCI prefetch bit
> merely means bridges can combine writes and prefetch reads.
> Prefetch does not affect ordering rules and does not allow
> writes to be collapsed [0]. WC is stronger, it allows collapsing
> and changes ordering rules. WC can also hurt latency as small
> writes are buffered. Because of all this drivers needs to
> know what they are doing, we can't set a write-combining
> preference flag in the pci core automatically for drivers.
>=20
> Lastly although there is also arch_phys_wc_add() this makes
> use of architecture specific write-combining *hacks* and
> the only one currently defined and used is MTRR for x86.
> MTRRs are legacy, limited in number, have restrictive size
> constraints, and are known to interact pooly with the BIOS.
> MTRRs should only really be considered on old video framebuffer
> drivers. If we made ioremap_wc() and similar calls start
> automatically adding MTRRs, then performance will vary wildly
> with the order of driver loading because we'll run out of MTRRs
> part-way through bootup.
>=20
> There are a few motivations for phasing out of MTRR and
> helping driver change over to use write-combining with PAT:
>=20
> a) Take advantage of PAT when available
>=20
> b) Help bury MTRR code away, MTRR is architecture specific and on
>    x86 its replaced by PAT
>=20
> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
>    de33c442e titled "x86 PAT: fix performance drop for glx,
>    use UC minus for ioremap(), ioremap_nocache() and
>    pci_mmap_page_range()")
>=20
> [0] https://lkml.org/lkml/2015/4/21/714
>=20
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: venkatesh.pallipadi@intel.com
> Cc: Stefan Bader <stefan.bader@canonical.com>
> Cc: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: konrad.wilk@oracle.com
> Cc: ville.syrjala@linux.intel.com
> Cc: david.vrabel@citrix.com
> Cc: jbeulich@suse.com
> Cc: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>=20
> This v5 makes the code return NULL for IORESOURCE_IO and fixes the commit
> log to clarify the conclusions reached for MTRR and our review of
> IORESOURCE_PREFETCH.
>=20
>  include/asm-generic/pci_iomap.h | 14 ++++++++++
>  lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 75 insertions(+)
>=20
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_io=
map.h
> index 7389c87..b1e17fc 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -15,9 +15,13 @@ struct pci_dev;
>  #ifdef CONFIG_PCI
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lo=
ng max);
> +extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned=
 long max);
>  extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  				     unsigned long offset,
>  				     unsigned long maxlen);
> +extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
> +					unsigned long offset,
> +					unsigned long maxlen);
>  /* Create a virtual mapping cookie for a port on a given PCI device.
>   * Do not call this directly, it exists to make it easier for architectu=
res
>   * to override */
> @@ -34,12 +38,22 @@ static inline void __iomem *pci_iomap(struct pci_dev =
*dev, int bar, unsigned lon
>  	return NULL;
>  }
> =20
> +static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, u=
nsigned long max)
> +{
> +	return NULL;
> +}
>  static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  					    unsigned long offset,
>  					    unsigned long maxlen)
>  {
>  	return NULL;
>  }
> +static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int =
bar,
> +					       unsigned long offset,
> +					       unsigned long maxlen)
> +{
> +	return NULL;
> +}
>  #endif
> =20
>  #endif /* __ASM_GENERIC_IO_H */
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index bcce5f1..9604dcb 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -52,6 +52,46 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
>  EXPORT_SYMBOL(pci_iomap_range);
> =20
>  /**
> + * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @offset: map memory at the given offset in BAR
> + * @maxlen: max length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do w=
hat
> + * you expect from them in the correct way. When possible write combining
> + * is used.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get acces=
s to
> + * the complete BAR from offset to the end, pass %0 here.
> + * */
> +void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
> +				 int bar,
> +				 unsigned long offset,
> +				 unsigned long maxlen)
> +{
> +	resource_size_t start =3D pci_resource_start(dev, bar);
> +	resource_size_t len =3D pci_resource_len(dev, bar);
> +	unsigned long flags =3D pci_resource_flags(dev, bar);
> +
> +	if (len <=3D offset || !start)
> +		return NULL;
> +	len -=3D offset;
> +	start +=3D offset;
> +	if (maxlen && len > maxlen)
> +		len =3D maxlen;
> +	if (flags & IORESOURCE_IO)
> +		return NULL;
> +	if (flags & IORESOURCE_MEM)
> +		return ioremap_wc(start, len);
> +	/* What? */
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
> +
> +/**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
>   * @bar: BAR number
> @@ -70,4 +110,25 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar,=
 unsigned long maxlen)
>  	return pci_iomap_range(dev, bar, 0, maxlen);
>  }
>  EXPORT_SYMBOL(pci_iomap);
> +
> +/**
> + * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do w=
hat
> + * you expect from them in the correct way. When possible write combining
> + * is used.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get acces=
s to
> + * the complete BAR without checking for its length first, pass %0 here.
> + * */
> +void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long m=
axlen)
> +{
> +	return pci_iomap_wc_range(dev, bar, 0, maxlen);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc);
>  #endif /* CONFIG_PCI */
> --=20
> 2.3.2.209.gd67f9d5.dirty
>=20
